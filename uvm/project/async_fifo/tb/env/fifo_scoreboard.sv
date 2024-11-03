`ifndef FIFO_SCOREBOARD_SV
`define FIFO_SCOREBOARD_SV

class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)

  uvm_analysis_imp #(axis_seq_item, fifo_scoreboard) write_export;
  uvm_analysis_imp #(axis_seq_item, fifo_scoreboard) read_export;

  axis_seq_item write_queue[$];
  axis_seq_item read_queue[$];

  int match_count;
  int mismatch_count;
  event check_data_event;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    write_export = new("write_export", this);
    read_export = new("read_export", this);
    match_count = 0;
    mismatch_count = 0;
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), $sformatf("________ Buil_Phase________"), UVM_LOW)
  endfunction

  function void write(axis_seq_item item);
    if (item.is_write) begin

    `uvm_info(get_type_name(), $sformatf("scb_wr_q_item %s",item.sprint()), UVM_LOW)
      write_queue.push_back(item);
    end else begin
    `uvm_info(get_type_name(), $sformatf("scb_rd_q_item %s",item.sprint()), UVM_LOW)
      read_queue.push_back(item);
    -> check_data_event;
    end
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    fork
      check_data();
    join_none
  endtask

  task check_data();
    axis_seq_item write_item, read_item;
    forever begin
      @(check_data_event);
      while (write_queue.size() > 0 && read_queue.size() > 0) begin
        write_item = write_queue.pop_front();
        read_item = read_queue.pop_front();

        if (write_item.compare(read_item)) begin
          match_count++;
          `uvm_info(get_type_name(), $sformatf("Data Match - Write: %h, Read: %h", write_item.tdata, read_item.tdata), UVM_HIGH)
        end else begin
          mismatch_count++;
          `uvm_error(get_type_name(), $sformatf("Data Mismatch - Write: %h, Read: %h", write_item.tdata, read_item.tdata))
        end
      end
    end
  endtask

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Scoreboard Report:"), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("  Matches: %0d", match_count), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("  Mismatches: %0d", mismatch_count), UVM_LOW)
    
    if (write_queue.size() != 0) begin
      `uvm_error(get_type_name(), $sformatf("%0d write transactions not processed", write_queue.size()))
    end
    
    if (read_queue.size() != 0) begin
      `uvm_error(get_type_name(), $sformatf("%0d read transactions not processed", read_queue.size()))
    end
  endfunction

endclass

`endif // FIFO_SCOREBOARD_SV