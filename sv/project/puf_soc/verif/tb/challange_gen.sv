class challange_gen ;

	// Data members
	mailbox  tx_mbx       ;
	event    rspns_rx_done;
	// challange generated
	host_item tx_item;

	// variable declarations
	int challenge ; 

	// send an transaction item to driver
	task run();
		// challange count
		int cg_cnt			= 0;
		int rsp_rcv_cnt = 0;
		$display("*****************************");
		$display("*******[CHALLANGE_GEN]*******");
		$display("*****************************");
		

		// construct the item class
		tx_item = new();	
		
		// randomize the host_tx_item class
		if (!(tx_item.randomize())) begin
			$display("CHALLANGE_GEN::_____ fail to randomize the host_tx_item",);
		end

		// post randomize
		tx_item.post_randomize();

		// print the contents of randomize class
		tx_item.print_hst_item();

		$display("[CHALLANGE_GEN]::_____ Number of challanges generated %d",tx_item.challenge_q.size());
		// sending all the generated challanges to driver
		while (tx_item.challenge_q.size()) begin
			// print challange
			// tx_item.print_challange(tx_item.challenge_q[0]);

			challenge = tx_item.challenge_q.pop_front();

			// put transaction into mail_box
			tx_mbx.put(tx_item);
			$display("[CHALLANGE_GEN]::_____ Number of challanges send %d", ++cg_cnt);
			// wait for the response to recieve from PUF
			@(rspns_rx_done);
			$display("[CHALLANGE_GEN]::_____ Number Responses received %d", ++rsp_rcv_cnt);
		end
		$display("[CHALLANGE_GEN]::_____ Done by sending %d challanges",cg_cnt);
	endtask : run

endclass : challange_gen