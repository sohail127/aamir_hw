module data_path 
	#(
		parameter BLK_CNT=6,
		parameter MSG_SIZ=512,
		parameter MSG_BLK=32,
		parameter MAX_CNT=63,
		parameter HASH_SIZE=256
	)
	(
		input clk,
		input reset_n,
		input i_dp_en,
	//	input [HASH_SIZE-1:0]i_pre_blck_hash,
		input [MSG_SIZ-1:0] i_msg,
		output [BLK_CNT-1:0]round_count,
		input i_cnt_en,
		output flag,
		output [HASH_SIZE-1:0] o_hash
	);
	`include "msg_schdl_function.vh"
	`include "round_function.vh"	
	
//--****** Internal Signals --************//
	wire [MSG_BLK-1:0] o_round_constant;
//	wire [BLK_CNT-1:0] round_count;
	wire [MSG_BLK-1:0]o_msg_blk;
	wire  [HASH_SIZE-1:0]i_pre_blck_hash;
	localparam IV=256'h6a09e667_bb67ae85_3c6ef372_a54ff53a_510e527f_9b05688c_1f83d9ab_5be0cd19;
//--******* Scheduling block ************--//	
	message_schdule 
   #(
		. BLK_CNT(BLK_CNT),
		. MSG_SIZ(MSG_SIZ),
		. MSG_BLK(MSG_BLK)
	)
	ms(
		.clk			(clk),
		.reset_n		(reset_n),
		.i_msg_schdl_en	(i_dp_en),
		.i_msg			(i_msg),
		.i_blk_nmbr		(round_count),
		.o_msg_blk		(o_msg_blk)
	);                                  
	
//--********* round constant **************--//
	round_constant 
	#(
		. ADDR_WTH(BLK_CNT),
		. WRD_SIZE(MSG_BLK)
	)
	rc(
	. clk(clk),				// clock signal
	. reset_n(reset_n),			// reset signal
	. enable(i_dp_en),				// enable signal
	. add(round_count),	// address as counter value to read rc
	.o_round_constant(o_round_constant)	// round_constant for each round
	);

//--*********** Counter *****************--//
	counter 
	#(
		. MAX_CNT(MAX_CNT),
		. CNT_SIZE(BLK_CNT)
	)
	cnt(
		.clk(clk),			// clock signal
		.reset_n(reset_n),  		// reset active low
		.i_cnt_en(i_cnt_en),		// counter enable
		.flag(flag),			// flag to change the control unit state
		.count(round_count)			// count will be passed as address
	);

//-- ******* round ****************************--//
	 round
	#(
		. BLK_SIZE(HASH_SIZE),
		. WRD_SIZE(MSG_BLK)
	)
	r(
		. clk(clk),									// clock signal
		. reset_n(reset_n),								// reset_n signal active low	
		. i_round_en(i_dp_en),                           // enable signal
		. i_round_constant(o_round_constant),		// round constant value from ROM
		. i_pre_blck_hash(i_pre_blck_hash), 		// hash of previous block
		. i_msg_blck(o_msg_blk),			// Message block
		. o_hash(o_hash)	
	);
assign i_pre_blck_hash=(i_dp_en && (round_count==6'd1) )?IV:o_hash;
/*
//--****************************************************************--//	
		always@(posedge clk or negedge reset_n)
	
		begin
			if (!reset_n)
				i_pre_blck_hash<=512'h0;
			else
				if (i_cnt_en)
					if (round_count==6'd0)
						i_pre_blck_hash=IV;
					else
						i_pre_blck_hash=o_hash;
				else
					i_pre_blck_hash<=i_pre_blck_hash;
		end // always@ (posedge clk)
	
//--****************************************************************--//	
*/
endmodule // data_path