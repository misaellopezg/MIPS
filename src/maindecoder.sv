module maindecoder(opcode, memtoreg, memwrite, branch, alusrc, regdst, regwrite, aluop, jump);
    input logic[5:0] opcode; 
    output logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump; 
    output logic[1:0] aluop;

    logic[8:0] result;

    always_comb begin
        case(opcode)
            6'b000000: result = 9'b110000100; // r type
            6'b100011: result = 9'b101001000; // load word lw
            6'b101011: result = 9'b0x101x000; // store word sw
            6'b000100: result = 9'b0x010x010; // branch if equal beq
            6'b001000: result = 9'b101000000; // add immediate addi
            6'b000010: result = 9'b0xxx0xxx1; // jump j
            default: result = 9'bxxxxxxxxx;
        endcase
    end  
    assign regwrite = result[8]; 
    assign regdst = result[7]; 
    assign alusrc = result[6];
    assign branch = result[5];
    assign memwrite = result[4];
    assign memtoreg = result[3];
    assign aluop = result[2:1];
    assign jump = result[0]; 
endmodule

module maindecoder_testbench(); 
    logic[5:0] opcode; 
    logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump; 
    logic[1:0] aluop;
    maindecoder dut(.opcode, .memtoreg, .memwrite, .branch, .alusrc, .regdst, .regwrite, .aluop, .jump);

    initial begin
            opcode = 6'b000000; #10;
            opcode = 6'b100011; #10;
            opcode = 6'b101011; #10;
            opcode = 6'b000100; #10;
    end
endmodule
