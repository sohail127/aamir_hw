module message_schdule_tb ();

	parameter BLK_CNT = 6  ;
	parameter MSG_SIZ = 512;
	parameter MSG_BLK = 32 ;

//--*************** Define internal signals here *************--//

	reg                clk           ;
	reg                reset_n       ;
	reg                i_msg_schdl_en;
	reg  [MSG_SIZ-1:0] i_msg         ;
	reg  [BLK_CNT-1:0] i_blk_nmbr    ;
	wire [MSG_BLK-1:0] o_msg_blk     ;

//--**************************************************--//
	message_schdule #(
		.BLK_CNT(BLK_CNT),
		.MSG_SIZ(MSG_SIZ),
		.MSG_BLK(MSG_BLK)
	) DUT (
		.clk           (clk           ),
		.reset_n       (reset_n       ),
		.i_msg_schdl_en(i_msg_schdl_en),
		.i_msg         (i_msg         ),
		.i_blk_nmbr    (i_blk_nmbr    ),
		.o_msg_blk     (o_msg_blk     )
	);

//--******* Define Clock here ****************--//

	initial clk = 1'b1;
	always #5 clk=!clk;

//--********* Start simulation here ************--//
	integer i;
	initial
		begin
			reset_n=1'b0;
			i_msg_schdl_en=1'b0;
			i_msg=512'h61626380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018;
			#1	$display ("\n");
			$display ("//--******** Start Stimulus ***************--// \n");
			$display ("Input Message is : %h:", i_msg);
			$display ("//--******** System Inputs ***************--// \n");
			$display ("	Reset_Value |	Start	|	Address");
			$display ("		%b		|  	%b		|	%d", reset_n, i_msg_schdl_en,i_blk_nmbr);
			$display ("//--******** System Outputs ***************--// \n");
			$display("Message weight	");
			$display("	%h			", o_msg_blk);
			$display ("\n");
			#14
				reset_n=1'b1;
			i_msg_schdl_en=1'b1;
			for (i=0; i<64;i=i+1)
				begin
					#9 i_blk_nmbr=i;
					#1	$display ("\n");
					$display ("//--******** System Inputs ***************--// \n");
					$display ("	Reset_Value |	Start	|	Address");
					$display ("		%b		|  	%b		|	%d", reset_n, i_msg_schdl_en,i_blk_nmbr);
					$display ("//--******** System Outputs ***************--// \n");
					$display("Message weight		");
					$display("	%h			", o_msg_blk);
					$display ("\n");
				end
			$display ("\n Test Passed! \n");
		end

endmodule // tb_message_schdule	