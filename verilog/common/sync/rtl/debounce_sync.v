module debounce_sync (
	input 		 clk 	 ,    // Clock
	input 		 rst_n ,  // Asynchronous reset active low
	input 		 i_data,  
	output     o_data  
);

reg [1:0] r_dbl_ff;
// 2-stage flip-flop logic
always @(posedge clk or negedge rst_n) begin 
	if(~rst_n) begin
		r_dbl_ff <= {2{1'b0}};
	end else begin
		r_dbl_ff[0] <= i_data 		;
		r_dbl_ff[1] <= r_dbl_ff[0];
	end
end
	// generate a pulse 
	assign o_data =  r_dbl_ff[0] & ~ r_dbl_ff[1];

endmodule : debounce_sync