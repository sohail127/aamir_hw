module tb_puls_hnd_shk_sync ();

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
	reg i_src_puls ;

//*********************************************************//
// 3. output as wire 																			 //
//*********************************************************//
	wire o_dst_puls  ;
	wire o_dst_ready ;
//*********************************************************//
// 4. DUT instantiations 																	 //
//*********************************************************//
	
	puls_hnd_shk_sync inst_puls_hnd_shk_sync(
	.i_src_clk  (i_src_clk  ), // input      i_src_clk  , // Fast clock
	.i_dst_clk  (i_dst_clk  ), // input      i_dst_clk  , // Slow clock
	.rst_n      (rst_n      ), // input      rst_n      ,
	.i_src_puls (i_src_puls ), // input      i_src_puls ,
	.o_dst_puls (o_dst_puls ), // output reg o_dst_puls ,
	.o_dst_ready(o_dst_ready)  // output reg o_dst_ready
	);
//*********************************************************//
// 5. clocks generator 																		 //
//*********************************************************//
`ifdef FAST_TO_SLOW 
	// source clock
	initial i_src_clk = 'b0; 
	always  #((FST_CLK_PRD)/2)	i_src_clk = ~ i_src_clk ;  
	// destination clock
	initial	i_dst_clk = 'b0; 
	always  #((SLW_CLK_PRD)/2)	i_dst_clk = ~ i_dst_clk ;  
`elsif SLW_TO_FAST
	// source clock
	initial i_src_clk = 'b0; 
	always  #((SLW_CLK_PRD)/2)	i_src_clk = ~ i_src_clk ;  
	// destination clock
	initial	i_dst_clk = 'b0; 
	always  #((FST_CLK_PRD)/2)	i_dst_clk = ~ i_dst_clk ; 
`endif
//*********************************************************//
// 6. Reset Generator  																		 //
//*********************************************************//
task sys_rst();
	rst_n 		 = 1'b0;
	i_src_puls = 1'b0; 
	repeat(5) begin
		@(posedge i_src_clk);
	end
	rst_n = 1'b1;
endtask : sys_rst

//*********************************************************//
// 7. generate pulses at slow clock  											 //
//*********************************************************//
task gen_pulses();
	
	for (int i = 0; i < XACT_CNT; i++) begin
		if (o_dst_ready) begin
			i_src_puls = 1'b1; 

			`ifdef FAST_TO_SLOW 
				$display("Number of pulses tarnsmitted on fast clock   %d",++fast_cc_pls);
			`elsif SLW_TO_FAST
				$display("Number of pulses tarnsmitted on slow clock   %d",++fast_cc_pls);
			`endif
			
			@(posedge i_src_clk);
			i_src_puls = 1'b0; 
		end
		@(posedge i_src_clk);
		wait(o_dst_ready);
	end
endtask : gen_pulses

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
					@(posedge o_dst_puls)
					
			`ifdef FAST_TO_SLOW 
					$display("Number of pulses collected on fast clock     %d",++slw_cc_pls);
			`elsif SLW_TO_FAST
					$display("Number of pulses collected on slow clock     %d",++slw_cc_pls);
			`endif

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
// 10. stimulus here                                       //
//*********************************************************//
initial begin
`ifdef FAST_TO_SLOW 
		$display("****************************************************");
		$display("*****_____FAST TO SLOW PULS SYNC_______________*****");
		$display("****************************************************");
	`elsif SLW_TO_FAST
		$display("****************************************************");
		$display("*****_____SLOW TO FAST SYNC____________________*****");
		$display("****************************************************");

	`endif	
  sys_rst() 	;
  fork
  	// Thread 1. generate input pulses
  	begin
  		gen_pulses();
  	end
  	// Thread 2: capture output pulses
  	begin
  		cllct_slw_pulses();
  	end
  join
  
  repeat(5) begin
 		@(posedge i_src_clk);
  end
  sys_checker();
  $stop();
end

endmodule // tb_puls_hnd_shk_sync