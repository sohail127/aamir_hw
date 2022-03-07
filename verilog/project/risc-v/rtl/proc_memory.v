module proc_memory #(
	parameter DATA_WIDTH= 32,
	parameter MEM_DEPTH = 1024
) (
	input                          clk       , // Clock
	input                          i_mem_we  , // i_mem_we : 1 to write
	input  [$clog2(MEM_DEPTH)-1:0] i_mem_add , // address to read and write
	input  [       DATA_WIDTH-1:0] i_mem_data, //  data to write
	output [       DATA_WIDTH-1:0] o_mem_data  // read data 
);

	// memory declaration
	reg [DATA_WIDTH-1:0] proc_mem[MEM_DEPTH-1:0];
	
	//memory initialization
	initial begin
		$readmemh("memory.mem", proc_mem);
	end
	// write memory
	always@(posedge clk) begin
		if(i_mem_we) begin
			proc_mem[i_mem_add] <= i_mem_data;
		end
	end

	// read logic here
	assign o_mem_data = proc_mem [i_mem_data] ;

endmodule : proc_memory