class host_tx_mon ;
	
	// data members
	virtual puf_rx_if host_tx_vif;
	
	// mailbox to send data to tx_checker
	mailbox tx_mon_mbx;
	// read serial data from bus and send 8-bit to checker through mailbox.
	task run();
		int cg_tx_cnt 	   = 0;
		int cg_tx_bit_cnt  = 0;
		bit [REG_BIT_SIZE-1:0] tx_data  = 0; 
		int challenge      =0;
		$display("*****************************");
		$display("*******[HOST_TX_MON]*******");
		$display("*****************************");
		// construct the item class
		forever begin
			if (host_tx_vif.i_rx_valid && host_tx_vif.o_rx_ready) begin
				tx_data = {host_tx_vif.i_rx_data,tx_data} ; 
				$display("[HOST_TX_MON]::_____ Number of challanges bits transmitted %d", ++cg_tx_bit_cnt );
				// once whole 8-bits are transmitted
				if (cg_tx_bit_cnt == REG_BIT_SIZE) begin
					challenge = tx_data ;  
					tx_mon_mbx.put(challenge);
					cg_tx_bit_cnt = 0;
					$display("[HOST_TX_MON]::_____ Number of challanges transmitted %d", ++cg_tx_cnt );
				end
			end
			// wait for postive edge of clock
			@(posedge host_tx_vif.clk);
		end

	endtask : run	


endclass : host_tx_mon