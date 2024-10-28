interface spi_if (
    input clk,
    input rst_n
);

  logic sclk;  // clock line
  logic mosi;  // master out slave in
  logic miso;  //master in slave out
  logic ss;  // slave select


  modport spi_master(output sclk, output mosi, input miso, output ss);

  modport spi_slave(input sclk, input mosi, output miso, input ss);

endinterface : spi_if
