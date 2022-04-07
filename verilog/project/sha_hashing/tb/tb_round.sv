module tb_round ();

	localparam BLK_SIZE = 256;
	localparam WRD_SIZE = 32 ;
	localparam CLK_PRD  = 10 ;

//--*************** Internal Signals ********************** -- //

	reg                 clk             ; // clock signal
	reg                 reset_n         ; // reset_n signal active low
	reg                 i_round_en      ; // enable signal
	reg  [WRD_SIZE-1:0] i_round_constant; // round constant value from ROM
	reg  [BLK_SIZE-1:0] i_pre_blck_hash ; // hash of previous block
	reg  [WRD_SIZE-1:0] i_msg_blck      ; // Message block
	wire [BLK_SIZE-1:0] o_hash          ;

	reg     [31:0] rc_vector[2:0];
	reg     [31:0] i_hash   [2:0];
	reg     [31:0] msg      [2:0];
	integer        FILE          ;

	round #(
		.BLK_SIZE(BLK_SIZE),
		.WRD_SIZE(WRD_SIZE)
	) DUT (
		.clk             (clk             ), // clock signal
		.reset_n         (reset_n         ), // reset_n signal active low
		.i_round_en      (i_round_en      ), // enable signal
		.i_round_constant(i_round_constant), // round constant value from ROM
		.i_pre_blck_hash (i_pre_blck_hash ), // hash of previous block
		.i_msg_blck      (i_msg_blck      ), // Message block
		.o_hash          (o_hash          )
	);

//--*** Define clock here --**** --//
	initial clk = 1'b1;
	always #(CLK_PRD/2) clk=!clk;

//-- *********** Stimulus here ******************--//
	initial
		begin
			reset_n=1'b0;
			i_round_en=1'b0;
			#1	$display ("\n");
			$display ("//--******** Start Stimulus ***************--// \n");
			$display ("//--******** System Inputs ***************--// \n");
			$display ("	Reset_Value |	Start	");
			$display ("		%b		|  	%b		", reset_n, i_round_en);
			$display ("\n");
			#15
				reset_n=1'b1;
			i_round_en=1'b1;
			#1  $display ("//--******** System Inputs ***************--// \n");
			$display ("	Reset_Value |	Start	");
			$display ("		%b		|  	%b		", reset_n, i_round_en);
			$display ("\n");
		end
//--- ********** Read text files *************** -- //

	initial
		begin
			$readmemh ("round_constant.txt", rc_vector); // read memory as hex
			$readmemh ("message.txt", msg); // read memory as hex
			$readmemh ("hash_vector.txt", i_hash); // read memory as hex
			/*		#1
			$display("%h",rc_vector[0]);
			$display("%h",rc_vector[1]);
			$display("%h",rc_vector[2]);
			$display("%h",i_hash[0]);
			$display("%h",i_hash[1]);
			$display("%h",i_hash[2]);
			$display("%h",msg[0]);
			$display("%h",msg[1]);
			$display("%h",msg[2]);

			*/	end

//-- ************ Write text file *********************** -- //
	initial
		begin
			#20
				i_round_constant=rc_vector[0];
			i_pre_blck_hash=i_hash[0];
			i_msg_blck=msg[0];
			$display("\n");
			$display("	i_round_constant 		|	 i_pre_blck_hash 	| 		i_msg_blck");
			$display("		%h	","			%h	","		%h	",i_round_constant,i_pre_blck_hash,i_msg_blck);
			$display("\n");
			FILE=$fopen("hash.txt");
			$fdisplay (FILE,"%h",o_hash);
		end
endmodule	