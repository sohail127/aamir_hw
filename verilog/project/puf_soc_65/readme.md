####################################################################
### PUF SoC FPGA Implementation
####################################################################
Its and PUF IP core implementation on FPGA. Its provided with tx and
rx interface with ready/valid handshake interface to interface with
other modules
####################################################################
##	FPGA Implementation 
####################################################################

1. Launch Vivado
2. cd <vivado_dir>/puf_soc_top
3. mkdir work
4. cd work
5. source ../script/puf_soc_top.tcl 

####################################################################
##	FPGA Verification 
####################################################################

FPGA Implementation can be divided into following steps:                        
1. Functional Simulation                                                      
2. Synthesis                                                                   
	2.1. Post_synthesis Functional Simulation                                    
	2.2. Post_synthesis Timing Simulation                                        
3. Implementation                                                               
	3.1. Post_impl Functional Simulation                                          
	3.2. Post_impl Timing Simulation                                             


##################################################################
# 1. Vivado Functional Simulation
##################################################################
1. cd <system_path>/puf_soc_top
2. cd sim/xsim
3. ./run_sim.sh

##################################################################
# 2. Vivado Synthesis
##################################################################
1. cd <system_path>/puf_soc_top
2. mkdir work
3. cd work
4. vivado
5. source ../script/puf_soc_top.tcl


##################################################################
# 2.1. Post Synthesis Functional Simulation
##################################################################
1. cd  <system_path>/puf_soc_top/sim/
2. source set_env.sh
3. cd xsim/post_syn/func
4. ./run_sim                                                                                                                                             
##################################################################
# 2.2. Post Synthesis timing Simulation
##################################################################
1. cd  <system_path>/puf_soc_top/sim/
2. source set_env.sh
3. cd xsim/post_syn/timing
4. ./run_sim 


##################################################################
# Modelsim/Questasim Functional Simulation
##################################################################
1. cd <system_path>/puf_soc_top
2. cd sim/vsim
3. do puf_top.do



