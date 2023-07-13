class spi_base_sequence#(spi_pkg::spi_param P) extends  uvm_sequence#(spi_pkg::spi_seq_item item);
	`uvm_component_utils(spi_base_sequence)
	rand send_item;

	// Constructor
	function new(string name = "spi_base_sequence");
		super.new(name, parent);
	endfunction : new

	virtual task body();
		spi_seq_item item;
		
		this.item = spi_seq_item::type_id::create("item", this);

		for (int i = 0; i < this.send_item; i++) begin
			spi_seq_item.start_item();
			if (!this.spi_seq_item.radomize()) begin
				`uvm_fatal(get_type_name(),$sformatf("Unable to radomize seq item"))
			end
			spi_seq_item.finish_item();
		end
	endtask : body

endclass : spi_base_sequence