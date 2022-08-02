module puls_hnd_shk_sync (
	input      i_src_clk  , // Fast clock
	input      i_dst_clk  , // Slow clock
	input      rst_n      ,
	input      i_src_puls ,
	output reg o_dst_puls ,
	output 		 o_dst_ready
);
// internal register
	reg  r_dst_thrd_ff;
	reg  r_src_toggle ;
	wire w_dst_dbl_ff ;
	wire w_src_dbl_ff ;
	wire w_dst_puls   ;

// First stage catching the pulse
	always @(posedge i_src_clk or negedge rst_n) begin
		if(~rst_n) begin
			r_src_toggle <= 1'b0;
		end else begin
			if (i_src_puls) begin
				r_src_toggle <= 1'b1;
			end else begin
				if (w_src_dbl_ff) begin
					r_src_toggle <= 1'b0;
				end else begin
					r_src_toggle <= r_src_toggle;
				end
			end
		end
	end

// passing pulse to 2-FF sync at destination clock
	m_ff_sync #(.NUM_FF(2)) inst_dst_m_ff_sync (
		.clk   (i_dst_clk   ), // input  clk   ,
		.rst_n (rst_n       ), // input  rst_n ,
		.i_data(r_src_toggle), // input  i_data,
		.o_data(w_dst_dbl_ff)  // output o_data
	);

// feedback loop for sync at source domain
// passing pulse to 2-FF sync at destination clock
	m_ff_sync #(.NUM_FF(2)) inst_src_m_ff_sync (
		.clk   (i_src_clk   ), // input  clk   ,
		.rst_n (rst_n       ), // input  rst_n ,
		.i_data(w_dst_dbl_ff), // input  i_data,
		.o_data(w_src_dbl_ff)  // output o_data
	);

	// flop the double-flop pulse at destination clock
	always @(posedge i_dst_clk or negedge rst_n) begin
		if(~rst_n) begin
			r_dst_thrd_ff <= 1'b0;
		end else begin
			r_dst_thrd_ff <= w_dst_dbl_ff;
		end
	end


	// synchronize pulse at destination clock
	always @(posedge i_dst_clk or negedge rst_n) begin
		if(~rst_n) begin
			o_dst_puls <= 1'b0;
		end else begin
			o_dst_puls <= w_dst_puls;
		end
	end

	assign w_dst_puls  = w_dst_dbl_ff & ~r_dst_thrd_ff;
	assign o_dst_ready = ~(w_src_dbl_ff | r_src_toggle);

endmodule // puls_hnd_shk_sync