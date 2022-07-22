class host_env;

	// generator instance
	challange_gen gen;
	// host agents
	host_tx_ag tx_ag;
	host_rx_ag rx_ag;
	// host_scb 	 scb	;
	mailbox gen_mbx;

	virtual puf_rx_if hst_tx_vif;
	virtual puf_tx_if hst_rx_vif;

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

			// tx interface handle
			tx_ag.tx_drv.host_tx_vif = hst_tx_vif;
			tx_ag.tx_mon.host_tx_vif = hst_tx_vif;
			// rx interface handle
			rx_ag.host_rx_vif 	= hst_rx_vif;

			fork
				tx_ag.run();
				rx_ag.run();
				// scb.new()  ;
			join_any
		endtask : run

	endclass : host_env