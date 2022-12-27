//Module: MIPS
//Note: sw_in is DE1_SoC input for addressing registers in register file
//Note: rfile_rd3 is output for DE1_SoC output to use for display purposes in DE1_SoC.sv
module mips(clk, reset, sw_in, rfile_rd3);
    input logic clk, reset; 
    input logic[4:0] sw_in;
    output logic[31:0] rfile_rd3; 
    logic[31:0] pc, pc_next; 

    //Program Counter
    programcounter pcntr(
        .clk, 
        .reset, 
        .in(pc_next), 
        .out(pc)
    );

    //Instruction memory
    logic[31:0] im_instr;
    imem instr_mem(
        .addr(pc),
        .rdata(im_instr)
    ); 

    //Control Unit
    logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump; 
    logic[2:0] alucontrol;
    controlunit ctrl_unit(
        .instr(im_instr), 
        .memtoreg(memtoreg), 
        .memwrite(memwrite), 
        .branch(branch), 
        .alusrc(alusrc), 
        .regdst(regdst), 
        .regwrite(regwrite), 
        .alucontrol(alucontrol),
        .jump(jump)
    );

    //Datapath
    datapath d_path(
        .clk, 
        .reset, 
        .pc(pc), 
        .regwrite(regwrite), 
        .alucontrol(alucontrol), 
        .memwrite(memwrite), 
        .alusrc(alusrc), 
        .memtoreg(memtoreg), 
        .regdst(regdst), 
        .branch(branch), 
        .jump(jump),
        .pc_next(pc_next),
        .sw_in(sw_in), 
        .rfile_rd3(rfile_rd3)
    ); 
endmodule

module mips_testbench(); 
    logic clk, reset; 
    logic[4:0] sw_in;
    logic[31:0] rfile_rd3; 
    mips dut(.clk, .reset, .sw_in, .rfile_rd3); 

    // Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
    initial begin
		clk <= 0;
		// Forever toggle the clock
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	// Test Fibonacci sequence (see instruction memory for more information).
	initial begin
		reset <= 1; sw_in <= 5'd2; repeat(1) @(posedge clk);
        reset <= 0; repeat(75) @(posedge clk);
        $stop; //End the simulation.
	end
endmodule