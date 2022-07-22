package puf_soc_pkg;


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
	parameter NORM_MOD     = 34 ;
	parameter DEBUG_MOD    = 133;
	parameter CLK_PRD      = 10 ;

	// config
	`include  "host_item.sv"
	// Generator
	`include "challange_gen.sv" 
	// output agent
	`include "host_rx_mon.sv" 
	`include "host_rx_ag.sv" 
	// input agent
	`include "host_tx_mon.sv" 
	`include "host_tx_drv.sv" 
	`include "host_tx_ag.sv" 
	// // coverage
	// `include "fifo_coverage.sv"
	// // scoreboard
	// `include "fifo_scoreboard.sv"
	// env
	`include "host_env.sv" 
	// test
	`include "host_test.sv" 


endpackage : puf_soc_pkg