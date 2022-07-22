add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_puls_hnd_shk_sync/i_src_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_puls_hnd_shk_sync/i_dst_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group rst 	 	 sim:/tb_puls_hnd_shk_sync/rst_n 
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_puls_hnd_shk_sync/i_src_puls   
add wave -position insertpoint -color "light blue"        -radix unsigned -group dut  	 sim:/tb_puls_hnd_shk_sync/inst_puls_hnd_shk_sync/r_src_toggle 
add wave -position insertpoint -color "light blue"        -radix unsigned -group dut  	 sim:/tb_puls_hnd_shk_sync/inst_puls_hnd_shk_sync/w_dst_dbl_ff 
add wave -position insertpoint -color "light blue"        -radix unsigned -group dut  	 sim:/tb_puls_hnd_shk_sync/inst_puls_hnd_shk_sync/w_src_dbl_ff 
add wave -position insertpoint -color "light blue"        -radix unsigned -group dut  	 sim:/tb_puls_hnd_shk_sync/inst_puls_hnd_shk_sync/w_dst_puls   
add wave -position insertpoint -color "light blue"        -radix unsigned -group dut  	 sim:/tb_puls_hnd_shk_sync/inst_puls_hnd_shk_sync/r_dst_thrd_ff
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_puls_hnd_shk_sync/o_dst_puls   
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_puls_hnd_shk_sync/o_dst_ready  
