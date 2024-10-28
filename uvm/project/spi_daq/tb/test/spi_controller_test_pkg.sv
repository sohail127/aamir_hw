`ifndef SPI_CONTROLLER_TEST_PKG_SV
`define SPI_CONTROLLER_TEST_PKG_SV
package spi_controller_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import spi_uvc_pkg::*; 
  import spi_controller_tb_pkg::*;
  // Include all test files
  `include "base_test.sv"
  `include "single_transfer_test.sv"
  `include "multi_transfer_test.sv"
  `include "max_transfer_test.sv"
  `include "random_transfer_test.sv"
  `include "back_to_back_test.sv"
  `include "concurrent_sensor_test.sv"

endpackage : spi_controller_test_pkg

`endif  // SPI_CONTROLLER_TEST_PKG_SV
