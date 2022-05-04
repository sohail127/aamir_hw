interface out_interface (input clk);
	output [BUS_WIDTH-1] o_data ; 
  output               o_empty; 
  output               o_full ;
endinterface : out_interface