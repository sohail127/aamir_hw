`ifndef SPI_COVERAGE_SV
`define SPI_COVERAGE_SV

class spi_coverage extends uvm_subscriber #(spi_seq_item);
  `uvm_component_utils(spi_coverage)

  spi_seq_item item;

  covergroup spi_cg with function sample(spi_seq_item item);
    DATA_SIZE: coverpoint item.data.size() {
      bins size_small[] = {[1:3]};
      bins size_medium[] = {[4:7]};
      bins size_large[] = {[8:10]};
    }
    
    DATA_VALUES: coverpoint item.data[0] {
      bins value_low = {[0:85]};
      bins value_mid = {[86:170]};
      bins value_high = {[171:255]};
    }
    
    DELAY: coverpoint item.delay {
      bins delay_short = {[1:3]};
      bins delay_medium = {[4:7]};
      bins delay_long = {[8:10]};
    }
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    spi_cg = new();
  endfunction

  function void write(spi_seq_item t);
    item = t;
    spi_cg.sample(item);
  endfunction

endclass : spi_coverage
`endif // SPI_COVERAGE_SV
