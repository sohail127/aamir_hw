class in_sequence extends  uvm_sequence #(in_seq_item);
		// component utils
	`uvm_object_utils(in_sequence)
	
	// class memebers here
	in_seq_item in_item;
	
	// class constructor function
	function void new (string name);
		super.new(name);
	endfunction : new	
	
	virtual task body();
		// build sequence item
		in_item	= in_seq_item::type_id::create::("in_item");

		start_item(in_item);
		//randomize sequence item 
		if(!in_item.randomize())
			`uvm_fatal(get_full_name(),"Input sequence randomiation Failed")
		finish_item(in_item);
	endtask : body
endclass : in_sequence
