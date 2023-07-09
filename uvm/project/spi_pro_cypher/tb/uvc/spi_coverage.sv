class spi_coverage extends  uvm_subscriber;
	`uvm_component_utils(spi_coverage)

	function new(string name = "spi_coverage", uvm_component parent=null);
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
	super.main_phase(phase);
endtask : main_phase

function write(spi_seq_item spi_seq_item);
	spi_seq_item_q.push();
endfunction : write
endclass : spi_coverage