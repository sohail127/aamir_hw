rm -rf work
# vlog ../tb/sha_256_tb.v  \
#  ../rtl/sha_256.v 			 \
# ../rtl/round_constant.v  \
# ../rtl/message_schdule.v \
# ../rtl/round.v 	 				 \
# ../rtl/counter.v 				 \
# ../rtl/cu_sha.v  				 \
# ../rtl/datapath.v 
vlog ../synth/sha_hash_post_synth_netlist.v

# eval vsim -sdftyp sha_256=../sdf/sha_hash_post_synth.sdf sha_256_tb
vsim -sdftyp DUT=../sdf/sha_hash_post_synth.sdf sha_256
# vsim sha_256_tb -voptargs=+acc+sha_256_tb -sv_seed random
# do wave.do
# run -a
# vsim -sdftyp /testbench/DUT=./annotations/interface.sdf