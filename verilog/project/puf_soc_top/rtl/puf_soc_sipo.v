//------------------------------------------------------------------------------
// Title       : Serial in parallel out
// Project     : PUF ASIC Implementation
//------------------------------------------------------------------------------
// File        : puf_soc_sipo.v
// Author      : Sohail <sohail@imse-cnm.csic.es>
// Company     : IMSE-CNM CSIC/US
// Created     : Thu May 26 15:59:58 2022
// Standard    : Verilog 2012
//------------------------------------------------------------------------------
// Copyright (c) 2022 IMSE-CNM CSIC/US
//-----------------------------------------------------------------------------
// Description:
// 							 It takes an serial input and sends parallel out.This sipo module
// asserts ready signal and once start datd from tx device it deasserts ready and
// takes starts capturing data with input valid asserted.  if packet is not lenth
// of 2**n padd zeros or asssert clear signal when done with input bits (TODO).
//-----------------------------------------------------------------------------
module puf_soc_sipo #(parameter N_BIT=32) (
	input              clk       , // Clock
	input              rst_n     , // Asynchronous reset active low
	input              i_rx_ready, // Serial Dat input
	input              i_rx_valid, // Actve High fo valid
	input              i_rx_data , // Serial Dat input
	output             o_rx_ready, // active high
	output             o_rx_valid, // active high
	output [N_BIT-1:0] o_rx_data   // Serial Dat input
);

	reg [        N_BIT-1:0] reg_buff   ;
	reg [				 N_BIT-1:0] bit_cnt    ;
	reg [        N_BIT-1:0] reg_o_data ;
	reg                     reg_o_valid;
	reg                     reg_o_ready;


	wire w_in_valid  = (i_rx_valid & o_rx_ready)              ;
	wire w_out_valid = ((bit_cnt == N_BIT-1) &    i_rx_ready) ;
	// wire w_out_ready = ((bit_cnt == N_BIT-1) &  !(i_rx_ready));
	wire w_out_ready = ((bit_cnt == N_BIT-1) &  (i_rx_ready));

	// Take data input serially and store that datd into register
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			reg_buff <= {N_BIT{1'b0}};
		end else begin
			if (w_in_valid ) begin
				reg_buff <= {i_rx_data,reg_buff[N_BIT-1:1]};
			end
			else begin
				reg_buff <= reg_buff ;
			end
		end
	end

	// bit counter to calculate number of bits
	always @(posedge clk or negedge rst_n ) begin
		if(~rst_n ) begin
			bit_cnt <= {N_BIT{1'b0}};
		end else begin
			if (w_in_valid) begin
				if ((bit_cnt == N_BIT-1) &  !(i_rx_ready)) begin
					bit_cnt <= bit_cnt ;
				end else begin
					bit_cnt <= bit_cnt+1;
				end
			end
			else begin
				bit_cnt <= bit_cnt ;
			end
		end
	end

	// ready logic here
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			reg_o_ready <= 1'b1;
		end else begin
			if (w_out_ready) begin
				reg_o_ready <= 1'b0;
			end
			else begin
				// reg_o_ready <= 1'b1;
				reg_o_ready <= reg_o_ready;
			end
		end
	end

	// valid register logic
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			reg_o_valid <= 1'b0;
			reg_o_data  <= {N_BIT{1'b0}};
		end else begin
			if (w_out_valid) begin
				reg_o_valid <= 1'b1 	 ;
				reg_o_data  <= reg_buff;
			end
			else begin
				reg_o_valid <= 1'b0;
				reg_o_data  <= {N_BIT{1'b0}};
			end
		end
	end

// ready logic
	assign o_rx_ready = reg_o_ready ;
	assign o_rx_valid = reg_o_valid ;
	assign o_rx_data  = reg_buff 		;
	// assign o_rx_data  = (reg_o_valid) ? reg_buff : {$clog2(N_BIT){1'b0}};
	// assign o_rx_valid = (w_out_valid);
	// assign o_rx_ready = ~(w_out_ready);
	// assign o_rx_data  = (w_out_valid) ? reg_buff : {N_BIT{1'b0}};

endmodule : puf_soc_sipo
