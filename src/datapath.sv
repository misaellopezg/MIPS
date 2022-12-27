module datapath(clk, reset, pc, regwrite, alucontrol, memwrite, alusrc, memtoreg, regdst, branch, jump, pc_next, sw_in, rfile_rd3); 
    input logic clk, reset, regwrite, memwrite, alusrc, memtoreg, regdst, branch, jump;
    input logic[31:0] pc;
    input logic[2:0] alucontrol;
    input logic[4:0] sw_in; //
    output logic[31:0] pc_next, rfile_rd3; //

    logic[31:0] result;
    logic[31:0] signext_imm; 
    logic[31:0] alu_srcb;
    
    //Instruction memory
    logic[31:0] im_instr;
    imem instr_mem(
        .addr(pc),
        .rdata(im_instr)
        ); 

    //Register File
    logic[31:0] rfile_rd1, rfile_rd2;
    logic[4:0] writereg;

    mux2 #(.WIDTH(5)) mux_regdst(
        .A(im_instr[20:16]), 
        .B(im_instr[15:11]), 
        .sel(regdst), 
        .out(writereg)
        ); 

    reg_file rfile(
        .clk, 
        .wren(regwrite),
        .ra1(im_instr[25:21]),     
        .ra2(im_instr[20:16]), 
        .ra3(sw_in),
        .wa(writereg), 
        .wd(result), 
        .rd1(rfile_rd1), 
        .rd2(rfile_rd2), 
        .rd3(rfile_rd3)
        ); 

    //Sign Extend for R-type offseft
    
    signextend signext(
        .in(im_instr[15:0]), 
        .out(signext_imm)
        ); 

    //ALU
    mux2 #(.WIDTH(32)) mux_alu(
        .A(rfile_rd2), 
        .B(signext_imm), 
        .sel(alusrc), 
        .out(alu_srcb)); 

    logic alu_cout, alu_zero; 
    logic[31:0] alu_result;
    alu m_alu(
        .A(rfile_rd1), 
        .B(alu_srcb), 
        .opcode(alucontrol), 
        .out(alu_result), 
        .c_out(alu_cout), 
        .zero(alu_zero)); 

    //Data Memory
    logic[31:0] dmem_readdata; 
    dmem data_mem(
        .clk, 
        .wren(memwrite), 
        .addr(alu_result), 
        .wdata(rfile_rd2), 
        .rdata(dmem_readdata)
        ); 

   
    mux2 #(.WIDTH(32)) mux_result(
        .A(alu_result), 
        .B(dmem_readdata), 
        .sel(memtoreg), 
        .out(result)
        );

    // 1010101....0000 0000
    //Next PC
    logic[31:0] pc_plus4, pc_branch, pc_src, pc_jump;
    assign pc_plus4 = pc + 4;
    assign pc_branch = pc_plus4 + (signext_imm << 2); 
    assign pc_jump = {(pc_plus4[31:28]),(im_instr[25:0]), 2'b00};

    assign pc_src = (branch & alu_zero) ? pc_branch : pc_plus4; 
    assign pc_next = (jump) ? pc_jump : pc_src; //Adding jump capability

endmodule

module datapath_testbench(); 
    logic clk, reset, regwrite, memwrite, alusrc, memtoreg, regdst, branch, jump; 
    logic[31:0] pc; 
    logic[2:0] alucontrol; 
    logic[4:0] sw_in; //
    logic[31:0] pc_next, rfile_rd3; //

    datapath dut(
            .clk,
            .reset, 
            .regwrite, 
            .regdst, 
            .alusrc, 
            .branch, 
            .memwrite, 
            .memtoreg, 
            .alucontrol, 
            .jump,
            .pc, 
            .pc_next, 
            .sw_in,
            .rfile_rd3
        );
    // Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
    initial begin
		clk <= 0;
		// Forever toggle the clock
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	// Test the design.
	initial begin
		reset <= 1; pc <= 32'h00000000; 
        regwrite <= 1; regdst <= 0; alusrc <= 1; branch <= 0; 
        memwrite <= 0; memtoreg <= 1; alucontrol <= 010; jump <= 0; 
        repeat(1) @(posedge clk);

        reset <= 0; repeat(2) @(posedge clk);
        $stop; //End the simulation.
	end
endmodule