`timescale 1ns/1ps
//********************************************************************************
// Title       : PUF ro
// Project     : ASIC Implementation of PUF
//********************************************************************************
// File        : puf_ro.v
// Author      : sohail (Email: sohail@imse-cnm.csic.es)
// Company     : IMSE-CNM (http://www.imse-cnm.csic.es)
// Created     : Mon Apr 11 18:03:22 2022
// Standard    : Verilog 2012
//********************************************************************************
// Copyright (c) 2022 IMSE-CNME ()
//********************************************************************************
// Description:
//********************************************************************************
module puf_ro #(
	parameter N_STAGE=5
	) (
	input  i_en,
	output o_ro
);
	wire w_nand         ;	
	wire  w_ring[N_STAGE-1:0];
	// (* dont_touch = "true" *)
	assign w_nand 	 = ~(i_en & w_ring[N_STAGE-1]);
	assign w_ring[0] = ~ w_nand;
	assign o_ro 		 = w_ring [N_STAGE-1];
	
	genvar i ;
	// TO generate chain of N-stages of Not gate 	
	generate
		for ( i = 0; i < N_STAGE-1; i=i+1) begin
			puf_not n1 (
				.i_not(w_ring[i]  ),
				.o_not(w_ring[i+1])
			);

		end
	endgenerate
       
endmodule // puf_ro