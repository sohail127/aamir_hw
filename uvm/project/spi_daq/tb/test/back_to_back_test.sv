`ifndef BACK_TO_BACK_TEST_SV
`define BACK_TO_BACK_TEST_SV

class back_to_back_test extends base_test;
  `uvm_component_utils(back_to_back_test)

  function new(string name = "back_to_back_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    spi_back_to_back_sequence seq;
    phase.raise_objection(this);
    seq = spi_back_to_back_sequence::type_id::create("seq");
    foreach(env_h.sensor_agent[i]) begin
      seq.start(env_h.sensor_agent[i].sequencer);
    end
    #100ns;
    phase.drop_objection(this);
  endtask
endclass
`endif // BACK_TO_BACK_TEST_SV
