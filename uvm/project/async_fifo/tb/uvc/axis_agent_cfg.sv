`ifndef AXIS_AGENT_CFG_SV
`define AXIS_AGENT_CFG_SV

class axis_agent_cfg extends uvm_object;
  `uvm_object_utils(axis_agent_cfg)

  virtual axis_if vif;
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  bit is_master = 1; // 1 for write agent, 0 for read agent

  function new(string name = "axis_agent_cfg");
    super.new(name);
  endfunction

endclass

`endif // AXIS_AGENT_CFG_SV