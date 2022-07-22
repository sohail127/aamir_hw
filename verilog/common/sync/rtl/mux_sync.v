// mux synchronizer to synchronize bus data
module mux_sync #(parameter DWIDTH=32) (
  input                   i_src_clk  , // Clock
  input                   i_dst_clk  , // Clock
  input                   rst_n      , // Asynchronous reset active low
  input      [DWIDTH-1:0] i_src_data ,
  input                   i_src_valid,
  output reg [DWIDTH-1:0] o_dst_data ,
  output reg              o_dst_valid  // Not required, additionaly added for understanding
);

  reg [DWIDTH-1:0] r_src_data  ;
  reg [       1:0] r_dst_dbl_ff;
  reg              r_src_valid ;

// 1. Flop input data at source clock
  always @(posedge i_src_clk or negedge rst_n) begin
    if(~rst_n) begin
      r_src_data <= {DWIDTH{1'b0}};
    end else begin
      r_src_data <= i_src_data;
    end
  end
// 2. Flop valid at source clock
  always @(posedge i_src_clk or negedge rst_n) begin
    if(~rst_n) begin
      r_src_valid <= 1'b0;
    end else begin
      r_src_valid <= i_src_valid;
    end
  end

// 3. Double flop register valid at destination clock
  always @(posedge i_dst_clk or negedge rst_n) begin
    if(~rst_n) begin
      r_dst_dbl_ff <= {2{1'b0}};
    end else begin
      r_dst_dbl_ff[0] <= r_src_valid;
      r_dst_dbl_ff[1] <= r_dst_dbl_ff[0];
    end
  end

// 4. syncronize data at destination clock based on
// valid signal synchronized at destination domain.
  always @(posedge i_dst_clk or negedge rst_n) begin
    if(~rst_n) begin
      o_dst_data <= {DWIDTH{1'b0}};
      o_dst_valid <= 1'b0;
    end else begin
      if (r_dst_dbl_ff[1]) begin
        o_dst_data  <= r_src_data;
        o_dst_valid <= 1'b1;
      end else begin
        o_dst_data <= o_dst_data;
      end
    end
  end

endmodule : mux_sync