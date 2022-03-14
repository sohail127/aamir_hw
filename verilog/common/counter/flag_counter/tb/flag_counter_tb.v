module flag_counter_tb();

		reg 			clk_p               ;
		reg 			clk_n;
    reg 			rst_n             ;
    reg 			enable;
    wire 			flag_count;	
	localparam CLK_PRD=10;

flag_counter
	DUT(
		.clk_p     (clk_p     )   ,
		.clk_n     (clk_n     )   ,
		.rst_n     (rst_n     )   ,
		.enable    (enable    )   ,
		.flag_count(flag_count)   
	);
	
//--*************************************--//
	initial	clk_p=1'b1;
	always #(CLK_PRD/2) clk_p=!clk_p;
		initial	clk_n=1'b0;
	always #(CLK_PRD/2) clk_n=!clk_n;
	

//--*************************************--//
	initial
		begin
		
		$dumpfile("flag_count.vcd");
		$dumpvars(0,flag_counter_tb);
		end

		initial
		begin
			rst_n=1'b0;
			enable=1'b0;
		#15
			rst_n=1'b1;
			enable=1'b1;	
		end
	
endmodule // stat_counter_tb	