add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_toggle_sync/i_src_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_toggle_sync/i_dst_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group rst 	 	 sim:/tb_toggle_sync/rst_n 
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_toggle_sync/i_src_data   
add wave -position insertpoint -color "light blue"         -radix unsigned -group input  sim:/tb_toggle_sync/inst_toggle_sync/src_dff
add wave -position insertpoint -color "light blue"         -radix unsigned -group input  sim:/tb_toggle_sync/inst_toggle_sync/toogle_src
add wave -position insertpoint -color "light blue"         -radix unsigned -group output sim:/tb_toggle_sync/inst_toggle_sync/dbl_ff_syn[0]
add wave -position insertpoint -color "light blue"         -radix unsigned -group output sim:/tb_toggle_sync/inst_toggle_sync/dbl_ff_syn[1]
add wave -position insertpoint -color "light blue"         -radix unsigned -group output sim:/tb_toggle_sync/inst_toggle_sync/dbl_ff_syn[2]
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_toggle_sync/o_dst_data   