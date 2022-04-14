`timescale 1ns/1ps
//********************************************************************************
// Title       : PUF counter
// Project     : ASIC Implementation of PUF
//********************************************************************************
// File        : puf_cnt.v
// Author      : sohail (Email: sohail@imse-cnm.csic.es)
// Company     : IMSE-CNM (http://www.imse-cnm.csic.es)
// Created     : Mon Apr 11 17:17:04 2022
// Standard    : Verilog 2012
//********************************************************************************
// Copyright (c) 2022 IMSE-CNME ()
//********************************************************************************
// Description:
//						Counter logic, its an CNT_BIT_SIZE counter with active low reset
// clk         : user clock pin
// rst_n    	 : active low reset
// i_en        : enable to start counting
// o_valid     : activ high for valid output
// o_count     : CNT_BIT_SIZE counter output value
// o_count_set : parametrize counter value  
//********************************************************************************
module puf_cntr #(
	parameter CNT_BIT_SIZE = 5 ,
	parameter CNT_SET      = 16
) (
	input                         clk        ,
	input                         rst_n      ,
	input                         i_en       ,
	output reg                    o_valid    ,
	output reg [CNT_BIT_SIZE-1:0] o_count    ,
	output reg [CNT_BIT_SIZE-1:0] o_count_set
);

	// counter logic
	always@(posedge  clk, negedge rst_n) begin
		if(!rst_n) begin
			o_count <= {CNT_BIT_SIZE{1'b0}};
		end
		else begin
			if (i_en) begin
				o_count <= o_count + 1;
			end
		end
	end
	
	// parametrize output of counter 
	always @(posedge clk , negedge rst_n) begin 
		if(!rst_n) begin
			o_count_set <= {CNT_BIT_SIZE{1'b0}} ;
			o_valid 		<= 1'b0 	 						  ;
		end 
			else begin
				if (o_count == CNT_SET) begin
					o_count_set <= o_count ;
					o_valid 		<= 1'b1 	 ;
				end
				else begin
					o_count_set <= {CNT_BIT_SIZE{1'b0}} ;
					o_valid 		<= 1'b0 	 						  ;
				end
		end
	end

endmodule // puf_cntr