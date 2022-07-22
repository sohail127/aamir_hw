rm -rf work
vlog ../../tb/tb_puf_soc_sipo.sv \
../../rtl/puf_soc_sipo.v

vsim tb_puf_soc_sipo -voptargs=+acc+tb_puf_soc_sipo -sv_seed random
do puf_soc_sipo_wave.do
run -a 
q