//Module: Instruction Memory
module imem(addr, rdata);
    input logic[31:0] addr;
    output logic[31:0] rdata;

    logic[31:0] ram[63:0]; 

    initial $readmemh("instructionmem.mem", ram);  
    always_comb begin
        $display("Instruction: %h", rdata);
    end 
    assign rdata = ram[addr[7:2]]; 
    
endmodule

module imem_testbench();
    logic[31:0] addr;
    logic[31:0] rdata;

    imem dut(.addr, .rdata); 

    initial begin
        addr = 32'd0; #10; 	
        addr = 32'd1; #10; 
    end
endmodule