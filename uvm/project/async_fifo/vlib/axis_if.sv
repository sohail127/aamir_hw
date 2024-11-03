interface axis_if (input logic aclk, input logic aresetn);
  logic [31:0] tdata;  // Assuming 32-bit data width
  logic [3:0]  tstrb;  // Assuming 4-bit strobe (for 32-bit data)
  logic        tlast;
  logic        tvalid;
  logic        tready;

  clocking driver_cb @(posedge aclk);
    output tdata, tstrb, tlast, tvalid;
    input  tready;
  endclocking

  clocking monitor_cb @(posedge aclk);
    input tdata, tstrb, tlast, tvalid, tready;
  endclocking

  modport driver (clocking driver_cb, input aclk, aresetn);
  modport monitor (clocking monitor_cb, input aclk, aresetn);
endinterface