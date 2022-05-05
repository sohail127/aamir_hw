//////////////////////////////////////////////////////////////////////////////////
// Engineer         : Aamir Sohail Nagra <sohailnagra135@outlook.com>
// Date of Creation : 26th March, 2020
// Design Name      : Single port RAM
// Module Name      : sp_ram
// Description      : Single port RAM. Size of RAM is parameterized and can adopt
//                    according to given arguments
// Revision         : 1.0
// Comments         : This module is written for single port RAM. it gives an
//                    option to select output either with 1cc or 2cc latency.
//                    Memory can also be initialized using File.
//////////////////////////////////////////////////////////////////////////////////
module sp_ram #(
  parameter WIDTH     = 32  ,
  parameter DEPTH     = 1024,
  parameter LATENCY   = 1   ,
  parameter INIT_FILE = ""
) (
  input                      clk , // system clock
  input                      we  , // write enable
  input  [$clog2(DEPTH)-1:0] addr, // memory address
  input  [        WIDTH-1:0] din , // ram data in
  output [        WIDTH-1:0] dout  // ram data out
);

//--******************************************--//
//**  Mmeory Declaration  **//
//--*****************************************--//

  reg [WIDTH-1:0] mem       [DEPTH-1:0]                ;
  reg [WIDTH-1:0] mem_out               = {WIDTH{1'b0}};
  reg [WIDTH-1:0] lc_mem_out            = {WIDTH{1'b0}}; // latency control data out (2cc)

//--******************************************--//
//**  Mmeory Initialization  **//
//--*****************************************--//

  generate
    if (INIT_FILE != "")
      begin: use_init_file
        initial
          $readmemh(INIT_FILE, mem, 0, DEPTH-1);
      end
    else
      begin: init_bram_to_zero
        integer mem_index;
        initial
          for (mem_index = 0; mem_index < DEPTH; mem_index = mem_index + 1)
            mem[mem_index] = {WIDTH{1'b0}};
      end
  endgenerate

//--***************************************--//
//--   Read and Write Dta   --//
//--***************************************--//

  always@(posedge clk)
    begin : reg_mem_out
      if (we)
        mem[addr] <= din;
      else
        mem_out <= mem[addr];
    end // reg_mem_out--always@(posedge clk)

//--***************************************--//
//--   2cc latency for data out   --//
//--***************************************--//

  always@(posedge clk)
    begin : reg_lc_mem_out
      lc_mem_out <= mem_out;
    end // reg_lc_mem_out--always@(posedge clk)

//--***************************************--//
//--   select 1cc or 2cc latency   --//
//--***************************************--//

  assign dout = (LATENCY==1)? mem_out : lc_mem_out;

endmodule