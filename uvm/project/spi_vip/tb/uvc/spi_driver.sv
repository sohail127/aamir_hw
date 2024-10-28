class spi_driver #(
    spi_pkg::spi_param_t P
) extends uvm_driver #(spi_pkg::spi_seq_item #(P));
  `uvm_component_utils(spi_driver)

  spi_config spi_cfg;
  spi_seq_item spi_seq_item_h;

  // Constructor
  function new(string name = "spi_driver", uvm_component parent = null);
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
      seq_item_port.get_next_item(this.spi_seq_item_h);

      if (this.spi_cfg.is_active == "UVM_ACTIVE") begin
        if (this.spi_seq_item_h.rw) begin  // 1 for write
          write_data();
        end else begin
          read_data();
        end
      end
      seq_item_port.finish_item();
    end

  endtask : main_phase

  virtual task write_data();
    @(posedge this.spi_cfg.spi_vif.clk);
    `uvm_info(get_type_name(), $sformatf("write_data %s", this.spi_cfg.sprint()), UVM_DEBUG)
  endtask : write_data

  virtual task read_data();
    @(posedge this.spi_cfg.spi_vif.clk);
    `uvm_info(get_type_name(), $sformatf("read_data %s", this.spi_cfg.sprint()), UVM_DEBUG)
  endtask : read_data

endclass : spi_driver
