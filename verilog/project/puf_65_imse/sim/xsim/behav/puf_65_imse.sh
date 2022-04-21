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
-prj puf_65_imse.prj 						\
-s puf_65_imse 									\
xil_defaultlib.tb_puf_top 

