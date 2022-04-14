`timescale 1ns/1ps
//********************************************************************************
// Title       : PUF counter Testbench
// Project     : ASIC Implementation of PUF
//********************************************************************************
// File        : tb_puf_cntr.v
// Author      : sohail (Email: sohail@imse-cnm.csic.es)
// Company     : IMSE-CNM (http://www.imse-cnm.csic.es)
// Created     : Tue Apr 12 15:12:36 2022
// Standard    : Verilog 2012
//********************************************************************************
// Copyright (c) 2022 IMSE-CNME ()
//********************************************************************************
// Description:
//********************************************************************************

module tb_puf_cntr ();

//********************************************************************************
// ** Parameters here
//********************************************************************************
	localparam CNT_BIT_SIZE = 5 ;
	localparam CNT_SET      = 16;
	localparam CLK_PRD      = 10;

//********************************************************************************
// ** All inputs as register
//********************************************************************************
	reg clk  ;
	reg rst_n;
	reg i_en ;
//********************************************************************************
// ** All outputs as wires
//********************************************************************************
	wire                    o_valid    ;
	wire [CNT_BIT_SIZE-1:0] o_count    ;
	wire [CNT_BIT_SIZE-1:0] o_count_set;

//********************************************************************************
// ** DUT Instantiation
//********************************************************************************
	puf_cntr #(
		.CNT_BIT_SIZE(CNT_BIT_SIZE), 	// CNT_BIT_SIZE = 5 ,
		.CNT_SET     (CNT_SET     ) 	// CNT_SET      = 32
	) DUT (
		.clk        (clk        ), //input                         clk        ,
		.rst_n      (rst_n      ), //input                         rst_n      ,
		.i_en       (i_en       ), //input                         i_en       ,
		.o_valid    (o_valid    ), //output reg                    o_valid    ,
		.o_count    (o_count    ), //output reg [CNT_BIT_SIZE-1:0] o_count    ,
		.o_count_set(o_count_set)  //output reg [CNT_BIT_SIZE-1:0] o_count_set
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
		rst_n = 1'b0;
		i_en 	= 1'b0;
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
		i_en = 1'b1;
	endtask // init_sys

//********************************************************************************
// ** initial procedural block
//********************************************************************************
initial begin
	$display("**********************************************");
	$display("********Start Simulation**********************");
	$display("**********************************************");
	rst_sys();
	init_sys();
	forever begin
		if (o_count_set==CNT_SET) begin
			$display("Counter value is %d",o_count);
			$display("Counter set value is %d",o_count_set);
			break;
		end 
		else begin
			$display("Counter set value is %d",o_count_set);
			$display("Counter value is %d",o_count);
		end
		@(posedge clk); 
	end
	
	$display("**********************************************");
	$display("********Simulation Done***********************");
	$display("**********************************************");
	$stop;
end
endmodule // tb_puf_cntr