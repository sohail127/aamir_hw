module tb_toggle_sync ();
//*********************************************************//
// 1. parameters declaration 															 //
//*********************************************************//
	parameter FST_CLK_PRD = 4 ;
	parameter SLW_CLK_PRD = 20;
	parameter XACT_CNT 		= 10; 
	int fast_cc_pls; 
	int slw_cc_pls ;
//*********************************************************//
// 2. input into reg 																			 //
//*********************************************************//
	reg i_src_clk  ;
	reg i_dst_clk  ;
	reg rst_n      ;
	reg i_src_data ;
//*********************************************************//
// 3. output as wire 																			 //
//*********************************************************//
	wire o_dst_data;
//*********************************************************//
// 4. DUT instantiations 																	 //
//*********************************************************//

	toggle_sync inst_toggle_sync(
		.i_src_clk  (i_src_clk  ), // input                   i_src_clk  , // Fast clock
		.i_dst_clk  (i_dst_clk  ), // input                   i_dst_clk  , // Slow clock
		.rst_n      (rst_n      ), // input 									rst_n      ,
		.i_src_data (i_src_data ), // input  								  i_src_data ,
		.o_dst_data (o_dst_data ) // output  								o_dst_data 
	);
//*********************************************************//
// 5. clocks generator 																		 //
//*********************************************************//
initial begin
	i_src_clk = 'b0; 
	i_dst_clk = 'b0; 
end

always  #((FST_CLK_PRD)/2)	i_src_clk = ~ i_src_clk ;  
always  #((SLW_CLK_PRD)/2)	i_dst_clk = ~ i_dst_clk ;  

//*********************************************************//
// 6. Reset Generator  																		 //
//*********************************************************//
task sys_rst();
	rst_n 		 = 1'b0;
	i_src_data = 1'b0; 
	repeat(5) begin
		@(posedge i_src_clk);
	end
	rst_n = 1'b1;
endtask : sys_rst
//*********************************************************//
// 7. generate pulses at slow clock  											 //
//*********************************************************//
task gen_data();
	for (int i = 0; i < XACT_CNT; i++) begin
		`ifdef  FULL_TEST 
			repeat (12) begin
				// $display("*****________FULL TEST_________________*****");
				@(posedge i_src_clk);
			end `elsif ERROR_TEST
				repeat (5) begin
				// $display("*****________ERROR TEST_________________*****");
					@(posedge i_src_clk);
				end
		`endif
		i_src_data = 1'b1; 
		$display("Number of pulses tarnsmitted on fast clock   %d",++fast_cc_pls);
			@(posedge i_src_clk);
		i_src_data = 1'b0; 
	end
endtask : gen_data

//*********************************************************//
// 8. collect pulses at slow clock  											 //
//*********************************************************//

task cllct_slw_pulses();
	fork
		// Thread 1 : collect pulses if successfully cdc is done  
		begin
			forever begin
				if (slw_cc_pls==XACT_CNT) begin
					break;
				end else begin
					@(posedge o_dst_data)
					$display("Number of pulses collected on slow clock     %d",++slw_cc_pls);
				end
				@(posedge i_dst_clk);
			end
		end
		// Thread 2: wait for 5*XACT_CNT clock cycle and abort the test
		begin
			repeat(XACT_CNT*5); begin
				@(posedge i_dst_clk);
			end
		end
	join_any
endtask : cllct_slw_pulses
//*********************************************************//
// 9. System checker 								 											 //
//*********************************************************//

task sys_checker();
	if (slw_cc_pls == fast_cc_pls) begin
		$display("****************************************************");
		$display("*****_____TEST PASS !!!!!!!____________________*****");
		$display("****************************************************");
	end else begin
		$display("****************************************************");
		$display("*****_____TEST FAILED !!!!!!!__________________*****");
		$display("****************************************************");
	end

	$display("****************************************************");
	$display("*****_____FINISH_SIMULATION____________________*****");
	$display("****************************************************");
endtask : sys_checker
//*********************************************************//
// 10. stimulus here 	 																		 //
//*********************************************************//
initial begin
	sys_rst();
	fork
		// Thread 1: send pulses
		begin
		gen_data();
		end
		// Thread 2: Receive pulses
		begin
			cllct_slw_pulses();
		end
	join
	
	repeat (5) begin
		@(posedge  i_dst_clk);
	end
	sys_checker();
	$stop();
end
endmodule : tb_toggle_sync