rm -rf work
vlog  ../../tb/tb_m_ff_sync.sv 		\
../../rtl/dflipflop.v 						\
../../rtl/m_ff_sync.v 						
 
vsim tb_m_ff_sync -voptargs=+acc+tb_m_ff_sync -sv_seed random  -t 1ns 

do m_ff_sync_wave.do
run -a
q
