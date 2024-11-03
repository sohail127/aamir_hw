`ifndef AXIS_PKG_SV
`define AXIS_PKG_SV
package axis_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  `include "axis_agent_cfg.sv"
  `include "axis_seq_item.sv"
  `include "axis_sequencer.sv"
  `include "axis_monitor.sv"
  `include "axis_driver.sv"
  `include "axis_coverage_collector.sv"
  `include "axis_seq_lib.sv"
  `include "axis_agent.sv"
endpackage : axis_pkg
`endif  // AXIS_PKG_SV




