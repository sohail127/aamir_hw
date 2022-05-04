//------------------------------------------------------------------------------
// Title       : FIFO Memory
// Project     : Memories in verilog
//------------------------------------------------------------------------------
// Author : Aamir Sohail Nagra (ASN) <sohailnagra135@outlook.com>
// File   : fifo.v
// Create : 2021-12-21 19:05:56
//-----------------------------------------------------------------------------
// Description:
//------------------------------------------------------------------------------
// FIFO is simple First in and First out memory. Data written on memory first 
// will be the one we get upon receiving. All counter bits except the MSB are 
// used to address the FIFO array. In this configuration, every location in the
// FIFO is accessed twice before the counter rolls over. When the MSBs of the
// write counter equal those of the read counter, the FIFO is empty. When the 
// MSBs are not equal and the actual count value is same, then the FIFO is full. 
// This scheme makes it relatively simple to generate the empty and full flags. 
// Since the FIFO logic prevents additional writes to a full FIFO and also 
// prevents reads from an empty FIFO, the counters can never get further apart 
// than the depth of the FIFO. This prevents reading old data or overwriting 
// new data.
// -----------------------------------------------------------------------------

module fifo #(
  parameter FIFO_DEPTH = 1024,
  parameter BUS_WIDTH  = 32
) (
  input                clk    , // Clock
  input                rst_n  , // Asynchronous reset active low
  input                i_rd   , // 1: rd
  input                i_wr   , // 1 : wr
  input  [BUS_WIDTH-1] i_data , // input data
  output [BUS_WIDTH-1] o_data , // output data
  output               o_empty, // 1 : if fifo is empty
  output               o_full   // 1 : if fifo is full
);

  // register array declaration
  reg [BUS_WIDTH-1:0] reg_a [FIFO_DEPTH-1:0];

  // register pointers for read and write
  reg [$clog2(FIFO_DEPTH):0] wr_ptr;
  reg [$clog2(FIFO_DEPTH):0] rd_ptr;

  wire [$clog2(FIFO_DEPTH-1):0] wr_add;
  wire [$clog2(FIFO_DEPTH-1):0] rd_add;

  assign wr_add = wr_ptr[$clog2(FIFO_DEPTH)-1:0] ;
  assign rd_add = rd_ptr[$clog2(FIFO_DEPTH)-1:0] ;

  wire wr_en = ~ o_full  && i_wr;
  wire rd_en = ~ o_empty && i_rd;

  //---------------------------------------------------
  // write on fifo
  //---------------------------------------------------
  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      wr_ptr <= {$clog2(FIFO_DEPTH+1){1'b0}};
    end else begin
      if (wr_en) begin
        reg_a[wr_add] <= i_data;
        wr_ptr        <= wr_ptr + 1'd1;
      end
    end
  end

  //---------------------------------------------------
  // Read from fifo
  //---------------------------------------------------

  always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
      rd_ptr <= {$clog2(FIFO_DEPTH+1){1'b0}};
    end else begin
      if (rd_en) begin
        o_data <= reg_a [rd_add] ;
        rd_ptr <= rd_ptr + 1'd1 ;
      end
    end
  end

  //---------------------------------------------------
  // Read from fifo
  //---------------------------------------------------
  assign o_empty = (rd_ptr[FIFO_DEPTH] == wr_ptr[FIFO_DEPTH]) &&
    (rd_ptr[FIFO_DEPTH-1:0] == wr_ptr[FIFO_DEPTH-1:0])   ;

  assign o_full = (rd_ptr[FIFO_DEPTH] != wr_ptr[FIFO_DEPTH]) &&
    (rd_ptr[FIFO_DEPTH-1:0] == wr_ptr[FIFO_DEPTH-1:0])   ;

endmodule : fifo