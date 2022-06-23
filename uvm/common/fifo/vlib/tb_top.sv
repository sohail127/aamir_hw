module tb_top ();

	// Internal paramters
	parameter CLK_PRD 	 = 10 	;
	parameter FIFO_DEPTH = 1024 ;
	parameter BUS_WIDTH  = 32 	;
	// clocking singnals
	bit clk;

	// Interface instances
	in_interface  if_in (clk);
	out_interface if_out(clk);

	// DUT initialization
	fifo #(
		.FIFO_DEPTH(FIFO_DEPTH),  
		.BUS_WIDTH (BUS_WIDTH )  
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
	uvm_config_db#(virtual in_interface)::set(uvm_root::get(),"*","if_in", vif_in );
	uvm_config_db#(virtual out_interface)::set(uvm_root::get(),"*","if_out",vif_out);
end

initial begin
	run_test();
end

endmodule : tb_top