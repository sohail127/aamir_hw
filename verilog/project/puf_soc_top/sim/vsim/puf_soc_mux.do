rm -rf work
vlog ../../tb/tb_puf_soc_mux.sv 	    \
     ../../rtl/puf_soc_mux.v    

vsim tb_puf_soc_mux -voptargs=+acc+tb_puf_soc_mux -sv_seed random
do puf_soc_mux_wave.do
run -a
q
