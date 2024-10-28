`ifndef SPI_DRIVER_SV
`define SPI_DRIVER_SV

class spi_driver extends uvm_driver#(spi_seq_item);
  `uvm_component_utils(spi_driver)

  virtual spi_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual spi_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive_transaction(req);
      seq_item_port.item_done();
    end
  endtask

  task drive_transaction(spi_seq_item item);
    @(vif.driver_cb);
    vif.driver_cb.cs_n <= 0;
    foreach(item.data[i]) begin
      for(int j=7; j>=0; j--) begin
        @(vif.driver_cb);
        vif.driver_cb.sck <= 0;
        vif.driver_cb.mosi <= item.data[i][j];
        @(vif.driver_cb);
        vif.driver_cb.sck <= 1;
      end
    end
    @(vif.driver_cb);
    vif.driver_cb.cs_n <= 1;
    repeat(item.delay) @(vif.driver_cb);
  endtask

endclass
`endif // SPI_DRIVER_SV
