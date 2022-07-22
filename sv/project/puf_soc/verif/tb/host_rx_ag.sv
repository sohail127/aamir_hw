class host_rx_ag ;
	
	// class data members
	host_rx_mon rx_mon;
	
	// interface instance
	virtual puf_tx_if host_rx_vif;

	// constructor for data members
	function new();
		rx_mon = new();
	endfunction
	
	// run task
	virtual task run();
		// connect interface
		rx_mon.host_rx_vif = host_rx_vif;
		
		rx_mon.run();
	endtask : run

endclass : host_rx_ag