# Makefile for AXIS Async FIFO UVM Testbench
################################
# Setup Project Name
################################
PROJ_NAME=axis_async_fifo

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

# Simulation options
VSIM_OPTS = -c -do "run -all; exit"

# Coverage options
# VCOVER_OPTS = -xmlmin
VCOVER_OPTS = -coverage
################################
################################
# Add dESIGN files here
################################
DESIGN_FILES ?= $(DESIGN_DIR)/axis_async_fifo.sv
################################
# TB_TOP file here
################################
TB_TOP=tb_axis_async_fifo

################################
# TB file
################################
UVC_FILES  ?=+incdir+$(TB_DIR)/uvc
UVC_FILES  +=$(TB_DIR)/uvc/axis_pkg.sv
TB_FILES   ?=+incdir+$(TB_DIR)/env/
TB_FILES   +=$(TB_DIR)/env/fifo_tb_pkg.sv
TEST_FILES +=+incdir+$(TB_DIR)/test/
TEST_FILES +=$(TB_DIR)/test/fifo_test_pkg.sv

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

VOPT_ARGS = -voptargs=+acc+rnbpc+tb_$(PROJ_NAME)  
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
	+UVM_TESTNAME="fifo_simple_test" \
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
