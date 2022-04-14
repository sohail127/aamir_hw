rm -rf work
vlog ../../tb/tb_puf_top.sv \
 ../../rtl/puf_not.v        \
 ../../rtl/puf_ro.v         \
 ../../rtl/puf_cntr.v       \
 ../../rtl/puf_top.v        

vsim tb_puf_top -voptargs=+acc+tb_puf_top -sv_seed random
do puf_top_wave.do
run -a
q
