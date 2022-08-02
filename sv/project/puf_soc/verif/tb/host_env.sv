class host_env;

	// generator instance
	challange_gen gen;
	// host agents
	host_tx_ag tx_ag;
	host_rx_ag rx_ag;
	// host_scb 	 scb	;
	mailbox gen_mbx;

	virtual puf_rx_if host_tx_vif;
	virtual puf_tx_if host_rx_vif;

	// construct the member classes, mail-boxes
	function new();
		// classes constructor
		gen   = new();
		tx_ag = new();
		rx_ag = new();

		// mail box xonstructor
		gen_mbx = new ();

		// connect mailboxes
		gen.tx_mbx 		= gen_mbx ;
		tx_ag.drv_mbx = gen_mbx ;

		endfunction : new

		// run task
		virtual task run();
		$display("*****************************");
		$display("*******[HOST_ENV]************");
		$display("*****************************");
			// tx interface handle
			tx_ag.host_tx_vif = host_tx_vif;
			tx_ag.host_tx_vif = host_tx_vif;
			// rx interface handle
			rx_ag.host_rx_vif 	= host_rx_vif;

			fork
				tx_ag.run();
				rx_ag.run();
				gen.run();
				// scb.new()  ;
			join_any
		endtask : run

	endclass : host_env