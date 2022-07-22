
#wave form script

add wave -position insertpoint -color "light blue" -radix unsigned -group cb sim:/tb_puf_soc_counter/clk   
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_soc_counter/rst_n 
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_soc_counter/i_cnt_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_soc_counter/o_valid        
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_soc_counter/o_cnt        
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_soc_counter/o_cnt_full 

