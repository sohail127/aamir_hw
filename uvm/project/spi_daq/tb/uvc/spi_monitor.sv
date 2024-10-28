`ifndef SPI_MONITOR_SV
`define SPI_MONITOR_SV

class spi_monitor extends uvm_monitor;
  `uvm_component_utils(spi_monitor)

  virtual spi_if vif;
  uvm_analysis_port#(spi_seq_item) item_collected_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual spi_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".vif"});
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      collect_transaction();
    end
  endtask

  task collect_transaction();
    spi_seq_item item = spi_seq_item::type_id::create("item");
    @(negedge vif.slave_cb.cs_n);
    item.data = new[0];
    while(vif.slave_cb.cs_n == 0) begin
      bit [7:0] byte_data;
      for(int i=7; i>=0; i--) begin
        @(posedge vif.slave_cb.sck);
        byte_data[i] = vif.slave_cb.mosi;
      end
      item.data = {item.data, byte_data};
    end
    item_collected_port.write(item);
  endtask

endclass
`endif // SPI_MONITOR_SV
