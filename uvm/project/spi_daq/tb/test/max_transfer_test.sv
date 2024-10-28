`ifndef MAX_TRANSFER_TEST_SV
`define MAX_TRANSFER_TEST_SV

class max_transfer_test extends base_test;
  `uvm_component_utils(max_transfer_test)

  function new(string name = "max_transfer_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    spi_max_transfer_sequence seq;
    phase.raise_objection(this);
    seq = spi_max_transfer_sequence::type_id::create("seq");
    foreach(env_h.sensor_agent[i]) begin
      seq.start(env_h.sensor_agent[i].sequencer);
    end
    #100ns;
    phase.drop_objection(this);
  endtask
endclass
`endif // MAX_TRANSFER_TEST_SV
