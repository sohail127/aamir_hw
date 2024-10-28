`ifndef SPI_SEQ_ITEM_SV
`define SPI_SEQ_ITEM_SV

class spi_seq_item extends uvm_sequence_item;
  `uvm_object_utils(spi_seq_item)

  rand bit [7:0] data[];
  rand int delay;
  bit is_flash_transaction;
  int sensor_id;

  constraint c_delay { delay inside {[1:10]}; }
  constraint c_data_size { data.size() inside {[1:10]}; }

  function new(string name = "spi_seq_item");
    super.new(name);
  endfunction

  function void do_copy(uvm_object rhs);
    spi_seq_item rhs_;
    if(!$cast(rhs_, rhs)) begin
      `uvm_fatal("do_copy", "cast of rhs object failed")
    end
    super.do_copy(rhs);
    this.data = rhs_.data;
    this.delay = rhs_.delay;
  endfunction

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    spi_seq_item rhs_;
    if(!$cast(rhs_, rhs)) return 0;
    return super.do_compare(rhs, comparer) &&
           this.data == rhs_.data &&
           this.delay == rhs_.delay;
  endfunction

  function string convert2string();
    string s;
    s = super.convert2string();
    $sformat(s, "%s\n data = %p\n delay = %0d", s, data, delay);
    return s;
  endfunction

endclass
`endif // SPI_SEQ_ITEM_SV
