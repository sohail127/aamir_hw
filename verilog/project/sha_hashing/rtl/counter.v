module counter 
	#(
		parameter MAX_CNT=63,
		parameter CNT_SIZE=6
	)
	(
		input 						clk,			// clock signal
		input 						reset_n,  		// reset active low
		input 						i_cnt_en,		// counter enable
		output reg					flag,			// flag to change the control unit state
		output reg [CNT_SIZE-1:0] 	count			// count will be passed as address
	);
	
	always@(posedge clk or negedge reset_n)
		begin
			if (!reset_n)  // active_low reset_n
				begin
					flag<=1'b0;
					count<= 6'd0;
				end
			else
				if (i_cnt_en)
					begin
						if (count==MAX_CNT)
							begin
								count<=6'd63;
								flag<=1'b1;
							end
						else // count !MAX_CNT
							begin
								count<=count+1;
								flag<=1'b0;								
							end
					end
				else	// if (i_cnt_en)
					begin
						flag<=1'b0;
						count<= 6'd0;
					end
		end // always@ (posedge clk or negedge reset_n)
	
endmodule // counter