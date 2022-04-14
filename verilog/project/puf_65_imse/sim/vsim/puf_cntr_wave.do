
#wave form script

add wave -position insertpoint -color "light blue" -radix unsigned -group cb sim:/tb_puf_cntr/clk   
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_cntr/rst_n 
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_cntr/i_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_cntr/o_valid        
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_cntr/o_count        
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_cntr/o_count_set 

