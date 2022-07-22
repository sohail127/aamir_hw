#!/bin/bash
###########################################################
# Creat simulation snapshot using xelab
# xelab -prj <project_file> \ 
# -s <simulation snapshot> <library>.<top_unit>
###########################################################

xelab --define NETLIST 								\
-timescale 1ns/1ps  									\
-prj puf_soc_top.prj 									\
--incr --debug typical 								\
--relax --mt 8 				 								\
--maxdelay 		 				 								\
-L xil_defaultlib 		 								\
-L unimacro_ver 											\
-L xilinxcorelib_ver  								\
-L simprims_ver 			 								\
-L secureip 					 								\
--snapshot puf_soc_top							  \
-transport_int_delays 								\
-pulse_r 0 														\
-pulse_int_r 0												\
-pulse_e 0 														\
-pulse_int_e 0 												\
xil_defaultlib.tb_puf_soc_top xil_defaultlib.glbl -log elaborate.log
