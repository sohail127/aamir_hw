rm -rf work
vlog ../../tb/tb_puf_cntr.sv \
 ../../rtl/puf_cntr.v 			 	

vsim tb_puf_cntr -voptargs=+acc+tb_puf_cntr -sv_seed random
do puf_cntr_wave.do
run -a
q
