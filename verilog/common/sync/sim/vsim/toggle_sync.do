rm -rf work
vlog -define ERROR_TEST ../../tb/tb_toggle_sync.sv 		\
../../rtl/toggle_sync.v 						
 
vsim tb_toggle_sync -voptargs=+acc+tb_toggle_sync -sv_seed random  -t 1ns 

do toggle_sync_wave.do
run -a
q
