rm -rf work
vlog  -define FAST_TO_SLOW	../../tb/tb_puls_hnd_shk_sync.sv 		\
../../rtl/dflipflop.v 						\
../../rtl/m_ff_sync.v 						\
../../rtl/puls_hnd_shk_sync.v  						
 
vsim tb_puls_hnd_shk_sync -voptargs=+acc+tb_puls_hnd_shk_sync -sv_seed random  -t 1ns 

do puls_hnd_shk_sync_wave.do
run -a
q
