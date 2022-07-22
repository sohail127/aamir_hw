module dflipflop (
	input 			clk 	,    // Clock
	input 			rst_n ,  // Asynchronous reset active low
	input 			i_data,	
	output reg  o_data	
);

// flip-flop logic
always @(posedge clk or negedge rst_n) begin 
	if(~rst_n) begin
		o_data <= 1'b0;
	end else begin
		o_data <= i_data;
	end
end

endmodule : dflipflop