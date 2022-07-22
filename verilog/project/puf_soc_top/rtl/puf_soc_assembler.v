module puf_soc_assembler #(
	parameter CNT_BIT_SIZE = 32 ,
	parameter MUX_LENGTH   = 16 ,
	parameter FRAM_SIZE    = 160
) (
	input                                 clk            , // Clock
	input                                 rst_n          , // Asynchronous reset active low
	input                                 i_op_mode      ,
	input                                 i_assmblr_en   ,
	input      [        CNT_BIT_SIZE-1:0] i_cnt_lser     ,
	input      [        CNT_BIT_SIZE-1:0] i_cnt_0        ,
	input      [        CNT_BIT_SIZE-1:0] i_cnt_1        ,
	input                                 i_full_0       ,
	input                                 i_full_1       ,
	input      [          MUX_LENGTH-1:0] i_ro_bnk_en    ,
	input      [                     2:0] i_fsm_state    ,
	input      [  $clog2(MUX_LENGTH)-1:0] i_sel_mux_0    ,
	input      [  $clog2(MUX_LENGTH)-1:0] i_sel_mux_1    ,
	input      [2*$clog2(MUX_LENGTH)-1:0] i_rx_data      ,
	output reg [           FRAM_SIZE-1:0] o_assmblr_data ,
	output reg                            o_assmblr_valid
);

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			o_assmblr_data  <= {FRAM_SIZE{1'b0}};
			o_assmblr_valid <= 1'b0;
		end else begin
			if (i_op_mode) begin
				o_assmblr_data  <= {27'b0,i_rx_data,i_sel_mux_1,i_sel_mux_0,i_fsm_state,i_ro_bnk_en,i_full_1,i_full_0,i_cnt_1,i_cnt_0,i_cnt_lser}; // 160-bit frame
				o_assmblr_valid <= 1'b1;
			end else begin
				if (i_assmblr_en) begin
					o_assmblr_data  <= {126'b0,i_full_1,i_full_0,i_cnt_lser}; // 160-bit frame
					o_assmblr_valid <= 1'b1;
				end else begin
					o_assmblr_valid <= 1'b0;
				end

			end
		end
	end

endmodule : puf_soc_assembler