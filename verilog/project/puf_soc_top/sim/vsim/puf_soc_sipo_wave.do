#wave form script
add wave -position insertpoint -color "light blue" -group clock  sim:/tb_puf_soc_sipo/clk       
add wave -position insertpoint -group reset 		sim:/tb_puf_soc_sipo/rst_n
add wave -position insertpoint -group sipo_in  	sim:/tb_puf_soc_sipo/i_rx_ready
add wave -position insertpoint -group sipo_in  	sim:/tb_puf_soc_sipo/i_rx_valid
add wave -position insertpoint -group sipo_in  	sim:/tb_puf_soc_sipo/i_rx_data 
add wave -position insertpoint -group sipo_out 	sim:/tb_puf_soc_sipo/o_rx_ready
add wave -position insertpoint -group sipo_out 	sim:/tb_puf_soc_sipo/o_rx_valid
add wave -position insertpoint -group sipo_out 	sim:/tb_puf_soc_sipo/o_rx_data 
add wave -position insertpoint -group dut_sig		sim:/tb_puf_soc_sipo/DUT/bit_cnt
add wave -position insertpoint -group dut_sig		sim:/tb_puf_soc_sipo/DUT/reg_buff