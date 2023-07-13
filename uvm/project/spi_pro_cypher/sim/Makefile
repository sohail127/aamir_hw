CWD=$(shell pwd)
DUT_DIR     ?= $(CWD)../vlib/
TB_DIR      ?= $(CWD)../tb/
TC_DIR      ?= $(TB_DIR)/tc
UVC_DIR     ?= $(TB_DIR)/uvc

# File variables
DUT_FILES   ?= $(wildcard $(DUT_DIR)/*.sv)
TB_FILES    ?= $(UVC_DIR)/spi_pkg.sv
TB_FILES    += $(TB_DIR)/spi_tc_pkg.sv
TB_FILES    += $(TC_DIR)/*.sv
# TB_DEFINES  ?=
# TB_ARGS     ?=
# UVM_V       ?=
# TB_TOP_NAME ?=
# WAVE_DUMP   ?=
# LOG_FILE    ?=

# QuestaSim variables
UVM_HOME ?= ../uvm-1.2
MTI_HOME = $(MODEL_HOME)

VLOG_OPTS   = -sv
VSIM_OPTS   = -novopt -do "run -all; quit -f"

build:
    vlog $(VLOG_OPTS) $(UVM_V) $(DUT_FILES) $(TB_FILES)

run:
    vsim $(VSIM_OPTS) $(TB_TOP_NAME)

clean:
    rm -rf work transcript vsim.wlf $(WAVE_DUMP) $(LOG_FILE)