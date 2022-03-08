module tb_shift_register ();
// parameters here
	localparam CLK_PRD   = 10;
	localparam BUS_WIDTH = 32;
	// internerl variables
	reg [$clog2(BUS_WIDTH):0] count      = 0;
	reg [      BUS_WIDTH-1:0] o_rcv_data = 0;
// inputs as registers here
	reg                 clk       ;
	reg                 rst_n     ;
	reg                 i_ld_data ;
	reg                 i_sht_lr  ;
	reg [BUS_WIDTH-1:0] i_reg_data;
// outputs as wire here
	wire o_busy ;
	wire o_shift;
	wire o_valid;

	shift_register #(.BUS_WIDTH(BUS_WIDTH)) SR (
		.clk       (clk       ), // input                  clk       , // clock
		.rst_n     (rst_n     ), // input                  rst_n     , // active low reset
		.i_ld_data (i_ld_data ), // input                  i_ld_data , // 1: to load data
		.i_sht_lr  (i_sht_lr  ), // input                  i_sht_lr  , // shift_lr : 1 for right shift, 0: for left shift
		.i_reg_data(i_reg_data), // input  [BUS_WIDTH-1:0] i_reg_data, // register data
		.o_busy    (o_busy    ), // output                 o_busy    , // 1: when shifiting
		.o_shift   (o_shift   ), // output                 o_shift   , // serial output
		.o_valid   (o_valid   )  // output                 o_valid     // 1: when output is valid
	);

// clock generation
	initial clk = 1'b1;
	always #((CLK_PRD/2)) clk = ~clk;
// reset task
	task rst_sys();
		$display("Active low reset is asserted");
		rst_n			 	= '0;
		i_ld_data   = '0;
		i_sht_lr    = '0;
		i_reg_data  = '0;
		@(posedge clk);

	endtask : rst_sys

// stimulus generator
	task sim_gen();
		$display("Simulation start");
		rst_n			 	= '1;
		i_ld_data   = '1;
		i_sht_lr    = '0;
		i_reg_data  = $random();
		// i_reg_data  = 'hAAAA_AAAA;
		@(posedge clk);
		i_ld_data   = '0;
		count 			= 'h0;
		// @(posedge clk);
		// reference Model
		forever begin
			if (o_valid) begin
				if(count==BUS_WIDTH-1) begin
					o_rcv_data = (i_sht_lr) ? {o_shift,o_rcv_data[BUS_WIDTH-1:1]} : {o_rcv_data[BUS_WIDTH-2:0],o_shift};
					// o_rcv_data = {o_shift,o_rcv_data[BUS_WIDTH-1:1]};
					$display("rcv data is %b for counter value %d",o_rcv_data,count++);
					$display("Simulation Done");
					break;
				end
				else begin
					o_rcv_data = (i_sht_lr) ? {o_shift,o_rcv_data[BUS_WIDTH-1:1]} : {o_rcv_data[BUS_WIDTH-2:0],o_shift};
					$display("rcv data is %b for counter value %d",o_rcv_data,count++);
				end
			end
			@(posedge clk);
		end
	endtask : sim_gen

// checker
task sim_checker();
	$display("checker");
		if (o_rcv_data == i_reg_data) begin
			$display("************************************************");
			$display("Test Pass");
			$display("Expected Value= %h Received value= %h", i_reg_data, o_rcv_data);
			$display("************************************************");
		end
		else begin
			$display("************************************************");
			$display("Test Failed");
			$display("Expected Value= %h Received value= %h", i_reg_data, o_rcv_data);
			$display("************************************************");
		end	
endtask : sim_checker



// run test
	initial
		begin
			$dumpfile("tb_shift_register.vcd");
			$dumpvar(1,tb_shift_register);
			$display("************************************************");
			$display("********** 	tb_shift_register  *****************");
			$display("************************************************");
			repeat (5) begin
				$display("Reset The device");
				rst_sys();
			end
			$display("run test");
			// call generator
			sim_gen();
			// call checker
			sim_checker();
			@(posedge clk);
			$stop();

		end
endmodule : tb_shift_register