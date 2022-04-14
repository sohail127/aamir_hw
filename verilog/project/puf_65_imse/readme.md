##################################################################
##  FPGA Implementation of Physical Unclonable Function (PUF)
##################################################################
# Synthesis and Simulation 
##################################################################
# Vivado Syntheis
##################################################################
1. cd <system_path>/puf_65_imse
2. mkdir work
3. cd work
4. vivado
5. source ../script/puf_ro.tcl

##################################################################
# Vivado Functional Simulation
##################################################################
1. cd <system_path>/puf_65_imse
2. cd sim/xsim
3. ./run_sim.sh

##################################################################
# Modelsim/Questasim Functional Simulation
##################################################################
1. cd <system_path>/puf_65_imse
2. cd sim/vsim
3. do puf_top.do
