module puf_soc_dta_pth #(
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
	input                               clk        ,
	input                               rst_n      ,
	input                               i_op_mode  ,
	input                               i_rx_ready ,
	input                               i_rx_valid ,
	input                               i_rx_data  ,
	input                               i_tx_ready ,
	input                               i_dcod_en  ,
	input                               i_cnt_en   ,
	input                               i_tx_en    ,
	input  [                       2:0] i_fsm_state,
	input  [    $clog2(MUX_LENGTH)-1:0] i_sel_mux_0,
	input  [    $clog2(MUX_LENGTH)-1:0] i_sel_mux_1,
	output                              o_rx_ready ,
	output                              o_rx_valid ,
	output [2*($clog2(MUX_LENGTH))-1:0] o_rx_data  ,
	output                              o_exec_done,
	output                              o_tx_data  ,
	output                              o_tx_valid ,
	output                              o_tx_done
);

//
	(* dont_touch = "true" *) wire [  MUX_LENGTH-1:0] w_puf_en       ;
	(* dont_touch = "true" *) wire [  MUX_LENGTH-1:0] w_puf_ro       ;
	(* dont_touch = "true" *) wire [             1:0] w_ro           ;
	wire                    w_full_0       ;
	wire                    w_full_1       ;
	wire [CNT_BIT_SIZE-1:0] w_cnt_0        ;
	wire [CNT_BIT_SIZE-1:0] w_cnt_1        ;
	wire [CNT_BIT_SIZE-1:0] w_lsr_out      ;
	wire [   FRAM_SIZE-1:0] w_assmblr_data ;
	wire                    w_assmblr_valid;
	wire                    w_ld_data      ;
	wire                    w_comp_valid   ;
	wire                    w_tx_ready     ;
	wire 										w_assmblr_en   ;  
	wire 										w_cnt_1_valid  ;  
	wire 										w_cnt_0_valid  ; 


//************************************************************************************************//
//	1. Serial Transimitter instnatiation
//************************************************************************************************//
// This blcok will accept data serially from host as a chalange. this block is provided with ready-
// valid interface. Ready need to be asserted before sending valid data. Ready will be down after
// taking complete challange from host.
//************************************************************************************************//

	(* keep_hierarchy = "yes" *)  puf_soc_sipo #(.N_BIT(2*$clog2(MUX_LENGTH))) inst_puf_soc_sipo (
		.clk       (clk       ), // input              clk       , // Clock
		.rst_n     (rst_n     ), // input              rst_n     , // Asynchronous reset active low
		.i_rx_ready(i_rx_ready), // input              i_rx_ready, // Serial Dat input
		.i_rx_valid(i_rx_valid), // input              i_rx_valid, // Actve High fo valid
		.i_rx_data (i_rx_data ), // input              i_rx_data , // Serial Dat input
		.o_rx_ready(o_rx_ready), // output             o_rx_ready, // active high
		.o_rx_valid(o_rx_valid), // output             o_rx_valid, // active high
		.o_rx_data (o_rx_data )  // output [N_BIT-1:0] o_rx_data   // Serial Dat input
	);

//************************************************************************************************//
//	2. Decoder block
//************************************************************************************************//
//  This block takes 8-bit input from transmitter once complete challage is received from host.This
//  block is provided with enable signals. only input fed with enable signal high will be accepted
// as valid input.
//************************************************************************************************//

	(* keep_hierarchy = "yes" *)  puf_soc_ro_decoder #(.MUX_LENGTH(MUX_LENGTH)) inst_puf_soc_ro_decoder (
		.clk 				(clk 				), // input clk;
		.rst_n      (rst_n      ), // input rst_n
		.i_dcod_en  (i_dcod_en  ), // 	input 																  i_dcod_en,
		.i_sel_mux_0(i_sel_mux_0), // input      [    $clog2(MUX_LENGTH)-1:0] i_sel_mux_1,
		.i_sel_mux_1(i_sel_mux_1), // input      [    $clog2(MUX_LENGTH)-1:0] i_sel_mux2,
		.o_puf_en   (w_puf_en   )  // output reg [2*($clog2(MUX_LENGTH))-1:0] o_puf_en
	);
//************************************************************************************************//
//	3. Serial Transimitter instnatiation
//************************************************************************************************//
//  This block consist of rign oscillator. Its parameterizable and can be set of any length and
// woidth (i.e. number of ro stages or not gates). By default this block is provided with 16 ro's
// each with 24 ro stages.
//************************************************************************************************//

	(* keep_hierarchy = "yes" *) puf_soc_ro_bank #(
		.PUF_LENGTH  (PUF_LENGTH  ),
		.NO_PUF_STAGE(NO_PUF_STAGE)
	) inst_puf_soc_ro (
		.i_puf_en(w_puf_en), // input  [PUF_LENGTH-1:0] i_puf_en, // Clock
		.o_puf_ro(w_puf_ro)  // output [PUF_LENGTH-1:0] o_puf_ro
	);
//************************************************************************************************//
//	4. lower MUX blcok
//************************************************************************************************//
// 		This is an 16 by 1 mux with each input of 1-bit. The output of the deocoder is connected with
// twwo mux blocks and only difference is select inuput. lower 4-bit of received challange will be
// passed to lower mux and 4 upper-bit (i.e.MSB) will be connected to select pin.
//************************************************************************************************//
	(* keep_hierarchy = "yes" *)  puf_soc_mux #(
		.N_BIT (MUX_IN_SIZ),
		.MUX_SZ(MUX_LENGTH)
	) inst_puf_soc_mux_0 (
		.i_data_0 (w_puf_ro[0] ), // input      [         N_BIT-1:0] i_data_0 ,
		.i_data_1 (w_puf_ro[1] ), // input      [         N_BIT-1:0] i_data_1 ,
		.i_data_2 (w_puf_ro[2] ), // input      [         N_BIT-1:0] i_data_2 ,
		.i_data_3 (w_puf_ro[3] ), // input      [         N_BIT-1:0] i_data_3 ,
		.i_data_4 (w_puf_ro[4] ), // input      [         N_BIT-1:0] i_data_4 ,
		.i_data_5 (w_puf_ro[5] ), // input      [         N_BIT-1:0] i_data_5 ,
		.i_data_6 (w_puf_ro[6] ), // input      [         N_BIT-1:0] i_data_6 ,
		.i_data_7 (w_puf_ro[7] ), // input      [         N_BIT-1:0] i_data_7 ,
		.i_data_8 (w_puf_ro[8] ), // input      [         N_BIT-1:0] i_data_8 ,
		.i_data_9 (w_puf_ro[9] ), // input      [         N_BIT-1:0] i_data_9 ,
		.i_data_10(w_puf_ro[10]), // input      [         N_BIT-1:0] i_data_10,
		.i_data_11(w_puf_ro[11]), // input      [         N_BIT-1:0] i_data_11,
		.i_data_12(w_puf_ro[12]), // input      [         N_BIT-1:0] i_data_12,
		.i_data_13(w_puf_ro[13]), // input      [         N_BIT-1:0] i_data_13,
		.i_data_14(w_puf_ro[14]), // input      [         N_BIT-1:0] i_data_14,
		.i_data_15(w_puf_ro[15]), // input      [         N_BIT-1:0] i_data_15,
		.i_sel_mux(i_sel_mux_0 ), // input      [$clog2(MUX_SZ)-1:0] i_sel_mux,
		.o_mux    (w_ro[0]     )  // output reg [         N_BIT-1:0] o_mux
	);
//************************************************************************************************//
//	4. upper MUX blcok
//************************************************************************************************//
//
//************************************************************************************************//

	(* keep_hierarchy = "yes" *)  puf_soc_mux #(
		.N_BIT (MUX_IN_SIZ),
		.MUX_SZ(MUX_LENGTH)
	) inst_puf_soc_mux_1 (
		.i_data_0 (w_puf_ro[0] ), // input      [         N_BIT-1:0] i_data_0 ,
		.i_data_1 (w_puf_ro[1] ), // input      [         N_BIT-1:0] i_data_1 ,
		.i_data_2 (w_puf_ro[2] ), // input      [         N_BIT-1:0] i_data_2 ,
		.i_data_3 (w_puf_ro[3] ), // input      [         N_BIT-1:0] i_data_3 ,
		.i_data_4 (w_puf_ro[4] ), // input      [         N_BIT-1:0] i_data_4 ,
		.i_data_5 (w_puf_ro[5] ), // input      [         N_BIT-1:0] i_data_5 ,
		.i_data_6 (w_puf_ro[6] ), // input      [         N_BIT-1:0] i_data_6 ,
		.i_data_7 (w_puf_ro[7] ), // input      [         N_BIT-1:0] i_data_7 ,
		.i_data_8 (w_puf_ro[8] ), // input      [         N_BIT-1:0] i_data_8 ,
		.i_data_9 (w_puf_ro[9] ), // input      [         N_BIT-1:0] i_data_9 ,
		.i_data_10(w_puf_ro[10]), // input      [         N_BIT-1:0] i_data_10,
		.i_data_11(w_puf_ro[11]), // input      [         N_BIT-1:0] i_data_11,
		.i_data_12(w_puf_ro[12]), // input      [         N_BIT-1:0] i_data_12,
		.i_data_13(w_puf_ro[13]), // input      [         N_BIT-1:0] i_data_13,
		.i_data_14(w_puf_ro[14]), // input      [         N_BIT-1:0] i_data_14,
		.i_data_15(w_puf_ro[15]), // input      [         N_BIT-1:0] i_data_15,
		.i_sel_mux(i_sel_mux_1 ), // input      [$clog2(MUX_SZ)-1:0] i_sel_mux,
		.o_mux    (w_ro[1]     )  // output reg [         N_BIT-1:0] o_mux
	);
//************************************************************************************************//
//	5.  a) counter block instantiation
//************************************************************************************************//
// 	This module is is used to count value starting from 0 to 2**32 -1. The ro pule is connected to
// clock pin of the counter. The counting operation is also controlled from controller block. Its
// instantiated twice same as mux.
//************************************************************************************************//

	(* keep_hierarchy = "yes" *)  puf_soc_counter #(.CNT_BIT_SIZE(CNT_BIT_SIZE)) inst_puf_soc_counter_0 (
		.clk       (w_ro[0]      ), // input                         clk     	,
		.rst_n     (rst_n        ), // input                         rst_n   	,
		.i_cnt_en  (i_cnt_en     ), // input                         i_cnt_en	,
		.o_valid   (w_cnt_0_valid), // output reg                    o_valid 	,
		.o_cnt     (w_cnt_0      ), // output reg [CNT_BIT_SIZE-1:0] o_cnt   	,
		.o_cnt_full(w_full_0     )  // output 	                      o_cnt_full
	);

//************************************************************************************************//
//	5.  b) counter block instantiation
//************************************************************************************************//

	(* keep_hierarchy = "yes" *)  puf_soc_counter #(.CNT_BIT_SIZE(CNT_BIT_SIZE)) inst_puf_soc_counter_1 (
		.clk       (w_ro[1]      ), // input                         clk     	,
		.rst_n     (rst_n        ), // input                         rst_n   	,
		.i_cnt_en  (i_cnt_en     ), // input                         i_cnt_en	,
		.o_valid   (w_cnt_1_valid), // output reg                    o_valid 	,
		.o_cnt     (w_cnt_1      ), // output reg [CNT_BIT_SIZE-1:0] o_cnt   	,
		.o_cnt_full(w_full_1     )  // output 	                      o_cnt_full
	);

//************************************************************************************************//
//	6.  Comparator Instantiation
//************************************************************************************************//
// This is an comparator block. It performs the comparision when anyone of counter reaches to its
// maximum value. Loser counter value be taken as output of comparator.
//************************************************************************************************//

	(* keep_hierarchy = "yes" *)  puf_soc_comparator #(.CNT_BIT_SIZE(CNT_BIT_SIZE)) inst_puf_soc_comparator (
		.i_full_0    (w_full_0    ), // input                     i_full_0 ,
		.i_full_1    (w_full_1    ), // input                     i_full_1 ,
		.i_cnt_0     (w_cnt_0     ), // input  [CNT_BIT_SIZE-1:0] i_cnt_0  ,
		.i_cnt_1     (w_cnt_1     ), // input  [CNT_BIT_SIZE-1:0] i_cnt_1  ,
		.o_loser     (w_lsr_out   ), // output [CNT_BIT_SIZE-1:0] o_loser  ,
		.o_comp_valid(w_comp_valid)  // output [CNT_BIT_SIZE-1:0] o_comp_valid
	);
//************************************************************************************************//
//	7.  Assember module instantiation
//************************************************************************************************//
// This module operates in two mode.
// 1: Normal mode when op_mode value remains 0. It sends frame of around 34-bit
// 2: Debug mode when op_mode signal is asserted high for one clock cycle.
//************************************************************************************************//
	(* keep_hierarchy = "yes" *)  puf_soc_assembler #(
		.CNT_BIT_SIZE(CNT_BIT_SIZE),
		.MUX_LENGTH  (MUX_LENGTH  ),
		.FRAM_SIZE   (FRAM_SIZE   )
	) inst_puf_soc_assembler (
		.clk            (clk            ), // input                                 clk            , // Clock
		.rst_n          (rst_n          ), // input                                 rst_n          , // Asynchronous reset active low
		.i_op_mode      (i_op_mode      ), // input                                 i_op_mode      ,
		// .i_assmblr_en   (w_comp_valid), // input                                 i_assmblr_en   ,
		.i_assmblr_en   (w_assmblr_en   ), // input                                 i_assmblr_en   ,
		.i_cnt_lser     (w_lsr_out      ), // input      [        CNT_BIT_SIZE-1:0] i_cnt_lser     ,
		.i_cnt_0        (w_cnt_0        ), // input      [        CNT_BIT_SIZE-1:0] i_cnt_0        ,
		.i_cnt_1        (w_cnt_1        ), // input      [        CNT_BIT_SIZE-1:0] i_cnt_1        ,
		.i_full_0       (w_full_0       ), // input                                 i_full_0       ,
		.i_full_1       (w_full_1       ), // input                                 i_full_1       ,
		.i_ro_bnk_en    (w_puf_ro       ), // input      [          MUX_LENGTH-1:0] i_ro_bnk_en    ,
		.i_fsm_state    (i_fsm_state    ), // input      [                     2:0] i_fsm_state    ,
		.i_sel_mux_0    (i_sel_mux_0    ), // input      [  $clog2(MUX_LENGTH)-1:0] i_sel_mux_0    ,
		.i_sel_mux_1    (i_sel_mux_1    ), // input      [  $clog2(MUX_LENGTH)-1:0] i_sel_mux_1    ,
		.i_rx_data      (o_rx_data      ), // input    	 [2*$clog2(MUX_LENGTH)-1:0] i_rx_data   	 ,
		.o_assmblr_data (w_assmblr_data ), // output reg [           FRAM_SIZE-1:0] o_assmblr_data ,
		.o_assmblr_valid(w_assmblr_valid)  // output reg                            o_assmblr_valid
	);
//************************************************************************************************//
//	7.  Transmitter block
//************************************************************************************************//
// This module is used to transmit the normal or debug frame serially. Its implemented with ready
// valid handshake interface. Ready will be asserted high befor sending valid data. In this case
// ready signal will come from host receiver.
//************************************************************************************************//

	(* keep_hierarchy = "yes" *)  puf_soc_piso #(
		.FRAM_SIZE(FRAM_SIZE),
		.NORM_MOD (NORM_MOD ),
		.DEBUG_MOD(DEBUG_MOD)
	) inst_puf_soc_piso (
		.clk       (clk           ), // input                  clk        , // clock
		.rst_n     (rst_n         ), // input                  rst_n      , // active low reset
		.i_tx_en   (i_tx_en       ),
		.i_tx_mode (i_op_mode     ),
		.i_tx_ready(i_tx_ready    ), // input                  i_tx_ready , // shift_lr : 1 for right shift, 0: for left shift
		.i_tx_valid(w_ld_data     ), // input                  i_tx_valid , // shift_lr : 1 for right shift, 0: for left shift
		.i_tx_data (w_assmblr_data), // input  [FRAM_SIZE-1:0] i_tx_data  , // register data
		.o_tx_ready(w_tx_ready    ), // output                 o_tx_ready , // Assert high to accept new data //TODO: check handshaking
		.o_tx_data (o_tx_data     ), // output                 o_tx_data  , // serial output
		.o_tx_valid(o_tx_valid    ), // output                 o_tx_valid , // 1: when output is valid
		.o_tx_done (o_tx_done     )  // output                 o_tx_done    // 1: when output is valid
	);
// valuid input to assemble data
	assign w_assmblr_en = w_comp_valid & w_cnt_0_valid & w_cnt_1_valid ;
// load new data to register
	assign w_ld_data = w_assmblr_valid	& w_tx_ready ;
// o_exec_done will be asserted high when data is compared in normal mode and loaded to piso.
	assign o_exec_done = w_assmblr_valid /*& ! o_piso_ready*/ ;

endmodule // puf_soc_dta_pth