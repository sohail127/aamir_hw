import uvm_pkg::*;
`include "uvm_macros.svh"
import fifo_test_pkg::*;
`include "axis_if.sv"
;

module tb_axis_async_fifo;

  // Parameters
  localparam DATA_WIDTH = 32;
  localparam ADDR_WIDTH = 10;
  localparam STRB_WIDTH = (DATA_WIDTH / 8);

  // Clock and reset signals
  logic s_axis_aclk;
  logic s_axis_aresetn;
  logic m_axis_aclk;
  logic m_axis_aresetn;

  // Instantiate interfaces
  axis_if write_if (
      s_axis_aclk,
      s_axis_aresetn
  );
  axis_if read_if (
      m_axis_aclk,
      m_axis_aresetn
  );

  // Status signals
  wire almost_full;
  wire almost_empty;

  // DUT instantiation
  axis_async_fifo #(
      .DATA_WIDTH(DATA_WIDTH),
      .ADDR_WIDTH(ADDR_WIDTH),
      .STRB_WIDTH(STRB_WIDTH)
  ) dut (
      .s_axis_aclk(s_axis_aclk),
      .s_axis_aresetn(s_axis_aresetn),
      .s_axis_tdata(write_if.tdata),
      .s_axis_tstrb(write_if.tstrb),
      .s_axis_tlast(write_if.tlast),
      .s_axis_tvalid(write_if.tvalid),
      .s_axis_tready(write_if.tready),

      .m_axis_aclk(m_axis_aclk),
      .m_axis_aresetn(m_axis_aresetn),
      .m_axis_tdata(read_if.tdata),
      .m_axis_tstrb(read_if.tstrb),
      .m_axis_tlast(read_if.tlast),
      .m_axis_tvalid(read_if.tvalid),
      .m_axis_tready(read_if.tready),

      .almost_full (almost_full),
      .almost_empty(almost_empty)
  );

  // Clock generation
  initial begin
    s_axis_aclk = 0;
    forever #5 s_axis_aclk = ~s_axis_aclk;
  end

  initial begin
    m_axis_aclk = 0;
    forever #7 m_axis_aclk = ~m_axis_aclk;
  end

  // Reset generation
  initial begin
    s_axis_aresetn = 0;
    m_axis_aresetn = 0;
    #100;
    s_axis_aresetn = 1;
    m_axis_aresetn = 1;
  end

  initial begin
    // Dump waves
    $dumpfile("tb_axis_async_fifo.vcd");
    $dumpvars(0, tb_axis_async_fifo,"+all");
  end

  initial begin
    // Set the interfaces in the config DB
    uvm_config_db#(virtual axis_if)::set(null, "uvm_test_top", "write_vif", write_if);
    uvm_config_db#(virtual axis_if)::set(null, "uvm_test_top", "read_vif", read_if);

    // Run the test
    run_test();
  end
endmodule : tb_axis_async_fifo
