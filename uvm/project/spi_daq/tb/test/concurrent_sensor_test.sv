`ifndef CONCURRENT_SENSOR_TEST_SV
`define CONCURRENT_SENSOR_TEST_SV

class concurrent_sensor_test extends base_test;
  `uvm_component_utils(concurrent_sensor_test)

  function new(string name = "concurrent_sensor_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    spi_random_transfer_sequence seq[3];
    phase.raise_objection(this);
    foreach(seq[i]) begin
      seq[i] = spi_random_transfer_sequence::type_id::create($sformatf("seq[%0d]", i));
      fork
        seq[i].start(env_h.sensor_agent[i].sequencer);
      join_none
    end
    #1000ns;
    phase.drop_objection(this);
  endtask
endclass
`endif // CONCURRENT_SENSOR_TEST_SV
