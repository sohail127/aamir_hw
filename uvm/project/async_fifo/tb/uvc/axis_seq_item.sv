`ifndef AXIS_SEQ_ITEM_SV
`define AXIS_SEQ_ITEM_SV
class axis_seq_item extends uvm_sequence_item;

  rand bit [31:0] tdata;  // Assuming 32-bit data width
  rand bit [ 3:0] tstrb;  // Assuming 4-bit strobe (for 32-bit data)
  rand bit        tlast;
  rand int        delay;
  bit is_write;  // 1 for write, 0 for read

    `uvm_object_utils_begin(axis_seq_item)
    `uvm_field_int(tdata, UVM_ALL_ON)
    `uvm_field_int(tstrb, UVM_ALL_ON)
    `uvm_field_int(tlast, UVM_ALL_ON)
    `uvm_field_int(delay, UVM_ALL_ON)
    `uvm_field_int(is_write, UVM_ALL_ON)
  `uvm_object_utils_end

  constraint c_delay {delay inside {[0 : 10]};}

  function new(string name = "axis_seq_item");
    super.new(name);
  endfunction

  function void do_copy(uvm_object rhs);
    axis_seq_item rhs_;
    if (!$cast(rhs_, rhs)) begin
      `uvm_fatal("AXIS_SEQ_ITEM", "Cast failed in do_copy()")
    end
    super.do_copy(rhs);
    this.tdata = rhs_.tdata;
    this.tstrb = rhs_.tstrb;
    this.tlast = rhs_.tlast;
    this.delay = rhs_.delay;
  endfunction

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    axis_seq_item rhs_;
    if (!$cast(rhs_, rhs)) begin
      `uvm_fatal("AXIS_SEQ_ITEM", "Cast failed in do_compare()")
      return 0;
    end
    return (super.do_compare(
        rhs, comparer
    ) && this.tdata == rhs_.tdata && this.tstrb == rhs_.tstrb && this.tlast == rhs_.tlast);
  endfunction

  function string convert2string();
    return
        $sformatf("tdata: 0x%0h, tstrb: 0b%0b, tlast: %0b, delay: %0d", tdata, tstrb, tlast, delay);
  endfunction
endclass
`endif  // AXIS_SEQ_ITEM_SV
