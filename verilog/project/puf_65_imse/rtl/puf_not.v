`timescale 1ns/1ps
//********************************************************************************
// Title       : PUF Not gate
// Project     : ASIC Implementation of PUF
//********************************************************************************
// File        : puf_not.v
// Author      : sohail (Email: sohail@imse-cnm.csic.es)
// Company     : IMSE-CNM (http://www.imse-cnm.csic.es)
// Created     : Thr Apr 14 15:19:25 2022
// Standard    : Verilog 2012
//********************************************************************************
// Copyright (c) 2022 IMSE-CNME ()
//********************************************************************************
// Description:
//						Counter logic, its an CNT_BIT_SIZE counter with active low reset
//********************************************************************************
module puf_not (
	input  i_not,
	output o_not
);
	not  #1(o_not,i_not);
	// not  n1(o_not,i_not);
endmodule // puf_not