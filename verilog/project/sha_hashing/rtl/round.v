module round
	#(
		parameter BLK_SIZE=256,
		parameter WRD_SIZE=32
	)
	(
		input clk,									// clock signal
		input reset_n,								// reset_n signal active low	
		input i_round_en,                           // enable signal
		input [WRD_SIZE-1:0] i_round_constant,		// round constant value from ROM
		input [BLK_SIZE-1:0]  i_pre_blck_hash, 		// hash of previous block
		input [WRD_SIZE-1:0]  i_msg_blck,			// Message block
		output reg [BLK_SIZE-1:0] o_hash	
	);
	
	`include "msg_schdl_function.vh"
	`include "round_function.vh"
	
	//----******* split i_pre_blck_hash to 4-byte words -----********//
		wire [WRD_SIZE-1:0] i_a;
		wire [WRD_SIZE-1:0] i_b;
		wire [WRD_SIZE-1:0] i_c;
		wire [WRD_SIZE-1:0] i_d;
		wire [WRD_SIZE-1:0] i_e;
		wire [WRD_SIZE-1:0] i_f;
		wire [WRD_SIZE-1:0] i_g;
		wire [WRD_SIZE-1:0] i_h;
	//--******** out hash of round -***************************--//
		wire [WRD_SIZE-1:0] o_a;
		wire [WRD_SIZE-1:0] o_b;
		wire [WRD_SIZE-1:0] o_c;
		wire [WRD_SIZE-1:0] o_d;
		wire [WRD_SIZE-1:0] o_e;
		wire [WRD_SIZE-1:0] o_f;
		wire [WRD_SIZE-1:0] o_g;
		wire [WRD_SIZE-1:0] o_h;
		
	//----*******  i_pre_blck_hash word initialization *******************--//
	assign i_a=i_pre_blck_hash[255:224];
	assign i_b=i_pre_blck_hash[223:192];
	assign i_c=i_pre_blck_hash[191:160];
	assign i_d=i_pre_blck_hash[159:128];
	assign i_e=i_pre_blck_hash[127:96];
	assign i_f=i_pre_blck_hash[95:64];
	assign i_g=i_pre_blck_hash[63:32];
	assign i_h=i_pre_blck_hash[31:0];
	
	//--**************************--//
	reg [WRD_SIZE-1:0] i_fn_sigma_a;
	reg [WRD_SIZE-1:0] i_fn_sigma_e;
	reg [WRD_SIZE-1:0] i_sum_a_0;
	reg [WRD_SIZE-1:0] i_sum_a_1;
	reg [WRD_SIZE-1:0] i_fn_maj;
	reg [WRD_SIZE-1:0] i_fn_ch;
	reg [WRD_SIZE-1:0] i_sum_d_0;
	reg [WRD_SIZE-1:0] i_sum_h_0;
	reg [WRD_SIZE-1:0] i_sum_h_1;
	reg [WRD_SIZE-1:0] i_sum_h_2;
	reg [WRD_SIZE-1:0] i_sum_h_3;
	
	//-------***** internal function in round --****** //
/*	assign i_fn_ch=				ch (i_e,i_f,i_g);
	assign i_sum_h_0= 			cs (i_fn_ch,i_h);
	assign i_fn_sigma_e= 		sigma_e(i_e);	
	assign i_sum_h_1= 			cs (i_fn_sigma_e,i_sum_h_0);
	assign i_sum_h_2= 			cs (i_sum_h_1,i_msg_blck);
	assign i_sum_h_3= 			cs (i_sum_h_2, i_round_constant);
	assign i_sum_d_0= 			cs (i_sum_h_3, i_d);
	assign i_fn_maj= 			maj (i_a,i_b,i_c);
	assign i_fn_sigma_a=		sigma_a (i_a);
	assign i_sum_a_0= 			cs (i_fn_sigma_a,i_fn_maj);
	assign i_sum_a_1= 			cs (i_sum_h_3,i_sum_a_0);
	*/
	//----******* Output hash of round -------*******//
	
	assign  o_a=  i_sum_a_1;
	assign  o_b=i_a;
	assign  o_c=i_b;
	assign  o_d=i_c;
	assign  o_e=i_sum_d_0;
	assign  o_f=i_e;
	assign  o_g=i_f;
	assign  o_h=i_g;
	
	always@ (posedge clk or negedge reset_n)
		begin
			if (! reset_n)
				begin				
				o_hash <= 256'd0;
				i_fn_ch=		32'd0;
				i_sum_h_0= 	    32'd0;
				i_fn_sigma_e=   32'd0;
				i_sum_h_1= 	    32'd0;
				i_sum_h_2= 	    32'd0;
				i_sum_h_3= 	    32'd0;
				i_sum_d_0= 	    32'd0;
				i_fn_maj= 	    32'd0;
				i_fn_sigma_a=   32'd0;
				i_sum_a_0= 	    32'd0;
				i_sum_a_1= 	    32'd0;
				
				end
			else
				if (i_round_en)
					begin
					
					i_fn_ch=			ch (i_e,i_f,i_g);
					i_sum_h_0= 			cs (i_fn_ch,i_h);
					i_fn_sigma_e= 		sigma_e(i_e);	
					i_sum_h_1= 			cs (i_fn_sigma_e,i_sum_h_0);
					i_sum_h_2= 			cs (i_sum_h_1,i_msg_blck);
					i_sum_h_3= 			cs (i_sum_h_2, i_round_constant);
					i_sum_d_0= 			cs (i_sum_h_3, i_d);
					i_fn_maj= 			maj (i_a,i_b,i_c);
					i_fn_sigma_a=		sigma_a (i_a);
					i_sum_a_0= 			cs (i_fn_sigma_a,i_fn_maj);
					i_sum_a_1= 			cs (i_sum_h_3,i_sum_a_0);
					o_hash<={i_sum_a_1,i_a,i_b,i_c,i_sum_d_0,i_e,i_f,i_g};
				//	o_hash <= {o_a,o_b,o_c,o_d,o_e,o_f,o_g,o_h};
					end
				else
					begin
					o_hash<=o_hash;
					i_fn_ch=		32'd0;
					i_sum_h_0= 	    32'd0;
					i_fn_sigma_e=   32'd0;
					i_sum_h_1= 	    32'd0;
					i_sum_h_2= 	    32'd0;
					i_sum_h_3= 	    32'd0;
					i_sum_d_0= 	    32'd0;
					i_fn_maj= 	    32'd0;
					i_fn_sigma_a=   32'd0;
					i_sum_a_0= 	    32'd0;
					i_sum_a_1= 	    32'd0;
					end					
		end //(posedge clk or negedge reset_n)
	
	
	
endmodule // round