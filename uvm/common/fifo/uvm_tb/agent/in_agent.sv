class in_agent extends  uvm_agent;
	// component utils
	`uvm_component_utils(in_agent)
	// analysis port
	uvm_analysis_port #(in_seq_item) in_ag_ap; 

	// Data Members
	in_driver 	in_drv 	;
	in_sqr 			in_sqr_h;
	in_monitor 	in_mon 	;

	// class constructor function
	function void new (string name, uvm_component parent);
		super.new(name, parent);
		// construct analysis port
		in_ag_ap = new("in_ag_ap", this);
	endfunction : new

	//build phase
	function void build_phase(uvm_phase phase);
    `uvm_info(get_name(),$sformatf("___________BUILD_PHASE____________"), UVM_LOW)
    super.build_phase(phase);
    // build data members here
    if (get_is_active()== UVM_ACTIVE) begin
    	in_drv 	 =	in_driver ::type_id::create("in_drv",		this); 
			in_sqr_h =	in_sqr 		::type_id::create("in_sqr_h", this); 
    end
		in_mon 	 =in_monitor::type_id::create("in_mon",		this); 
	endfunction : build_phase
	
	//connect phase
	function void connect_phase(uvm_phase phase);
    `uvm_info(get_name(),$sformatf("___________CONNECT_PHASE____________"), UVM_LOW)
		super.connect_phase(phase);
		if (get_is_active() == UVM_ACTIVE) begin
			in_drv.seq_item_port.connect(in_sqr_h.seq_item_export);
		end
		in_ag_ap.connect(out_mon.in_mon_ap);
	endfunction : connect_phase

endclass : in_agent
