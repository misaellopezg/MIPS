module debounce(clk, reset, in, out);
    input logic clk, reset, in; 
    output logic out;

    //State variables
    enum bit[1:0] {a = 2'b00, b = 2'b01, c = 2'b10} ps, ns; 
    //Next State Logic
    always_comb begin
        case(ps)
            a: 
                if (in)
                    ns = b;
                else 
                    ns = a;
            b:
                if (in)
                    ns = c;
                else
                    ns = a; 
            c: 
                if(in)
                    ns = c;
                else
                    ns = a;
        endcase
    end
    //Output Logic
    assign out = ps[0];
    //Define Flip Flop
    always_ff @(posedge clk) begin
        if(reset)
            ps <= a;
        else    
            ps <= ns;        
    end
endmodule

module debounce_testbench();
    logic clk, reset, in; 
    logic out;
    debounce dut(.clk, .reset, .in, .out);

    // Set up a simulated clock.
    parameter CLOCK_PERIOD=100;
    initial begin
        clk <= 0;
        //Forever toggle the clock
        forever #(CLOCK_PERIOD/2) clk <= ~clk;
    end
    // Set up the inputs to the design. Each line is a clock cycle.
    initial begin
        @(posedge clk);
        reset <= 1; @(posedge clk); // Always reset FSMs at start
        reset <= 0; in <= 0; @(posedge clk);
        in <= 1; @(posedge clk);
        in <= 1; @(posedge clk);
        in <= 1; @(posedge clk);
        in <= 0; @(posedge clk);
        in <= 1; @(posedge clk);
        in <= 1; @(posedge clk);
        reset <= 1; @(posedge clk);
        @(posedge clk);
        in <= 0; @(posedge clk);
        @(posedge clk);
        $stop; // End the simulation.
    end

endmodule