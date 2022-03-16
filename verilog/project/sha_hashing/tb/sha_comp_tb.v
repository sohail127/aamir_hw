module sha_comp_tb();


//--********** GIT signal declaration *********************--//
	reg            clk;		
	reg            reset_n;    
	reg            init;       
	reg            next;       
	reg            mode;       
	reg [511 : 0]  block;      
	wire           ready;      
	wire [255 : 0] digest;     
	wire           digest_valid;
	
//--******* PROPOSED design signals --*******************--//	
	
	parameter BLK_CNT=6;
	parameter MSG_SIZ=512;
	parameter MSG_BLK=32;
	parameter MAX_CNT=63;
	parameter HASH_SIZE=256;
	localparam CLK_PRD=10;
	
	reg usr_clk;				// input usr_clk;			// system clock signal 
	reg usr_reset_n;			// input usr_reset_n;		// system global reset_n active low logic
	reg i_start;				// input i_start;			// To start calculating hash just as enable
	reg [MSG_SIZ-1:0] i_msg;  	// input [MSG_SIZ-1:0] i_msg;  // message to finf hash
	wire o_valid;               //    output o_valid,
	wire [HASH_SIZE-1:0] o_hash; // output [HASH_SIZE-1:0] o_hash  // Hash value

//--****************** PROPOSED DESIGN **********************--//	
	sha_256 
	#(
		. BLK_CNT	 (BLK_CNT	 ),
		. MSG_SIZ	 (MSG_SIZ	 ),
		. MSG_BLK	 (MSG_BLK	 ),
		. MAX_CNT	 (MAX_CNT	 ),
		. HASH_SIZE	 (HASH_SIZE  )
	)               
	DUT_Proposed(
		. usr_clk		(usr_clk		),				// input usr_clk,			// system clock signal 
		. usr_reset_n	(usr_reset_n	),				// input usr_reset_n,		// system global reset_n active low logic
		. i_start		(i_start		),				// input i_start,			// To start calculating hash just as enable
		. i_msg  		(i_msg  		),				// input [MSG_SIZ-1:0] i_msg,  // message to finf hash
		.  o_valid	    ( o_valid	    ),             	//    output o_valid,
		.  o_hash  		( o_hash  		)				// output [HASH_SIZE-1:0] o_hash  // Hash value
	);
	
//--*************** GIT_REPO *********************************--//
	
	sha256_core
		
		GIT_REPO(
				.clk			(clk			)				,			//	input wire            clk,		
				.reset_n		(reset_n		)				,       	//  input wire            reset_n,              
				.init			(init			)				,          	//  input wire            init,       
				.next			(next			)				,          	//  input wire            next,       
				.mode			(mode			)				,          	//  input wire            mode,       
				.block			(block			)				,         	//  input wire [511 : 0]  block,      
				.ready			(ready			)				,         	//  output wire           ready,      
				.digest			(digest			)				,        	//  output wire [255 : 0] digest,     
				.digest_valid   (digest_valid   )							//  output wire           digest_valid
                );
				
//--****************************************************************//

//--***** define clock ***************--//
	initial	clk=1'b1;
	initial usr_clk=1'b1;
	
	always #(CLK_PRD/2)	usr_clk= !usr_clk;
	always #(CLK_PRD/2)	clk= !clk;	
	
//--*****************************************--//
	//--***** define stimulus GIT REPO****--//
	initial
	
	begin
		reset_n=1'b0;
	#15
		reset_n=1'b1;
		init=1'b1;       
		next=1'b0;       
		mode=1'b1;       
		block=512'h61626380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018;
	end // initial
	
//-- *********** Stimulus here proposed design******************--//	
	initial
		begin
			usr_reset_n=1'b0;
			i_start=1'b0;
			i_msg=512'h0;
		#15
        	usr_reset_n=1'b1;
			i_start=1'b1;	
			i_msg=512'h61626380000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018;
		end			
		
//--***************************************--//
endmodule