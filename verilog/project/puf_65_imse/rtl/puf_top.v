`timescale 1ns/1ps
//********************************************************************************
// Title       : PUF top module
// Project     : ASIC Implementation of PUF
//********************************************************************************
// File        : puf_top.v
// Author      : sohail (Email: sohail@imse-cnm.csic.es)
// Company     : IMSE-CNM (http://www.imse-cnm.csic.es)
// Created     : Tue Apr 12 17:58:02 2022
// Standard    : Verilog 2012
//********************************************************************************
// Copyright (c) 2022 IMSE-CNME ()
//********************************************************************************
// Description:
//********************************************************************************
module puf_top #(
	parameter CNT_BIT_SIZE = 5 ,
	parameter CNT_SET      = 16,
	parameter N_STAGE      = 6
) (
	input                     i_en       ,
	input                     rst_n      ,
	output                    o_valid    ,
	output [CNT_BIT_SIZE-1:0] o_count    ,
	output [CNT_BIT_SIZE-1:0] o_count_set
);

// internal Signals

	wire w_ro;

//********************************************************************************
//** Module Instantiation
//********************************************************************************
	puf_ro  #( 
		.N_STAGE(N_STAGE)
		)i_puf_ro (
		.i_en(i_en),
		.o_ro(w_ro)
	);
//********************************************************************************
//** PUF Counter module instantiation 
//********************************************************************************
	puf_cntr #(
		.CNT_BIT_SIZE(CNT_BIT_SIZE),
		.CNT_SET     (CNT_SET     )
	) i_puf_cntr (
		.clk        (w_ro       ),
		.rst_n      (rst_n      ),
		.i_en       (i_en       ),
		.o_valid    (o_valid    ),
		.o_count    (o_count    ),
		.o_count_set(o_count_set)
	);


endmodule // puf_top