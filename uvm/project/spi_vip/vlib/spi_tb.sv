module spi_tb ();

  // `include "spi_if.sv";
  import uvm_pkg::*;
  import spi_pkg::*;

  logic clk;
  logic rst_n;

  spi_if _if (
      .clk  (clk),
      .rst_n(rst_n)
  );

  // dut instantaneous
  spi spi_dut (.spi_if(_if.spi_master));

endmodule
