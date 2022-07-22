	interface puf_rx_if (input clk); 
	logic     rst_n 		;
	logic 		i_start   ;
	logic 		i_op_mode ;
	logic 		o_rx_ready;
	logic 		i_rx_valid;
	logic 		i_rx_data ;

endinterface : puf_rx_if