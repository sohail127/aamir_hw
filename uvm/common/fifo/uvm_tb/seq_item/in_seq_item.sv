class in_seq_item extends uvm_object;
	// component utils
	`uvm_object_utils(in_seq_item)
	
	// class members
	rand bit [15:0] wrd;
	// class constructor function
	function void new (string name);
		super.new(name);
	endfunction : new	
	
endclass : in_seq_item