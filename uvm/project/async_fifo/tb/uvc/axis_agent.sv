`ifndef AXIS_AGENT_SV
`define  AXIS_AGENT_SV
class axis_agent extends uvm_agent;
  `uvm_component_utils(axis_agent)

  axis_agent_cfg cfg;
  axis_driver    driver;
  axis_sequencer sequencer;
  axis_monitor   monitor;
  axis_coverage_collector coverage;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("________ Buil_Phase________"), UVM_LOW)
    if (!uvm_config_db#(axis_agent_cfg)::get(this, "", "axis_agent_cfg", cfg))
      `uvm_fatal("AXIS_AGENT", "Failed to get axis_agent_cfg")

    monitor = axis_monitor::type_id::create("monitor", this);
    coverage = axis_coverage_collector::type_id::create("coverage", this);
    
    if (get_is_active() == UVM_ACTIVE) begin
      driver    = axis_driver::type_id::create("driver", this);
      sequencer = axis_sequencer::type_id::create("sequencer", this);
    end
    // Set the configuration for the driver
      uvm_config_db#(axis_agent_cfg)::set(this, "driver", "axis_agent_cfg", cfg);
      uvm_config_db#(axis_agent_cfg)::set(this, "monitor", "axis_agent_cfg", cfg);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("________ Connect_Phase________"), UVM_LOW)
    if (get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
    monitor.item_collected_port.connect(coverage.analysis_export);
  endfunction: connect_phase
endclass : axis_agent
`endif // AXIS_AGENT_SV 
