// class spi_base_sequence#(spi_pkg::PARAM spi_param_t P) extends  uvm_sequence#(spi_pkg::spi_seq_item item);
class spi_base_sequence#(spi_pkg::spi_param_t P) extends  uvm_sequence#(spi_pkg::spi_seq_item#(P));
	`uvm_object_utils(spi_base_sequence)
	
	rand int send_item;
	spi_seq_item item;

	// Constructor
	function new(string name = "spi_base_sequence");
		super.new(name);
	endfunction : new

	virtual task body();
		
		this.item = spi_seq_item#(P)::type_id::create("item");

		for (int i = 0; i < this.send_item; i++) begin
			this.item.start_item();
			if (!this.item.radomize()) begin
				`uvm_fatal(get_type_name(),$sformatf("Unable to radomize seq item"))
			end
			this.item.finish_item();
		end
	endtask : body

endclass : spi_base_sequence