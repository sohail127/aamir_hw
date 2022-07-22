//********************************************************************************
// Title       : PUF puf_soc_counter
// Project     : ASIC Implementation of PUF
//********************************************************************************
// File        : puf_soc_counter.v
// Author      : sohail (Email: sohail@imse-cnm.csic.es)
// Company     : IMSE-CNM (http://www.imse-cnm.csic.es)
// Created     : Mon Apr 11 17:17:04 2022
// Standard    : Verilog 2012
//********************************************************************************
// Copyright (c) 2022 IMSE-CNME ()
//********************************************************************************
// Description:
//						Counter logic, its an CNT_BIT_SIZE puf_soc_counter with active low reset
// clk        : user clock pin
// rst_n      : active low reset
// i_cnt_en   : enable to start counting
// o_valid    : activ high for valid output
// o_cnt      : CNT_BIT_SIZE puf_soc_counter output value
// o_cnt_full : parametrize puf_soc_counter value
//********************************************************************************


module puf_soc_counter #(parameter CNT_BIT_SIZE = 32) (
	input                         clk       ,
	input                         rst_n     ,
	input                         i_cnt_en  ,
	output reg                    o_valid   ,
	output reg [CNT_BIT_SIZE-1:0] o_cnt     ,
	output                        o_cnt_full
);

	// puf_soc_counter logic
	always@(posedge  clk, negedge rst_n) begin
		if(!rst_n) begin
			o_cnt   <= {CNT_BIT_SIZE{1'b0}};
			o_valid <= 1'b0;
		end
		else begin
			if (i_cnt_en) begin
				o_cnt   <= o_cnt + 1;
				o_valid <= 1'b1;
			end else begin
				o_valid <= 1'b0;
				o_cnt   <= o_cnt;

			end
		end
	end
	assign o_cnt_full = (o_cnt == 2**CNT_BIT_SIZE-1) ? 1'b1 : 1'b0;
endmodule // puf_soc_counter
