`ifndef ENV_SV
`define ENV_SV

class env extends uvm_env;
  `uvm_component_utils(env)

  spi_agent sensor_agent[3];
  spi_agent flash_agent;
  scoreboard sb;
  system_coverage sys_cov;
  env_config cfg;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(env_config)::get(this, "", "cfg", cfg))
      `uvm_fatal("NOCFG", {"Config object must be set for: ", get_full_name(), ".cfg"});

    foreach(sensor_agent[i]) begin
      sensor_agent[i] = spi_agent::type_id::create($sformatf("sensor_agent[%0d]", i), this);
    end
    flash_agent = spi_agent::type_id::create("flash_agent", this);

    if(cfg.has_scoreboard) begin
      sb = scoreboard::type_id::create("sb", this);
    end

    if(cfg.has_coverage) begin
      sys_cov = system_coverage::type_id::create("sys_cov", this);
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    if(cfg.has_scoreboard) begin
      sensor_agent[0].monitor.item_collected_port.connect(sb.sensor_fifo0);
      sensor_agent[1].monitor.item_collected_port.connect(sb.sensor_fifo1);
      sensor_agent[2].monitor.item_collected_port.connect(sb.sensor_fifo2);
      flash_agent.monitor.item_collected_port.connect(sb.flash_fifo);
    end

    if(cfg.has_coverage) begin
      foreach(sensor_agent[i]) begin
        sensor_agent[i].monitor.item_collected_port.connect(sys_cov.sensor_export[i]);
      end
      flash_agent.monitor.item_collected_port.connect(sys_cov.flash_export);
    end
  endfunction

endclass
`endif // ENV_SV
