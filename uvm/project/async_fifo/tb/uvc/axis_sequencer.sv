`ifndef AXIS_SEQUENCER_SV
`define AXIS_SEQUENCER_SV
class axis_sequencer extends uvm_sequencer #(axis_seq_item);
  `uvm_component_utils(axis_sequencer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
`endif  // AXIS_SEQUENCER_SV
