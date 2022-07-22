#clock and reset
add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_bus_sync/i_src_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_bus_sync/i_dst_clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group rst 	 	 sim:/tb_bus_sync/rst_n 
#inputs
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_bus_sync/i_src_data   
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_bus_sync/i_src_valid  

#dut signals
add wave -position insertpoint -color "light blue"        -radix unsigned -group dut  	 sim:/tb_bus_sync/inst_bus_sync/w_dst_valid 
#outputs
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_bus_sync/o_dst_data  
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_bus_sync/o_dst_ready 
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_bus_sync/o_dst_valid 




