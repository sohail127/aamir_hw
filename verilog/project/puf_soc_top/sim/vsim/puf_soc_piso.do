rm -rf work
vlog ../../tb/tb_puf_soc_piso.sv \
../../rtl/puf_soc_piso.v

vsim tb_puf_soc_piso -voptargs=+acc+tb_puf_soc_piso -sv_seed random
do puf_soc_piso_wave.do
run -a 
q