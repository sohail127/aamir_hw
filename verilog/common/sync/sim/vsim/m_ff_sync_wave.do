add wave -position insertpoint -color "light blue" 				-radix unsigned -group cb 		 sim:/tb_m_ff_sync/clk   
add wave -position insertpoint -color "light blue" 				-radix unsigned -group rst 	 	 sim:/tb_m_ff_sync/rst_n 
add wave -position insertpoint -color "Salmon" 		 				-radix unsigned -group input   sim:/tb_m_ff_sync/i_data   
add wave -position insertpoint -color "Medium Violet Red" -radix unsigned -group output  sim:/tb_m_ff_sync/o_data   