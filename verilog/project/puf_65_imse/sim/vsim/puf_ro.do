rm -rf work
vlog ../../tb/tb_puf_ro.sv \
 ../../rtl/puf_not.v 			 	\
 ../../rtl/puf_ro.v         

vsim tb_puf_ro -voptargs=+acc+tb_puf_ro -sv_seed random
do puf_ro_wave.do
run -a
q
