rm -rf work
vlog ../tb/tb_sha_256.sv 	\
 ../rtl/sha_256.v 			 	\
 ../rtl/round_constant.v 	\
 ../rtl/message_schdule.v \
 ../rtl/round.v 	 				\
 ../rtl/counter.v 				\
 ../rtl/cu_sha.v  				\
 ../rtl/datapath.v 

vsim tb_sha_256 -voptargs=+acc+tb_sha_256 -sv_seed random
do sha_wave.do
run -a
q
