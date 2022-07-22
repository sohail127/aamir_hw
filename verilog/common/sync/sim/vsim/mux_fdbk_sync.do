rm -rf work
vlog  -define FAST_TO_SLOW	../../tb/tb_mux_fdbk_sync.sv 		\
../../rtl/mux_fdbk_sync.v
 
vsim tb_mux_fdbk_sync -voptargs=+acc+tb_mux_fdbk_sync -sv_seed random  -t 1ns 

do mux_fdbk_sync_wave.do
run -a
q
