`ifndef FIFO_BASE_TEST_SV
`define FIFO_BASE_TEST_SV

class fifo_base_test extends uvm_test;
  `uvm_component_utils(fifo_base_test)

  fifo_env env;
  fifo_env_cfg env_cfg;

  function new(string name = "fifo_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("________ Buil_Phase________"), UVM_LOW)
    
    // Create and configure the environment
    env_cfg = fifo_env_cfg::type_id::create("env_cfg");

    if (!uvm_config_db#(virtual axis_if)::get(this, "", "write_vif", env_cfg.write_vif))
      `uvm_fatal("FIFO_BASE_TEST", "Failed to get write_vif")
    
    if (!uvm_config_db#(virtual axis_if)::get(this, "", "read_vif", env_cfg.read_vif))
      `uvm_fatal("FIFO_BASE_TEST", "Failed to get read_vif")

    env_cfg.set_write_vif(env_cfg.write_vif);
    env_cfg.set_read_vif(env_cfg.read_vif);

    uvm_config_db#(fifo_env_cfg)::set(this, "env", "fifo_env_cfg", env_cfg);

    env = fifo_env::type_id::create("env", this);
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info(get_type_name(), "Starting base test", UVM_LOW)
    // Add any common test logic here
    phase.drop_objection(this);
  endtask

  virtual function void report_phase(uvm_phase phase);
    uvm_report_server server = uvm_report_server::get_server();
    if (server.get_severity_count(UVM_FATAL) + 
        server.get_severity_count(UVM_ERROR) == 0)
      `uvm_info(get_type_name(), "TEST PASSED", UVM_LOW)
    else
      `uvm_error(get_type_name(), "TEST FAILED")
  endfunction

endclass

`endif // FIFO_BASE_TEST_SV
