rm -rf work

vlib work
vlib msim
vlib msim/xil_defaultlib
vmap xil_defaultlib msim/xil_defaultlib
vlog -work xil_defaultlib  ../tb/tb_sha_256.sv  ../synth/sha_hash_post_synth_netlist.v

# eval vsim -sdftyp sha_256=../sdf/sha_hash_post_synth.sdf sha_256_tb
# vsim   -L unisims_ver -L unimacro_ver -L simprims_ver -L secureip -lib xil_defaultlib  xil_defaultlib.glbl -sdftyp ../sdf/sha_hash_post_synth.sdf sha_256
vsim   -t 1ps -L work -L msim/xil_defaultlib -voptargs="+acc" +sdf_verbose -L unisims_ver -L secureip -lib xil_defaultlib  xil_defaultlib.glbl -sdftyp DUT=../sdf/sha_hash_post_synth.sdf tb_sha_256
# do wave.do
run -a
# vsim -sdftyp /testbench/DUT=./annotations/interface.sdf

# vsim -t 1ps -L gate_work -L work -voptargs="+acc" +sdf_verbose +bitblast tb

