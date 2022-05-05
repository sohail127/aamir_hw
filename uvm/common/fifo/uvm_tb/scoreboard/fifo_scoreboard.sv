`uvm_analysis_imp_decl(_tx_item)
`uvm_analysis_imp_decl(_rx_item)

class fifo_scoreboard extends  uvm_scoreboard;
	//component utils
	`uvm_component_utils(fifo_scoreboard)

	// Implicit Analysis port
	uvm_analysis_imp_tx_item#(in_seq_item, fifo_scoreboard) in_item_exp_ap;
	uvm_analysis_imp_rx_item#(in_seq_item, fifo_scoreboard) out_item_exp_ap;
	
	// data members 
	in_seq_item wrd_tx_q [$];
	in_seq_item wrd_rx_q [$];
	
	// class constructor function
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build phase
  function void build_phase(uvm_phase phase);
  	super.build_phase(phase);
  	// Analysis port construct
  	in_item_exp_ap = new("in_item_exp_ap",this);
  	out_item_exp_ap = new("out_item_exp_ap",this);
  endfunction : build_phase
  
  // write function for analysis port
  virtual function write_tx_item(in_seq_item in_item);
  	wrd_tx_q.push_back(in_item);
	endfunction : write_tx_item

	// write function for analysis port
  virtual function write_rx_item(in_seq_item in_item);
  	wrd_rx_q.push_back(in_item);
	endfunction : write_rx_item
	
	virtual function write();
endfunction : write

endclass : fifo_scoreboard