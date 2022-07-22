################################################################################
##  Vivado Syntehsis Project
################################################################################

################################################################################
## 1. Define Path Variables
################################################################################

	set  WORK_DIR ./
	set  PROJ_NAME toggle_sync
	# creat project directory 	
	if {![file exists ${PROJ_NAME}]} {
		file mkdir $WORK_DIR/$PROJ_NAME
		puts "Creating create_project directory ${PROJ_NAME}"
	} else {
		puts "overwriting project directory ${PROJ_NAME}"
		file mkdir $WORK_DIR/$PROJ_NAME
	}
	
	# creat netlist directory 	
	if {![file exists netlist]} {
		file mkdir $WORK_DIR/../netlist
	} else {
		puts "overwriting project netlist directory "
		file mkdir $WORK_DIR/../netlist
	}

	# creat sdf directory 	
	if {![file exists sdf]} {
		file mkdir $WORK_DIR/../sdf
	} else {
		puts "overwriting project directory sdf"
		file mkdir $WORK_DIR/../sdf
	}
		# creat bit_stream directory 	
	if {![file exists bit_stream]} {
		file mkdir $WORK_DIR/../bit_stream
	} else {
		puts "overwriting project directory sdf"
		file mkdir $WORK_DIR/../bit_stream
	}

	# creat Report Directories directory 	
	if {![file exists ${PROJ_NAME}_rpt]} {
		file mkdir $WORK_DIR/../${PROJ_NAME}_rpt
		file mkdir $WORK_DIR/../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt
		file mkdir $WORK_DIR/../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt
	} else {
		puts "overwriting project directory ${PROJ_NAME}_rpt"
		file mkdir $WORK_DIR/../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt
		file mkdir $WORK_DIR/../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt
	}


	cd 	 $PROJ_NAME
################################################################################
## 2. Crear Project with board selection
################################################################################
	# set PART_NUMB xc7z020clg400-1
	set PART_NUMB xc7a200tfbg676-2
	create_project $PROJ_NAME "$WORK_DIR" -part $PART_NUMB -force
################################################################################
## 3. Add files,  rtl , tb and constraints files
################################################################################
	add_files -fileset sources_1 [glob "${WORK_DIR}/../../rtl/*.v"] 
	add_files -fileset sim_1 		 [glob "${WORK_DIR}/../../tb/*.sv"] 
	add_files -fileset constrs_1 [glob "${WORK_DIR}/../../constraints/${PROJ_NAME}.xdc"]
	update_compile_order -fileset sources_1

################################################################################
## 4. Run Synthesis 
################################################################################
	#set atributes here
	synth_design -top toggle_sync -part $PART_NUMB 
  write_checkpoint 				-force 					 ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth.dcp
	report_timing_summary 	 					 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_timing_summary.rpt
	report_design_analysis 	 					 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_design_summary.rpt
	report_design_analysis -timing 		 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_critical_path_summary.rpt
	report_utilization 	-hierarchical  -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_util_summary.rpt
	report_utilization 			 					 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_util.rpt
	report_power 			 			 					 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_power.csv
	report_qor_assessment 	 					 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_qor_report.csv
	#Post-Synthesis Functional netlist
	write_verilog 	-force -mode funcsim ../../netlist/${PROJ_NAME}_post_synth_func_netlist.v 
	# post-synthesis SDF file
	# open_checkpoint 			 ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth.dcp
	write_verilog 	-force -mode timesim -sdf_anno true ../../netlist/${PROJ_NAME}_post_synth_time_netlist.v
	write_sdf 			-force 															../../sdf/${PROJ_NAME}_post_synth_time.sdf
################################################################################
##  5. run logic optimization,placement
################################################################################
	opt_design
	# reportCriticalPaths 		../../${PROJ_NAME}_impl_rpt/post_opt_critpath_report.csv
	#placement
	place_design
	write_checkpoint 				-force ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_place.dcp
	report_clock_utilization -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/clock_util.rpt
	report_utilization 			 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_place_util.rpt
	report_timing_summary 	 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_place_timing_summary.rpt
################################################################################
#6. Route Design
################################################################################
	route_design
	write_checkpoint 			-force				 ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_route.dcp
	report_route_status 	-file  				 ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_route_status.rpt
	report_timing_summary -file  				 ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_route_timing_summary.rpt
	report_design_analysis -timing -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_impl_critical_path_summary.rpt
	report_power 					-file  				 ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_route_power.rpt
	report_drc   					-file  				 ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_imp_drc.rpt
	write_xdc -no_fixed_only -force 		 ../../constraints/${PROJ_NAME}_post_route.xdc
		#Post-Synthesis Functional netlist
	write_verilog 	-force -mode funcsim ../../netlist/${PROJ_NAME}_post_impl_func_netlist.v 
	# post-implementtation SDF file
	# open_checkpoint 			 ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_route.dcp
	write_verilog 	-force -mode timesim -sdf_anno true ../../netlist/${PROJ_NAME}_post_impl_time_netlist.v
	write_sdf 			-force 															../../sdf/${PROJ_NAME}_post_impl_time.sdf

################################################################################
# ## Generate Bitstream
################################################################################
# 	# write_bitstream -force 					../../bit_stream/${PROJ_NAME}.bit

################################################################################
################################################################################
	close_project
	cd ../${WORK_DIR}



