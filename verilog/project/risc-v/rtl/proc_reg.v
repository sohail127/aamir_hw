module proc_reg #(parameter DATA_WIDTH=32) (
	input                       clk       , // Clock
	input                       rst_n     , // Asynchronous reset active low
	input                       i_reg_en  , // Clock Enable
	input      [DATA_WIDTH-1:0] i_reg_data,
	output reg [DATA_WIDTH-1:0] o_reg_data
);
// simple instruction register logic here
	always@(posedge clk) begin
		if (!rst_n) begin
			o_reg_data <= {DATA_WIDTH{1'b0}};
		end
		else begin
			if (i_reg_en) begin
				o_reg_data <= i_reg_data;
			end
		end
	end
endmodule : proc_reg