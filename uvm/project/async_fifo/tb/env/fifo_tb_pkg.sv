`ifndef FIFO_TB_PKG_SV
`define FIFO_TB_PKG_SV
package fifo_tb_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import axis_pkg::*;
  `include "fifo_env_cfg.sv"
  `include "fifo_scoreboard.sv"
  `include "fifo_env.sv"

endpackage : fifo_tb_pkg
`endif  // FIFO_TB_PKG_SV
