class host_tx_ag ;

	challange_gen tx_gen ;
	host_tx_drv 	tx_drv ;
	host_tx_mon 	tx_mon ;

	mailbox 			drv_mbx ;
	mailbox 			mon_mbx ;
	
	// PUF soc tx interface
	virtual puf_rx_if host_tx_vif		;

	// construct the member classes and connect events 
	function new ();
		tx_gen = new();   
		tx_drv = new();  
		tx_mon = new();  
		// mailbox to driver
		drv_mbx = new ();
		mon_mbx = new ();
	

	endfunction : new

	// run task 
	virtual task run();
		$display("*****************************");
		$display("*******[HOST_TX_AG]**********");
		$display("*****************************");
		tx_drv.host_tx_vif = host_tx_vif ;
		tx_mon.host_tx_vif = host_tx_vif ;
		
		// conencting mailbox
		tx_drv.drv_mbx 		= drv_mbx ;
		tx_mon.tx_mon_mbx = mon_mbx ;
		
		fork
			tx_drv.run();
			tx_mon.run();
		join_any
	endtask : run

endclass : host_tx_ag