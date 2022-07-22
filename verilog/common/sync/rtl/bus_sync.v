module bus_sync  #(parameter DWIDTH=32) (
  input                   i_src_clk  , // Clock
  input                   i_dst_clk  , // Clock
  input                   rst_n      , // Asynchronous reset active low
  input      [DWIDTH-1:0] i_src_data ,
  input                   i_src_valid,
  output reg [DWIDTH-1:0] o_dst_data ,
  output 		              o_dst_ready, 
  output reg              o_dst_valid  // Not required, additionaly added for understanding
	
);

	wire w_dst_valid;

// instantiation of pulse hand-shake synchronizer
// synchronize pulse and constrin is data will remain
// on bus for m+1 clcock cyclea

puls_hnd_shk_sync inst_puls_hnd_shk_sync(
	.i_src_clk  (i_src_clk  ) , // input      i_src_clk  , // Fast clock
	.i_dst_clk  (i_dst_clk  ) , // input      i_dst_clk  , // Slow clock
	.rst_n      (rst_n      ) , // input      rst_n      ,
	.i_src_puls (i_src_valid ) , // input      i_src_puls ,
	.o_dst_puls (w_dst_valid) , // output reg o_dst_puls ,
	.o_dst_ready(o_dst_ready)   // output reg o_dst_ready
);

// synchronze src input data at destination clock
always @(posedge i_dst_clk or negedge rst_n) begin 
	if(~rst_n) begin
		o_dst_data 	<= {DWIDTH{1'b0}};
		o_dst_valid <= 1'b0;
	end else begin
		if (w_dst_valid) begin
			o_dst_data <= i_src_data;
			o_dst_valid <= 1'b1;
		end else begin
			o_dst_data <= o_dst_data;
			o_dst_valid <= 1'b0;
		end
	end
end

endmodule : bus_sync