// import uvm package and macros
import uvm_pkg::*;
`include "uvm_macros.svh"

struct {
  AWIDTH = 10,
  DWIDTH = 32
} spi_param; 

// TODO : check for seq_lib package

// package for spi_uvc
package spi_pkg;
  `include "spi_seq_item.sv"
  `include "spi_config.sv"
  `include "spi_sequencer.sv"
  `include "spi_base_sequence.sv"
  `include "spi_driver.sv"
  `include "spi_monitor.sv"
  `include "spi_coverage.sv"
  `include "spi_agent.sv"

endpackage : spi_pkg 