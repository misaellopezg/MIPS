//taken from book
module aludecoder(funct, aluop, alucontrol);
    input logic[5:0] funct; 
    input logic[1:0] aluop; 
    output logic[2:0] alucontrol; 

    always_comb begin
        case(aluop)
            2'b00: alucontrol <= 3'b010; //add (for lw/sw/addi)
            2'b01: alucontrol <= 3'b110; //sub (for beq)
            default: case(funct) //R-type instructions
                6'b100000: alucontrol <= 3'b010; //add
                6'b100010: alucontrol <= 3'b110; //sub
                6'b100100: alucontrol <= 3'b000; //and
                6'b100101: alucontrol <= 3'b001; //or
                6'b101010: alucontrol <= 3'b111; //slt
                default: alucontrol <= 3'bxxx; // ???
            endcase
        endcase
    end
endmodule

module aludecoder_testbench(); 
    logic[5:0] funct; 
    logic[1:0] aluop; 
    logic[2:0] alucontrol; 

    aludecoder dut(.funct, .aluop, .alucontrol); 
    
    initial begin
        aluop = 2'b00; funct = 6'b000000; #10; //add
        aluop = 2'b01; funct = 6'b000000; #10; //sub
        aluop = 2'b10; funct = 6'b100000; #10; //add
        aluop = 2'b11; funct = 6'b100010; #10; //sub
        aluop = 2'b11; funct = 6'b100100; #10; //and
        aluop = 2'b11; funct = 6'b100101; #10; //or
        aluop = 2'b11; funct = 6'b101010; #10; //slt
    end
endmodule