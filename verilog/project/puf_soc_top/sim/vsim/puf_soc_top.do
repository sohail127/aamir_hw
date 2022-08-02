rm -rf work
vlog -define SYNC_SYS ../../tb/tb_puf_soc_top.sv 		\
../../rtl/puf_soc_top.v 						\
../../rtl/puf_soc_cntrlr.v 					\
../../rtl/puf_soc_sipo.v            \
../../rtl/puf_soc_ro_decoder.v      \
../../rtl/puf_soc_ro_not.v          \
../../rtl/puf_soc_ro.v              \
../../rtl/puf_soc_ro_bank.v         \
../../rtl/puf_soc_counter.v         \
../../rtl/puf_soc_comparator.v      \
../../rtl/dflipflop.v     				  \
../../rtl/m_ff_sync.v     				  \
../../rtl/puls_hnd_shk_sync.v       \
../../rtl/puf_soc_syn.v     			  \
../../rtl/puf_soc_piso.v            \
../../rtl/puf_soc_mux.v             \
../../rtl/puf_soc_assembler.v       \
../../rtl/puf_soc_dta_pth.v                            
 
vsim tb_puf_soc_top -voptargs=+acc+tb_puf_soc_top -sv_seed random -t 1ns
do puf_soc_top_wave.do
run -a
q
