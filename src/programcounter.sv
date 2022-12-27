//Module: Program Counter
module programcounter(clk, reset, in, out);
    input logic clk, reset; 
    input logic[31:0] in; 
    output logic[31:0] out; 
    always_ff @(posedge clk) begin
        if(reset) out <= 0; 
        else out <= in; 
        $display("PC Value: %d \n", out);
    end
endmodule

module programcounter_testbench(); 
    logic clk, reset; 
    logic[31:0] in, out; 
    programcounter dut(.clk, .reset, .in, .out);
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
        reset <= 1; in <= 32'h0000FFFF; @(posedge clk); // Always reset FSMs at start
        reset <= 0; repeat(2) @(posedge clk);
        reset <= 1; in <= 32'h0000FFFF; @(posedge clk);
        reset <= 1; in <= 32'h0000FFFF; @(posedge clk);
        $stop; // End the simulation.
    end
endmodule