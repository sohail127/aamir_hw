set PROJ_DIR [pwd]/../../
set PROJ_NAME puf_ro_65
set XILINX_VIVADO /EDA/Xilinx/Vivado/2021.1

rm -rf work
rm -rf msim

vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vlog  	-work xil_defaultlib															 \
${PROJ_DIR}/netlist/${PROJ_NAME}_post_synth_time_netlist.v \
${PROJ_DIR}/tb/tb_puf_top.sv												 			 \
$XILINX_VIVADO/data/verilog/src/glbl.v
vsim  -L xil_defaultlib     					\
-L unisims_ver  											\
-L unimacro_ver 											\
-L secureip														\
xil_defaultlib.tb_puf_top xil_defaultlib.glbl 					 								

