class host_tx_ag ;

	challange_gen tx_gen ;
	host_tx_drv 	tx_drv ;
	host_tx_mon 	tx_mon ;

	mailbox 			drv_mbx ;
	
	// PUF soc tx interface
	virtual puf_rx_if host_tx_vif		;

	// construct the member classes and connect events 
	function new ();
		tx_gen = new();   
		tx_drv = new();  
		tx_mon = new();  
		// mailbox to driver
		drv_mbx = new ();
		// conencting mailbox
		tx_drv.drv_mbx = drv_mbx ;

	endfunction : new

	// run task 
	virtual task run();
		
		tx_drv.host_tx_vif = host_tx_vif ;
		tx_mon.host_tx_vif = host_tx_vif ;
		
		fork
			tx_drv.run();
			tx_mon.run();
		join_any
	endtask : run

endclass : host_tx_ag