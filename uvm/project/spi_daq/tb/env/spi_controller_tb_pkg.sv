`ifndef SPI_CONTROLLER_TB_PKG_SV
`define SPI_CONTROLLER_TB_PKG_SV

package spi_controller_tb_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // uvc package
  import spi_uvc_pkg::*;

  //tb files
  `include "env_config.sv"
  `include "scoreboard.sv"
  `include "system_coverage.sv"
  `include "env.sv"

endpackage : spi_controller_tb_pkg
`endif  // SPI_CONTROLLER_TB_PKG_SV
