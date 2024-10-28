`ifndef SPI_UVC_PK_SV
`define SPI_UVC_PK_SV
package spi_uvc_pkg;
  
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // uvc files here
  `include "spi_seq_item.sv" 
  `include "spi_sequencer.sv"
  `include "spi_driver.sv"
  `include "spi_monitor.sv"
  `include "spi_coverage.sv"
  `include "spi_seq_lib.sv"
  `include "spi_agent.sv"

endpackage : spi_uvc_pkg

`endif // SPI_UVC_PK_SV
