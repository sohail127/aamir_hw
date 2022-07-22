module puf_soc_ro #(parameter N_STAGE=6) (
	input  i_en,
	output o_ro
);

	// wire w_nand             ;
	// wire w_ring[N_STAGE-1:0];

	(*ALLOW_COMBINATORIAL_LOOPS = "true" , dont_touch = "true" *) 		 wire  w_nand    		      ;	
	(*ALLOW_COMBINATORIAL_LOOPS = "true" , dont_touch = "true" *) 		 wire  w_ring[N_STAGE-1:0];

	

	nand n1 (w_nand, i_en, w_ring[N_STAGE-1]);
	not  n0 (w_ring[0], w_nand);

//	assign w_nand    = ~(i_en & w_ring[N_STAGE-1]);
//	assign w_ring[0] = ~ w_nand;
	assign o_ro = w_ring [N_STAGE-1];

	genvar i;
	// TO generate chain of N-stages of Not gate
	generate
		for ( i = 0; i < N_STAGE-1; i=i+1) begin
			puf_soc_ro_not n1 (
				.i_not(w_ring[i]  ),
				.o_not(w_ring[i+1])
			);
		end
	endgenerate

endmodule // puf_soc_ro
