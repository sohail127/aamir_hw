
#wave form script

add wave -position insertpoint -color "light blue" -group top sim:/tb_sha_256/usr_clk    
add wave -position insertpoint -color "light blue" -group top sim:/tb_sha_256/usr_reset_n
add wave -position insertpoint -color "light blue" -group top sim:/tb_sha_256/i_start    
add wave -position insertpoint -color "light blue" -group top sim:/tb_sha_256/i_msg      
add wave -position insertpoint -color "light blue" -group top sim:/tb_sha_256/o_valid    
add wave -position insertpoint -color "light blue" -group top sim:/tb_sha_256/o_hash  

add wave -position insertpoint -group cu sim:/tb_sha_256/DUT/cu/*
add wave -position insertpoint -group dp sim:/tb_sha_256/DUT/dp/*  