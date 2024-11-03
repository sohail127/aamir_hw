`ifndef FIFO_ENV_SV
`define FIFO_ENV_SV

class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)

  fifo_env_cfg cfg;
  axis_agent write_agent;
  axis_agent read_agent;
  fifo_scoreboard scoreboard;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("________ Buil_Phase________"), UVM_LOW)
    if (!uvm_config_db#(fifo_env_cfg)::get(this, "", "fifo_env_cfg", cfg))
      `uvm_fatal("FIFO_ENV", "Failed to get fifo_env_cfg")

    cfg.write_agent_cfg.is_master = 1;   
    cfg.read_agent_cfg.is_master = 0;   
    uvm_config_db#(axis_agent_cfg)::set(this, "write_agent", "axis_agent_cfg", cfg.write_agent_cfg);
    uvm_config_db#(axis_agent_cfg)::set(this, "read_agent", "axis_agent_cfg", cfg.read_agent_cfg);

    write_agent = axis_agent::type_id::create("write_agent", this);
    read_agent  = axis_agent::type_id::create("read_agent", this);
    scoreboard  = fifo_scoreboard::type_id::create("scoreboard", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
      `uvm_info(get_type_name(), $sformatf("________ Connect_Phase________"), UVM_LOW)
      write_agent.monitor.item_collected_port.connect(scoreboard.write_export);
      read_agent.monitor.item_collected_port.connect(scoreboard.read_export);
  endfunction

endclass

`endif  // FIFO_ENV_SV
