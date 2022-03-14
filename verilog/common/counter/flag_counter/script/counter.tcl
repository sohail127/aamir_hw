#!/usr/bin/tclsh

############################### 
##     1. Define Path        ## 
###############################
set soucrce_dir /home/aamir/Desktop/sahil_semi_aamir/scripting/vivado_work
set work_dir ./flag_project
file mkdir $work_dir
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
add_files -fileset sim_1 [glob "$soucrce_dir/tb/*.v"]
add_files -fileset constrs_1 [glob "$soucrce_dir/constraints/*.xdc"]
#add_files -fileset sources_1 [glob "$soucrce_dir/rtl/*.v"]
read_verilog [ glob "$soucrce_dir/rtl/*.v" ]
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
#write_checkpoint -force $soucrce_dir/rpt/post_synth.dcp
report_timing_summary -file $soucrce_dir/rpt/post_synth_timing_summary.rpt
report_utilization -file $soucrce_dir/rpt/post_synth_util.rpt
#reportCriticalPaths $soucrce_dir/rpt/post_synth_critpath_report.csv
######################################################
##  5. run logic optimization,placement             ##
######################################################
opt_design
#reportCriticalPaths $soucrce_dir/rpt/post_opt_critpath_report.csv
place_design
report_clock_utilization -file $soucrce_dir/rpt/clock_util.rpt
#placement
write_checkpoint -force $soucrce_dir/rpt/post_place.dcp
report_utilization -file $soucrce_dir/rpt/post_place_util.rpt
report_timing_summary -file $soucrce_dir/rpt/post_place_timing_summary.rpt

######################################################
##  6. Router                                       ##
######################################################
route_design
write_checkpoint -force $soucrce_dir/rpt/post_route.dcp
report_route_status -file $soucrce_dir/rpt/post_route_status.rpt
report_timing_summary -file $soucrce_dir/rpt/post_route_timing_summary.rpt
report_power -file $soucrce_dir/rpt/post_route_power.rpt
report_drc -file $soucrce_dir/rpt/post_imp_drc.rpt
write_verilog -force $soucrce_dir/rpt/counter_impl_netlist.v -mode timesim -sdf_anno true

######################################################
##  7. Generate Testbench                           ##
######################################################

write_bitstream -force $soucrce_dir/bit_stream/counter.bit