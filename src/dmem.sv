module dmem(clk, wren, addr, wdata, rdata);
    input logic clk, wren; 
    input logic[31:0] addr, wdata; 
    output logic[31:0] rdata; 

    logic[31:0] ram[63:0]; 

    initial 
        $readmemh("datamem.mem", ram);
    assign rdata = ram[addr[31:2]]; 

    always_ff @(posedge clk) begin
        if(wren) ram[addr[31:2]] <= wdata; 
    end

endmodule

module dmem_testbench();
    logic clk, wren; 
    logic[31:0] addr, wdata;
    logic[31:0] rdata;

    dmem dut(.clk, .wren, .addr, .wdata, .rdata); 

    // Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
    initial begin
		clk <= 0;
		// Forever toggle the clock
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	// Test the design.
	initial begin
		addr = 32'd0; repeat(2) @(posedge clk);
        $stop; //End the simulation.
	end
endmodule