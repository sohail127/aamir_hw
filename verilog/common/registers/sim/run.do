#rm -rf work
vlog ../tb/tb_shift_register.sv ../rtl/shift_register.v
vsim tb_shift_register -voptargs=+acc+tb_shift_register -sv_seed random
do wave.do
run -a
