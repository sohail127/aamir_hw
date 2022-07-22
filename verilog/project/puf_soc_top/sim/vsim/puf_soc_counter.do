rm -rf work
vlog ../../tb/tb_puf_soc_counter.sv \
 ../../rtl/puf_soc_counter.v 			 	

vsim tb_puf_soc_counter -voptargs=+acc+tb_puf_soc_counter -sv_seed random
do puf_soc_counter_wave.do
run -a
q
