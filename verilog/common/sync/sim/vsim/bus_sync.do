rm -rf work
vlog  -define SLW_TO_FAST	../../tb/tb_bus_sync.sv 		\
../../rtl/dflipflop.v 						\
../../rtl/m_ff_sync.v 						\
../../rtl/puls_hnd_shk_sync.v  		\
../../rtl/bus_sync.v
 
vsim tb_bus_sync -voptargs=+acc+tb_bus_sync -sv_seed random  -t 1ns 

do bus_sync_wave.do
run -a
q
