
class out_monitor extends  uvm_agent;
	// component utils
	`uvm_component_utils(out_monitor)
	
	// analysis port
	uvm_analysis_port #(in_seq_item) out_mon_ap; 
	
	// Data Members
	virtual in_interface out_vif;
	in_seq_item out_item;

	// class constructor function
	function void new (string name, uvm_component parent);
		super.new(name,parent);
		// construct analysis port
		out_mon_ap = new("out_mon_ap", this);
	endfunction : new	
	
	//build phase
	function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // build data members classes
		out_item = in_seq_item::type_id::create("out_item");
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
		@(posedge out_vif.clk);
	endtask : print_vif
	
	// collect_wrd
	task collect_wrd();
		out_mon_ap.write(out_item);
	endtask : collect_wrd


endclass : out_monitor