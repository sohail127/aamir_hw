module count_tb ();

	localparam CLK_PRD=10;
	parameter MAX_CNT=63;
	parameter CNT_SIZE=6;

//--****** signal declaration ***************--//
	reg 					clk;			// clock signal
    reg 					reset_n;  		// reset active low
    reg 					i_cnt_en;		// counter enable
    wire 					flag;			// flag to change the control unit state
    wire  [CNT_SIZE-1:0] 	count;			// count will be passed as address

counter 
	#(
		.MAX_CNT(MAX_CNT),
		.CNT_SIZE(CNT_SIZE)
	)
	DUT(
		.clk(clk),			// clock signal
		.reset_n(reset_n),  		// reset active low
		.i_cnt_en(i_cnt_en),		// counter enable
		.flag(flag),			// flag to change the control unit state
		.count(count)			// count will be passed as address
	);
	
	//--******* define clock here ***********--//
		initial clk=1'b1;
		always #(CLK_PRD/2) clk=!clk;
	
	//--****** Define stimulus here --*********//
		initial	
			begin
			$display ("//--************** Start Simulation ****************--// \n");
				reset_n=1'b0;
				i_cnt_en=1'b0;
			$display ("//--************** System Inputs ****************--// \n");	
			$display ("Reset_value	| Enable_value \n" );
			$display ("      %b     |   %b", reset_n, i_cnt_en);
			//$display ("Reset value: %b", reset_n);
			//$display ("Enable value: %b", i_cnt_en);	
				
			#15
				reset_n=1'b1;
				i_cnt_en=1'b1;
			$display ("      %b     |   %b", reset_n, i_cnt_en);
			//	display ("Reset");
		//	$display ("Reset value: %b", reset_n);
		//	$display ("Enable value: %b", i_cnt_en);
			end 
			
		initial
			begin
				#20
						$display ("//--************** System outputs ****************--//");
						$display ("Count_value  |   Flag_Status");
				forever
					begin	
						if (flag==1)
							begin
								$display("\n");
								$display ("//--******* End Simulation! Test pass *********** --// \n");
								$finish;
							end
						else
						
							#10 $display ("    %d        |      %b", count,flag );
					//	#5 $display ("Count value: %d", count);
					//	#5 $display ("Flag Status: %b", flag);
					end
			end
endmodule	// count_tb