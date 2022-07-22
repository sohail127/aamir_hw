add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_debounce_sync/clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group rst 	 	 sim:/tb_debounce_sync/rst_n 
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_debounce_sync/i_data   
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_debounce_sync/o_data   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group dut 		 sim:/tb_debounce_sync/inst_debounce_sync/r_dbl_ff