class fifo_base_test extends  uvm_test;
	// component utils
	`uvm_component_utils(fifo_base_test)

	// class members here
	fifo_env fifo_env_h;

	// virtual interface instacne
	virtual in_interface 	vif_in ;
	virtual out_interface vif_out;

	// class constructor function
	function void new (string name, uvm_component parent);
		super.new(namem,parent);
	endfunction : new	

	// build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_name(),$sformatf("___________BUILD_PHASE____________"), UVM_LOW)
		// env factory registration
		fiof_env_h = fifo_env::type_id::create::("fifo_env_h",this);
		
		//get input interface
		if( !uvm_config_db#(virtual in_interface)::get(this,"*", "if_in", vif_in))
  		`uvm_fatal(get_full_name(),"Unable to get input interface"); 
		//get output interface
		if( !uvm_config_db#(virtual out_interface)::get(this,"*", "if_ouy", vif_out))
  		`uvm_fatal(get_full_name(),"Unable to get output interface"); 
  	  // starting a sequence with default_sequence
  	
  	uvm_config_db#(uvm_object_wrapper)::set(this, "env.agent.sequencer.main_phas", "default_sequence", my_sequence::type_id::get());
	endfunction : build_phase	

	// // main_phase
	// function void main_phase(uvm_phase phase);
	// 	`uvm_info(get_name(),$sformatf("___________MIAN_PHASE____________"), UVM_LOW)
	// 	super.main_phase(phase);

	// endfunction : main_phase

endclass : fifo_base_test