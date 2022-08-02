module puf_soc_syn #(parameter CNT_BIT_SIZE= 32) (
	input                         ro_clk        ,
	input                         sys_clk       ,
	input                         rst_n         ,
	input                         i_ro_cnt_valid,
	input      [CNT_BIT_SIZE-1:0] i_ro_cnt      ,
	input                         i_ro_cnt_full ,
	output                        o_sys_ready   ,
	output reg [CNT_BIT_SIZE-1:0] o_sys_cnt     ,
	output reg                    o_sys_cnt_full,
	output reg                    o_sys_valid     
);
	wire       ro_os         ;
	reg  [1:0] r_ro_cnt_valid;

/*	// double flop the single bit input count valid
	always @(posedge ro_clk or negedge rst_n) begin
	if(~rst_n) begin
	r_ro_cnt_valid <= {2{1'b0}};
	end else begin
	r_ro_cnt_valid[0] <= i_ro_cnt_valid 		 ;
	r_ro_cnt_valid[1] <= r_ro_cnt_valid [0] ;
	end
	end
	// generate one-shot pulse at src clock i.e. Fast clock genrated from oscillator circuit
	assign ro_os = r_ro_cnt_valid [0] && (~r_ro_cnt_valid [1]);

*/
	// instantiate the close-loop pulse  synchronizer
	puls_hnd_shk_sync inst_puls_hnd_shk_sync (
		.i_src_clk  (ro_clk                 ), // input      i_src_clk  , // Fast clock
		.i_dst_clk  (sys_clk                ), // input      i_dst_clk  , // Slow clock
		.rst_n      (rst_n                  ), // input      rst_n      ,
		.i_src_puls (i_ro_cnt_valid/*ro_os*/), // input      i_src_puls ,
		.o_dst_puls (sys_os                 ), // output reg o_dst_puls ,
		.o_dst_ready(o_sys_ready            )  // output reg o_dst_ready
	);


	// synchronze src input data at destination clock
	always @(posedge sys_clk or negedge rst_n) begin
		if(~rst_n) begin
			o_sys_cnt      <= {CNT_BIT_SIZE{1'b0}};
			o_sys_cnt_full <= 1'b0;
			o_sys_valid    <= 1'b0;
		end else begin
			if (sys_os) begin
				o_sys_cnt      <= i_ro_cnt;
				o_sys_cnt_full <= i_ro_cnt_full;
				o_sys_valid    <= 1'b1;
			end else begin
				o_sys_cnt      <= o_sys_cnt     ;
				o_sys_cnt_full <= o_sys_cnt_full;
				o_sys_valid    <= 1'b0;
			end
		end
	end
endmodule : puf_soc_syn