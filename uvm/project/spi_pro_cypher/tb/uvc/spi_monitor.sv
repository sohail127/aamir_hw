class spi_monitor#(spi_pkg::spi_param P) extends  uvm_monitor;
	`uvm_component_utils(spi_monitor)

	spi_config spi_cfg;

	// Constructor
	function new(string name = "spi_monitor", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		// get config
			if (!uvm_config_db#(spi_config)::get(this, "", "spi_cfg",spi_cfg)) begin
		`uvm_fatal(get_type_name(), $sformatf("Unable to get spi_cfg from test"))
	end
	endfunction : build_phase

	virtual task main_phase(uvm_phase phase);
		spi_seq_item spi_seq_item_h;
		super.main_phase(phase);
		forever begin
			sample_data();
		end
	endtask : main_phase

	virtual task sample_data();
		@(posedge spi_config.vif.clk);
		`uvm_info(get_type_name(), $sformatf("write_data %s",spi_config.sprint()),UVM_DEBUG)
	endtask : sample_data


