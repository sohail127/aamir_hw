module tb_top ();

	in_interface  vif_in ;
	out_interface vif_out;

// DUT initialization
	fifo #(
		parameter FIFO_DEPTH = 1024,
		parameter BUS_WIDTH  = 32
	) DUT (
		.clk    (clk            ), // input                clk    , // Clock
		.rst_n  (vif_in.rst_n   ), // input                rst_n  , // Asynchronous reset active low
		.i_rd   (vif_in.i_rd    ), // input                i_rd   , // 1: rd
		.i_wr   (vif_in.i_wr    ), // input                i_wr   , // 1 : wr
		.i_data (vif_in.i_data  ), // input  [BUS_WIDTH-1] i_data , // input data
		.o_data (vif_out.o_data ), // output [BUS_WIDTH-1] o_data , // output data
		.o_empty(vif_out.o_empty), // output               o_empty, // 1 : if fifo is empty
		.o_full (vif_out.o_full )  // output               o_full   // 1 : if fifo is full
	);
// set interface config_db 
initial begin
	`uvm_config_db();
	`uvm_config_db();
end
initial begin
	run_test();
end

endmodule : tb_top