class host_rx_mon ;

	// interface instance
	virtual puf_tx_if host_rx_vif;

	int op_mod = 0 ; 

	// capture response for both norm and debug mode
	task run();
		$display("*****************************");
		$display("*******[HOST_RX_MON]**********");
		$display("*****************************");
		forever begin
			if (op_mod) begin  //TBD
				norm_mod();
			end else begin
				debug_mod();
			end
			@(posedge host_rx_vif.clk);
		end
	endtask : run

	// capture data in ormal mode
	task norm_mod();
		int                 nrm_cnt         = 0  ;
		bit [ NORM_MOD-1:0] nrm_data_buff   = 0  ;
		$display("************************_______norm_mod____________************************************");
		forever begin
			@(posedge host_rx_vif.clk);
			if (host_rx_vif.o_tx_valid) begin
				if(nrm_cnt != NORM_MOD-1) begin
					nrm_data_buff = {host_rx_vif.o_tx_data,nrm_data_buff[NORM_MOD-1:1]};
					nrm_cnt++;
					$display("****___serial bit index %d ______*******************************************",nrm_cnt);
				end else begin
					nrm_data_buff = {host_rx_vif.o_tx_data,nrm_data_buff[NORM_MOD-1:1]};
					//TBD put in mailbox
				end
			end
		end
	endtask : norm_mod
	// debug_mode monitor
	task debug_mod();
		// varaiables
		int                 debug_cnt       = 0  ;
		bit [DEBUG_MOD-1:0] debug_data_buff = 0  ;
	
		$display("************************_______debug_mod____________************************************");
		forever begin
			@(posedge host_rx_vif.clk);
			if (host_rx_vif.o_tx_valid) begin
				if(debug_cnt != DEBUG_MOD-1) begin
					debug_data_buff  = {host_rx_vif.o_tx_data,debug_data_buff[DEBUG_MOD-1:1]};
					debug_cnt++;
				end else begin
					debug_data_buff 		= {host_rx_vif.o_tx_data,debug_data_buff[DEBUG_MOD-1:1]};
					// TBD put in mailbox
				end
			end
		end
	endtask : debug_mod

endclass : host_rx_mon