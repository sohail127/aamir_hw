class spi_agent #(
    spi_pkg::spi_param_t P
) extends uvm_agent;
  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_component_utils(spi_agent)

  spi_config spi_cfg;

  spi_sequencer spi_vseqr;
  spi_coverage  spi_cov  ;
  spi_monitor   spi_mon  ;
  spi_driver    spi_drv  ;

  // Constructor
  function new(string name = "spi_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    this.spi_vseqr = spi_sequencer::type_id::create("spi_vseqr", this);
    this.spi_cov   = spi_coverage#(P)::type_id::create("spi_cov", this);
    this.spi_mon   = spi_monitor#(P)::type_id::create("spi_mon", this);
    this.spi_drv   = spi_driver#(P)::type_id::create("spi_drv", this);

    // get config from test
    if (!uvm_config_db#(spi_config)::get(this, "", "spi_cfg", spi_cfg)) begin
      `uvm_fatal(get_type_name(), $sformatf("Unable to get spi_cfg from test"))
    end

    // set config to yvm componnets
    uvm_config_db#(spi_config)::set(this, "spi_mon", spi_cfg);
    uvm_config_db#(spi_config)::set(this, "spi_cov", spi_cfg);
    uvm_config_db#(spi_config)::set(this, "spi_drv", spi_cfg);
    uvm_config_db#(spi_config)::set(this, "spi_vseqr", spi_cfg);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (this.spi_cfg.spi_uvc_type == "UVM_ACTIVE") begin  // TODO : check what to do for back pressure
      this.spi_drv.seq_item_port.connect(this.spi_vseqr.seq_item_export);
    end
  endfunction : connect_phase

endclass : spi_agent
