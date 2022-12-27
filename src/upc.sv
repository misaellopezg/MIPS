module upc(stln, dscnt, u,p,c,m);	
	output logic stln, dscnt; 	
	input  logic u,p,c,m;
	
	//Stolen Logic
	assign dscnt = p | (u & c); 
	//Discount Logic
	assign stln = ~(p | ( (~u & c) | m) ); 

endmodule		
		
module upc_testbench();		
	logic  a,b,c,d; 		
	logic  x,y;	
			
	upc dut (.stln(x), .dscnt(y), .u(a),.p(b),.c(c),.m(d)); 		
		
	integer i; 	
	initial begin	
		for(i=0; i<16; i++) begin	
			{a,b,c,d} = i; #10; 	
		end	
	end	
endmodule	