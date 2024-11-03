`ifndef FIFO_TEST_PKG_SV
`define FIFO_TEST_PKG_SV
package fifo_test_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	import axis_pkg::*;
	import fifo_tb_pkg::*;
	// tests here
	`include "fifo_base_test.sv"
	`include "fifo_simple_test.sv"
endpackage :fifo_test_pkg
`endif // FIFO_TEST_PKG_SV
