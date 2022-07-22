rm -rf work
vlog ../../tb/tb_puf_soc_ro_bank.sv      \
 ../../rtl/puf_soc_ro_bank.v 			 	     \
 ../../rtl/puf_soc_ro_not.v              \
 ../../rtl/puf_soc_ro.v         

vsim tb_puf_soc_ro_bank -voptargs=+acc+tb_puf_soc_ro_bank -sv_seed random
do puf_soc_ro_bank_wave.do
run -a
q
