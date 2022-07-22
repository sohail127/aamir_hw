module m_ff_sync #(parameter NUM_FF = 3) (
	input  clk   , // Clock
	input  rst_n , // Asynchronous reset active low
	input  i_data,
	output o_data
);

	(*ALLOW_COMBINATORIAL_LOOPS = "true" , dont_touch = "true" *) wire w_ff[NUM_FF:0];

	assign w_ff[0] = i_data ;
	assign o_data  = w_ff [NUM_FF];

	genvar ii;
	// TO generate chain of N-stages of Flip-flop
	generate
		for ( ii = 0; ii < NUM_FF; ii=ii+1) begin
			dflipflop ff (
				.clk   (clk       ), // input 			clk   ,    // Clock
				.rst_n (rst_n     ), // input 			rst_n ,  // Asynchronous reset active low
				.i_data(w_ff[ii]  ), // input 			i_data,
				.o_data(w_ff[ii+1])  // output reg  o_data
			);
		end
	endgenerate

endmodule // m_ff_sync