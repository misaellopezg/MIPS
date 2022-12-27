module mux2 #(parameter WIDTH=8)(A,B, sel, out); 
    input logic[WIDTH-1:0] A, B; 
    input logic sel;
    output logic[WIDTH-1:0] out; 
    assign out = sel ? B : A; 
endmodule

 module mux2_testbench();
    logic[7:0] A, B; 
    logic sel;
    logic[7:0] out; 

    mux2 #(.WIDTH(8)) dut(.A, .B, .sel, .out); 

    initial begin
        A = 8'h0F; B = 8'hF0; sel = 0; #10; 
        A = 8'h0F; B = 8'hF0; sel = 1; #10; 
    end
 endmodule