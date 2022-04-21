`timescale 1ns/1ps
module flag_counter #(parameter N_BIT=5 ,  parameter DUMP=10) (
	input      clk_p     ,
	input      clk_n     ,
	input      rst_n     ,
	input      enable    ,
	output reg flag_count
);

	//--***********************************************--//
	reg [2**N_BIT-1:0] count;

	//--**************************************************-//
	wire sys_clk;

	IBUFGDS #(
		.DIFF_TERM   ("FALSE"  ), // Differential Termination
		.IBUF_LOW_PWR("TRUE"   ), // Low power="TRUE", Highest performance="FALSE"
		.IOSTANDARD  ("LVDS_25")  // Specify the input I/O standard
	) IBUFGDS_inst (
		.O (sys_clk), // Clock buffer output
		.I (clk_p  ), // Diff_p clock buffer input (connect directly to top-level port)
		.IB(clk_n  )  // Diff_n clock buffer input (connect directly to top-level port)
	);

	always @(posedge sys_clk or posedge rst_n) begin
		if(rst_n) begin
			count      <= {N_BIT{1'b0}};
			flag_count <= 1'b0;
		end
		else begin
			if (enable) begin
				if(count==DUMP) begin
					count      <= {N_BIT{1'b0}};
					flag_count <= 1'b1;
				end
				else begin
					count      <= count+1;
					flag_count <= 1'b0;
				end
			end
			else begin
				count      <= {N_BIT{1'b0}};;
				flag_count <= 1'b0;
			end	end
	end
endmodule