`ifndef SPI_IF_SV
`define SPI_IF_SV
interface spi_if(input logic clk);
  logic sck;
  logic cs_n;
  logic mosi;
  logic miso;

  // Clocking block for master
  clocking master_cb @(posedge clk);
    output sck, cs_n, mosi;
    input miso;
  endclocking

  // Clocking block for slave
  clocking slave_cb @(posedge clk);
    input sck, cs_n, mosi;
    output miso;
  endclocking

  // Clocking block for monitor
  clocking monitor_cb @(posedge clk);
    input sck, cs_n, mosi, miso;
  endclocking

    // Clocking block for driver
  clocking driver_cb @(posedge clk);
    output sck, cs_n, mosi;
    input miso;
  endclocking



  // Modport for master
  modport master(
    output sck, cs_n, mosi,
    input miso
  );

  // Modport for slave
  modport slave(
    input sck, cs_n, mosi,
    output miso
  );

  // Modport for monitor
  modport monitor(clocking monitor_cb);
endinterface
`endif // SPI_IF_SV
