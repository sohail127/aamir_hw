////////////////////////////////////////////////////////////////////////////////
/*
AXIS Slave Interface (Write Side):

s_axis_tdata: Input data
s_axis_tstrb: Byte strobe
s_axis_tlast: End of packet signal
s_axis_tvalid: Data valid signal
s_axis_tready: Ready signal (output)
AXIS Master Interface (Read Side):

m_axis_tdata: Output data
m_axis_tstrb: Byte strobe
m_axis_tlast: End of packet signal
m_axis_tvalid: Data valid signal
m_axis_tready: Ready signal (input)
Handshaking:

Write occurs when s_axis_tvalid and s_axis_tready are both high
Read occurs when m_axis_tvalid and m_axis_tready are both high
Additional Features:

almost_full and almost_empty status signals
Parameterized data width and FIFO depth
Stores tlast and tstrb along with data in the FIFO
Clock Domain Crossing:

Maintained separate read and write clocks for asynchronous operation
Uses gray code for safe pointer crossing between clock domains
*/
////////////////////////////////////////////////////////////////////////////////

module axis_async_fifo #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 10,  // 2^10 = 1024 words (1KB for 32-bit words)
    parameter STRB_WIDTH = (DATA_WIDTH/8)
) (
    // AXI Stream slave interface (write side)
    input  wire                   s_axis_aclk,
    input  wire                   s_axis_aresetn,
    input  wire [DATA_WIDTH-1:0]  s_axis_tdata,
    input  wire [STRB_WIDTH-1:0]  s_axis_tstrb,
    input  wire                   s_axis_tlast,
    input  wire                   s_axis_tvalid,
    output wire                   s_axis_tready,
    
    // AXI Stream master interface (read side)
    input  wire                   m_axis_aclk,
    input  wire                   m_axis_aresetn,
    output reg  [DATA_WIDTH-1:0]  m_axis_tdata,
    output reg  [STRB_WIDTH-1:0]  m_axis_tstrb,
    output reg                    m_axis_tlast,
    output reg                    m_axis_tvalid,
    input  wire                   m_axis_tready,
    
    // Status signals
    output wire                   almost_full,
    output wire                   almost_empty
);

    localparam FIFO_DEPTH = (1 << ADDR_WIDTH);
    localparam ALMOST_FULL_THRESHOLD  = FIFO_DEPTH - 4;
    localparam ALMOST_EMPTY_THRESHOLD = 4;

    // Dual-port RAM
    reg [DATA_WIDTH+STRB_WIDTH:0] mem [0:FIFO_DEPTH-1];

    // Read and write pointers
    reg [ADDR_WIDTH:0] wr_ptr, rd_ptr;
    reg [ADDR_WIDTH:0] wr_ptr_gray, rd_ptr_gray;
    reg [ADDR_WIDTH:0] wr_ptr_gray_rd, rd_ptr_gray_wr;

    // Synchronizers
    reg [ADDR_WIDTH:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2;
    reg [ADDR_WIDTH:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2;

    // Full and empty flags
    wire full_internal, empty_internal;

    // Gray code conversion functions
    function [ADDR_WIDTH:0] bin2gray(input [ADDR_WIDTH:0] bin);
        bin2gray = bin ^ (bin >> 1);
    endfunction

    function [ADDR_WIDTH:0] gray2bin(input [ADDR_WIDTH:0] gray);
        integer i;
        reg [ADDR_WIDTH:0] bin;
        begin
            bin = gray;
            for (i = 1; i <= ADDR_WIDTH; i = i + 1)
                bin = bin ^ (gray >> i);
            gray2bin = bin;
        end
    endfunction

    // Write logic
    wire wr_en = s_axis_tvalid && s_axis_tready;
    always @(posedge s_axis_aclk or negedge s_axis_aresetn) begin
        if (!s_axis_aresetn) begin
            wr_ptr <= 0;
            wr_ptr_gray <= 0;
        end else if (wr_en) begin
            mem[wr_ptr[ADDR_WIDTH-1:0]] <= {s_axis_tlast, s_axis_tstrb, s_axis_tdata};
            wr_ptr <= wr_ptr + 1;
            wr_ptr_gray <= bin2gray(wr_ptr + 1);
        end
    end

    // Read logic
    reg rd_en;
    always @(posedge m_axis_aclk or negedge m_axis_aresetn) begin
        if (!m_axis_aresetn) begin
            rd_ptr <= 0;
            rd_ptr_gray <= 0;
            m_axis_tvalid <= 1'b0;
            m_axis_tdata <= {DATA_WIDTH{1'b0}};
            m_axis_tstrb <= {STRB_WIDTH{1'b0}};
            m_axis_tlast <= 1'b0;
        end else begin
            if (rd_en) begin
                {m_axis_tlast, m_axis_tstrb, m_axis_tdata} <= mem[rd_ptr[ADDR_WIDTH-1:0]];
                rd_ptr <= rd_ptr + 1;
                rd_ptr_gray <= bin2gray(rd_ptr + 1);
                m_axis_tvalid <= 1'b1;
            end else if (m_axis_tready && m_axis_tvalid) begin
                m_axis_tvalid <= 1'b0;
            end
        end
    end

    always @(*) begin
        rd_en = !empty_internal && (!m_axis_tvalid || (m_axis_tvalid && m_axis_tready));
    end

    // Synchronizers
    always @(posedge s_axis_aclk or negedge s_axis_aresetn) begin
        if (!s_axis_aresetn) begin
            rd_ptr_gray_sync1 <= 0;
            rd_ptr_gray_sync2 <= 0;
        end else begin
            rd_ptr_gray_sync1 <= rd_ptr_gray;
            rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
        end
    end

    always @(posedge m_axis_aclk or negedge m_axis_aresetn) begin
        if (!m_axis_aresetn) begin
            wr_ptr_gray_sync1 <= 0;
            wr_ptr_gray_sync2 <= 0;
        end else begin
            wr_ptr_gray_sync1 <= wr_ptr_gray;
            wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
        end
    end

    // Full and empty generation
    assign full_internal = (wr_ptr_gray == {~rd_ptr_gray_sync2[ADDR_WIDTH:ADDR_WIDTH-1], rd_ptr_gray_sync2[ADDR_WIDTH-2:0]});
    assign empty_internal = (rd_ptr_gray == wr_ptr_gray_sync2);

    // AXIS interface signals
    assign s_axis_tready = !full_internal;

    // Status signals
    wire [ADDR_WIDTH:0] wr_ptr_bin = gray2bin(wr_ptr_gray);
    wire [ADDR_WIDTH:0] rd_ptr_bin = gray2bin(rd_ptr_gray);
    assign almost_full = (wr_ptr_bin - rd_ptr_bin >= ALMOST_FULL_THRESHOLD);
    assign almost_empty = (wr_ptr_bin - rd_ptr_bin <= ALMOST_EMPTY_THRESHOLD);

endmodule