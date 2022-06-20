add wave -position insertpoint -color "light blue" -radix unsigned -group CLK  	 sim:/tb_puf_soc_top/clk      
add wave -position insertpoint -color "light blue" -radix unsigned -group RST  	 sim:/tb_puf_soc_top/rst_n    
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_top/i_strt   
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_top/i_op_mode
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_top/i_valid  
add wave -position insertpoint -color "light blue" -radix unsigned -group input  sim:/tb_puf_soc_top/i_data   
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_soc_top/o_ready  
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_soc_top/o_serial 
add wave -position insertpoint -color "light blue" -radix unsigned -group output sim:/tb_puf_soc_top/o_valid  
#wave form script
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/clk         
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/rst_n       
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/i_op_mode   
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/i_sipo_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/i_sipo_valid
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/i_dcod_en   
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/i_cnt_en    
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/i_shft_en   
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/i_fsm_state 
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/i_sel_mux_0 
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/i_sel_mux_1 
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/o_sipo_ready
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/o_sipo_valid
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/o_sipo_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/o_exec_done 
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/o_piso_ready
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/o_piso_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/o_piso_valid
add wave -position insertpoint -color "light blue" -radix unsigned -group DP sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/o_piso_done

#wave form script
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/clk          
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/rst_n        
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/i_strt       
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/i_op_mode    
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/i_valid      
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/i_sipo_ready 
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/i_sipo_valid 
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/i_sipo_data  
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/i_exec_done  
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/i_shft_done  
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/o_fsm_state 
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/o_sipo_enable
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/o_dcod_enable
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/o_cnt_enable 
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/o_shft_enable
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/o_sel_mux_0   
add wave -position insertpoint -color "light blue" -radix unsigned -group CU  sim:/tb_puf_soc_top/DUT/inst_puf_soc_cntrlr/o_sel_mux_1   

#sipo
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_sipo/clk    
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_sipo/rst_n  
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_sipo/i_valid
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_sipo/i_ready
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_sipo/i_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_sipo/o_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_sipo/o_ready
add wave -position insertpoint -color "light blue" -radix unsigned -group SIPO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_sipo/o_valid 

# Decoder
add wave -position insertpoint -color "light blue" -radix unsigned -group DECODE sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_ro_decoder/i_dcod_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group DECODE sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_ro_decoder/i_sel_mux_0
add wave -position insertpoint -color "light blue" -radix unsigned -group DECODE sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_ro_decoder/i_sel_mux_1
add wave -position insertpoint -color "light blue" -radix unsigned -group DECODE sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_ro_decoder/o_puf_en   
#RO-Bank
add wave -position insertpoint -color "light blue" -radix unsigned -group RO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_ro/i_puf_en
add wave -position insertpoint -color "light blue" -radix unsigned -group RO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_ro/o_puf_ro
# MUX0
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_0 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_1 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_2 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_3 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_4 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_5 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_6 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_7 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_8 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_9 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_10
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_11
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_12
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_13
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_14
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_data_15
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/i_sel_mux
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX0  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_0/o_mux
# # MUX1
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_0 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_1 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_2 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_3 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_4 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_5 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_6 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_7 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_8 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_9 
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_10
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_11
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_12
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_13
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_14
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_data_15
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/i_sel_mux
add wave -position insertpoint -color "light blue" -radix unsigned -group MUX1  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_mux_1/o_mux        
#count0       
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_0/clk       
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_0/rst_n     
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_0/i_en      
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_0/o_valid   
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_0/o_cnt     
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT0 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_0/o_cnt_full
#count1       
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT1 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_1/clk       
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT1 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_1/rst_n     
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT1 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_1/i_en      
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT1 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_1/o_valid   
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT1 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_1/o_cnt     
add wave -position insertpoint -color "light blue" -radix unsigned -group CONT1 sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_counter_1/o_cnt_full
# comparator
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_comparator/i_full_0    
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_comparator/i_full_1    
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_comparator/i_cnt0      
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_comparator/i_cnt1      
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_comparator/o_loser       
add wave -position insertpoint -color "light blue" -radix unsigned -group COMP  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_comparator/o_comp_valid
#
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/clk            
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/rst_n          
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_op_mode      
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_assmblr_en   
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_cnt_lser     
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_cnt_0        
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_cnt_1        
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_full_0       
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_full_1       
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_ro_bnk_en    
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_fsm_state    
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_sel_mux_0    
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_sel_mux_1    
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/i_sipo_data    
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/o_assmblr_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group ASSEMBLE  sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_assembler/o_assmblr_valid
#PISO
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/clk        
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/rst_n      
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/i_ld_data  
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/i_shft_en  
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/i_shft_mode
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/i_reg_data 
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/o_ready    
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/o_shift    
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/o_valid    
add wave -position insertpoint -color "light blue" -radix unsigned -group PISO sim:/tb_puf_soc_top/DUT/inst_puf_soc_dta_pth/inst_puf_soc_piso/o_done     