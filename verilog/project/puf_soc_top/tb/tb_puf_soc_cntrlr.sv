module tb_puf_soc_cntrlr ();

//********************************************************************************
// ** Parameters Declaration
//********************************************************************************
	parameter MUX_LENGTH = 16;
	parameter CLK_PRD    = 10;
	typedef enum bit [2:0] { RESET=0, WAIT=1 ,RECEIVE=2 ,RO_DECODER=3 ,EXECUTE=4, TRANSMIT=5 , DUMP=6 } fsm_stat_enm;

//********************************************************************************
// ** Outputs are wire
//********************************************************************************
	wire [                       2:0] o_fsm_state   ;
	wire                              o_dcod_ready  ;
	wire                              o_dcod_enable ;
	wire                              o_exec_enable ;
	wire                              o_tx_enable   ;
	wire                              o_dump_enable ;
	wire [    $clog2(MUX_LENGTH)-1:0] o_sel_mux_0   ;
	wire [    $clog2(MUX_LENGTH)-1:0] o_sel_mux_1   ;
//********************************************************************************
// ** Inputs are reg
//********************************************************************************
	reg                               clk          ;
	reg                               rst_n        ;
	reg                               i_start      ;
	reg                               i_op_mode    ;
	reg                               i_rx_ready   ;
	reg                               i_rx_valid   ;
	reg                               i_rx_done    ;
	reg  [2*($clog2(MUX_LENGTH))-1:0] i_rx_data    ;
	reg                               i_exec_done  ;
	reg                               i_tx_done    ;
//********************************************************************************
// ** Outputs are wire
//********************************************************************************

puf_soc_cntrlr #(.MUX_LENGTH(MUX_LENGTH)) DUT(
	.clk          (clk          ), // input                                   clk          , // Clock
	.rst_n        (rst_n        ), // input                                   rst_n        , // active low reset
	.i_start      (i_start      ), // input                                   i_start      ,
	.i_op_mode    (i_op_mode    ), // input                                   i_op_mode    ,
	.i_rx_ready   (i_rx_ready   ), // input                                   i_rx_ready   ,
	.i_rx_valid   (i_rx_valid   ), // input                                   i_rx_valid   ,
	.i_rx_done    (i_rx_done    ), // input                                   i_rx_done    ,
	.i_rx_data    (i_rx_data    ), // input      [2*($clog2(MUX_LENGTH))-1:0] i_rx_data    ,
	.i_exec_done  (i_exec_done  ), // input                                   i_exec_done  ,
	.i_tx_done    (i_tx_done    ), // input                                   i_tx_done    ,
	.o_fsm_state  (o_fsm_state  ), // output     [                       2:0] o_fsm_state  ,
	.o_dcod_ready (o_dcod_ready ), // output reg                              o_dcod_ready ,
	.o_dcod_enable(o_dcod_enable), // output reg                              o_dcod_enable,
	.o_exec_enable(o_exec_enable), // output reg                              o_exec_enable ,
	.o_tx_enable  (o_tx_enable  ), // output reg                              o_tx_enable  ,
	.o_dump_enable(o_dump_enable), // output reg                              o_dump_enable,
	.o_sel_mux_0  (o_sel_mux_0  ), // output reg [    $clog2(MUX_LENGTH)-1:0] o_sel_mux_0  ,
	.o_sel_mux_1  (o_sel_mux_1  )  // output reg [    $clog2(MUX_LENGTH)-1:0] o_sel_mux_1      
);

// clock generation
	initial clk = 1'b1;
	always #((CLK_PRD/2)) clk = ~clk;

//********************************************************************************
// ** Reset Task
//********************************************************************************
	task sys_rst();
		rst_n 			= {$bits(rst_n 			 ){1'b0}};
		i_start     = {$bits(i_start     ){1'b0}};    
		i_op_mode   = {$bits(i_op_mode   ){1'b0}};
		i_rx_ready  = {$bits(i_rx_ready  ){1'b0}};
		i_rx_valid  = {$bits(i_rx_valid  ){1'b0}};
		i_rx_done   = {$bits(i_rx_done   ){1'b0}};
		i_rx_data   = {$bits(i_rx_data   ){1'b0}};
		i_exec_done = {$bits(i_exec_done ){1'b0}};
		i_tx_done   = {$bits(i_tx_done   ){1'b0}};
		// assert reset for 5 clock cycles
		repeat (5) begin
			@(posedge clk) ;
		end
		@(posedge clk);
		rst_n 	= 1'b1;
		@(posedge clk);
	endtask : sys_rst
//********************************************************************************
// ** generate fsm control signals in normal mode
//********************************************************************************
	task gen_data();
		@(posedge clk);
		i_start  = 1'b1;
		@(posedge clk);
		// Data path will assert ready signal high after reset 
		i_rx_ready = 1'b1;
		@(posedge clk);
		i_rx_valid = 'b1;
		// spend 7 clock cycles to recieve done signal from Data path receiver
		repeat(7) begin
			@(posedge clk);
		end
		i_rx_done  = 'b1;
		i_rx_data  = $random();

		// Decode state 
		@(posedge clk);
		// spend 32 clock cycle for counter
		repeat(8) begin
			@(posedge clk);
		end
		// for execution state
		i_exec_done 	= 1'b1;
		// transmit state
		@(posedge clk);

		repeat(4) begin
			@(posedge clk);
		end
		i_tx_done = 1'b1;
		repeat(3) begin
			@(posedge clk);
		end
		// FSM will go to RESET state
	endtask : gen_data
//********************************************************************************
// **debug mode
//********************************************************************************
task debug_mode();
	int cc;
	@(posedge clk);
		i_start  = 1'b1;
		@(posedge clk);
		// Data path will assert ready signal high after reset 
		i_rx_ready = 1'b1;
		@(posedge clk);
		i_rx_valid = 'b1;
		// spend 7 clock cycles to recieve done signal from Data path receiver
		repeat(7) begin
			@(posedge clk);
		end
		i_rx_done  = 'b1;
		i_rx_data  = $random();
		// Decode state 
		@(posedge clk);
		// spend 32 clock cycle for counter
		repeat(7) begin
			if (cc==2) begin
				// Assert debug for 1 clock cycle
				i_op_mode = 1'b1;
			end else begin
				i_op_mode = 1'b0;
			end
			cc++;
			@(posedge clk);
		end
		i_tx_done = 1'b1;
		
		// spend 5 clock cycle in execution state 
		repeat (5) begin
			@(posedge clk);
		end

		// for execution state
		i_exec_done 	= 1'b1;
		i_tx_done 		= 1'b0;
		// transmit state
		repeat(4) begin
			@(posedge clk);
		end
		// i_tx_done = 1'b1;
		repeat(3) begin
			@(posedge clk);
		end
		// FSM will go to RESET state
endtask : debug_mode

//********************************************************************************
// **state monitor
//********************************************************************************
	task state_mon();
		fsm_stat_enm fsm_stat;
		forever begin
			$cast(fsm_stat,o_fsm_state);
			$display("**************************************************************************");
			$display("***************_____o_fsm_state  _____*****************:: %s",fsm_stat  	 ); 
			$display("***************_____o_dcod_ready _____*****************:: %h",o_dcod_ready ); 
			$display("***************_____o_dcod_enable_____*****************:: %h",o_dcod_enable); 
			$display("***************_____o_exec_enable_____*****************:: %h",o_exec_enable); 
			$display("***************_____o_tx_enable  _____*****************:: %h",o_tx_enable  ); 
			$display("***************_____o_dump_enable_____*****************:: %h",o_dump_enable); 
			$display("***************_____o_sel_mux_0  _____*****************:: %h",o_sel_mux_0  ); 
			$display("***************_____o_sel_mux_1  _____*****************:: %h",o_sel_mux_1  ); 
			$display("**************************************************************************");
			@(posedge  clk);
		end
	endtask : state_mon
//********************************************************************************
// run_test
//********************************************************************************
	initial begin
		sys_rst();
		fork
			// Thread 1 : FSM Control Signals
			begin
				$display("***********______Normal mode _____________*******************");
				gen_data();
				sys_rst();
				$display("***********______Debugig mode _____________*******************");
				debug_mode();
			end
			// FSM state Monitor
			begin
				state_mon();
			end
		join_any
		$stop();
	end
endmodule : tb_puf_soc_cntrlr