`timescale 1ns/1ps
module tb_sha_256 ();

//--********************************************--//
	parameter  BLK_CNT   = 6  ;
	parameter  MSG_SIZ   = 512;
	parameter  MSG_BLK   = 32 ;
	parameter  MAX_CNT   = 63 ;
	parameter  HASH_SIZE = 256;
	localparam CLK_PRD   = 20 ;
	integer    ii        = 0  ;
//--******************************************--//
	reg                  usr_clk    ;
	reg                  usr_reset_n;
	reg                  i_start    ;
	reg  [  MSG_SIZ-1:0] i_msg      ;
	wire                 o_valid    ;
	wire [HASH_SIZE-1:0] o_hash     ;


	sha_256 /*#(
		.BLK_CNT  (BLK_CNT  ),
		.MSG_SIZ  (MSG_SIZ  ),
		.MSG_BLK  (MSG_BLK  ),
		.MAX_CNT  (MAX_CNT  ),
		.HASH_SIZE(HASH_SIZE)
	)*/
	 DUT (
		.usr_clk    (usr_clk    ), // system clock signal
		.usr_reset_n(usr_reset_n), // system global reset_n active low logic
		.i_start    (i_start    ), // To start calculating hash just as enable
		.i_msg      (i_msg      ), // message to finf hash
		.o_valid    (o_valid    ),
		.o_hash     (o_hash     )  // Hash value
	);

//--*** Define clock here --**** --//
	initial usr_clk = 1'b1;
	always #(CLK_PRD/2) usr_clk=!usr_clk;

// system reset task
	task sys_rst(); 
		begin
		usr_reset_n = 1'b0   ;
		i_start   	= 1'b0   ;
		i_msg     	= 512'h0 ;
		ii 					= 0 		 ;
		end
	endtask : sys_rst

// initialize data
	task init_sys();
		begin
		usr_reset_n = 1'b1 ;
		i_start 		= 1'b1 ;
		i_msg   		= 512'h61626380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018;
		end
	endtask : init_sys
//-- *********** Stimulus here ******************--//
	initial begin
		repeat(5) begin
			sys_rst();
			@(posedge usr_clk);
		end
		@(posedge usr_clk)
			init_sys();
		// wait for getting fisrt hash
		forever begin
			if(o_valid) begin
				$display("First hash value is received as %h",o_hash);
				break ;
			end
			else begin
				$display("system busy at clock cycle %d", ii++);
			end
			@(posedge usr_clk);
		end
		@(posedge usr_clk);
		$stop();
	end
endmodule // tb_sha_256	