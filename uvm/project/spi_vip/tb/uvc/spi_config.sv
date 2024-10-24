class spi_config #(
    spi_pkg::spi_param_t P
) extends uvm_object;

  bit spi_cov_en;  // spi_cov_en =1 to control coverage
  uvm_active_passive_enum is_active;  // UVM_ACTIVE/UVM_PASSIVE

  // handle to interface
  virtual spi_if #(
      .AWIDTH(P.DWIDTH),
      .DWIDTH(P.DWIDTH)
  ) spi_vif;

  `uvm_object_utils_begin(spi_config)
    `uvm_field_int(spi_cov_en, UVM_DEFAULT)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
  `uvm_object_utils_end


  // Constructor 
  function new(string name = "spi_config");
    super.new(name);
  endfunction : new

endclass : spi_config
