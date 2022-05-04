class fifo_env extends  uvm_env;
	// component utils
	`uvm_component_utils(fifo_env)
	
	//Data members here
	//configs
	fifo_config fifo_cnfg;
	// agents
	in_agent 	in_ag ;
	out_agent out_ag;
	//scorbaord
	fifo_scoreboard fifo_scb;

	// class constructor function
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  //build phase
	function void build_phase(uvm_phase phase);
    `uvm_info(get_name(),$sformatf("___________BUILD_PHASE____________"), UVM_LOW)
    super.build_phase(phase);
    // build data members here
    fifo_cnfg = fifo_config		 ::type_id::create("fifo_cnfg",this);
    in_ag 		= in_agent 	 		 ::type_id::create("in_ag",		 this);
    out_ag 		= out_agent	 		 ::type_id::create("out_ag",	 this);
    fifo_scb 	= fifo_scoreboard::type_id::create("fifo_scb", this);
	endfunction : build_phase
	
 
endclass : fifo_env