module message_peddaing 
	#(
		parameter INPUT_SIZE=24,
		parameter OUTPUT_SIZE=512
	)
	(
		input 	[INPUT_SIZE-1:0] i_msg,
		output 	[OUTPUT_SIZE-1:0] o_msg
	);
	
		assign o_msg={i_msg,1'b1,423'd0,64'd24};
	endmodule