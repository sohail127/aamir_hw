`timescale 1ns/1ps
//********************************************************************************
// Title       : PUF top module
// Project     : ASIC Implementation of PUF
//********************************************************************************
// File        : puf_top.v
// Author      : sohail (Email:sohail@imse-cnm.csic.es)
// Company     : IMSE-CNM (http://www.imse-cnm.csic.es)
// Created     : Tue Apr 12 17:58:02 2022
// Standard    : Verilog 2012
//********************************************************************************
// Copyright (c) 2022 IMSE-CNME ()
//********************************************************************************
// Description:
//********************************************************************************
module tb_puf_top ();

//********************************************************************************
// ** Parameters here
//********************************************************************************

	parameter CNT_BIT_SIZE = 5  ; 
	parameter CNT_SET      = 32 ;
	parameter N_STAGE 		 = 6 	;

//********************************************************************************
// ** Outputs are wire
//********************************************************************************
	reg i_en   ;
	reg rst_n  ;

//********************************************************************************
// ** Outputs are wire
//********************************************************************************
	wire                    o_valid     ; 
	wire [CNT_BIT_SIZE-1:0] o_count     ; 
	wire [     CNT_SET-1:0] o_count_set ; 

//********************************************************************************
// ** Module instantiation
//********************************************************************************

puf_top #(
	.CNT_BIT_SIZE(CNT_BIT_SIZE),
	.CNT_SET     (CNT_SET     ),
	.N_STAGE 		 (N_STAGE 		)
) DUT(
	.i_en       (i_en       ),
	.rst_n      (rst_n      ),
	.o_valid    (o_valid    ),
	.o_count    (o_count    ),
	.o_count_set(o_count_set)
);

//********************************************************************************
// task initial system
//********************************************************************************
task init_sys(); 
	begin
		i_en 	= 1'b0;
		#10	
		i_en 	= 1'b1;
		$display("Reset is de asserted");
		repeat (5) begin
			rst_n = 1'b0;
			#5;
		end
		$display("Initialization task");
		rst_n = 1'b1;
	end
endtask : init_sys

//********************************************************************************
// procedural block
//********************************************************************************

initial begin
	$display("**********************************************");
	$display("********Start Simulation**********************");
	$display("**********************************************");
	init_sys();
	#200;
	$display("**********************************************");	
	$display("********Simulation Done***********************");
	$display("**********************************************");
	$stop;
end

endmodule // tb_puf_top