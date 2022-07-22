
//------------------------------------------------------------------------------
// Title       : Serial in parallel out
// Project     : PUF ASIC Implementation
//------------------------------------------------------------------------------
// File        : puf_soc_piso.v
// Author      : Sohail <sohail@imse-cnm.csic.es>
// Company     : IMSE-CNM CSIC/US
// Created     : Fri May 27 10:51:09 2022
// Standard    : Verilog 2012
//------------------------------------------------------------------------------
// Copyright (c) 2022 IMSE-CNM CSIC/US
//-----------------------------------------------------------------------------
// Description:
// 					Its an paramterizabe serializer module. Takes an parallel output and
// starts serial transmission when i_tx_valid signal is asserted. It right shifts
// data on each rising edge of clock.
//-----------------------------------------------------------------------------

module puf_soc_piso #(
	parameter FRAM_SIZE = 160,
	parameter NORM_MOD  = 34 ,
	parameter DEBUG_MOD = 133
) (
	input                  clk       , // clock
	input                  rst_n     , // active low reset
	input                  i_tx_en   , // 1: to accept serial data
	input                  i_tx_mode , // i_tx_mode : 1 for debugging frame, 0: for normal frame
	input                  i_tx_ready, // shift_lr : 1 for right shift, 0: for left shift
	input                  i_tx_valid, // shift_lr : 1 for right shift, 0: for left shift
	input  [FRAM_SIZE-1:0] i_tx_data , // register data
	output                 o_tx_ready, // Assert high to accept new data
	output                 o_tx_data , // serial output
	output                 o_tx_valid, // 1: when output is valid
	output                 o_tx_done   // 1: when output is valid
);

	wire [$clog2(FRAM_SIZE)-1:0] w_max_cnt; // maximum count value
	wire                         w_tx_en  ;
	wire                         w_ld_en  ;
	// register declaration
	reg [        FRAM_SIZE-1:0] reg_data     ;
	reg [$clog2(FRAM_SIZE)-1:0] reg_shift_cnt; // shift counter
	reg                         reg_o_shift  ;
	reg                         reg_o_ready  ;
	reg                         reg_o_valid  ;
	reg                         reg_o_done   ;

	// valid ready handshake
	assign w_tx_en = i_tx_en & i_tx_ready & ~ o_tx_ready;
	assign w_ld_en = i_tx_valid & o_tx_ready;
	
	// load and shift logic here
	always@(posedge clk) begin
		if (!rst_n) begin
			reg_data    <= {FRAM_SIZE{1'b0}};
			reg_o_valid <= 1'b0;
			reg_o_shift <= 1'b0;
		end
		else	begin
			if (w_ld_en) begin // laod data
				reg_data <= i_tx_data;
			end
			else	begin
				if (w_tx_en ) begin // 1: for  shift
					if (reg_shift_cnt==w_max_cnt) begin // to check shift count
						reg_o_valid <= 'b0;
					end else begin
						reg_o_shift <= reg_data[0];
						reg_data    <= {1'b0,reg_data[FRAM_SIZE-1:1]};// shift right
						reg_o_valid <= 1'b1;
					end
				end else	begin // shifting is not enable
					reg_o_shift <= 1'b0;
					reg_data    <= reg_data ;// shift right
					reg_o_valid <= 1'b0;
				end
			end
		end
	end

	// shifting counter logic here
	always@(posedge clk , negedge rst_n ) begin
		if (!rst_n) begin
			reg_shift_cnt <= {$clog2(FRAM_SIZE){1'b0}};
		end
		else begin
			if (w_tx_en) begin
				if (reg_shift_cnt == w_max_cnt) begin
					reg_shift_cnt <= {$clog2(FRAM_SIZE){1'b0}};
				end else begin
					reg_shift_cnt <= reg_shift_cnt+1;
				end
			end
			else begin
				reg_shift_cnt <= reg_shift_cnt;
			end
		end
	end

	// ready logic here
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			reg_o_ready <= 1'b1;
		end else begin
			if (i_tx_valid) begin  // laod  is assserted
				reg_o_ready <= 1'b0;
			end else begin
				if (reg_shift_cnt == w_max_cnt) begin
					reg_o_ready <= 1'b1;
				end else begin
					reg_o_ready <= reg_o_ready;
				end
			end
		end
	end  // always @(posedge clk or negedge rst_n)

// done logic here
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			reg_o_done <= 1'b0;
		end else begin
			if (reg_shift_cnt == w_max_cnt-1) begin //TBD
				reg_o_done <= 1'b1;
			end else begin
				reg_o_done <= 1'b0;
			end
		end
	end
	// maximum assignment
	// assign w_max_cnt = (i_tx_mode) ? DEBUG_MOD-1 : NORM_MOD-1;
	assign w_max_cnt = (i_tx_mode) ? DEBUG_MOD : NORM_MOD;
	// output assignment
	assign o_tx_valid = reg_o_valid ;
	assign o_tx_data  = reg_o_shift ;
	assign o_tx_ready = reg_o_ready ;
	assign o_tx_done  = reg_o_done  ;
endmodule : puf_soc_piso