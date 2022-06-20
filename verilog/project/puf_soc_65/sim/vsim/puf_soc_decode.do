rm -rf work
vlog ../../tb/tb_puf_soc_ro_decoder.sv \
../../rtl/puf_soc_ro_decoder.v

vsim tb_puf_soc_ro_decoder -voptargs=+acc+tb_puf_soc_ro_decoder -sv_seed random
do puf_soc_decode_wave.do
run -a 
q