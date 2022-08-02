module tb_puf_soc_top ();
//********************************************************************************
// ** Parameters Declaration
//********************************************************************************
	parameter REG_BIT_SIZE   = 40 ;
	parameter MUX_IN_SIZ     = 1  ;
	parameter MUX_LENGTH     = 16 ;
	parameter NO_PUF_STAGE   = 24 ;
	parameter PUF_LENGTH     = 16 ;
	parameter CNT_BIT_SIZE   = 32 ;
	parameter FRAM_SIZE      = 160;
	parameter NORM_MOD       = 34 ;
	parameter DEBUG_MOD      = 133;
	parameter CLK_PRD        = 10 ;
	parameter XACT_CNT       = 10 ; 
	parameter DEBUG_XACT_CNT = 6 ;
//********************************************************************************
// ** Internal Signals
//********************************************************************************

//********************************************************************************
// ** Inputs are reg
//********************************************************************************
	reg clk       ;
	reg rst_n     ;
	reg i_start   ;
	reg i_op_mode ;
	reg i_rx_valid;
	reg i_rx_data ;
	reg i_tx_ready;
	reg o_puf_ro_0;
	reg o_puf_ro_1;
//********************************************************************************
// ** outputs are wire
//********************************************************************************
	wire o_rx_ready;
	wire o_tx_data ;
	wire o_tx_valid;
//********************************************************************************
// ** DUT initialization
//********************************************************************************
	puf_soc_top
		`ifndef NETLIST
			#(
				.REG_BIT_SIZE(REG_BIT_SIZE),
				.MUX_IN_SIZ  (MUX_IN_SIZ  ),
				.MUX_LENGTH  (MUX_LENGTH  ),
				.NO_PUF_STAGE(NO_PUF_STAGE),
				.PUF_LENGTH  (PUF_LENGTH  ),
				.CNT_BIT_SIZE(CNT_BIT_SIZE),
				.FRAM_SIZE   (FRAM_SIZE   ),
				.NORM_MOD    (NORM_MOD    ),
				.DEBUG_MOD   (DEBUG_MOD   )
			)
		`endif
	DUT (
		.clk       (clk       ), // input  clk       , // Clock
		.rst_n     (rst_n     ), // input  rst_n     , // Asynchronous reset active low
		.i_start   (i_start   ), // input  i_start   ,
		.i_op_mode (i_op_mode ), // input  i_op_mode ,
		.o_rx_ready(o_rx_ready), // output o_rx_ready,
		.i_rx_valid(i_rx_valid), // input  i_rx_valid,
		.i_rx_data (i_rx_data ), // input  i_rx_data ,
		.i_tx_ready(i_tx_ready), // output i_tx_ready,
		.o_tx_data (o_tx_data ), // output o_tx_data ,
		.o_tx_valid(o_tx_valid),  // output o_tx_valid
		.o_puf_ro_0 (o_puf_ro_0), //output o_puf_ro_0
		.o_puf_ro_1 (o_puf_ro_1)  //output o_puf_ro_1
	);

// clock generation
	initial clk = 1'b1;
	always #((CLK_PRD/2)) clk = ~clk;

//********************************************************************************
// ** Reset Task
//********************************************************************************
	task sys_rst();
		rst_n 			= {$bits(rst_n 	  	 ){1'b0}};
		i_start 		= {$bits(i_start 		 ){1'b0}};
		i_op_mode 	= {$bits(i_op_mode	 ){1'b0}};
		i_rx_data  	= {$bits(i_rx_data   ){1'b0}};
		i_rx_valid 	= {$bits(i_rx_valid  ){1'b0}};
		i_tx_ready 	= {$bits(i_tx_ready  ){1'b1}}; //TODO
		// assert reset for 5 clock cycles
		repeat (5) begin
			@(posedge clk) ;
		end
		@(posedge clk);
		rst_n 	= 1'b1;
		@(posedge clk);
	endtask : sys_rst

//********************************************************************************
// ** normal mode  testing
//********************************************************************************
task norm_mod();
	for (int ii=0; ii < XACT_CNT ; ii++) begin
		fork
			begin // Thread_1
				host_tx();
			end
			begin // Thread_2
				host_rx();
			end
		join
		$display(" Number of CRPs recorded :: %0d  ", ii+1 );
	end
endtask : norm_mod

//********************************************************************************
// ** debug mode  testing
//********************************************************************************
task debug_mod();
	 int debug_frame;
	 int norm_frame ;
	for (int ii=0; ii < DEBUG_XACT_CNT ; ii++) begin
		fork
			begin // Thread_1
				host_tx_debug();
			end
			begin // Thread_2
				host_rx_debug();
				$display("Number of debug frames received",++debug_frame);
				host_rx();
				$display("Number of normal frames received",++norm_frame);
			end
		join
		$display(" Number of CRPs recorded :: %0d  ", ii+1 );
	end
endtask : debug_mod

//********************************************************************************
// ** Host Transmitter assert opt_mode
//********************************************************************************
	task automatic host_tx_debug();
		automatic bit  [REG_BIT_SIZE-1:0] rx_frame ;
		$display("***********_____host_tx_debug_____***********",);
		i_start 	= 1'b1;
		rx_frame  = {32'd1024,4'b1000,4'b0001};
		@(posedge clk) ;
		if(o_rx_ready); begin
			for (int ii=0; ii<REG_BIT_SIZE; ii++) begin
				@(posedge clk) ;
				i_rx_valid = 1'b1;
				// i_rx_data  = $urandom_range(0,1);
				i_rx_data  = rx_frame [ii];
			end
			
			// wait for some clock cycles and assert the op_mode signal for 1 clock cycle
			repeat(200) begin
				@(posedge clk); 
			end
			$display("i_op_mode is asserted");
			i_op_mode = 1'b1;
			@(posedge clk); 
			i_op_mode = 1'b0;
			$display("i_op_mode is deasserted");
		end
	endtask : host_tx_debug


//********************************************************************************
// ** Host Transmitter
//********************************************************************************
	task automatic host_tx();
		automatic bit  [REG_BIT_SIZE-1:0] rx_frame ;
		$display("***********_____host_tx_____***********",);
		i_start 	= 1'b1;
		rx_frame  = {32'd1024,4'b1000,4'b0001};
		@(posedge clk) ;
		if(o_rx_ready); begin
			for (int ii=0; ii<REG_BIT_SIZE; ii++) begin
				@(posedge clk) ;
				i_rx_valid = 1'b1;
				// i_rx_data  = $urandom_range(0,1);
				i_rx_data  = rx_frame [ii];
			end
		end
	endtask : host_tx

//********************************************************************************
// ** run_test
//********************************************************************************
	task automatic host_rx();
			automatic reg [    NORM_MOD-1:0] hst_rx_buff;
			automatic bit [    NORM_MOD-1:0] rx_bit_cnt ;
		$display("***********_____host_rx_____***********",);
		forever begin
			if(o_tx_valid)	begin
				$display("***********_____valid_bits: %d _____***********",++rx_bit_cnt);
				if (rx_bit_cnt==NORM_MOD) begin
					hst_rx_buff = {o_tx_data,hst_rx_buff[NORM_MOD-1:1]};
					repeat(3) begin
						@(posedge clk);
					end
					break;
				end
				hst_rx_buff = {o_tx_data,hst_rx_buff[NORM_MOD-1:1]};
				// rx_bit_cnt++;
			end
			@(posedge clk);
		end
	endtask : host_rx

//********************************************************************************
// ** run_test
//********************************************************************************
	task automatic host_rx_debug();
		automatic reg [    DEBUG_MOD-1:0] debug_hst_rx_buff;
		automatic bit [    DEBUG_MOD-1:0] debug_rx_bit_cnt ;
		$display("***********_____host_rx_debug_____***********",);
		forever begin
			if(o_tx_valid)	begin
				$display("***********_____valid_bits: %d _____***********",++debug_rx_bit_cnt);
				if (debug_rx_bit_cnt==DEBUG_MOD) begin
					debug_hst_rx_buff = {o_tx_data,debug_hst_rx_buff[DEBUG_MOD-1:1]};
					repeat(3) begin
						@(posedge clk);
					end
					break;
				end
				debug_hst_rx_buff = {o_tx_data,debug_hst_rx_buff[DEBUG_MOD-1:1]};
				// rx_bit_cnt++;
			end
			@(posedge clk);
		end
	endtask : host_rx_debug

//********************************************************************************
// ** run_test
//********************************************************************************
	initial begin
		sys_rst()  ;
		norm_mod() ;
		debug_mod();
		$display("***************************************");
		$display("*********** Simulation Done ***********");
		$display("***************************************");
		$stop;

	end
endmodule : tb_puf_soc_top