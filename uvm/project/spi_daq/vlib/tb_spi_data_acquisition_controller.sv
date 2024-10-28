`ifndef TB_SPI_DATA_ACQUISITION_CONTROLLER_SV
`define TB_SPI_DATA_ACQUISITION_CONTROLLER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
import spi_controller_test_pkg::*;
// Include all the testbench components
`include "spi_if.sv"



module tb_spi_data_acquisition_controller;

  // parameters
parameter SENSOR_COUNT     = 3;
parameter DATA_WIDTH       = 16;
parameter FIFO_DEPTH       = 256;
parameter FLASH_ADDR_WIDTH = 24;

  // Clock and reset signals
  logic clk;
  logic rst_n;

  // sideband signals
  logic [SENSOR_COUNT-1:0] sensor_data_valid;
  logic start_acquisition;
  logic acquisition_done;
  logic flash_write_busy;


  // clue logic signals
  logic [SENSOR_COUNT-1:0] sensor_spi_if_sclk;
  logic [SENSOR_COUNT-1:0] sensor_spi_if_cs_n;
  logic [SENSOR_COUNT-1:0] sensor_spi_if_mosi;
  logic [SENSOR_COUNT-1:0] sensor_spi_if_miso;
  // Instantiate the interfaces
  spi_if sensor_spi_if[3](.clk(clk));
  spi_if flash_spi_if(.clk(clk));


  // initial begin
  //   sensor_spi_if_sclk <= {sensor_spi_if[2].slave_cb.sck,  sensor_spi_if[1].slave_cb.sck,  sensor_spi_if[0].slave_cb.sck};
  //   sensor_spi_if_cs_n <= {sensor_spi_if[2].slave_cb.cs_n, sensor_spi_if[1].slave_cb.cs_n, sensor_spi_if[0].slave_cb.cs_n};
  //   sensor_spi_if_mosi <= {sensor_spi_if[2].slave_cb.mosi, sensor_spi_if[1].slave_cb.mosi, sensor_spi_if[0].slave_cb.mosi};
  //   sensor_spi_if_miso <= {sensor_spi_if[2].slave_cb.miso, sensor_spi_if[1].slave_cb.miso, sensor_spi_if[0].slave_cb.miso};
  // end

  // Instantiate the DUT
  spi_data_acquisition_controller #(
    .SENSOR_COUNT     (3)  ,
    .DATA_WIDTH       (16) ,
    .FIFO_DEPTH       (256),
    .FLASH_ADDR_WIDTH (24)
)dut (
    .clk(clk),
    .rst_n(rst_n),
    .sensor_sck        ({sensor_spi_if[2].slave_cb.sck,  sensor_spi_if[1].slave_cb.sck,  sensor_spi_if[0].slave_cb.sck}),
    .sensor_cs_n       ({sensor_spi_if[2].slave_cb.cs_n, sensor_spi_if[1].slave_cb.cs_n, sensor_spi_if[0].slave_cb.cs_n}),
    .sensor_mosi       ({sensor_spi_if[2].slave_cb.mosi, sensor_spi_if[1].slave_cb.mosi, sensor_spi_if[0].slave_cb.mosi}),
    .sensor_miso       ({sensor_spi_if[2].slave_cb.miso, sensor_spi_if[1].slave_cb.miso, sensor_spi_if[0].slave_cb.miso}),
    .flash_sck         (flash_spi_if.slave_cb.sck  ),
    .flash_cs_n        (flash_spi_if.slave_cb.cs_n ),
    .flash_mosi        (flash_spi_if.slave_cb.mosi ),
    .flash_miso        (flash_spi_if.slave_cb.miso ),
    .start_acquisition (start_acquisition ),
    .acquisition_done  (acquisition_done  ),
    .sensor_data_valid (sensor_data_valid ),
    .flash_write_busy  (flash_write_busy  )
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #100 rst_n = 1;
  end

  // Start UVM phases
  initial begin
    uvm_config_db#(virtual spi_if)::set(null, "*.sensor_agent[0]*", "vif", sensor_spi_if[0]);
    uvm_config_db#(virtual spi_if)::set(null, "*.sensor_agent[1]*", "vif", sensor_spi_if[1]);
    uvm_config_db#(virtual spi_if)::set(null, "*.sensor_agent[2]*", "vif", sensor_spi_if[2]);
    uvm_config_db#(virtual spi_if)::set(null, "*.flash_agent*", "vif", flash_spi_if);
    run_test();
  end

endmodule

`endif // TB_SPI_DATA_ACQUISITION_CONTROLLER_SV