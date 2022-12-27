module signextend(in, out);
    input logic[15:0] in; 
    output logic[31:0] out; 
    assign out = { { 16{in[15]} }, in};
endmodule

module signextend_testbench();
    logic[15:0] in; 
    logic[31:0] out; 

    signextend dut(.in, .out); 

    initial begin
        in = 16'hFF00; #10; 	
        in = 16'd1; #10; 
    end
endmodule