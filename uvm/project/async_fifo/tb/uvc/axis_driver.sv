`ifndef AXIS_DRIVER_SV
`define AXIS_DRIVER_SV
class axis_driver extends uvm_driver #(axis_seq_item);
  `uvm_component_utils(axis_driver)

  axis_agent_cfg cfg;
  virtual axis_if vif;
  int num_driven = 0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("________ Buil_Phase________"), UVM_LOW)

    if (!uvm_config_db#(axis_agent_cfg)::get(this, "", "axis_agent_cfg", cfg))
      `uvm_fatal("AXIS_DRIVER", "Failed to get axis_agent_cfg")
    vif = cfg.vif;
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("________ Run_Phase________"), UVM_LOW)
    begin
      axis_seq_item item;
      forever begin
        seq_item_port.get_next_item(item);
        if (cfg.is_master) begin
          drive_write_item(item);
        end else begin
          drive_read_item(item);
        end
        seq_item_port.item_done();
      end
    end
  endtask

  task drive_write_item(axis_seq_item item);
    @(posedge vif.aclk);
    vif.tvalid <= 1'b1;
    vif.tdata  <= item.tdata;
    vif.tstrb  <= item.tstrb;
    vif.tlast  <= item.tlast;

    do begin
      @(posedge vif.aclk);
    end while (!vif.tready);

    vif.tvalid <= 1'b0;
    num_driven++;
    `uvm_info(get_type_name(), $sformatf("Driver_wr_item %s", item.sprint()), UVM_LOW)
  endtask

  task drive_read_item(axis_seq_item item);
    // For read transactions, we just need to assert tready
    @(posedge vif.aclk);
    vif.tready <= 1'b1;

    do begin
      @(posedge vif.aclk);
    end while (!vif.tvalid);

    vif.tready <= 1'b0;
    num_driven++;
    `uvm_info(get_type_name(), $sformatf("Driver_rd_item %s", item.sprint()), UVM_LOW)
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Total items driven: %0d", num_driven), UVM_LOW)
  endfunction
endclass
`endif  // AXIS_DRIVER_SV
