module flag_counter
	(
		input 			clk_p         ,
		input				clk_n					,
		input 			rst_n        ,
		input 			enable       ,
		output	reg flag_count   
	);
	
	//--***********************************************--//
	reg [31 : 0]	count 	;
	
	//--**************************************************-//
	wire sys_clk;
IBUFGDS #(
.DIFF_TERM("FALSE"), // Differential Termination
.IBUF_LOW_PWR("TRUE"), // Low power="TRUE", Highest performance="FALSE"
.IOSTANDARD("LVDS_25") // Specify the input I/O standard
)
IBUFGDS_inst (
.O(sys_clk), // Clock buffer output
.I(clk_p), // Diff_p clock buffer input (connect directly to top-level port)
.IB(clk_n) // Diff_n clock buffer input (connect directly to top-level port)
);



always @(posedge sys_clk or posedge rst_n) 
	begin : proc_flag_counter
			if(rst_n) 
				begin		 			
		 			count<= 32'd0;
		 			flag_count<=1'b0;
				end 
			else 
				begin
						if (enable)
		 					begin
		 					if(count==32'd1000)
		 						begin
		 							count<=32'd0 ;
		 							flag_count<=1'b1;
		 						end	
		 					else
		 							begin
										count<=count+1;
			 							flag_count<=1'b0;
		 							end
		 					end			
		 				else
		 					begin
		 						count<= 32'd0;
		 						flag_count<=1'b0;
		 					end	

	end
end
endmodule