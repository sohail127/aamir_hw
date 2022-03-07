module proc_mux 
	#(parameter  DATA_WIDTH	=32,
		parameter  MUX_SEL_SZ = 2
	)
	(
		input [DATA_WIDTH-1:0] i_mux_data_a,	
		input [DATA_WIDTH-1:0] i_mux_data_b,	
		input [DATA_WIDTH-1:0] i_mux_data_c,	
		input [DATA_WIDTH-1:0] i_mux_data_d,	
		input [MUX_SEL_SZ-1:0] i_mux_sel ,
		input [DATA_WIDTH-1:0] o_mux_data
);

`define MUX_2_1

`ifdef MUX_2_1
	assign o_mux_data = (i_mux_sel[0]) ?  i_mux_data_a : i_mux_data_b;
`elsif MUX_4_1
	always@(*) begin
		case (i_mux_sel)
		2'b00: o_mux_data = i_mux_data_a ;
		2'b01: o_mux_data = i_mux_data_b ;
		2'b10: o_mux_data = i_mux_data_c ;
		2'b11: o_mux_data = i_mux_data_d ;
			default : o_mux_data = {DATA_WIDTH{1'b0}};
		endcase
	end 
	`endif

endmodule : proc_mux