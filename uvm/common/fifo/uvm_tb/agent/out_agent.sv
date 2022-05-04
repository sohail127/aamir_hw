class out_agent extends  uvm_agent;
	// component utils
	`uvm_component_utils(out_agent)
	// analysis port
	uvm_analysis_port #(in_seq_item) out_ag_ap; 

	// Data Members
	out_monitor out_mon;

	// class constructor function
	function void new (string name, uvm_component parent);
		super.new(name,parent);
		// construct analysis port
		out_ag_ap = new("out_ag_ap", this);
	endfunction : new
	
	// build phase
	function void buidl_phase(uvm_phase phase);
		super.build_phase(phase);
		// build monitor
		if (get_is_active()== UVM_PASSIVE) begin
			out_mon = out_monitor::type_id::create("out_mon",this);
		end
	endfunction : buidl_phase
	
	//connect phase
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		out_ag_ap.connect(out_mon.out_mon_ap);
	endfunction : connect_phase

endclass : out_agent