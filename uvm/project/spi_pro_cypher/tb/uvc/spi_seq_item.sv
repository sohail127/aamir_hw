class spi_seq_item#(spi_pkg::spi_param P) extends  uvm_sequence_item;

	radn logic [P.AWIDTH-1:0] addr  ;
	radn logic [P.DWIDTH-1:0] data  ;

`uvm_object_utils_begin(spi_seq_item)
`uvm_object_field(addr)
`uvm_object_field(data)
`uvm_object_utils_end 

	// Constructor
	function new(string name = "spi_seq_item");
		super.new(name);
	endfunction : new

endclass : spi_seq_item