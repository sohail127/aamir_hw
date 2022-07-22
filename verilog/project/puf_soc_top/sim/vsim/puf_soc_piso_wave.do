#clocking group
	add wave -position insertpoint -color "light blue" -group clock  sim:/tb_puf_soc_piso/clk       
# Reset Gropu
	add wave -position insertpoint -group reset 		sim:/tb_puf_soc_piso/rst_n
# input gropus
	add wave -position insertpoint -group piso_in  	sim:/tb_puf_soc_piso/i_tx_en   
	add wave -position insertpoint -group piso_in  	sim:/tb_puf_soc_piso/i_tx_mode 
	add wave -position insertpoint -group piso_in  	sim:/tb_puf_soc_piso/i_tx_ready
	add wave -position insertpoint -group piso_in  	sim:/tb_puf_soc_piso/i_tx_valid
	add wave -position insertpoint -group piso_in  	sim:/tb_puf_soc_piso/i_tx_data 
# output group
	add wave -position insertpoint -group piso_out 	sim:/tb_puf_soc_piso/o_tx_ready
	add wave -position insertpoint -group piso_out 	sim:/tb_puf_soc_piso/o_tx_data 
	add wave -position insertpoint -group piso_out 	sim:/tb_puf_soc_piso/o_tx_valid
	add wave -position insertpoint -group piso_out 	sim:/tb_puf_soc_piso/o_tx_done 

# DUT signals
	add wave -position insertpoint -group dut_sig		sim:/tb_puf_soc_piso/DUT/reg_shift_cnt
	add wave -position insertpoint -group dut_sig		sim:/tb_puf_soc_piso/DUT/w_max_cnt
	add wave -position insertpoint -group  TB_CNT   sim:/tb_puf_soc_piso/nrm_cnt
	add wave -position insertpoint -group  TB_CNT   sim:/tb_puf_soc_piso/debug_cnt
   
   
   