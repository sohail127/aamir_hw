module tb_debounce_sync ();
//*********************************************************//
// 1. parameters declaration 															 //
//*********************************************************//
	parameter CLK_PRD  = 20;
	parameter XACT_CNT = 10;
//*********************************************************//
// 2. input into reg 																			 //
//*********************************************************//
	reg clk   ;
	reg rst_n ;
	reg i_data;
//*********************************************************//
// 3. output as wire 																			 //
//*********************************************************//
	wire o_data;

//*********************************************************//
// 4. DUT instantiations 																	 //
//*********************************************************//
	debounce_sync inst_debounce_sync (
		.clk   (clk   ), // input 		 clk 	 ,    // Clock
		.rst_n (rst_n ), // input 		 rst_n ,  // Asynchronous reset active low
		.i_data(i_data), // input 		 i_data,
		.o_data(o_data)  // output    o_data
	);
//*********************************************************//
// 5. clock Generator  																		 //
//*********************************************************//
	initial clk = 1'b1;
	always #((CLK_PRD)/2) clk = ~ clk ;

//*********************************************************//
// 6. Reset Generator  																		 //
//*********************************************************//
	task sys_rst();
		rst_n 		 = 1'b0;
		i_data 		 = 1'b0;
		repeat(5) begin
			@(posedge clk);
		end
		rst_n = 1'b1;
	endtask : sys_rst

//*********************************************************//
// 7. generate pulses at slow clock  											 //
//*********************************************************//
	task gen_data();
		for (int i = 0; i < XACT_CNT; i++) begin
			@(posedge clk);
			i_data = $random();
		end
	endtask : gen_data

//*********************************************************//
// 8. stimulus here 	 																		 //
//*********************************************************//
	initial begin
		sys_rst();
		gen_data();
		repeat (5) begin
			@(posedge  clk);
		end
		$display("****************************************************");
		$display("*****_____FINISH_SIMULATION____________________*****");
		$display("****************************************************");
		$stop();
	end
endmodule : tb_debounce_sync

