class spi_sequencer extends  uvm_sequencer;
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(spi_sequencer)

	function new(string name = "spi_sequencer", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

endclass : spi_sequencer