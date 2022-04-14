
#wave form script
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_top/rst_n 
add wave -position insertpoint -color "light blue" -radix unsigned -group input sim:/tb_puf_top/i_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_top/o_valid        
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_top/o_count        
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_top/o_count_set 
# sub modules 	
add wave -position insertpoint -color "Cyan" 			 -radix unsigned -group puf_ro sim:/tb_puf_top/DUT/i_puf_ro/*
