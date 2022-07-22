class host_tx_drv;
	// PUF soc tx interface
	virtual puf_rx_if host_tx_vif		;
	// event to trigger after sending each challange
	event drv_done;
	// mail box to rcv challange from generator
	mailbox drv_mbx;

	task run();
		int drv_cg_cnt 		= 0;
		int drv_cg_rx_cnt = 0;

		$display("*****************************");
		$display("*******[HOST_TX_DRV]*********");
		$display("*****************************");

		forever begin
			host_item host_tx_item ;
			// construct item class
			host_tx_item = new();

			// get item from mail box send by generator
			drv_mbx.get(host_tx_item);
			$display("[HOST_TX_DRV]::_____ Number of challanges recieved from generator %d", ++drv_cg_rx_cnt);
			$display("[HOST_TX_DRV]::_____  challanges recieved from generator 					%d", host_tx_item.challenge);

			// calling task to write challange on interface
			host_tx();
			$display("[HOST_TX_DRV]::_____ Number of challanges send %d", ++drv_cg_cnt);

			// trigegr event
			->drv_done; //TBD
		end
	endtask : run

	//********************************************************************************
	// ** Host Transmitter
	//********************************************************************************
	task host_tx();
		bit [7:0] tx_data ;
		$display("[HOST_TX_DRV]::***********_____host_tx_____***********",);
		// tx_data = host_tx_item.challenge;
		host_tx_vif.i_start = 1'b1;
		@(posedge host_tx_vif.clk) ;
		if(host_tx_vif.o_rx_ready) begin
			for (int ii=0; ii<REG_BIT_SIZE; ii++) begin
				@(posedge host_tx_vif.clk) ;
				host_tx_vif.i_rx_valid = 1'b1;
				host_tx_vif.i_rx_data  = tx_data[ii];
			end
		end
	endtask : host_tx
endclass : host_tx_drv

