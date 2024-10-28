`ifndef SINGLE_TRANSFER_TEST_SV
`define SINGLE_TRANSFER_TEST_SV

class single_transfer_test extends base_test;
  `uvm_component_utils(single_transfer_test)

  function new(string name = "single_transfer_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    spi_single_transfer_sequence seq;
    phase.raise_objection(this);
    `uvm_info(get_type_name(), "Starting single_transfer_test", UVM_LOW)

    seq = spi_single_transfer_sequence::type_id::create("seq");

    foreach (env_h.sensor_agent[i]) begin
      fork
        automatic int agent_num = i;
        begin
          `uvm_info(get_type_name(), $sformatf("Starting sequence on sensor_agent[%0d]", agent_num),
                    UVM_LOW)
          seq.start(env_h.sensor_agent[agent_num].sequencer);
        end
      join_none
    end

    wait fork;

    #100ns;
    `uvm_info(get_type_name(), "Ending single_transfer_test", UVM_LOW)
    phase.drop_objection(this);
  endtask

endclass
`endif  // SINGLE_TRANSFER_TEST_SV
