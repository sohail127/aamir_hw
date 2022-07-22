//////////////////////////////////////////////////////////////////////////////////
// Engineer         : Aamir Sohail Nagra <sohailnagra135@outlook.com>
// Date of Creation : 26th March, 2020
// Design Name      : True dual port RAM
// Module Name      : tdp_ram
// Description      : True dual port ram with parSize of RAM is parameterized and 
//                    can adopt
//                    according to given arguments
// Revision         : 1.0
// Comments         : This module is written for True port RAM. it gives an option
//                    to select output either with 1cc or 2cc latency. Memory can 
//                    also be initialized using File. each port has its own clock.
//////////////////////////////////////////////////////////////////////////////////
module tdp_ram #(
  parameter WIDTH     = 32  ,
  parameter DEPTH     = 1024,
  parameter LATENCY   = 1   ,
  parameter INIT_FILE = ""
) (
  input                      clka , // system clock for port A
  input                      wea  , // write enable for port A
  input  [$clog2(DEPTH)-1:0] addra, // memory address for port A
  input  [        WIDTH-1:0] dina , // ram data in for port A
  output [        WIDTH-1:0] douta, // ram data out for port A
  input                      clkb , // system clock for port B
  input                      web  , // write enable for port B
  input  [$clog2(DEPTH)-1:0] addrb, // memory address for port B
  input  [        WIDTH-1:0] dinb , // ram data in for port B
  output [        WIDTH-1:0] doutb  // ram data out for port B
);

//--******************************************--//
//**  Shared Mmeory Declaration  **//
//--*****************************************--//

  reg [WIDTH-1:0] mem[DEPTH-1:0];

  //--- port A registers --//

  reg [WIDTH-1:0] mem_outa    = {WIDTH{1'b0}};
  reg [WIDTH-1:0] lc_mem_outa = {WIDTH{1'b0}};

  //--- port A registers --//

  reg [WIDTH-1:0] mem_outb    = {WIDTH{1'b0}};
  reg [WIDTH-1:0] lc_mem_outb = {WIDTH{1'b0}};


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

//----------Port A operation ----------------//

//--***************************************--//
//--   Read and Write Dta   --//
//--***************************************--//

  always@(posedge clka)
    begin : reg_mem_outa
      if (wea)
        mem[addra] <= dina;
      else
        mem_outa <= mem[addra];
    end // reg_mem_out--always@(posedge clk)

//--***************************************--//
//--   2cc latency for data out   --//
//--***************************************--//

  always@(posedge clka)
    begin : reg_lc_mem_outa
      lc_mem_outa <= mem_outa;
    end // reg_lc_mem_out--always@(posedge clk)

//----------Port B operation ----------------//

//--***************************************--//
//--   Read and Write Dta   --//
//--***************************************--//

  always@(posedge clkb)
    begin : reg_mem_outb
      if (web)
        mem[addrb] <= dinb;
      else
        mem_outb <= mem[addrb];
    end // reg_mem_out--always@(posedge clk)

//--***************************************--//
//--   2cc latency for data out   --//
//--***************************************--//

  always@(posedge clkb)
    begin : reg_lc_mem_outb
      lc_mem_outb <= mem_outb;
    end // reg_lc_mem_out--always@(posedge clk)

//--***************************************--//
//--   select 1cc or 2cc latency   --//
//--***************************************--//

  assign douta = (LATENCY==1)? mem_outa : lc_mem_outa;
  assign doutb = (LATENCY==1)? mem_outb : lc_mem_outb;

endmodule : tdp_ram