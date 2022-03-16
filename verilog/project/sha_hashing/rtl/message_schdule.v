module message_schdule 
   #(
		parameter BLK_CNT=6,
		parameter MSG_SIZ=512,
		parameter MSG_BLK=32
	)
	(
		input clk,
		input reset_n,
		input i_msg_schdl_en,
		input [MSG_SIZ-1:0] i_msg,
		input [BLK_CNT-1:0] i_blk_nmbr,
		output reg [MSG_BLK-1:0] o_msg_blk		
	);
	
	`include "msg_schdl_function.vh"
	`include "round_function.vh"
    wire [MSG_BLK-1:0] message_weight [63:0];
//-------------------------------------------------//	
	assign message_weight[15 ]= i_msg[31 :0];
	assign message_weight[14 ]= i_msg[63 :32];
	assign message_weight[13 ]= i_msg[95 :64];
	assign message_weight[12 ]= i_msg[127:96];
	assign message_weight[11 ]= i_msg[159:128];
	assign message_weight[10 ]= i_msg[191:160];
	assign message_weight[9]= i_msg[223:192];
	assign message_weight[8 ]= i_msg[255:224];
	assign message_weight[7 ]= i_msg[287:256];
	assign message_weight[6 ]= i_msg[319:288];
	assign message_weight[5]= i_msg[351:320];
	assign message_weight[4]= i_msg[383:352];
	assign message_weight[3]= i_msg[415:384];
	assign message_weight[2]= i_msg[447:416];
	assign message_weight[1]= i_msg[479:448];
	assign message_weight[0]= i_msg[511:480];



//--******************************************************--//
genvar i;
generate 					
				for (i=16; i<64; i=i+1)
		begin				
					assign message_weight[i]= alpha_1(message_weight[i-2])+ alpha_0(message_weight[i-15]) + message_weight[i-7]+ message_weight[i-16];
		end
	endgenerate

//--********************************************************--//

//--*******************************************************--//
	always@ (posedge clk or negedge reset_n)
		begin
			if (! reset_n)
				begin
					o_msg_blk<=32'd0;
				end
			else
				begin
					if (i_msg_schdl_en)
							begin
								o_msg_blk<=message_weight[i_blk_nmbr];
							end
					else
						begin

						end
				end		
		end // always@ (posedge clk or negedge reset_n) 
		
endmodule // message_schdule
