####################################################################
### SHA Hash Implementation
####################################################################
SHA-2 is implemented using verilog. Initial version has bandwidth of
512-bit and operating frequency is > 200MHz.

####################################################################
##	For Vivado project 
####################################################################

1. Launch Vivado
2. cd <vivado_dir>/sha_hashing
3. mkdir work
4. cd work
5. source ../script/sha_hash.tcl 


####################################################################
##	For Functional Simulation 
####################################################################

1. Launch Modelsim
2. cd <vsim_dir>/sha_hashing
3. mkdir work
4. cd work
5. do ../sim/run_sha256.do

####################################################################
##	For Timing Simulation 
####################################################################

1. Launch Modelsim
2. cd <vsim_dir>/sha_hashing
3. mkdir work
4. cd work
5. do ../sim/post_sim/post_synth_run_sha256.do
