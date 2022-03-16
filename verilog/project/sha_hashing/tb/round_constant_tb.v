module round_constant_tb();

localparam ADDR_WTH=6;
localparam WRD_SIZE=32;
localparam CLK_PRD=10;

//--******* Declare signals here ****************--//

	reg clk;				// clock signal
	reg reset_n;			// reset signal
	reg enable;				// enable signal
	reg [ADDR_WTH-1:0]add;	// address as counter value to read rc
	wire  [WRD_SIZE-1:0]o_round_constant;	// round_constant for each round
	
round_constant 
	#(
		.ADDR_WTH(ADDR_WTH),
		.WRD_SIZE(WRD_SIZE)
	)
	DUT(
	.clk(clk),				// clock signal
	.reset_n(reset_n),			// reset signal
	.enable(enable),				// enable signal
	.add(add),	// address as counter value to read rc
	.o_round_constant(o_round_constant)	// round_constant for each round
	);

//--******* Define Clock here ****************--//
	initial clk=1'b1;
	always #5 clk=!clk;
	
//--********* Start simulation here ************--//
	integer i;
	initial
		begin
			reset_n=1'b0;
			enable=1'b0;
		#1	$display ("\n");
			$display ("//--******** Start Stimulus ***************--// \n");
			$display ("//--******** System Inputs ***************--// \n");
			$display ("	Reset_Value |	Start	|	Address");
			$display ("		%b		|  	%b		|	%d", reset_n, enable,add);
			$display ("//--******** System Outputs ***************--// \n");
			$display("o_round_constant	");
			$display("	%h			", o_round_constant);
			$display ("\n");	
		#5
			reset_n=1'b1;
			enable=1'b1;
		#5	
		for (i=0; i<64;i=i+1)
		begin
			#9 add=i;
		#1	$display ("\n");
			$display ("//--******** System Inputs ***************--// \n");
			$display ("	Reset_Value |	Start	|	Address");
			$display ("		%b		|  	%b		|	%d", reset_n, enable,add);
			$display ("//--******** System Outputs ***************--// \n");
			$display("o_round_constant	");
			$display("	%h			", o_round_constant);
			$display ("\n");	
		end		
		$display ("\n Test Passed! \n");
		end
	
endmodule // round_constant_tb	