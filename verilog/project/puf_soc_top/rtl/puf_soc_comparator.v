module puf_soc_comparator #(parameter CNT_BIT_SIZE=32) (
	input                         i_full_0    ,
	input                         i_full_1    ,
	input      [CNT_BIT_SIZE-1:0] i_cnt_0     ,
	input      [CNT_BIT_SIZE-1:0] i_cnt_1     ,
	output reg [CNT_BIT_SIZE-1:0] o_loser     ,
	output reg                    o_comp_valid
);
// o_loser is a looser out
//
	always @(i_full_1 or i_full_0 or i_cnt_0 or i_cnt_1) begin
		case ({i_full_1,i_full_0})
			2'b00 : begin
				o_loser      = {CNT_BIT_SIZE{1'b0}};
				o_comp_valid = 1'b0;
			end
			2'b01 : begin
				o_loser      = i_cnt_1;
				o_comp_valid = 1'b1;
			end
			2'b10 : begin
				o_loser      = i_cnt_0;
				o_comp_valid = 1'b1;
			end
			2'b11 : begin
				o_loser      = {CNT_BIT_SIZE{1'b1}};
				o_comp_valid = 1'b1;
			end
			default : begin
				o_loser      = {CNT_BIT_SIZE{1'b0}};
				o_comp_valid = 1'b0;
			end
		endcase
	end
endmodule : puf_soc_comparator