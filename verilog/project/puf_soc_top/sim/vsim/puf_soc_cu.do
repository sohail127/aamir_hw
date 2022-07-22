rm -rf work
vlog ../../tb/tb_puf_soc_cntrlr.sv \
 ../../rtl/puf_soc_cntrlr.v 			 	

vsim tb_puf_soc_cntrlr -voptargs=+acc+tb_puf_soc_cntrlr -sv_seed random
do puf_soc_cu_wave.do
run -a
q
