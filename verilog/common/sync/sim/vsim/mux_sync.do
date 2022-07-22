rm -rf work
vlog -define ERROR_TEST	 ../../tb/tb_mux_sync.sv 		\
../../rtl/mux_sync.v 						
 
vsim tb_mux_sync -voptargs=+acc+tb_mux_sync -sv_seed random  -t 1ns 

do mux_sync_wave.do
run -a
q
