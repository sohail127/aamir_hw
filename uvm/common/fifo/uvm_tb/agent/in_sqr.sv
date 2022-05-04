class in_sqr extends  uvm_sequencer#(in_seq_item);
	// component utils
	`uvm_sequencer_utils(in_sqr)
	
	// class constructor function
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
 
endclass : in_sqr
