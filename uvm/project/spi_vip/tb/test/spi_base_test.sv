class spi_base_test  /* #(spi_pkg::spi_param_t P) */ extends uvm_test;
  `uvm_component_utils(spi_base_test)

  // spi_env spi_env_m;
  // spi_base_sequence spi_base_seq_m;
  // spi_config spi_test_cfg_m;

  virtual spi_if vif;

  // class constructor
  function new(string name = "spi_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // this.spi_env_m      = spi_env#(P)::type_id::create("spi_env_m", this);
    // this.spi_base_seq_m = spi_base_sequence#(P)::type_id::create("spi_base_seq_m");
    // this.spi_test_cfg_m = spi_config#(P)::type_id::create("spi_test_cfg_m");

    // set test config into config_db
    // uvm_config_db#(spi_config#(P))::set(this, "spi_env_m", "spi_test_cfg_m", spi_test_cfg_m);
    // get interface from config_db
    uvm_config_db#(virtual spi_if)::get(this, ".","_if",vif);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction : connect_phase


  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
    phase.raise_objection(this);
    `uvm_info(get_type_name(),$sformatf("======== Eneter main_phase ============"),UVM_LOW)
    // this.spi_base_seq_m.start();
    phase.drop_objection(this);
  endtask : main_phase

endclass : spi_base_test
