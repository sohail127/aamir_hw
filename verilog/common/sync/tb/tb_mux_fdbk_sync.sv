module tb_mux_fdbk_sync ();
//*********************************************************//
// 1. parameters declaration                               //
//*********************************************************//
  parameter DWIDTH          = 4 ;
  parameter FST_CLK_PRD     = 4 ;
  parameter SLW_CLK_PRD     = 20;
  parameter XACT_CNT        = 10;
  int       fast_cc_pls     = 0 ;
  int       slw_cc_pls      = 0 ;
  int       i_src_data_q[$]     ;
  int       o_dst_data_q[$]     ;
//*********************************************************//
// 2. input into reg                                       //
//*********************************************************//
  reg              i_src_clk  ;
  reg              i_dst_clk  ;
  reg              rst_n      ;
  reg [DWIDTH-1:0] i_src_data ;
  reg              i_src_valid;
//*********************************************************//
// 3. output as wire                                       //
//*********************************************************//
  wire [DWIDTH-1:0] o_dst_data ;
  wire              o_dst_valid;
  wire              o_dst_ready;
//*********************************************************//
// 4. DUT instantiations                                   //
//*********************************************************//
mux_fdbk_sync #(.DWIDTH(DWIDTH)) inst_mux_fdbk_sync(
  .i_src_clk  (i_src_clk  ), // input                   i_src_clk  , // Clock
  .i_dst_clk  (i_dst_clk  ), // input                   i_dst_clk  , // Clock
  .rst_n      (rst_n      ), // input                   rst_n      , // Asynchronous reset active low
  .i_src_data (i_src_data ), // input      [DWIDTH-1:0] i_src_data ,
  .i_src_valid(i_src_valid), // input                   i_src_valid,
  .o_dst_data (o_dst_data ), // output reg [DWIDTH-1:0] o_dst_data ,
  .o_dst_ready(o_dst_ready), // output                  o_dst_ready,
  .o_dst_valid(o_dst_valid)  // output reg              o_dst_valid  // Not required, additionaly added for understanding
);
//*********************************************************//
// 5. clocks generator                                     //
//*********************************************************//
`ifdef FAST_TO_SLOW 
  // source clock
  initial i_src_clk = 'b0; 
  always  #((FST_CLK_PRD)/2)  i_src_clk = ~ i_src_clk ;  
  // destination clock
  initial i_dst_clk = 'b0; 
  always  #((SLW_CLK_PRD)/2)  i_dst_clk = ~ i_dst_clk ;  
`elsif SLW_TO_FAST
  // source clock
  initial i_src_clk = 'b0; 
  always  #((SLW_CLK_PRD)/2)  i_src_clk = ~ i_src_clk ;  
  // destination clock
  initial i_dst_clk = 'b0; 
  always  #((FST_CLK_PRD)/2)  i_dst_clk = ~ i_dst_clk ; 
`endif

//*********************************************************//
// 6. Reset Generator                                      //
//*********************************************************//
  task sys_rst();
    rst_n      = 1'b0;
    i_src_data  = {$bits(i_src_data)  {1'b0}};
    i_src_valid = {$bits(i_src_valid) {1'b0}};
    repeat(5) begin
      @(posedge i_src_clk);
    end
    rst_n = 1'b1;
  endtask : sys_rst

//*********************************************************//
// 7. generate pulses at slow clock                        //
//*********************************************************//
  task gen_data();

    for (int i = 0; i < XACT_CNT; i++) begin
      // send first sample and the wait for ready signal from synchronizer
      if (i==0) begin
      	i_src_valid = 1'b1;
        i_src_data  = $random();
        i_src_data_q.push_back(i_src_data);
        `ifdef FAST_TO_SLOW
          $display("Number of pulses tarnsmitted on fast clock   %d",++fast_cc_pls);
        `elsif SLW_TO_FAST
          $display("Number of pulses tarnsmitted on slow clock   %d",++fast_cc_pls);
        `endif
        @(posedge i_src_clk);
        i_src_valid = 1'b0;
      end else begin
	      if (o_dst_ready) begin
	        i_src_valid = 1'b1;
	        i_src_data  = $random();
	        i_src_data_q.push_back(i_src_data);
	        `ifdef FAST_TO_SLOW
	          $display("Number of pulses tarnsmitted on fast clock   %d",++fast_cc_pls);
	        `elsif SLW_TO_FAST
	          $display("Number of pulses tarnsmitted on slow clock   %d",++fast_cc_pls);
	        `endif
	        @(posedge i_src_clk);
	        i_src_valid = 1'b0;
	      end	
      end
      @(posedge i_src_clk);
      wait(o_dst_ready);
    end
  endtask : gen_data

//*********************************************************//
// 8. collect pulses at slow clock                         //
//*********************************************************//

  task cllct_dst_data();
    fork
      // Thread 1 : collect pulses if successfully cdc is done
      begin
        forever begin
          if (o_dst_data_q.size()==XACT_CNT) begin
            break;
          end else begin
            if (o_dst_valid) begin
              o_dst_data_q.push_back(o_dst_data);
              $display("Number of samples collected on slow clock     %d",o_dst_data_q.size());
            end
          end
          @(posedge i_dst_clk);
        end
      end
      // Thread 2: wait for 5*XACT_CNT clock cycle and abort the test
      begin
        repeat(XACT_CNT*4); begin
          @(posedge i_dst_clk);
        end
      end
    join_any
  endtask : cllct_dst_data

//*********************************************************//
// 9. System checker                                       //
//*********************************************************//
  task sys_checker();
    int match   ;
    int mismatch;
    int src_data;
    int dst_data;

    	$display("contents of expected q %p",i_src_data_q);
    	$display("contents of capture q  %p",o_dst_data_q);
    // read data from queue
    while(i_src_data_q.size()>0) begin
      // check size of destination queue
      if (o_dst_data_q.size()==0) begin
        $display("*****_____Unexpected Errors____________________*****");
        break;
      end
      // pop data form queu
      src_data = i_src_data_q.pop_front();
      dst_data = o_dst_data_q.pop_front();

      // compare sample and recv data
      if (src_data == dst_data) begin
        $display("Number of Sample Matches",++match);
      end else begin
        $display("Number of Sample Mismatches",++mismatch);
      end
    end
    // monitor statistics of results here
    if (match == XACT_CNT) begin
      $display("****************************************************");
      $display("*****_____TEST PASS !!!!!!!____________________*****");
      $display("*****_____Matches :: %d__________________*****",match);
      $display("*****_____Mismatches :: %d____________*****",mismatch);
      $display("****************************************************");
    end else begin
      $display("****************************************************");
      $display("*****_____TEST FAILED !!!!!!!__________________*****");
      $display("*****_____Matches :: %d__________________*****",match);
      $display("*****_____Mismatches :: %d____________*****",mismatch);
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
    sys_rst();
    fork
      // Thread 1: send pulses
      begin
        gen_data();
      end
      // Thread 2: Receive pulses
      begin
        cllct_dst_data();
      end
    join

    repeat (5) begin
      @(posedge  i_dst_clk);
    end
    sys_checker();
    $stop();
  end

endmodule : tb_mux_fdbk_sync