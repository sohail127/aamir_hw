module toggle_sync (
	input      i_src_clk , // Fast clock
	input      i_dst_clk , // Slow clock
	input      rst_n     ,
	input      i_src_data,
	output reg o_dst_data
);

	// toogle synchronizer
	(* dont_touch = "true" *) reg 			src_dff		;
	(* dont_touch = "true" *) reg [2:0] dbl_ff_syn;
	(* dont_touch = "true" *) reg 			toogle_src;


	// 1. toogle at source clock
	always @(posedge i_src_clk or negedge rst_n) begin
		if(~rst_n) begin
			toogle_src <= 1'b0;
		end else begin
			if (i_src_data) begin
				toogle_src <= ~ toogle_src;
			end else begin
				toogle_src <= toogle_src;
			end
		end
	end

	// 2. stage flip-flop synchronizer
	always @(posedge i_dst_clk or negedge rst_n) begin
		if(~rst_n) begin
			dbl_ff_syn <= {3{1'b0}};
		end else begin
			// dbl_ff_syn[0] <= src_dff ;
			dbl_ff_syn[0] <= toogle_src ;
			dbl_ff_syn[1] <= dbl_ff_syn[0] ;
			dbl_ff_syn[2] <= dbl_ff_syn[1] ;
		end
	end
	// 3. output pulse at destination clock
	always @(posedge i_dst_clk or negedge rst_n) begin
		if(~rst_n) begin
			o_dst_data <= 1'b0;
		end else begin
			o_dst_data <= dbl_ff_syn[2] ^ dbl_ff_syn[1];
		end
	end
endmodule : toggle_sync