`ifndef SPI_SEQ_LIB_SV
`define SPI_SEQ_LIB_SV

class spi_base_sequence extends uvm_sequence#(spi_seq_item);
  `uvm_object_utils(spi_base_sequence)

  function new(string name = "spi_base_sequence");
    super.new(name);
  endfunction

  task pre_body();
    if (starting_phase != null)
      starting_phase.raise_objection(this);
  endtask

  task post_body();
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask
endclass

class spi_single_transfer_sequence extends spi_base_sequence;
  `uvm_object_utils(spi_single_transfer_sequence)

  function new(string name = "spi_single_transfer_sequence");
    super.new(name);
  endfunction

  task body();
    `uvm_do_with(req, {data.size() == 1; data[0] inside {[0:255]};})
  endtask
endclass

class spi_multi_transfer_sequence extends spi_base_sequence;
  `uvm_object_utils(spi_multi_transfer_sequence)

  rand int num_transfers;

  function new(string name = "spi_multi_transfer_sequence");
    super.new(name);
  endfunction

  constraint c_num_transfers { num_transfers inside {[2:5]}; }

  task body();
    repeat(num_transfers) begin
      `uvm_do_with(req, {data.size() inside {[1:4]};})
    end
  endtask
endclass

class spi_max_transfer_sequence extends spi_base_sequence;
  `uvm_object_utils(spi_max_transfer_sequence)

  function new(string name = "spi_max_transfer_sequence");
    super.new(name);
  endfunction

  task body();
    `uvm_do_with(req, {data.size() == 10; foreach(data[i]) data[i] == 8'hFF;})
  endtask
endclass

class spi_random_transfer_sequence extends spi_base_sequence;
  `uvm_object_utils(spi_random_transfer_sequence)

  rand int num_transfers;

  function new(string name = "spi_random_transfer_sequence");
    super.new(name);
  endfunction

  constraint c_num_transfers { num_transfers inside {[5:20]}; }

  task body();
    repeat(num_transfers) begin
      `uvm_do(req)
    end
  endtask
endclass

class spi_back_to_back_sequence extends spi_base_sequence;
  `uvm_object_utils(spi_back_to_back_sequence)

  function new(string name = "spi_back_to_back_sequence");
    super.new(name);
  endfunction

  task body();
    repeat(5) begin
      `uvm_do_with(req, {delay == 1; data.size() inside {[1:3]};})
    end
  endtask
endclass
`endif // SPI_SEQ_LIB_SV
