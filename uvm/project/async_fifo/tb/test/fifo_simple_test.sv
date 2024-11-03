`ifndef FIFO_SIMPLE_TEST_SV
`define FIFO_SIMPLE_TEST_SV

class fifo_simple_test extends fifo_base_test;

  `uvm_component_utils(fifo_simple_test)

  function new(string name = "fifo_simple_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    axis_write_sequence write_seq;
    axis_read_sequence read_seq;

    phase.raise_objection(this);

    // Create the write sequence
    write_seq = axis_write_sequence::type_id::create("write_seq");
    write_seq.num_transactions = 10;

    // Create the read sequence
    read_seq = axis_read_sequence::type_id::create("read_seq");
    read_seq.num_transactions = 10;

    // Start the write sequence on the write agent's sequencer
    write_seq.start(env.write_agent.sequencer);

    // Start the read sequence on the read agent's sequencer
    read_seq.start(env.read_agent.sequencer);

    // Allow time for transactions to complete
    #100;

    phase.drop_objection(this);
  endtask

endclass

`endif // FIFO_SIMPLE_TEST_SV