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
	parameter N_STAGE      = 14
) (
	input 										clk 			 ,
	input                     i_en       ,
	input                     rst_n      ,
	output                    o_valid    ,
	output [CNT_BIT_SIZE-1:0] o_count    ,
	output [CNT_BIT_SIZE-1:0] o_count_set
);

// internal Signals

	(*ALLOW_COMBINATORIAL_LOOPS = "true" , dont_touch = "true" *) 	  wire 	w_ro 	;
	(*ALLOW_COMBINATORIAL_LOOPS = "true" , dont_touch = "true" *) 	  reg 	reg_ro;
	// (*ALLOW_COMBINATORIAL_LOOPS = "true" , dont_touch = "true" *) 	  wire 	[CNT_BIT_SIZE-1:0] w_o_count    ;
	// (*ALLOW_COMBINATORIAL_LOOPS = "true" , dont_touch = "true" *) 	  wire 	[CNT_BIT_SIZE-1:0] w_o_count_set;

//********************************************************************************
//** Module Instantiation
//********************************************************************************
	(*ALLOW_COMBINATORIAL_LOOPS = "true" , dont_touch = "true" *)	puf_ro #(.N_STAGE(N_STAGE)) i_puf_ro (
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
		/*.clk        (w_ro       ),*/
		.clk        (reg_ro     	),
		.rst_n      (rst_n      	),
		.i_en       (i_en       	),
		.o_valid    (o_valid    	),
		// .o_count    (w_o_count    ),
		// .o_count_set(w_o_count_set)
		.o_count    (o_count    ),
		.o_count_set(o_count_set)
	);

// register for STA
always @(posedge clk or negedge rst_n) begin 
	if(~rst_n) begin
		reg_ro <= 0;
	end else begin
		reg_ro <= w_ro;
	end
end

/*// register for STA
always @(posedge clk or negedge rst_n) begin 
	if(~rst_n) begin
		o_count     	<= {CNT_BIT_SIZE{1'b0}};
		o_count_set 	<= {CNT_BIT_SIZE{1'b0}};
	end else begin
		o_count     	<= w_o_count    ;
		o_count_set 	<= w_o_count_set;
	end
end*/


endmodule // puf_top
