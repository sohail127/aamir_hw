class spi_seq_item #( spi_pkg::spi_param_t P) extends uvm_sequence_item;

  rand logic [P.AWIDTH-1:0] addr;
  rand logic [P.DWIDTH-1:0] data;

  `uvm_object_utils_begin(spi_seq_item)
    `uvm_field_int(addr, UVM_DEFAULT)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end

  // Constructor
  function new(string name = "spi_seq_item");
    super.new(name);
  endfunction : new

endclass : spi_seq_item
