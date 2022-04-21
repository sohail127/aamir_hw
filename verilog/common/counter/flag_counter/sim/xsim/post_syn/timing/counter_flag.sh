#!/bin/bash
###########################################################
# Creat simulation snapshot using xelab
# xelab -prj <project_file> \ 
# -s <simulation snapshot> <library>.<top_unit>
###########################################################

# xelab --debug typical 					\
# --maxdelay 						 					\
# --mt 8 													\
# -L xil_defaultlib 							\
# -L secureip  \
# -L simprims_ver  								\
# -prj counter_flag.prj 					\
# -s counter_flag 								\
# -transport_int_delays 					\
# -pulse_r 0 											\
# -pulse_int_r 0 									\
# -pulse_e 0 		 									\
# -pulse_int_e 0 									\
# xil_defaultlib.flag_counter_tb xil_defaultlib.glbl

# xelab -wto cbe395c45f614551adef5ce6598a3ab7 \
# -L unisims_ver  											\

xelab -prj counter_flag.prj 					\
--incr --debug typical 								\
--relax --mt 8 				 								\
--maxdelay 		 				 								\
-L xil_defaultlib 		 								\
-L unimacro_ver 											\
-L xilinxcorelib_ver  								\
-L simprims_ver 			 								\
-L secureip 					 								\
--snapshot counter_flag							  \
-transport_int_delays 								\
-pulse_r 0 														\
-pulse_int_r 0												\
-pulse_e 0 														\
-pulse_int_e 0 												\
xil_defaultlib.flag_counter_tb xil_defaultlib.glbl -log elaborate.log
