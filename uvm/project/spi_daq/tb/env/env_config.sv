`ifndef ENV_CONFIG_SV
`define ENV_CONFIG_SV

class env_config extends uvm_object;
  `uvm_object_utils(env_config)

  bit has_scoreboard = 1;
  bit has_coverage = 1;
  int num_sensors = 3;

  function new(string name = "");
    super.new(name);
  endfunction

endclass
`endif // ENV_CONFIG_SV
