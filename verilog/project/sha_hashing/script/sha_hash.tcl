################################################################################
##  Vivado Syntehsis Project
################################################################################

## 1. Define Path Variables
	set  WORK_DIR ./
	set  PROJ_NAME sha_hash
	
	# creat project directory 	
	if {![file exists ${PROJ_NAME}]} {
		file mkdir $WORK_DIR/$PROJ_NAME
		puts "Creating create_project directory ${PROJ_NAME}"
	} else {
		puts "overwriting project directory ${PROJ_NAME}"
		file mkdir $WORK_DIR/$PROJ_NAME
	}
	
	# creat reporting directory 	
	if {![file exists synth]} {
		file mkdir $WORK_DIR/../sdf
	} else {
		puts "overwriting project synth directory "
		file mkdir $WORK_DIR/../sdf
	}

	# creat sdf directory 	
	if {![file exists sdf]} {
		file mkdir $WORK_DIR/../sdf
	} else {
		puts "overwriting project directory sdf"
		file mkdir $WORK_DIR/../sdf
	}
		# creat sdf directory 	
	if {![file exists sdf]} {
		file mkdir $WORK_DIR/../bit_stream
	} else {
		puts "overwriting project directory sdf"
		file mkdir $WORK_DIR/../bit_stream
	}

	# creat synth directory 	
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
## 2. Crear Project with board selection
	# set PART_NUMB xc7z020clg400-1
	# set PART_NUMB xc7a200tfbg676-2
	set PART_NUMB xc7k325tffg900-2
	create_project $PROJ_NAME "$WORK_DIR" -part $PART_NUMB -force
## 3. Add files,  rtl , tb and constraints files
	add_files -fileset sources_1 [glob "${WORK_DIR}/../../rtl/*.v"] 
	add_files -fileset sim_1 		 [glob "${WORK_DIR}/../../tb/*.v"] 
	add_files -fileset constrs_1 [glob "$WORK_DIR/../../constraints/${PROJ_NAME}.xdc"]
	update_compile_order -fileset sources_1

## 4. Run Synthesis 
	#set atributes here
	synth_design -top sha_256 -part $PART_NUMB 
  write_checkpoint -force 		../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth.dcp
	report_timing_summary -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_timing_summary.rpt
	report_utilization 		-file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_util.rpt
	report_utilization 		-file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_synth_rpt/post_synth_critpath_report.csv
	# post-synthesis SDF file
	write_verilog -force 						../../synth/${PROJ_NAME}_post_synth_netlist.v -mode timesim -sdf_anno true
	write_sdf 							 -force	../../sdf/${PROJ_NAME}_post_synth.sdf

##  5. run logic optimization,placement
# 	opt_design
# 	# reportCriticalPaths 		../../${PROJ_NAME}_impl_rpt/post_opt_critpath_report.csv
# 	#placement
# 	place_design
# 	write_checkpoint 				-force ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_place.dcp
# 	report_clock_utilization -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/clock_util.rpt
# 	report_utilization 			 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_place_util.rpt
# 	report_timing_summary 	 -file ../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_place_timing_summary.rpt
# #6. Route Design
# 	route_design
# 	write_checkpoint 			-force		../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_route.dcp
# 	report_route_status 	-file  		../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_route_status.rpt
# 	report_timing_summary -file  		../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_route_timing_summary.rpt
# 	report_power 					-file  		../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_route_power.rpt
# 	report_drc   					-file  		../../${PROJ_NAME}_rpt/${PROJ_NAME}_impl_rpt/post_imp_drc.rpt
# 	write_verilog -force 						../../synth/${PROJ_NAME}_netlist.v -mode timesim -sdf_anno true
# 	write_xdc -no_fixed_only -force ../../constraints/${PROJ_NAME}_impl.xdc
# 	write_sdf 							 -force	../../sdf/${PROJ_NAME}.sdf
# ## Generate Bitstream
# 	# write_bitstream -force 					../../bit_stream/${PROJ_NAME}.bit

	# close_project
	# cd ../${WORK_DIR}



