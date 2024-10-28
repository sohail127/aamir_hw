class spi_env #(spi_pkg::spi_param_t P) extends uvm_env;
  `uvm_component_utils(spi_env)

  spi_agent  spi_agent_m;
  spi_config spi_cfg_m;

  //uvc and cnfig instances
  function new(string name, uvm_component parent = null);
    super.new(name, parent);
  endfunction : new


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // create instances of the spi_agent and spi_cfg components
    this.spi_agent_m = spi_agent#(P)::type_id::create("spi_agent_m", this);
    this.spi_cfg_m   = spi_config#(P)::type_id::create("spi_cfg_m");
  endfunction : build_phase


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

  endfunction : connect_phase
endclass : spi_env
