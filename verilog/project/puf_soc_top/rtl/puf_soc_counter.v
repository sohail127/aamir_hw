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
	input      [CNT_BIT_SIZE-1:0] i_cnt_max ,
	input                         i_op_mode ,
	output reg                    o_valid   ,
	output reg [CNT_BIT_SIZE-1:0] o_cnt     ,
	output reg                    o_cnt_full
);
	wire                    w_cnt_en    ;
	reg  [CNT_BIT_SIZE-1:0] r_cnt_max   ;
	reg                     r_max_en    ;
	reg  [             1:0] r_dbl_o_full;
	reg  [             1:0] r_op_mode   ;
	reg  [CNT_BIT_SIZE-1:0] r_o_cnt     ;
	reg                     r_o_cnt_full;
	// enable signal for counter
	assign w_cnt_en = i_cnt_en && ~(r_o_cnt_full) ;

	// puf_soc_counter logic
	always@(posedge  clk, negedge rst_n) begin
		if(!rst_n) begin
			r_o_cnt   <= {CNT_BIT_SIZE{1'b0}};
		end
		else begin
			if (w_cnt_en) begin
				r_o_cnt   <= r_o_cnt + 1;
			end else begin
				r_o_cnt   <= r_o_cnt;
			end
		end
	end

	// generate full signal
	always @(posedge clk , negedge rst_n) begin
		if(!rst_n) begin
			r_o_cnt_full <= 1'b0;
		end else begin
			if ((r_o_cnt == r_cnt_max) && r_max_en) begin
				r_o_cnt_full <= 1'b1;
			end else begin
				r_o_cnt_full <= r_o_cnt_full;
			end
		end
	end

	// register the counter max value
	always @(posedge clk , negedge rst_n) begin
		if(!rst_n) begin
			r_cnt_max <= {CNT_BIT_SIZE{1'b0}};
			r_max_en  <= 1'b0 ;
		end else begin
			r_cnt_max <= i_cnt_max;
			r_max_en  <= 1'b1 ;
		end
	end


	// Doube flop the data to overcome synchronization issue
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			r_dbl_o_full <= {2{1'b0}};
		end else begin
			if (r_o_cnt_full) begin
				r_dbl_o_full[0] <= r_o_cnt_full		;
				r_dbl_o_full[1] <= r_dbl_o_full[0];
			end else begin
				r_dbl_o_full <= r_dbl_o_full;
			end
		end
	end

	// Doube flop the op_mode pulse
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			r_op_mode <= {2{1'b0}};
		end else begin
			if (i_op_mode) begin
				r_op_mode[0] <= i_op_mode		;
				r_op_mode[1] <= r_op_mode[0];
			end else begin
				r_op_mode 	<= {2{1'b0}} ; 
			end
		end
	end


	// Final output
	always @(posedge clk or negedge rst_n) begin 
			if(~rst_n) begin
				o_cnt      <= {CNT_BIT_SIZE{1'b0}};
				o_cnt_full <= 1'b0;
				o_valid 	 <= 1'b0;
			end else begin
				if (r_dbl_o_full[1] || r_op_mode[1]) begin
					o_cnt      <= r_o_cnt 		;
					o_valid 	 <= 1'b1;
					o_cnt_full <= r_o_cnt_full;
				end else begin
					o_cnt      <= o_cnt_full;
					o_cnt_full <= o_cnt_full;
					o_valid 	 <= 1'b0 	; 
				end
			end
		end

	// assign o_cnt_full = (o_cnt == i_cnt_max) ? 1'b1 : 1'b0;
endmodule // puf_soc_counter
