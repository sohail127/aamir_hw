`ifndef AXIS_COVERAGE_COLLECTOR_SV
`define AXIS_COVERAGE_COLLECTOR_SV

class axis_coverage_collector extends uvm_subscriber #(axis_seq_item);
  `uvm_component_utils(axis_coverage_collector)

  axis_seq_item axis_item;
  bit in_packet;
  int packet_length;

  // Covergroups
  covergroup axis_transaction_cg;
    option.per_instance = 1;

    // TDATA coverage
    tdata_cp: coverpoint axis_item.tdata {
      option.auto_bin_max = 256; // Adjust as needed
    }

    // TSTRB coverage
    tstrb_cp: coverpoint axis_item.tstrb {
      bins all_ones = {'b1111};
      bins all_zeros = {'b0000};
      bins others = {['b0001:'b1110]};
    }

    // TLAST coverage
    tlast_cp: coverpoint axis_item.tlast {
      bins asserted = {1};
      bins deasserted = {0};
    }

    // Position byte coverage
    position_byte_cp: coverpoint axis_item.tstrb {
      bins first_byte = {'b0001, 'b0011, 'b0111, 'b1111};
      bins middle_byte = {'b1110, 'b1100, 'b1000};
      bins last_byte = {'b1000, 'b1100, 'b1110, 'b1111};
    }

    // Null byte coverage
    null_byte_cp: coverpoint axis_item.tstrb {
      bins null_byte = {'b0000};
      bins non_null = {['b0001:'b1111]};
    }

    // TSTRB and TLAST cross coverage
    tstrb_tlast_cross: cross tstrb_cp, tlast_cp;

    // Transaction size coverage
    transaction_size_cp: coverpoint $countones(axis_item.tstrb) {
      bins sizes[] = {[1:4]};
    }

    // Packet start coverage
    packet_start_cp: coverpoint (packet_length == 1) {
      bins packet_start = {1};
      bins not_packet_start = {0};
    }

    // Packet end coverage
    packet_end_cp: coverpoint axis_item.tlast {
      bins packet_end = {1};
      bins not_packet_end = {0};
    }

    // Packet length coverage
    packet_length_cp: coverpoint packet_length {
      bins single_beat = {1};
      bins short_packet = {[2:5]};
      bins medium_packet = {[6:10]};
      bins long_packet = {[11:$]};
    }
  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    axis_transaction_cg = new();
    in_packet = 0;
    packet_length = 0;
  endfunction

  function void write(axis_seq_item t);
    axis_item = t;
    
    if (!in_packet) begin
      packet_length = 1;
      in_packet = 1;
    end else begin
      packet_length++;
    end

    axis_transaction_cg.sample();
    
    if (t.tlast) begin
      in_packet = 0;
    end
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("________ Report_Phase________"), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("AXIS coverage: %0.2f%%", axis_transaction_cg.get_inst_coverage()), UVM_LOW)
  endfunction

endclass

`endif // AXIS_COVERAGE_COLLECTOR_SV