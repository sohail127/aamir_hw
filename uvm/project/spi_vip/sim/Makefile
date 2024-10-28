################################
# Setup Project Directory
################################
PROJ_DIR=$(shell pwd)/..
TB_DIR=$(PROJ_DIR)/tb
DESIGN_DIR=$(PROJ_DIR)/rtl
LIB_DIR=$(PROJ_DIR)/vlib

################################
# UVM HOME 
################################
UVM_HOME=/home/sohail/eda_tools/questasim/verilog_src/uvm-1.2

################################
# Setup Project Name
################################
PROJ_NAME=spi

################################
# Add files here
################################
DESIGN_FILE=$(DESIGN_DIR)/$(PROJ_NAME).sv
TB_TOP=spi_tb

################################
# TB file
################################
UVC_FILES  ?=+incdir+$(TB_DIR)/uvc
UVC_FILES  +=$(TB_DIR)/uvc/spi_pkg.sv
TB_FILES   ?=+incdir+$(TB_DIR)/env/
TB_FILES   +=$(TB_DIR)/env/spi_tb_pkg.sv
TEST_FILES +=+incdir+$(TB_DIR)/test/
TEST_FILES +=$(TB_DIR)/test/spi_test_pkg.sv

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
	$(DESIGN_FILE) \
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
	+UVM_TESTNAME="spi_base_test" \
	$(VSIM_OPTS) 

run: uvm build sim

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
