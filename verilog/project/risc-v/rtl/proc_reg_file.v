module proc_reg_file #(
	parameter BUS_WIDTH = 32,
	parameter REG_DPTH  = 32
) (
	input                         clk        , // Clock
	input                         rst_n      , // Asynchronous reset active low
	input                         i_reg_we   , // i_reg_we : 1 for write,
	input  [$clog2(REG_DPTH)-1:0] i_regw_add , // input register write address
	input  [$clog2(REG_DPTH)-1:0] i_rega_add ,
	input  [$clog2(REG_DPTH)-1:0] i_regb_add ,
	input  [       BUS_WIDTH-1:0] i_reg_data ,
	output [       BUS_WIDTH-1:0] o_rega_data,
	output [       BUS_WIDTH-1:0] o_regb_data
);
// registers here
	reg [BUS_WIDTH-1:0] reg_file[REG_DPTH-1:0];

// wriitng on registers
	always@(posedge clk) begin
		if (i_reg_we) begin
			reg_file[i_regw_add] <= i_reg_data ;
		end
	end

// reading from registers
	assign o_rega_data = reg_file[i_rega_add];
	assign o_regb_data = reg_file[i_regb_add];

endmodule : proc_reg_file