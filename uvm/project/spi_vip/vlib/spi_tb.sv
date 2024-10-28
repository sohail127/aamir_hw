module spi_tb ();

  // `include "spi_if.sv";
  import uvm_pkg::*;
  `include "uvm_macros.svh";

  import spi_test_pkg::*;

  logic clk;
  logic rst_n;

  spi_if _if (
      .clk  (clk),
      .rst_n(rst_n)
  );

  // dut instantaneous
  // spi spi_dut (.spi_if(_if.spi_master));

  initial begin
    uvm_config_db#(virtual spi_if)::set(null, "spi_base_test", "_if", _if);
  end

  initial begin
    run_test();
  end

endmodule : spi_tb
