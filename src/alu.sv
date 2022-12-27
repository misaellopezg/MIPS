module alu(A, B, opcode, out, c_out, zero);
    input logic[31:0] A,B;
    input logic[2:0] opcode;
    output logic[31:0] out;
    output logic c_out, zero;
    logic[32:0] result;

    always_comb begin
        case(opcode)
            0: // and
                result = A & B;
            1: // or 
                result = A | B;
            2: //add
                result = A + B; 
            6: //sub
                result = A + (~B + 1); 
            7: begin //set less than
				if (A[31] != B[31]) begin
					if (A[31] > B[31]) begin
						result = 1;
					end else begin
						result = 0;
					end
				end else begin
					if (A < B)
					begin
						result = 1;
					end
					else
					begin
						result = 0;
					end
				end
			end
            default: result = 33'hxxxxxxxxx;
        endcase
    end

    assign out = result[31:0]; 
    assign c_out = result[32]; 
    assign zero = (result[31:0] == 0); 
endmodule

module alu_testbench(); 
    logic[31:0] A,B;
    logic[2:0] opcode;
    logic[31:0] out;
    logic c_out, zero; 

    alu dut(.A, .B, .opcode, .out, .c_out, .zero); 

    initial begin
        //and test
        opcode = 3'd0; 
        A = 32'hFFFFFFFF; B = 32'hFFF0FFFF; #10; 	
        A = 32'h0000000F; B = 32'hFFFFFFF1; #10; 
        // or test
        opcode = 3'd1;
        A = 32'hFFFFFFFF; B = 32'hFFF0FFFF; #10; 	
        A = 32'h0000000F; B = 32'hFFFFFFF1; #10; 
        //add test
        opcode = 3'd2;
        A = 32'hFFFFFFFF; B = 32'h00000001; #10; //c_out test
        A = 32'd0; B = 32'd0; #10; 
        //subtract test
        opcode = 3'd6;
        A = 32'hFFFFFFFF; B = 32'h00000001; #10; //c_out test
        A = 32'd0; B = 32'd0; #10;
        //SLT
        opcode = 3'd7;
        A = 32'hFFFFFFFF; B = 32'h00000001; #10; //c_out test
        A = 32'd0; B = 32'd0; #10;
    end

endmodule