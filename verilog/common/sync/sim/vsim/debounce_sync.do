rm -rf work
vlog  ../../tb/tb_debounce_sync.sv 		\
../../rtl/debounce_sync.v 						
 
vsim tb_debounce_sync -voptargs=+acc+tb_debounce_sync -sv_seed random  -t 1ns 

do debounce_sync_wave.do
run -a
q
