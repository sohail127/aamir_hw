
module tb_puf_soc_top();

	import puf_soc_pkg::*;

// clock instance
logic clk;

// interface instance
puf_rx_if rx_if(clk);
puf_tx_if tx_if(clk);

// class handle of base test
host_test test;
//********************************************************************************
// ** DUT initialization
//********************************************************************************
	puf_soc_top
		`ifndef NETLIST
			#(
				.REG_BIT_SIZE(REG_BIT_SIZE),
				.MUX_IN_SIZ  (MUX_IN_SIZ  ),
				.MUX_LENGTH  (MUX_LENGTH  ),
				.NO_PUF_STAGE(NO_PUF_STAGE),
				.PUF_LENGTH  (PUF_LENGTH  ),
				.CNT_BIT_SIZE(CNT_BIT_SIZE),
				.FRAM_SIZE   (FRAM_SIZE   ),
				.NORM_MOD    (NORM_MOD    ),
				.DEBUG_MOD   (DEBUG_MOD   )
			)
		`endif
	DUT (
		.clk       (clk       			), // input  clk       , // Clock
		.rst_n     (rx_if.rst_n     ), // input  rst_n     , // Asynchronous reset active low
		.i_start   (rx_if.i_start   ), // input  i_start   ,
		.i_op_mode (rx_if.i_op_mode ), // input  i_op_mode ,
		.o_rx_ready(rx_if.o_rx_ready), // output o_rx_ready,
		.i_rx_valid(rx_if.i_rx_valid), // input  i_rx_valid,
		.i_rx_data (rx_if.i_rx_data ), // input  i_rx_data ,
		.i_tx_ready(tx_if.i_tx_ready), // output i_tx_ready,
		.o_tx_data (tx_if.o_tx_data ), // output o_tx_data ,
		.o_tx_valid(tx_if.o_tx_valid)  // output o_tx_valid
	);


// clock generation
	initial clk = 1'b1;
	always #((CLK_PRD/2)) clk = ~clk;

// stimulus here

initial begin
	// call sys reset task
	sys_rst();

	// constructor to host test
	test = new () ;

	// connect interface
	test.env.tx_ag.host_tx_vif 	= rx_if ;
	test.env.rx_ag.host_rx_vif  = tx_if ;

	// run test
	test.run();

	repeat(5) begin
		@(posedge clk);
		$display("idle clock cycles");
	end

end

//********************************************************************************
// ** Reset Task
//********************************************************************************
	task sys_rst();
		rx_if.rst_n 			= {$bits(rx_if.rst_n 	  	){1'b0}};
		rx_if.i_start 		= {$bits(rx_if.i_start 		){1'b0}};
		rx_if.i_op_mode 	= {$bits(rx_if.i_op_mode 	){1'b0}};
		rx_if.i_rx_data  	= {$bits(rx_if.i_rx_data  ){1'b0}};
		rx_if.i_rx_valid 	= {$bits(rx_if.i_rx_valid ){1'b0}};
		tx_if.i_tx_ready 	= {$bits(tx_if.i_tx_ready ){1'b1}}; //TODO
		// assert reset for 5 clock cycles
		repeat (5) begin
			@(posedge clk) ;
		end
		@(posedge clk);
		rx_if.rst_n 	= 1'b1;
		@(posedge clk);
	endtask : sys_rst


endmodule // tb_puf_soc_top