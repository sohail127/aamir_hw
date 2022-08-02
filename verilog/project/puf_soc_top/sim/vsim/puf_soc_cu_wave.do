#wave form script
add wave -position insertpoint -color "light blue" -radix unsigned -group cb 		 sim:/tb_puf_soc_cntrlr/clk          
#Reset here
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_cntrlr/rst_n        
#Inputs
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_cntrlr/i_start      
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_cntrlr/i_op_mode    
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_cntrlr/i_rx_ready   
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_cntrlr/i_rx_valid   
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_cntrlr/i_rx_done    
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_cntrlr/i_rx_data    
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_cntrlr/i_exec_done  
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_cntrlr/i_tx_done    
#Outputs
add wave -position insertpoint -color "light blue" -radix unsigned -group output  sim:/tb_puf_soc_cntrlr/o_fsm_state  
add wave -position insertpoint -color "light blue" -radix unsigned -group output  sim:/tb_puf_soc_cntrlr/o_dcod_ready 
add wave -position insertpoint -color "light blue" -radix unsigned -group output  sim:/tb_puf_soc_cntrlr/o_dcod_enable
add wave -position insertpoint -color "light blue" -radix unsigned -group output  sim:/tb_puf_soc_cntrlr/o_exec_enable
add wave -position insertpoint -color "light blue" -radix unsigned -group output  sim:/tb_puf_soc_cntrlr/o_tx_enable  
add wave -position insertpoint -color "light blue" -radix unsigned -group output  sim:/tb_puf_soc_cntrlr/o_dump_enable
add wave -position insertpoint -color "light blue" -radix unsigned -group output  sim:/tb_puf_soc_cntrlr/o_sel_mux_0  
add wave -position insertpoint -color "light blue" -radix unsigned -group output  sim:/tb_puf_soc_cntrlr/o_sel_mux_1  
add wave -position insertpoint -color "light blue" -radix unsigned -group output  sim:/tb_puf_soc_cntrlr/o_max_count  
#DUT signals
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT  sim:/tb_puf_soc_cntrlr/DUT/isr_done
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT  sim:/tb_puf_soc_cntrlr/DUT/isr_call
add wave -position insertpoint -color "light blue" -radix unsigned -group DUT  sim:/tb_puf_soc_cntrlr/DUT/stack_pntr