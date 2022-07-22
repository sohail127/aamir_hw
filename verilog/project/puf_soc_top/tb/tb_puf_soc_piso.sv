module tb_puf_soc_piso ();
//********************************************************************************
// ** Parameters here
//********************************************************************************
	parameter           FRAM_SIZE       = 160;
	parameter           NORM_MOD        = 34 ;
	parameter           DEBUG_MOD       = 133;
	parameter           CLK_PRD         = 10 ;
	reg [ NORM_MOD-1:0] nrm_data_buff   = 0  ;
	reg [DEBUG_MOD-1:0] debug_data_buff = 0  ;
	int                 nrm_cnt         = 0  ;
	int                 debug_cnt       = 0  ;

//********************************************************************************
// ** Outputs are wire
//********************************************************************************
	wire o_tx_ready;
	wire o_tx_data ;
	wire o_tx_valid;
	wire o_tx_done ;
//********************************************************************************
// ** Inputs as reg
//********************************************************************************
	reg                 clk       ;
	reg                 rst_n     ;
	reg                 i_tx_valid;
	reg                 i_tx_mode ;
	reg                 i_tx_en   ;
	reg [FRAM_SIZE-1:0] i_tx_data ;
	reg                 i_tx_ready;

//********************************************************************************
// ** Module instantiation
//********************************************************************************

	puf_soc_piso #(
		.FRAM_SIZE(FRAM_SIZE),
		.NORM_MOD (NORM_MOD ),
		.DEBUG_MOD(DEBUG_MOD)
	) DUT (
		.clk       (clk       ), // input                  clk       , // clock
		.rst_n     (rst_n     ), // input                  rst_n     , // active low reset
		.i_tx_en   (i_tx_en   ), // input                  i_tx_valid , // 1: to load data
		.i_tx_mode (i_tx_mode ), // input                  i_tx_mode , // i_tx_mode : 1 for debugging frame, 0: for normal frame
		.i_tx_ready(i_tx_ready), // input                  i_tx_ready, // shift_lr : 1 for right shift, 0: for left shift
		.i_tx_valid(i_tx_valid), // input                  i_tx_valid, // shift_lr : 1 for right shift, 0: for left shift
		.i_tx_data (i_tx_data ), // input  [FRAM_SIZE-1:0] i_tx_data , // register data
		.o_tx_ready(o_tx_ready), // output                 o_tx_ready, // Assert high to accept new data
		.o_tx_data (o_tx_data ), // output                 o_tx_data , // serial output
		.o_tx_valid(o_tx_valid), // output                 o_tx_valid, // 1: when output is valid
		.o_tx_done (o_tx_done )  // output                 o_tx_done   // 1: when output is valid
	);

// clock generation
	initial clk = 1'b1;
	always #((CLK_PRD/2)) clk = ~clk;

//********************************************************************************
// ** Reset Task
//********************************************************************************
	task sys_rst();
		rst_n       = {$bits(rst_n       ){1'b0}};
		i_tx_en   	= {$bits(i_tx_en   	 ){1'b0}};
		i_tx_valid  = {$bits(i_tx_valid  ){1'b0}};
		i_tx_mode   = {$bits(i_tx_mode   ){1'b0}};
		i_tx_data   = {$bits(i_tx_data   ){1'b0}};
		i_tx_ready  = {$bits(i_tx_ready  ){1'b1}};

		// assert reset for 5 clock cycles
		repeat (5) begin
			@(posedge clk) ;
		end
		@(posedge clk);
		rst_n 	= 1'b1;
		@(posedge clk);
	endtask : sys_rst
//********************************************************************************
// ** Load data
//********************************************************************************
	task gen_data();
		$display("************************_______gen_data____________************************************");
		if (o_tx_ready) begin
			i_tx_valid 	= 1'b1;
			i_tx_data   = $random();
		end
		@(posedge clk);
		i_tx_valid 	= 1'b0;
		// Normal mode
		i_tx_mode 	= 1'b0;
		i_tx_en 		= 1'b1;
		@(posedge clk);
	endtask : gen_data

	//********************************************************************************
// ** Load data
//********************************************************************************
	task gen_debug_data();
		$display("************************_______gen_debug_data____________************************************");
		if (o_tx_ready) begin
			i_tx_valid 	= 1'b1;
			i_tx_data   = $random();
		end
		@(posedge clk);
		i_tx_valid 	= 1'b0;
		// Normal mode
		i_tx_mode 	= 1'b1;
		i_tx_en 		= 1'b1;
		@(posedge clk);
	endtask : gen_debug_data
//********************************************************************************
// ** sys_checker
//********************************************************************************
	task sys_checker();
		$display("************************_______sys_checker____________************************************");
		if (~i_tx_mode) begin
			norm_mod();
		end else begin
			debug_mod();
		end
	endtask : sys_checker
//********************************************************************************
// ** normal mode
//********************************************************************************
	task norm_mod();
		$display("************************_______norm_mod____________************************************");
		forever begin
			@(posedge clk);
			if (o_tx_valid) begin
				if(nrm_cnt != NORM_MOD-1) begin
					nrm_data_buff = {o_tx_data,nrm_data_buff[NORM_MOD-1:1]};
					nrm_cnt++;
					$display("****___serial bit index %d ______*******************************************",nrm_cnt);
				end else begin
					nrm_data_buff = {o_tx_data,nrm_data_buff[NORM_MOD-1:1]};
					if (nrm_data_buff == i_tx_data[NORM_MOD-1:0]) begin
						$display("***********************************************************************************");
						$display("________________________________ TEST PASSED ______________________________________");
						$display("Expected output:______%b  ************* Actual output:_________ %b",i_tx_data[NORM_MOD-1:0],nrm_data_buff);
						$display("***********************************************************************************");
						repeat(3)
							@(posedge clk);
						break;
					end else begin
						$display("***********************************************************************************");
						$display("________________________________ TEST FAILED ______________________________________");
						$display("Expected output:______%b  ************* Actual output:_________ %b",i_tx_data[NORM_MOD-1:0],nrm_data_buff);
						$display("***********************************************************************************");
						repeat(3)
							@(posedge clk);
						break;
					end
				end
			end
			// @(posedge clk);
		end
	endtask : norm_mod

//********************************************************************************
// ** debug_mode checker
//********************************************************************************
	task debug_mod();
		$display("************************_______debug_mod____________************************************");
		forever begin
			@(posedge clk);
			if (o_tx_valid) begin
				if(debug_cnt != DEBUG_MOD-1) begin
					debug_data_buff  = {o_tx_data,debug_data_buff[DEBUG_MOD-1:1]};
					debug_cnt++;
				end else begin
					debug_data_buff = {o_tx_data,debug_data_buff[DEBUG_MOD-1:1]};
					if (debug_data_buff == i_tx_data[DEBUG_MOD-1:0]) begin
						$display("***********************************************************************************");
						$display("________________________________ TEST PASSED ______________________________________");
						$display("Expected output:______%b  ************* Actual output:_________ %b",i_tx_data[DEBUG_MOD-1:0],debug_data_buff);
						$display("***********************************************************************************");
						break;
					end else begin
						$display("***********************************************************************************");
						$display("________________________________ TEST FAILED ______________________________________");
						$display("Expected output:______%b  ************* Actual output:_________ %b",i_tx_data[DEBUG_MOD-1:0],debug_data_buff);
						$display("***********************************************************************************");
						repeat(3)
							@(posedge clk);
						break;
					end
				end
			end
		end
	endtask : debug_mod


//********************************************************************************
// ready back pressure
//********************************************************************************
	task automatic ready_deassrt();
		int rnd_delay	=0;
		int cc_cnt 	 	=0;
		rnd_delay = $urandom_range(10,25);
		forever begin
			if (o_tx_valid) begin
				if (cc_cnt == rnd_delay) begin
					repeat (5) begin
						i_tx_ready = 1'b0; // deassert ready signal for 5 clock cycles.
						$display("************************_______ready_deassrt____________************************************");
						@(posedge clk);
					end
					i_tx_ready = 1'b1;
					break;
				end else begin
					i_tx_ready = 1'b1;
					cc_cnt++;
				end
			end
			@(posedge clk);
		end

	endtask : ready_deassrt
//********************************************************************************
// run_test
//********************************************************************************
	initial begin
		sys_rst();
		
		// Normal mode 		
		fork
			// Thread 1
			begin
				// Normal mode
				gen_data();
				sys_checker();
			end
			// Thread 2
			begin
				ready_deassrt();
			end
		join 
		// Debug mode 		
		fork
			// Thread 1
			begin
				// Debug mode
				gen_debug_data();
				sys_checker();
			end
			// Thread 2
			begin
				ready_deassrt();
			end
		join 

		// // Normal mode
		// gen_data();
		// sys_checker();

		// // Debug mode
		// gen_debug_data();
		// sys_checker();
		$stop();
	end
endmodule : tb_puf_soc_piso

