#!/bin/bash
###########################################################
# Creat simulation snapshot using xelab
# xelab -prj <project_file> \ 
# -s <simulation snapshot> <library>.<top_unit>
###########################################################

xelab --debug typical --relax   \
--mt 8 													\
--maxdelay 						 					\
-L xil_defaultlib 							\
-L unisims_ver  								\
-L unimacro_ver 								\
-L xilinxcorelib_ver  					\
xil_defaultlib.glbl 						\
-L secureip 										\
-L simprims_ver  								\
-transport_int_delays 					\
-pulse_r 0 											\
-pulse_int_r 0 									\
-prj sha_256.prj 								\
-s sha_256 											\
xil_defaultlib.tb_sha_256 

