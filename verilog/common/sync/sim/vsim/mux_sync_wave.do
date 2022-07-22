add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_mux_sync/i_src_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_mux_sync/i_dst_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group rst 	 	 sim:/tb_mux_sync/rst_n 
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_mux_sync/i_src_data   
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_mux_sync/i_src_valid   
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_sync/inst_mux_sync/r_src_data
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_sync/inst_mux_sync/r_src_valid
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_sync/inst_mux_sync/r_dst_dbl_ff[0]
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_sync/inst_mux_sync/r_dst_dbl_ff[1]
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_mux_sync/o_dst_data   
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_mux_sync/o_dst_valid   