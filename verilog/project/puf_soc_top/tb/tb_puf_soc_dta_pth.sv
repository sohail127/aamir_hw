
module tb_puf_soc_dta_pth ();


//********************************************************************************
// ** Parameters Declaration
//********************************************************************************
	parameter REG_BIT_SIZE = 8  ;
	parameter MUX_IN_SIZ   = 1  ;
	parameter MUX_LENGTH   = 16 ;
	parameter NO_PUF_STAGE = 24 ;
	parameter PUF_LENGTH   = 16 ;
	parameter CNT_BIT_SIZE = 5  ;
	parameter FRAM_SIZE    = 160;
	parameter NORM_MOD  	 = 34 ;
	parameter DEBUG_MOD 	 = 133;
	parameter CLK_PRD      = 10 ;
//********************************************************************************
// ** Ouputs are wire
//********************************************************************************
	wire                              o_rx_ready ;
	wire                              o_rx_valid ;
	wire [2*($clog2(MUX_LENGTH))-1:0] o_rx_data  ;
	wire                              o_tx_data  ;
	wire                              o_tx_valid ;
	wire                              o_tx_done  ;
	wire                              o_exec_done;
//********************************************************************************
// ** Inputs are reg
//********************************************************************************
	reg                          clk        ;
	reg                          rst_n      ;
	reg                          i_op_mode  ;
	reg                          i_rx_data  ;
	reg                          i_rx_valid ;
	reg                          i_rx_ready ;
	reg 												 i_tx_ready ;
	reg                          i_dcod_en  ;
	reg                          i_cnt_en   ;
	reg                          i_tx_en    ;
	reg [                   2:0] i_fsm_state;
	reg [$clog2(MUX_LENGTH)-1:0] i_sel_mux_0;
	reg [$clog2(MUX_LENGTH)-1:0] i_sel_mux_1;
//********************************************************************************
// ** DUT Instantiation
//********************************************************************************


	puf_soc_dta_pth #(
		.REG_BIT_SIZE(REG_BIT_SIZE),
		.MUX_IN_SIZ  (MUX_IN_SIZ  ),
		.MUX_LENGTH  (MUX_LENGTH  ),
		.NO_PUF_STAGE(NO_PUF_STAGE),
		.PUF_LENGTH  (PUF_LENGTH  ),
		.CNT_BIT_SIZE(CNT_BIT_SIZE),
		.FRAM_SIZE   (FRAM_SIZE   ),
		.NORM_MOD 	 (NORM_MOD 		),
		.DEBUG_MOD	 (DEBUG_MOD		)
	) DUT (
		.clk        (clk        ), // input                               clk        ,
		.rst_n      (rst_n      ), // input                               rst_n      ,
		.i_op_mode  (i_op_mode  ), // input                               i_op_mode  ,
		.i_rx_ready (i_rx_ready ), // input                               i_rx_ready ,
		.i_rx_valid (i_rx_valid ), // input                               i_rx_valid ,
		.i_rx_data  (i_rx_data  ), // input                               i_rx_data  ,
		.i_tx_ready (i_tx_ready ), // input                               i_tx_ready ,
		.i_dcod_en  (i_dcod_en  ), // input                               i_dcod_en  ,
		.i_cnt_en   (i_cnt_en   ), // input                               i_cnt_en   ,
		.i_tx_en    (i_tx_en    ), // input                               i_tx_en    ,
		.i_fsm_state(i_fsm_state), // input  [                       2:0] i_fsm_state,
		.i_sel_mux_0(i_sel_mux_0), // input  [    $clog2(MUX_LENGTH)-1:0] i_sel_mux_0,
		.i_sel_mux_1(i_sel_mux_1), // input  [    $clog2(MUX_LENGTH)-1:0] i_sel_mux_1,
		.o_rx_ready (o_rx_ready ), // output                              o_rx_ready ,
		.o_rx_valid (o_rx_valid ), // output                              o_rx_valid ,
		.o_rx_data  (o_rx_data  ), // output [2*($clog2(MUX_LENGTH))-1:0] o_rx_data  ,
		.o_exec_done(o_exec_done), // output                              o_exec_done,
		.o_tx_data  (o_tx_data  ), // output                              o_tx_data  ,
		.o_tx_valid (o_tx_valid ), // output                              o_tx_valid ,
		.o_tx_done  (o_tx_done  )  // output                              o_tx_done
	);

// clock generation
	initial clk = 1'b1;
	always #((CLK_PRD/2)) clk = ~clk;

//********************************************************************************
// ** Reset Task
//********************************************************************************
	task sys_rst();
		rst_n 			 = {$bits(rst_n 	 		 ){1'b0}};
		i_op_mode    = {$bits(i_op_mode 	 ){1'b0}};
		i_rx_data  	 = {$bits(i_rx_data  	 ){1'b0}};
		i_rx_valid 	 = {$bits(i_rx_valid 	 ){1'b0}};
		i_rx_ready 	 = {$bits(i_rx_ready 	 ){1'b0}};
		i_dcod_en    = {$bits(i_dcod_en    ){1'b0}};
		i_cnt_en     = {$bits(i_cnt_en     ){1'b0}};
		i_tx_en      = {$bits(i_tx_en      ){1'b0}};
		i_fsm_state  = {$bits(i_fsm_state  ){1'b0}};
		i_sel_mux_0  = {$bits(i_sel_mux_0  ){1'b0}};
		i_sel_mux_1  = {$bits(i_sel_mux_1  ){1'b0}};
		// assert reset for 5 clock cycles
		repeat (5) begin
			@(posedge clk) ;
		end
		@(posedge clk);
		rst_n 	= 1'b1;
		@(posedge clk);
	endtask : sys_rst

//********************************************************************************
// ** Generate Serial Data
//********************************************************************************
	task receive();
		$display("***********_____receive_____***********",);
		wait(o_rx_ready); begin
			for (int ii=0; ii<REG_BIT_SIZE; ii++) begin
				@(posedge clk) ;
				i_rx_valid = 1'b1;
				i_rx_ready = 1'b1;
				i_rx_data  = $urandom_range(0,1);
			end
		end
	endtask : receive

//********************************************************************************
// ** Decode Data
//********************************************************************************
	task decode();
		$display("***********_____decode_____***********",);
		wait(o_rx_valid); begin
			@(posedge clk);
			i_rx_ready = 1'b0;
			i_dcod_en 	 = 1'b1;
			i_sel_mux_0  = o_rx_data[3:0];
			i_sel_mux_1  = o_rx_data[7:4];
		end
	endtask : decode

//********************************************************************************
// ** Decode Data
//********************************************************************************
	task execute();
		$display("***********_____execute_____***********",);
		@(posedge clk);
		i_cnt_en = 1'b1;
		@(o_exec_done);
		@(posedge clk);
		i_tx_en = 1'b1;
		@(posedge o_tx_done) ;
		repeat (5) begin
			@(posedge clk);
		end
		$finish;
	endtask : execute

//********************************************************************************
// ** run_test
//********************************************************************************
	initial begin
		sys_rst();
		receive();
		decode();
		execute();
	end
endmodule : tb_puf_soc_dta_pth