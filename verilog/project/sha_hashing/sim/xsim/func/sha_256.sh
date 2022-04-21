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
-prj sha_256.prj 								\
-s sha_256 											\
xil_defaultlib.tb_sha_256 

