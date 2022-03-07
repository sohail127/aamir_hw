module proc_pc #(
	parameter PC_START   = 128,
	parameter DATA_WIDTH = 32
) (
	input                       clk    , // Clock
	input                       rst_n  , // Asynchronous reset active low
	input                       i_ld_pc,
	input      [DATA_WIDTH-1:0] i_pc   ,
	output reg [DATA_WIDTH-1:0] o_pc
);

// program counter logic here. Initially set to offset value
	always@(posedge  clk) begin
		if(!rst_n) begin
			o_pc <= PC_START;
		end
		else begin
			if (i_ld_pc) begin
				o_pc <= i_pc;
			end
		end
	end
endmodule : proc_pc