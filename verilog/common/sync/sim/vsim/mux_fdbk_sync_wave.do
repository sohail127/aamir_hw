#clock and reset
add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_mux_fdbk_sync/i_src_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_mux_fdbk_sync/i_dst_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group rst 	 	 sim:/tb_mux_fdbk_sync/rst_n 
#inputs
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_mux_fdbk_sync/i_src_data   
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_mux_fdbk_sync/i_src_valid  

#dut signals
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_fdbk_sync/inst_mux_fdbk_sync/r_src_data
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_fdbk_sync/inst_mux_fdbk_sync/r_src_valid
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_fdbk_sync/inst_mux_fdbk_sync/r_dst_dbl_ff[0]
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_fdbk_sync/inst_mux_fdbk_sync/r_dst_dbl_ff[1] 
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_fdbk_sync/inst_mux_fdbk_sync/r_re_sync_src_ff[0] 
add wave -position insertpoint -color "light blue"         -radix unsigned -group DUT 	 sim:/tb_mux_fdbk_sync/inst_mux_fdbk_sync/r_re_sync_src_ff[1] 
#outputs
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_mux_fdbk_sync/o_dst_data  
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_mux_fdbk_sync/o_dst_ready 
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_mux_fdbk_sync/o_dst_valid 




