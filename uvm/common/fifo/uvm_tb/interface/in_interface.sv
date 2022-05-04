interface in_interface (input clk);
	logic               rst_n ;
	logic               i_rd  ;
	logic               i_wr  ;
	logic [BUS_WIDTH-1] i_data;
endinterface : in_interface