`ifndef AXIS_MONITOR_SV
`define AXIS_MONITOR_SV
class axis_monitor extends uvm_monitor;
  `uvm_component_utils(axis_monitor)

  axis_agent_cfg cfg;
  virtual axis_if vif;
  int num_collected; 
  uvm_analysis_port #(axis_seq_item) item_collected_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("________ Buil_Phase________"), UVM_LOW)
    if (!uvm_config_db#(axis_agent_cfg)::get(this, "", "axis_agent_cfg", cfg))
      `uvm_fatal("AXIS_DRIVER", "Failed to get axis_agent_cfg")
    vif = cfg.vif;
  endfunction : build_phase

   task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("________ Run_Phase________"), UVM_LOW)
   begin
    axis_seq_item item;
    forever begin
      @(posedge vif.aclk);
      if (vif.aresetn) begin
        if (cfg.is_master) begin
          `uvm_info(get_type_name(), $sformatf("________ [MASTER]________"), UVM_LOW)
          monitor_write_transaction(item);
        end else begin
          `uvm_info(get_type_name(), $sformatf("________ [SLAVE]________"), UVM_LOW)
          monitor_read_transaction(item);
        end
      end
    end
   end
  endtask

  task monitor_write_transaction(output axis_seq_item item);
    if (vif.tvalid && vif.tready) begin
      item = axis_seq_item::type_id::create("item");
      item.tdata = vif.tdata;
      item.tstrb = vif.tstrb;
      item.tlast = vif.tlast;
      item.is_write = 1;
      item_collected_port.write(item);
      num_collected++;
      `uvm_info(get_type_name(), $sformatf("Collected write item %0d: %s", num_collected, item.convert2string()), UVM_HIGH)
    end
  endtask

  task monitor_read_transaction(output axis_seq_item item);
    if (vif.tvalid && vif.tready) begin
      item = axis_seq_item::type_id::create("item");
      item.tdata = vif.tdata;
      item.tstrb = vif.tstrb;
      item.tlast = vif.tlast;
      item.is_write = 0;
      item_collected_port.write(item);
      num_collected++;
      `uvm_info(get_type_name(), $sformatf("Collected read item %0d: %s", num_collected, item.convert2string()), UVM_HIGH)
    end
  endtask


  // task run_phase(uvm_phase phase);
  //   `uvm_info(get_type_name(), $sformatf("________ Run_Phase________"), UVM_LOW)
  //   begin
  //     axis_seq_item item;
  //     forever begin
  //       item = axis_seq_item::type_id::create("item");
  //       @(posedge vif.aclk);
  //       collect_item(item);
  //       `uvm_info(get_type_name(), $sformatf("Monitor_item_is %s", item.sprint()), UVM_LOW)
  //       item_collected_port.write(item);
  //     end
  //   end
  // endtask : run_phase

  // task collect_item(axis_seq_item item);
  //   if (vif.aresetn) begin
  //     if (vif.tvalid && vif.tready) begin
  //       item.tdata    = vif.tdata;
  //       item.tstrb    = vif.tstrb;
  //       item.tlast    = vif.tlast;
  //       item.is_write = cfg.is_master;
  //     end
  //   end
  // endtask
endclass
`endif  // AXIS_MONITOR_SV
