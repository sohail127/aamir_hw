
#wave form script

add wave -position insertpoint -color "light blue" -radix unsigned -group CLOCK  	sim:/tb_puf_soc_dta_pth/clk        
add wave -position insertpoint -color "light blue" -radix unsigned -group RESET  	sim:/tb_puf_soc_dta_pth/rst_n      
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_op_mode  
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_rx_ready 
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_rx_valid 
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_rx_data  
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_tx_ready 
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_dcod_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_cnt_en   
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_tx_en    
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_fsm_state
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_sel_mux_0
add wave -position insertpoint -color "light blue" -radix unsigned -group INPUT  	sim:/tb_puf_soc_dta_pth/i_sel_mux_1
add wave -position insertpoint -color "light blue" -radix unsigned -group OUTPUT  sim:/tb_puf_soc_dta_pth/o_rx_ready 
add wave -position insertpoint -color "light blue" -radix unsigned -group OUTPUT  sim:/tb_puf_soc_dta_pth/o_rx_valid 
add wave -position insertpoint -color "light blue" -radix unsigned -group OUTPUT  sim:/tb_puf_soc_dta_pth/o_rx_data  
add wave -position insertpoint -color "light blue" -radix unsigned -group OUTPUT  sim:/tb_puf_soc_dta_pth/o_exec_done
add wave -position insertpoint -color "light blue" -radix unsigned -group OUTPUT  sim:/tb_puf_soc_dta_pth/o_tx_data  
add wave -position insertpoint -color "light blue" -radix unsigned -group OUTPUT  sim:/tb_puf_soc_dta_pth/o_tx_valid 
add wave -position insertpoint -color "light blue" -radix unsigned -group OUTPUT  sim:/tb_puf_soc_dta_pth/o_tx_done  

#Receiver

add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_sipo/clk       
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_sipo/rst_n     
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_sipo/i_rx_ready
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_sipo/i_rx_valid
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_sipo/i_rx_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_sipo/o_rx_ready
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_sipo/o_rx_valid
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_sipo/o_rx_data 
 
# Decoder
add wave -position insertpoint -color "light blue" -radix unsigned -group DECODE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_ro_decoder/rst_n      
add wave -position insertpoint -color "light blue" -radix unsigned -group DECODE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_ro_decoder/i_dcod_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group DECODE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_ro_decoder/i_sel_mux_0
add wave -position insertpoint -color "light blue" -radix unsigned -group DECODE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_ro_decoder/i_sel_mux_1
add wave -position insertpoint -color "light blue" -radix unsigned -group DECODE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_ro_decoder/o_puf_en   

#RO-Bank
add wave -position insertpoint -color "light blue" -radix unsigned -group RO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_ro/i_puf_en
add wave -position insertpoint -color "light blue" -radix unsigned -group RO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_ro/o_puf_ro

# MUX0
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_0 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_1 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_2 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_3 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_4 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_5 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_6 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_7 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_8 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_9 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_10
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_11
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_12
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_13
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_14
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_data_15
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/i_sel_mux
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_0/o_mux
# MUX1
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_0 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_1 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_2 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_3 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_4 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_5 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_6 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_7 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_8 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_9 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_10
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_11
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_12
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_13
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_14
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_data_15
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/i_sel_mux
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_mux_1/o_mux        
#count0       
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_0/clk       
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_0/rst_n     
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_0/i_cnt_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_0/o_valid   
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_0/o_cnt     
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_0/o_cnt_full
#count1       
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_1/clk       
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_1/rst_n     
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_1/i_cnt_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_1/o_valid   
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_1/o_cnt     
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_counter_1/o_cnt_full

# comparator
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_comparator/i_full_0    
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_comparator/i_full_1    
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_comparator/i_cnt_0      
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_comparator/i_cnt_1      
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_comparator/o_loser       
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_comparator/o_comp_valid
# Assembler
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/clk            
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/rst_n          
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_op_mode      
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_assmblr_en   
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_cnt_lser     
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_cnt_0        
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_cnt_1        
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_full_0       
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_full_1       
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_ro_bnk_en    
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_fsm_state    
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_sel_mux_0    
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_sel_mux_1    
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/i_rx_data      
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/o_assmblr_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_assembler/o_assmblr_valid
#PISO
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/clk       
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/rst_n     
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/i_tx_en 
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/i_tx_mode 
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/i_tx_ready
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/i_tx_valid
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/i_tx_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/o_tx_ready
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/o_tx_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/o_tx_valid
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_dta_pth/DUT/inst_puf_soc_piso/o_tx_done    