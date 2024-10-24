package spi_pkg;

  // import uvm package and macros
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // TODO : check for seq_lib package

  typedef struct {
    int unsigned AWIDTH = 10;
    int unsigned DWIDTH = 32;
  } spi_param_t;

  localparam spi_param_t default_val = {10, 32};

  `include "spi_seq_item.sv"
  `include "spi_config.sv"
  `include "spi_sequencer.sv"
  `include "spi_driver.sv"
  `include "spi_monitor.sv"
  `include "spi_coverage.sv"
  `include "spi_agent.sv"

  // Sequence library
  `include "spi_base_sequence.sv"

endpackage : spi_pkg
