class spi_coverage#(spi_pkg::spi_param_t P) extends uvm_subscriber#(spi_seq_item#(P));
  `uvm_component_utils(spi_coverage)

  spi_seq_item spi_seq_item_q [$];
  spi_config#(P) spi_cfg; 

  function new(string name = "spi_coverage", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // get config
    if (!uvm_config_db#(spi_config)::get(this, "", "spi_cfg", spi_cfg)) begin
      `uvm_fatal(get_type_name(), $sformatf("Unable to get spi_cfg from test"))
    end
  endfunction : build_phase


  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
    forever begin
      if (spi_seq_item_q.size() > 0) begin
        `uvm_info(get_type_name(), $sformatf(" size of spi_seq_item_q is : %0d",
                                             spi_seq_item_q.size()), UVM_LOW)
      end
    end
  endtask : main_phase

  function void write(T t);
    spi_seq_item_q.push_back(t);
  endfunction : write
endclass : spi_coverage
