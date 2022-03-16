module sha_256 
	#(
		parameter BLK_CNT=6,
		parameter MSG_SIZ=512,
		parameter MSG_BLK=32,
		parameter MAX_CNT=63,
		parameter HASH_SIZE=256
	)
	(
		input usr_clk,			// system clock signal 
		input usr_reset_n,		// system global reset_n active low logic
		input i_start,			// To start calculating hash just as enable
		input [MSG_SIZ-1:0] i_msg,  // message to finf hash
		output o_valid,
		output [HASH_SIZE-1:0] o_hash  // Hash value
	);
	`include "msg_schdl_function.vh"
	`include "round_function.vh"
	localparam IV=256'h6a09e667_bb67ae85_3c6ef372_a54ff53a_510e527f_9b05688c_1f83d9ab_5be0cd19; 
	/*
	//---------------//
	   wire [511:0] i_msg;
	   assign i_msg={488'd0,i_msg_tmp};
	//--------------//
	*/
	
	reg [HASH_SIZE-1:0] i_pre_blck_hash;
	wire [BLK_CNT-1:0]round_count;
	wire flag;
	wire o_cnt_en;
	wire [HASH_SIZE-1:0]o_hash_rnd;
	wire sel_1;
	reg [HASH_SIZE-1:0] o_hash_reg;
	
	wire [MSG_BLK-1:0] h_a;
	wire [MSG_BLK-1:0] h_b;
	wire [MSG_BLK-1:0] h_c;
	wire [MSG_BLK-1:0] h_d;
	wire [MSG_BLK-1:0] h_e;
	wire [MSG_BLK-1:0] h_f;
	wire [MSG_BLK-1:0] h_g;
	wire [MSG_BLK-1:0] h_h;
	
	assign h_a=o_hash_rnd[255:224];
	assign h_b=o_hash_rnd[223:192];
	assign h_c=o_hash_rnd[191:160];
	assign h_d=o_hash_rnd[159:128];
	assign h_e=o_hash_rnd[127:96];
	assign h_f=o_hash_rnd[95:64];
	assign h_g=o_hash_rnd[63:32];
	assign h_h=o_hash_rnd[31:0];
	
//--**********control unit **************--//
	cu_sha 
	cu(
		.usr_clk(usr_clk),			// system clock signal 
		.usr_reset_n(usr_reset_n),		// system global reset_n active low logic
		.i_start(i_start),			// To start calculating hash just as enable
		.i_cnt_flag(flag),		// FSM state driver flag from counter
		.o_cnt_en(o_cnt_en),		// counter enable signal as output
		.o_valid(o_valid),
		.sel_1(sel_1)
	);	
	
//---**************************************--//

	data_path 
	#(
		. BLK_CNT(BLK_CNT),
		. MSG_SIZ(MSG_SIZ),
		. MSG_BLK(MSG_BLK),
		. MAX_CNT(MAX_CNT),
		. HASH_SIZE(HASH_SIZE)
	)
	dp(
		.clk(usr_clk),
		.reset_n(usr_reset_n),
		.i_dp_en(o_cnt_en),
	//	.i_pre_blck_hash(i_pre_blck_hash),
		.i_msg(i_msg),
		.round_count(round_count),
		.i_cnt_en(o_cnt_en),
		.flag(flag),
		.o_hash(o_hash_rnd)
	);
	
//	assign o_hash = sel_1 ? (o_hash_rnd + IV) : 256'd0;
	
	
	always@(*)
		begin
			if (sel_1)
				begin

					o_hash_reg ={( h_a+ 32'h6a09e667),(h_b+32'hbb67ae85),(h_c+32'h3c6ef372),(h_d+32'ha54ff53a),(h_e+32'h510e527f),(h_f+32'h9b05688c),(h_g+32'h1f83d9ab),(h_h+32'h5be0cd19)};				
				end
			else
				o_hash_reg=256'h0;
			
		end
	assign o_hash=o_hash_reg;
	
//	assign 	i_pre_blck_hash= (round_count==6'd0) ? IV : o_hash_rnd;
	

	
endmodule // sha_256