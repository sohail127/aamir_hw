`timescale 1ns/1ps
//********************************************************************************
// Title       : PUF counter Testbench
// Project     : ASIC Implementation of PUF
//********************************************************************************
// File        : tb_counter.v
// Author      : sohail (Email: sohail@imse-cnm.csic.es)
// Company     : IMSE-CNM (http://www.imse-cnm.csic.es)
// Created     : Tue Apr 12 15:12:36 2022
// Standard    : Verilog 2012
//********************************************************************************
// Copyright (c) 2022 IMSE-CNME ()
//********************************************************************************
// Description:
//********************************************************************************

module tb_puf_soc_counter ();

//********************************************************************************
// ** Parameters here
//********************************************************************************
	localparam CNT_BIT_SIZE = 32;
	localparam CLK_PRD      = 10;
	int        jj               ;

//********************************************************************************
// ** All inputs as register
//********************************************************************************
	reg                    clk      ;
	reg                    rst_n    ;
	reg                    i_cnt_en ;
	reg [CNT_BIT_SIZE-1:0] i_cnt_max;
	reg                    i_op_mode;
//********************************************************************************
// ** All outputs as wires
//********************************************************************************
	wire                    o_valid   ;
	wire [CNT_BIT_SIZE-1:0] o_cnt     ;
	wire                    o_cnt_full;

//********************************************************************************
// ** DUT Instantiation
//********************************************************************************
	puf_soc_counter #(.CNT_BIT_SIZE(CNT_BIT_SIZE)) DUT (
		.clk       (clk       ), // input                         clk       ,
		.rst_n     (rst_n     ), // input                         rst_n     ,
		.i_cnt_en  (i_cnt_en  ), // input                         i_cnt_en  ,
		.i_cnt_max (i_cnt_max ), // input [CNT_BIT_SIZE-1:0]		  i_cnt_max ,
		.i_op_mode (i_op_mode ), // input                         i_op_mode ,
		.o_valid   (o_valid   ), // output reg                    o_valid   ,
		.o_cnt     (o_cnt     ), // output reg [CNT_BIT_SIZE-1:0] o_cnt     ,
		.o_cnt_full(o_cnt_full)  // output                        o_cnt_full
	);


//********************************************************************************
// ** Clock Generator
//********************************************************************************
	initial clk = 1'b1;
	always #((CLK_PRD)/2) clk = ~ clk;

//********************************************************************************
// ** reset task
//********************************************************************************
	task rst_sys();
		$display("**********************************************");
		$display("********System Reset Task ********************");
		$display("**********************************************");
		rst_n 		= 1'b0;
		i_cnt_en 	= 1'b0;
		i_cnt_max = 32'd0;
		repeat (5) begin
			@(posedge clk);
		end
		rst_n =1'b1;
	endtask// rst_sys

//********************************************************************************
// ** initialization task
//********************************************************************************
	task init_sys();
		$display("**********************************************");
		$display("*********Initialization task *****************");
		$display("**********************************************");
		i_cnt_en  = 1'b1;
		i_cnt_max = 32'd1024;
	endtask // init_sys

//********************************************************************************
// ** monitor count
//********************************************************************************
	task mon_count();
		forever begin
			@(posedge clk);

			if( jj== 'd500) begin
				i_op_mode = 1'b1;
				i_cnt_en 	= 1'b0;
			end 

			if (o_valid) begin
				if (o_cnt_full) begin
					$display("Counter Max value is :: %0d",o_cnt     );
					$display("o_cnt_full valus is  :: %0d",o_cnt_full);
					$display("o_valid is  				 :: %0d",o_valid   );
					$stop();
				end else begin
					$display("Counter Max value is :: %0d",o_cnt     );
					$display("o_cnt_full valus is  :: %0d",o_cnt_full);
					$display("o_valid is  				 :: %0d",o_valid   );
					i_op_mode = 1'b0;
					i_cnt_en 	= 1'b1;
				end
			end else begin
				$display("Counter value is %d",o_cnt);
			end
			jj++;
		end
	endtask : mon_count
//********************************************************************************
// ** initial procedural block
//********************************************************************************
	initial begin
		$display("**********************************************");
		$display("********Start Simulation**********************");
		$display("**********************************************");
		rst_sys();
		init_sys();
		mon_count();
		$display("**********************************************");
		$display("********Simulation Done***********************");
		$display("**********************************************");
		$stop;
	end
endmodule // tb_puf_soc_counter