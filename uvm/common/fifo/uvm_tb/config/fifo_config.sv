class fifo_config extends  uvm_object;
	// component utils
	`uvm_object_utils(fifo_config)
	
	// class constructor function
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 

endclass : fifo_config