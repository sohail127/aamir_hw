module proc_alu #(
	parameter DATA_WIDTH = 32,
	parameter ISA_DPTH   = 64
) (
	input  [$clog2(ISA_DPTH)-1:0] i_opcode  ,
	input  [      DATA_WIDTH-1:0] i_data_a  ,
	input  [      DATA_WIDTH-1:0] i_data_b  ,
	output reg [      DATA_WIDTH-1:0] o_data_alu
);

// Alu operations based on op-code
	always@(*) begin
		case(i_opcode)
			64'h0   : o_data_alu = i_data_a + i_data_b ; // ADD
			default : o_data_alu = {DATA_WIDTH{1'b0}} ; // TODO
		endcase
	end
endmodule : proc_alu