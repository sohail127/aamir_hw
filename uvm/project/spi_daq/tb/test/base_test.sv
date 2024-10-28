`ifndef BASE_TEST_SV
`define BASE_TEST_SV

class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  env env_h;
  env_config cfg;

  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg = env_config::type_id::create("cfg");
    cfg.has_scoreboard = 1;
    cfg.has_coverage = 1;
    cfg.num_sensors = 3;
    
    uvm_config_db#(env_config)::set(this, "*", "cfg", cfg);
    env_h = env::type_id::create("env_h", this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_type_name(), "Starting test...", UVM_LOW)
    #100ns;
    phase.drop_objection(this);
  endtask

endclass
`endif // BASE_TEST_SV
