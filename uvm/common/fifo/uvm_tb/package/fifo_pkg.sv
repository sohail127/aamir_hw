package fifo_pkg;
	// config
	`include "fifo_config.sv"
	//sequence item
	`include "in_seq_item.sv"
	// sequences
	`include "in_sequnece.sv"
	// output agent
	`include "out_monitor.sv"
	`include "out_agent.sv"
	// input agent
	`include "in_sqr.sv"
	`include "in_monitor.sv"
	`include "in_driver.sv"
	`include "in_agent.sv"
	// coverage
	`include "fifo_coverage.sv"
	// scoreboard
	`include "fifo_scoreboard.sv"
	// env
	`include "fifo_env.sv"
	// test
	`include "fifo_base_test.sv"
endpackage : fifo_pkg