
#wave form script

add wave -position insertpoint -color "light blue" -radix unsigned -group cb sim:/tb_puf_soc_counter/clk   
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_soc_counter/rst_n 
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_soc_counter/i_cnt_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_soc_counter/i_cnt_max  
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_soc_counter/i_op_mode  
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_soc_counter/o_valid        
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_soc_counter/o_cnt        
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_soc_counter/o_cnt_full 
#DUT  
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT sim:/tb_puf_soc_counter/DUT/w_cnt_en    
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT sim:/tb_puf_soc_counter/DUT/r_cnt_max   
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT sim:/tb_puf_soc_counter/DUT/r_max_en    
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT sim:/tb_puf_soc_counter/DUT/r_dbl_o_full
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT sim:/tb_puf_soc_counter/DUT/r_op_mode   
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT sim:/tb_puf_soc_counter/DUT/r_o_cnt     
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT sim:/tb_puf_soc_counter/DUT/r_o_cnt_full

