#!/bin/bash
###########################################################
# Creat simulation snapshot using xelab
# xelab -prj <project_file> \ 
# -s <simulation snapshot> <library>.<top_unit>
###########################################################

xelab --debug typical 					\
-L xil_defaultlib 							\
-L unisims_ver  								\
-L unimacro_ver 								\
-L xilinxcorelib_ver  					\
-L secureip xil_defaultlib.glbl \
-timescale 1ns/1ps  						\
-prj puf_soc_top.prj 						\
-s puf_soc_top 									\
xil_defaultlib.tb_puf_soc_top 

