rm -rf work
# vlog ../tb/sha_256_tb.v  \
#  ../rtl/sha_256.v 			 \
# ../rtl/round_constant.v  \
# ../rtl/message_schdule.v \
# ../rtl/round.v 	 				 \
# ../rtl/counter.v 				 \
# ../rtl/cu_sha.v  				 \
# ../rtl/datapath.v 
vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib
vlog -work xil_defaultlib  ../tb/sha_256_tb.v  ../synth/sha_hash_post_synth_netlist.v

# eval vsim -sdftyp sha_256=../sdf/sha_hash_post_synth.sdf sha_256_tb
vsim   -L unisims_ver -L unimacro_ver -L simprims_ver -L secureip -lib xil_defaultlib  xil_defaultlib.glbl -sdftyp ../sdf/sha_hash_post_synth.sdf sha_256
# vsim sha_256_tb -voptargs=+acc+sha_256_tb -sv_seed random
# do wave.do
# run -a
# vsim -sdftyp /testbench/DUT=./annotations/interface.sdf

