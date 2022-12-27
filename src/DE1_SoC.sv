// Top-level module that defines the I/Os for the DE1 SoC board
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;

	//Default HEX Displays
	//assign HEX0 = 7'b1111111; 
	//assign HEX1 = 7'b1111111;
	//assign HEX2 = 7'b1111111; 
	//assign HEX3 = 7'b1111111; 
	//assign HEX4 = 7'b1111111; 
	//assign HEX5 = 7'b1111111; 

	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic reset;
	logic [31:0] div_clk;
	assign reset = SW[9];
	parameter whichClock = 20; // 0.75 Hz clock
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk));
	// Clock selection; allows for easy switching between simulation and board clocks
	logic clkSelect;
	// Uncomment ONE of the following two lines depending on intention
	//assign clkSelect = CLOCK_50; // for simulation
	assign clkSelect = div_clk[whichClock]; // for board

	//Starting the best CPU ever...
	logic[31:0] reg_out; 
	mips misa_cpu(.clk(clkSelect), .reset(reset), .sw_in(SW[4:0]), .rfile_rd3(reg_out));

	seg7 h0(.in(reg_out[3:0]), .disp(HEX0));
	seg7 h1(.in(reg_out[7:4]), .disp(HEX1)); 
	seg7 h2(.in(reg_out[11:8]), .disp(HEX2));
	seg7 h3(.in(reg_out[15:12]), .disp(HEX3)); 
	seg7 h4(.in(reg_out[19:16]), .disp(HEX4));
	seg7 h5(.in(reg_out[23:20]), .disp(HEX5)); 

endmodule

`timescale  1 ps/1 ps 
module DE1_SoC_testbench();
	logic CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	DE1_SoC dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		// Forever toggle the clock
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	// Test the design.
	initial begin
		repeat(1) @(posedge CLOCK_50);
		$stop; // End the simulation.
	end
endmodule