
#wave form script
add wave -position insertpoint -color "light blue" -group clocink  sim:/tb_shift_register/clk       
add wave -position insertpoint -group reset 	sim:/tb_shift_register/rst_n          
add wave -position insertpoint -group reg_in  sim:/tb_shift_register/i_ld_data 
add wave -position insertpoint -group reg_in  sim:/tb_shift_register/i_sht_lr  
add wave -position insertpoint -group reg_in  sim:/tb_shift_register/i_reg_data
add wave -position insertpoint -group reg_out sim:/tb_shift_register/o_busy    
add wave -position insertpoint -group reg_out sim:/tb_shift_register/o_shift   
add wave -position insertpoint -group reg_out sim:/tb_shift_register/o_valid   