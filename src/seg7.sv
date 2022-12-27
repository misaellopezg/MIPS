module seg7 (in, disp);
    input logic [3:0] in;
    output logic [6:0] disp;
    always_comb begin
        //Display 0
        case (in)
            4'b0000: disp = 7'b1000000; // 0
            4'b0001: disp = 7'b1111001; // 1
            4'b0010: disp = 7'b0100100; // 2 
            4'b0011: disp = 7'b0110000; // 3
            4'b0100: disp = 7'b0011001; // 4
            4'b0101: disp = 7'b0010010; // 5
            4'b0110: disp = 7'b0000010; // 6
            4'b0111: disp = 7'b1111000; // 7
            4'b1000: disp = 7'b0000000; // 8
            4'b1001: disp = 7'b0011000; // 9
            4'b1010: disp = 7'b0001000; // a
            4'b1011: disp = 7'b0000011; // b
            4'b1100: disp = 7'b1000110; // c
            4'b1101: disp = 7'b0100001; // d
            4'b1110: disp = 7'b0000110; // e
            4'b1111: disp = 7'b0001110; // f
            default: disp = 7'b1111111;
        endcase
    end
endmodule