class in_driver extends  uvm_component #(in_seq_item);
	// component utils
	`uvm_componnet_utils(fifo_config)
	// Data members
	virtual in_interface in_vif;
	in_seq_item in_item;
	// class constructor function
	function void new (string name, uvm_component parent);
		super.new(name,parent);
	endfunction : new	
	
	// build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		in_item = in_seq_item::type_id::create("in_item");
		// get interface from config db
		get_config_db(); // TODO 
	endfunction : build_phase

	function void main_phase(uvm_phase phase);
		super.main_phase(phase);
		seq_item_port.get_next_item(in_item);
		rst_sys();
		push_wrd();
		pop_word();
		seq_item_port.item_done();_
	endfunction : main_phase

// reset system 
task rst_sys();
	@ (posedge in_vif.clk)
endtask : rst_sys

// push_wrd
task push_wrd();
	@ (posedge in_vif.clk)
endtask : push_wrd

//pop_word
task pop_word();
	@ (posedge in_vif.clk)
endtask : pop_word

endclass : in_driver