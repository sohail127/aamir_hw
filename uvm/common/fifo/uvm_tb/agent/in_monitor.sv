class in_monitor extends  uvm_monitor;
	// component utils
	`uvm_component_utils(in_monitor)
	
	// analysis port
	uvm_analysis_port #(in_seq_item) in_mon_ap; 
	
	// Data Members
	virtual in_interface in_vif;
	in_seq_item in_item;

	// class constructor function
	function void new (string name, uvm_component parent);
		super.new(name,parent);
		// construct analysis port
		in_mon_ap = new("in_mon_ap", this);
	endfunction : new	
	
	//build phase
	function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // build data members classes
		in_item = in_seq_item::type_id::create("in_item");
		// uvm_config_db_get 
	endfunction : build_phase

	function void main_phase( uvm_phase phase);
		super.main_phase(phase);
		// call print function
		print_vif();
		collect_wrd();
	endfunction : main_phase
	
	// print_vif
	task print_vif();
		@(posedge in_vif.clk);
	endtask : print_vif
	
	// collect_wrd
	task collect_wrd();
		in_mon_ap.write(in_item);
	endtask : collect_wrd

endclass : in_monitor