################################
# Setup Project Directory
################################
PROJ_DIR=$(shell pwd)/..
TB_DIR=$(PROJ_DIR)/tb
DESIGN_DIR=$(PROJ_DIR)/rtl
LIB_DIR=$(PROJ_DIR)/vlib

################################
#Setup Project Name
################################
PROJ_NAME=spi

################################
# Add files here
################################
DESIGN_FILE=$(DESIGN_DIR)/$(PROJ_NAME).sv
################################
# TB file
################################

UVC_FILES ?=+incdir+$(TB_DIR)/uvc
UVC_FILES +=$(TB_DIR)/uvc/spi_pkg.sv
TB_FILES +=$(TB_DIR)/env/spi_tb_pkg.sv
# UVC_FILES +=$(TB_DIR)/uvc/spi_seq_item.sv
# UVC_FILES +=$(TB_DIR)/uvc/spi_config.sv
# UVC_FILES +=$(TB_DIR)/uvc/spi_base_sequence.sv
# UVC_FILES +=$(TB_DIR)/uvc/spi_sequencer.sv
# UVC_FILES +=$(TB_DIR)/uvc/spi_coverage.sv
# UVC_FILES +=$(TB_DIR)/uvc/spi_driver.sv
# UVC_FILES +=$(TB_DIR)/uvc/spi_monitor.sv
# UVC_FILES +=$(TB_DIR)/uvc/spi_agent.sv
################################
# Compile args here
################################
COMPILE=vlog
Timescale=-timescale "1ns/1ps"
LOG_FILE=-l comile.log

build:
	@echo "Comiling Design and Testbench files"
	$(COMPILE) \
	$(TIMESCALE)   \
	$(LOG_FILE)    \
	$(DESIGN_FILE) \
	$(UVC_FILES)   \
	$(TB_FILES)    \
	$(LIB_DIR)/$(PROJ_NAME)_tb.sv
	 
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
