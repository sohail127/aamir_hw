`ifndef RANDOM_TRANSFER_TEST_SV
`define RANDOM_TRANSFER_TEST_SV

class random_transfer_test extends base_test;
  `uvm_component_utils(random_transfer_test)

  function new(string name = "random_transfer_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    spi_random_transfer_sequence seq;
    phase.raise_objection(this);
    seq = spi_random_transfer_sequence::type_id::create("seq");
    foreach(env_h.sensor_agent[i]) begin
      seq.start(env_h.sensor_agent[i].sequencer);
    end
    #100ns;
    phase.drop_objection(this);
  endtask
endclass
`endif // RANDOM_TRANSFER_TEST_SV
