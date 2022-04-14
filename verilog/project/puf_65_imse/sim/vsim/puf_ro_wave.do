add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_ro/i_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_ro/o_ro        
add wave -position insertpoint -color "Cyan" 			 -radix unsigned -group wires  sim:/tb_puf_ro/DUT/w_nand
add wave -position insertpoint -color "Cyan" 			 -radix unsigned -group wires  sim:/tb_puf_ro/DUT/w_ring