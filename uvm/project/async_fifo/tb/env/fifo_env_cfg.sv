`ifndef FIFO_ENV_CFG_SV
`define FIFO_ENV_CFG_SV

class fifo_env_cfg extends uvm_object;
  `uvm_object_utils(fifo_env_cfg)

  // Agent configs
  axis_agent_cfg write_agent_cfg;
  axis_agent_cfg read_agent_cfg;

  // Virtual interfaces
  virtual axis_if write_vif;
  virtual axis_if read_vif;

  function new(string name = "fifo_env_cfg");
    super.new(name);
    write_agent_cfg = axis_agent_cfg::type_id::create("write_agent_cfg");
    read_agent_cfg  = axis_agent_cfg::type_id::create("read_agent_cfg");
    
    write_agent_cfg.is_master = 1;
    read_agent_cfg.is_master = 0;
  endfunction

  function void set_write_vif(virtual axis_if vif);
    this.write_vif = vif;
    write_agent_cfg.vif = vif;
  endfunction

  function void set_read_vif(virtual axis_if vif);
    this.read_vif = vif;
    read_agent_cfg.vif = vif;
  endfunction

endclass

`endif // FIFO_ENV_CFG_SV

