module controlunit(instr, memtoreg, memwrite, branch, alusrc, regdst, regwrite, alucontrol, jump);
    input logic[31:0] instr; 
    output logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump;
    output logic[2:0] alucontrol; 

    logic[1:0] aluop_out; 
    maindecoder m_dec(
        .opcode(instr[31:26]), 
        .memtoreg, 
        .memwrite, 
        .branch, 
        .alusrc, 
        .regdst, 
        .regwrite,
        .aluop(aluop_out),
        .jump); 

    aludecoder alu_dec(
        .funct(instr[5:0]), 
        .aluop(aluop_out), 
        .alucontrol); 
endmodule

module controlunit_testbench(); 
    logic[31:0] instr; 
    logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump;
    logic[2:0] alucontrol;

    controlunit dut(.instr, .memtoreg, .memwrite, .branch, .alusrc, .regdst, .regwrite, .alucontrol, .jump); 

    initial begin
        instr = 32'h00000022; #10; // funct sub
        instr = 32'h8C000000; #10; // lw add
    end
endmodule