//Description: 32x32 register file for MIPS processor 
/*Inputs:
clk: clock 
wren: write enable
ra1: read address port 1, represents address of register 1 to read (5 bit)
ra2: read address port 2, represents address of register 2 to read (5 bit)
wa: write address port, represents register address to write data to (5 bit)
wd: write data port, represents data that will be written (32 bit)
*/
/*Outputs
rd1: read data port 1, represents data read from register 1 (32 bit)
rd2: read data port 2, represents data read from register 2 (32 bit)
*/
//Note: design based on class book
module reg_file(clk, wren, ra1, ra2, ra3, wa, wd, rd1, rd2, rd3);
    input logic clk, wren; //clock, write enable
    input logic[4:0] ra1, ra2, ra3, wa; //read A1 reg, read A2 reg, write address reg
    input logic[31:0] wd; // write data
    output logic[31:0] rd1, rd2, rd3; // read A1 data, read A2 data

    logic[31:0] rf[31:0];//32 registers per MIPS architecture

    always_ff @(posedge clk) begin
        $display ("Register a0 n : %d", rf[4]); 
        $display ("Register s0 b : %d", rf[16]); 
        $display ("Register s1 a : %d", rf[17]); 
        $display ("Register t0 t : %d", rf[8]); 
        $display ("Register t1 cntr : %d", rf[9]); 
        $display ("Register v0 : %d", rf[2]); 
        $display ("Read Out 1 : %h", rd1); 
        $display ("Read Out 2 : %h", rd2); 
        if(wren) rf[wa] <= wd;
    end

    //Assign read port outputs
    assign rd1 = (ra1 != 0) ? rf[ra1] : 0; 
    assign rd2 = (ra2 != 0) ? rf[ra2] : 0; 
    assign rd3 = rf[ra3]; 
    
endmodule

module reg_file_testbench(); 
    logic clk, wren; 
    logic[4:0] ra1, ra2, ra3, wa;
    logic[31:0] wd;
    logic[31:0] rd1, rd2, rd3;
    
    reg_file dut(.clk, .wren, .ra1, .ra2, .ra3, .wa, .wd, .rd1, .rd2, .rd3);
    // Set up a simulated clock.
    parameter CLOCK_PERIOD=100;
    initial begin
        clk <= 0;
        //Forever toggle the clock
        forever #(CLOCK_PERIOD/2) clk <= ~clk;
    end
    // Set up the inputs to the design. Each line is a clock cycle.
    initial begin
            //@(posedge clk);
        wren <= 0; ra1 <= 32'h00000000; ra2 <= 32'h00000001; wa <= 5'b00000; wd <= 32'h0000FFFF; @(posedge clk); // Always reset FSMs at start
        //Testing writing values to all registers
        wren <= 1; wa <= 5'd1; wd <= 32'h0000FFFF; @(posedge clk);
        wren <= 1; wa <= 5'd2; wd <= 32'hFFFF0000; @(posedge clk);
        wren <= 1; wa <= 5'd30; wd <= 32'h01010101; @(posedge clk);
        wren <= 1; wa <= 5'd31; wd <= 32'h0F0F0F0F; @(posedge clk);
        wren <= 0; ra1 <= 32'd1; ra2 <= 32'd2; @(posedge clk);
        wren <= 0; ra1 <= 32'd30; ra2 <= 32'd31; @(posedge clk);
        wren <= 0; ra1 <= 32'd0; ra2 <= 32'd0; @(posedge clk);
        $stop; // End the simulation.
    end
endmodule