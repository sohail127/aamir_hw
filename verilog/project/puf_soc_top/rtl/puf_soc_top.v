module puf_soc_top #(
	parameter REG_BIT_SIZE = 8  ,
	parameter MUX_IN_SIZ   = 1  ,
	parameter MUX_LENGTH   = 16 ,
	parameter NO_PUF_STAGE = 24 ,
	parameter PUF_LENGTH   = 16 ,
	parameter CNT_BIT_SIZE = 32 ,
	parameter FRAM_SIZE    = 160,
	parameter NORM_MOD     = 34 ,
	parameter DEBUG_MOD    = 133
) (
	input  clk       , // Clock
	input  rst_n     , // Asynchronous reset active low
	input  i_start   ,
	input  i_op_mode ,
	output o_rx_ready,
	input  i_rx_valid,
	input  i_rx_data ,
	input  i_tx_ready,
	output o_tx_data ,
	output o_tx_valid
);
	// internal signals
	wire                              w_dcod_enable;
	wire                              w_exec_done  ;
	wire [    $clog2(MUX_LENGTH)-1:0] w_sel_mux_0  ;
	wire [    $clog2(MUX_LENGTH)-1:0] w_sel_mux_1  ;
	wire                              w_dcod_ready ;
	wire                              w_rx_ready   ;
	wire                              w_rx_valid   ;
	wire [2*($clog2(MUX_LENGTH))-1:0] w_rx_data    ;
	wire                              w_exec_enable;
	wire                              w_dump_enable;
	wire [                       2:0] w_fsm_state  ;
	wire                              w_tx_done    ;
	wire                              w_tx_enable  ;

//************************************************************************************************//
//	1. Controller module instantiation
//************************************************************************************************//
// This module contains an FSM to generate the control signals for different system operations such
// as receivng, decoding ,executaion and transmitter states. All the hardware components are placed
// in data path module.
//************************************************************************************************//
	(* keep_hierarchy = "yes" *) puf_soc_cntrlr #(.MUX_LENGTH(MUX_LENGTH)) inst_puf_soc_cntrlr (
		.clk          (clk          ), // input                                   clk          , // Clock
		.rst_n        (rst_n        ), // input                                   rst_n        , // active low reset
		.i_start      (i_start      ), // input                                   i_start      ,
		.i_op_mode    (i_op_mode    ), // input                                   i_op_mode    ,
		.i_rx_ready   (w_rx_ready   ), // input                                   i_rx_ready   ,
		.i_rx_valid   (i_rx_valid   ), // input                                   i_rx_valid   ,
		.i_rx_data    (w_rx_data    ), // input      [2*($clog2(MUX_LENGTH))-1:0] i_rx_data    ,
		.i_rx_done    (w_rx_valid   ), // input                                   i_rx_done    ,
		.i_exec_done  (w_exec_done  ), // input                                   i_exec_done  ,
		.i_tx_done    (w_tx_done    ), // input                                   i_tx_done    ,
		.o_fsm_state  (w_fsm_state  ), // output     [                       2:0] o_fsm_state  ,
		.o_dcod_ready (w_dcod_ready ), // output reg                              o_dcod_ready ,
		.o_dcod_enable(w_dcod_enable), // output reg                              o_dcod_enable,
		.o_exec_enable(w_exec_enable), // output reg                              o_exec_enable,
		.o_tx_enable  (w_tx_enable  ), // output reg                              o_tx_enable  ,
		.o_dump_enable(w_dump_enable), // output reg                              o_dump_enable,
		.o_sel_mux_0  (w_sel_mux_0  ), // output reg [    $clog2(MUX_LENGTH)-1:0] o_sel_mux_0  ,
		.o_sel_mux_1  (w_sel_mux_1  )  // output reg [    $clog2(MUX_LENGTH)-1:0] o_sel_mux_1
	);

//************************************************************************************************//
//	2. Data path module instantiation
//************************************************************************************************//
// This module contains the instantiation and integration of differnet hardware components as:
// 1. Receiver	 	: To receive serial data from host as challange
// 2. Decode  	 	: Its an decoder block that is 8-bit _to__> 16-bit
// 3. RO bank 	 	: having six ro block each with around 24 stages
// 4. MUX 			 	: blcok for selection and passing oscillation pulse to counter as clock input
// 5. counter 	 	: simple 32-bit counter
// 6. comparator 	: A block to compare the count value and produce loser count as output when one
// 								 from two counter is full.
// 7. Assembler   : To pack a data into a frame formante eitehr normal or debug mode.
// 8. Transmitter : Finally to send PUF respone to hardware
//************************************************************************************************//
	(* keep_hierarchy = "yes" *) puf_soc_dta_pth #(
		.REG_BIT_SIZE(REG_BIT_SIZE),
		.MUX_IN_SIZ  (MUX_IN_SIZ  ),
		.MUX_LENGTH  (MUX_LENGTH  ),
		.NO_PUF_STAGE(NO_PUF_STAGE),
		.PUF_LENGTH  (PUF_LENGTH  ),
		.CNT_BIT_SIZE(CNT_BIT_SIZE),
		.FRAM_SIZE   (FRAM_SIZE   ),
		.NORM_MOD    (NORM_MOD    ),
		.DEBUG_MOD   (DEBUG_MOD   )
	) inst_puf_soc_dp (
		.clk        (clk          ), // input                               clk        ,
		.rst_n      (rst_n        ), // input                               rst_n      ,
		.i_op_mode  (w_dump_enable), // input                               i_op_mode  ,
		.i_rx_ready (w_dcod_ready ), // input                               i_rx_ready ,
		.i_rx_valid (i_rx_valid   ), // input                               i_rx_valid ,
		.i_rx_data  (i_rx_data    ), // input                               i_rx_data  ,
		.i_tx_ready (i_tx_ready   ), // input                               i_tx_ready ,
		.i_dcod_en  (w_dcod_enable), // input                               i_dcod_en  ,
		.i_cnt_en   (w_exec_enable), // input                               i_cnt_en   ,
		.i_tx_en    (w_tx_enable  ), // input                               i_tx_en    ,
		.i_fsm_state(w_fsm_state  ), // input  [                       2:0] i_fsm_state,
		.i_sel_mux_0(w_sel_mux_0  ), // input  [    $clog2(MUX_LENGTH)-1:0] i_sel_mux_0,
		.i_sel_mux_1(w_sel_mux_1  ), // input  [    $clog2(MUX_LENGTH)-1:0] i_sel_mux_1,
		.o_rx_ready (w_rx_ready   ), // output                              o_rx_ready ,
		.o_rx_valid (w_rx_valid   ), // output                              o_rx_valid ,
		.o_rx_data  (w_rx_data    ), // output [2*($clog2(MUX_LENGTH))-1:0] o_rx_data  ,
		.o_exec_done(w_exec_done  ), // output                              o_exec_done,
		.o_tx_data  (o_tx_data    ), // output                              o_tx_data  ,
		.o_tx_valid (o_tx_valid   ), // output                              o_tx_valid ,
		.o_tx_done  (w_tx_done    )  // output                              o_tx_done
	);
	assign o_rx_ready = w_rx_ready;
endmodule // puf_soc_top