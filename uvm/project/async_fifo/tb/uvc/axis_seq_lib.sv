`ifndef AXIS_SEQ_LIB_SV
`define AXIS_SEQ_LIB_SV

class axis_base_sequence extends uvm_sequence #(axis_seq_item);
  `uvm_object_utils(axis_base_sequence)

  rand int num_transactions = 2;

  function new(string name = "axis_base_sequence");
    super.new(name);
  endfunction
endclass

class axis_write_sequence extends axis_base_sequence;
  `uvm_object_utils(axis_write_sequence)

  function new(string name = "axis_write_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Starting write sequence", UVM_LOW)
    repeat(num_transactions) begin
      `uvm_create(req)
      start_item(req);
      if (!req.randomize() with {
        tdata inside {[0:255]};
        tlast dist {0:/80, 1:/20};
      }) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end
      req.is_write = 1;  // Set is_write after randomization
      finish_item(req);
    end
    `uvm_info(get_type_name(), "Finished write sequence", UVM_LOW)
  endtask
endclass

class axis_read_sequence extends axis_base_sequence;
  `uvm_object_utils(axis_read_sequence)

  function new(string name = "axis_read_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Starting read sequence", UVM_LOW)
    repeat(num_transactions) begin
      `uvm_create(req)
      start_item(req);
      if (!req.randomize()) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end
      req.is_write = 0;  // Set is_write after randomization
      finish_item(req);
    end
    `uvm_info(get_type_name(), "Finished read sequence", UVM_LOW)
  endtask
endclass

`endif // AXIS_SEQ_LIB_SV

// `ifndef AXIS_SEQ_LIB_SV
// `define AXIS_SEQ_LIB_SV

// class axis_base_sequence extends uvm_sequence #(axis_seq_item);
//   `uvm_object_utils(axis_base_sequence)

//   rand int num_transactions = 10;

//   function new(string name = "axis_base_sequence");
//     super.new(name);
//   endfunction

//   virtual task pre_body();
//     uvm_phase phase = get_starting_phase();
//     if (phase != null)
//       phase.raise_objection(this);
//   endtask

//   virtual task post_body();
//     uvm_phase phase = get_starting_phase();
//     if (phase != null)
//       phase.drop_objection(this);
//   endtask
// endclass

// class axis_write_sequence extends axis_base_sequence;
//   `uvm_object_utils(axis_write_sequence)

//   function new(string name = "axis_write_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     repeat(num_transactions) begin
//       `uvm_do_with(req, {is_write == 1;})
//     end
//   endtask
// endclass

// class axis_read_sequence extends axis_base_sequence;
//   `uvm_object_utils(axis_read_sequence)

//   function new(string name = "axis_read_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     repeat(num_transactions) begin
//       `uvm_do_with(req, {is_write == 0;})
//     end
//   endtask
// endclass

// class axis_alternating_sequence extends axis_base_sequence;
//   `uvm_object_utils(axis_alternating_sequence)

//   function new(string name = "axis_alternating_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     repeat(num_transactions) begin
//       `uvm_do_with(req, {is_write == 1;})
//       `uvm_do_with(req, {is_write == 0;})
//     end
//   endtask
// endclass

// class axis_burst_write_sequence extends axis_base_sequence;
//   `uvm_object_utils(axis_burst_write_sequence)

//   rand int burst_size = 5;

//   function new(string name = "axis_burst_write_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     repeat(num_transactions) begin
//       repeat(burst_size) begin
//         `uvm_do_with(req, {is_write == 1;})
//       end
//       #10; // Small delay between bursts
//     end
//   endtask
// endclass

// class axis_burst_read_sequence extends axis_base_sequence;
//   `uvm_object_utils(axis_burst_read_sequence)

//   rand int burst_size = 5;

//   function new(string name = "axis_burst_read_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     repeat(num_transactions) begin
//       repeat(burst_size) begin
//         `uvm_do_with(req, {is_write == 0;})
//       end
//       #10; // Small delay between bursts
//     end
//   endtask
// endclass

// class axis_random_sequence extends axis_base_sequence;
//   `uvm_object_utils(axis_random_sequence)

//   function new(string name = "axis_random_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     repeat(num_transactions) begin
//       `uvm_do(req)
//     end
//   endtask
// endclass

// class axis_fifo_full_sequence extends axis_base_sequence;
//   `uvm_object_utils(axis_fifo_full_sequence)

//   rand int fifo_depth;

//   function new(string name = "axis_fifo_full_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     // Fill the FIFO
//     repeat(fifo_depth) begin
//       `uvm_do_with(req, {is_write == 1;})
//     end
//     // Try one more write (should be blocked)
//     `uvm_do_with(req, {is_write == 1;})
//     // Read one item
//     `uvm_do_with(req, {is_write == 0;})
//     // Write should now succeed
//     `uvm_do_with(req, {is_write == 1;})
//   endtask
// endclass

// class axis_fifo_empty_sequence extends axis_base_sequence;
//   `uvm_object_utils(axis_fifo_empty_sequence)

//   function new(string name = "axis_fifo_empty_sequence");
//     super.new(name);
//   endfunction

//   virtual task body();
//     // Ensure FIFO is empty (read until empty)
//     repeat(5) begin // Arbitrary number, adjust as needed
//       `uvm_do_with(req, {is_write == 0;})
//     end
//     // Try one more read (should be blocked)
//     `uvm_do_with(req, {is_write == 0;})
//     // Write one item
//     `uvm_do_with(req, {is_write == 1;})
//     // Read should now succeed
//     `uvm_do_with(req, {is_write == 0;})
//   endtask
// endclass

// `endif // AXIS_SEQ_LIB_SV