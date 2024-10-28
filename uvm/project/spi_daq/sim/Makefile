# Makefile for AXIS Async FIFO UVM Testbench
################################
# Setup Project Directory
################################
PROJ_DIR=$(shell pwd)/..
TB_DIR=$(PROJ_DIR)/tb
DESIGN_DIR=$(PROJ_DIR)/rtl
LIB_DIR=$(PROJ_DIR)/vlib

# Questasim commands
VLOG = vlog
VSIM = vsim
VCOVER = vcover

################################
# UVM HOME 
################################
UVM_HOME=/home/sohail/eda_tools/questasim/verilog_src/uvm-1.2

# Compile options
VLOG_OPTS = -sv -mfcu -suppress 2181 -suppress 7033 -timescale 1ns/1ps +acc

# Simulation options
VSIM_OPTS = -c -do "run -all; exit"

# Coverage options
# VCOVER_OPTS = -xmlmin
VCOVER_OPTS = -coverage

################################
# Add dESIGN files here
################################
DESIGN_FILES ?= $(DESIGN_DIR)/arbitration_logic.sv
DESIGN_FILES += $(DESIGN_DIR)/fifo.sv
DESIGN_FILES += $(DESIGN_DIR)/spi_flash_controller.sv
DESIGN_FILES += $(DESIGN_DIR)/spi_sensor_interface.sv
DESIGN_FILES += $(DESIGN_DIR)/spi_data_acquisition_controller.sv

################################
# TB_TOP file here
################################
TB_TOP=tb_spi_data_acquisition_controller

################################
# TB file
################################
UVC_FILES  ?=+incdir+$(TB_DIR)/uvc
UVC_FILES  +=$(TB_DIR)/uvc/spi_uvc_pkg.sv
TB_FILES   ?=+incdir+$(TB_DIR)/env/
TB_FILES   +=$(TB_DIR)/env/spi_controller_tb_pkg.sv
TEST_FILES +=+incdir+$(TB_DIR)/test/
TEST_FILES +=$(TB_DIR)/test/spi_controller_test_pkg.sv

# Work library
WORK_LIB = work

################################
# Compile args here
################################
COMPILE=vlog
TIMESCALE=-timescale "1ns/1ps"
LOG_FILE=-l compile.log
UVM_LIB=+incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv

################################
# Sim args here
################################
SIM=vsim
# GUI Mode Variable: Set to 1 for GUI, 0 for non-GUI
GUI ?= 0
# SIM_ARGS depending on GUI mode
ifeq ($(GUI), 1)
    SIM_ARGS = -gui
else
    SIM_ARGS = -c
endif

VOPT_ARGS = -voptargs=+acc+$(PROJ_NAME)_tb  
VSIM_OPTS = -do "run -all; quit"

################################
# Targets
################################

work:
	vlib work 

uvm:
	vlog +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm_pkg.sv -ccflags -DQUESTA \
                 -ccflags -Wno-maybe-uninitialized \
                 -ccflags -Wno-missing-declarations \
                 -ccflags -Wno-return-type \
                 ${UVM_HOME}/src/dpi/uvm_dpi.cc 
build:
	@echo "Compiling Design and Testbench files"
	$(COMPILE) \
	$(UVM_LIB) \
	$(TIMESCALE) \
	$(LOG_FILE) \
	$(DESIGN_FILES) \
	$(UVC_FILES) \
	$(TB_FILES) \
	$(TEST_FILES) \
	$(LIB_DIR)/$(TB_TOP).sv  # Ensure the top-level testbench is compiled

sim: 
	@echo "Run simulation"
	$(SIM) \
	$(SIM_ARGS) \
	$(TB_TOP) \
	$(VOPT_ARGS) \
	$(VCOVER_OPTS) \
	+UVM_TESTNAME="base_test" \
	$(VSIM_OPTS) 

run:  uvm build sim

clean:
	@echo "Remove log and work directory"
	rm -rf work
	rm -rf compile.log

print:
	@echo $(PROJ_DIR)/
	@echo $(TB_DIR)/
	@echo $(DESIGN_DIR)/
	@echo $(LIB_DIR)/
	@echo "UVC Files: $(UVC_FILES)"
	@echo "ENV Files: $(TB_FILES)"
	@echo "TEST_FILES: $(TEST_FILES)"

# ################################
# # Targets
# ################################
# all: compile run

# # Compile target
# compile:
# 	vlib $(WORK_LIB)
# 	vmap work $(WORK_LIB)
# 	$(VLOG) $(VLOG_OPTS) +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm_pkg.sv +UVM_NO_DPI
# 	$(VLOG) $(VLOG_OPTS) +incdir+$(UVM_HOME)/src $(DESIGN_FILES) $(UVC_FILES) $(TB_FILES) $(TEST_FILES) $(LIB_DIR)/$(TB_TOP).sv

# # Run target
# run:
# 	$(VSIM) $(VSIM_OPTS) -coverage -sv_seed random +UVM_NO_DPI work.tb_spi_data_acquisition_controller +UVM_TESTNAME=single_transfer_test

# # Coverage target
# coverage:
# 	$(VCOVER) merge coverage/merged.ucdb coverage/*.ucdb
# 	$(VCOVER) report $(VCOVER_OPTS) coverage/merged.ucdb

# # Clean target
# clean:
# 	rm -rf $(WORK_LIB)
# 	rm -rf transcript
# 	rm -rf vsim.wlf
# 	rm -rf coverage

# # Help target
# help:
# 	@echo "Available targets:"
# 	@echo "  all       : Compile and run the testbench (default)"
# 	@echo "  compile   : Compile the RTL and testbench files"
# 	@echo "  run       : Run the simulation"
# 	@echo "  coverage  : Generate and view coverage report"
# 	@echo "  clean     : Remove generated files and directories"
# 	@echo "  help      : Display this help message"

# .PHONY: all compile run coverage clean help

