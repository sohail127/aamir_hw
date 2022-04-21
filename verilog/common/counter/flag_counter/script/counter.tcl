#!/usr/bin/tclsh

###################################################### 
##     1. Define Path        ## 
######################################################

set SOURCE_DIR [pwd]/..
set work_dir ./flag_project
file mkdir $work_dir
file mkdir $SOURCE_DIR/sdf
###################################################### 
##     2. Creat Project and set board files         ## 
######################################################
#create_project -part partNumber projectName $outputdir
set partNumber xc7a200tfbg676-2
create_project flag_counter "$work_dir" \
-part $partNumber -force


###################################################### 
##     3. Setup Design,constraints,sim files        ## 
######################################################
add_files -fileset sim_1 [glob "$SOURCE_DIR/tb/*.v"]
add_files -fileset constrs_1 [glob "$SOURCE_DIR/constraints/*.xdc"]
#add_files -fileset sources_1 [glob "$SOURCE_DIR/rtl/*.v"]
read_verilog [ glob "$SOURCE_DIR/rtl/*.v" ]
update_compile_order -fileset sources_1
#set top level module and update compile order
#set_property top flag_counter [flag_counter]
#update_compile_order -fileset sources_1
#update_compile_order -fileset sim_1
######################################################
##  4. Run Synthesis                                ##
######################################################

#launch_runs synth_1
#wait_on_run synth_1
synth_design -top flag_counter -part $partNumber 
#-top flag_counter -part $partNumber
report_timing_summary -file $SOURCE_DIR/rpt/post_synth_timing_summary.rpt
report_utilization 		-file $SOURCE_DIR/rpt/post_synth_util.rpt
write_checkpoint -force 		$SOURCE_DIR/rpt/post_synth.dcp
open_checkpoint 						$SOURCE_DIR/rpt/post_synth.dcp
write_verilog 	 -force 		$SOURCE_DIR/netlist/counter_synth_func_netlist.v -mode funcsim 
write_verilog 	 -force 		$SOURCE_DIR/netlist/counter_synth_time_netlist.v -mode timesim -sdf_anno true
write_sdf 			 -force 		$SOURCE_DIR/sdf/counter_post_synth.sdf

#reportCriticalPaths $SOURCE_DIR/rpt/post_synth_critpath_report.csv
######################################################
##  5. run logic optimization,placement             ##
######################################################
opt_design
#reportCriticalPaths $SOURCE_DIR/rpt/post_opt_critpath_report.csv
place_design
report_clock_utilization -file $SOURCE_DIR/rpt/clock_util.rpt
#placement
write_checkpoint 	-force $SOURCE_DIR/rpt/post_place.dcp
report_utilization 		-file $SOURCE_DIR/rpt/post_place_util.rpt
report_timing_summary -file $SOURCE_DIR/rpt/post_place_timing_summary.rpt

######################################################
##  6. Router                                       ##
######################################################
route_design
write_checkpoint -force 		$SOURCE_DIR/rpt/post_route.dcp
report_route_status 	-file $SOURCE_DIR/rpt/post_route_status.rpt
report_timing_summary -file $SOURCE_DIR/rpt/post_route_timing_summary.rpt
report_power 					-file $SOURCE_DIR/rpt/post_route_power.rpt
report_drc 						-file $SOURCE_DIR/rpt/post_imp_drc.rpt
write_verilog 				-force $SOURCE_DIR/netlist/counter_impl_func_netlist.v -mode funcsim 
write_verilog 				-force $SOURCE_DIR/netlist/counter_impl_time_netlist.v -mode timesim -sdf_anno true
write_sdf 			 -force 		$SOURCE_DIR/sdf/counter_post_impl.sdf

######################################################
##  7. Generate Testbench                           ##
######################################################

write_bitstream -force $SOURCE_DIR/bit_stream/counter.bit