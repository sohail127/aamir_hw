module spi_flash_controller #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 24,
    parameter CLK_DIV = 4
)(
    input wire clk,
    input wire rst_n,
    output reg sck,
    output reg cs_n,
    output reg mosi,
    input wire miso,
    input wire [DATA_WIDTH-1:0] write_data,
    input wire [ADDR_WIDTH-1:0] write_addr,
    input wire write_start,
    output reg write_ready,
    output reg write_busy
);

    localparam IDLE = 3'b000;
    localparam SEND_CMD = 3'b001;
    localparam SEND_ADDR = 3'b010;
    localparam SEND_DATA = 3'b011;
    localparam WAIT_BUSY = 3'b100;

    reg [2:0] state;
    reg [7:0] cmd;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data;
    reg [$clog2(ADDR_WIDTH+DATA_WIDTH)-1:0] bit_count;
    reg [$clog2(CLK_DIV)-1:0] clk_counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            sck <= 1'b0;
            cs_n <= 1'b1;
            mosi <= 1'b0;
            write_ready <= 1'b1;
            write_busy <= 1'b0;
            cmd <= 8'h02; // Page Program command
            addr <= {ADDR_WIDTH{1'b0}};
            data <= {DATA_WIDTH{1'b0}};
            bit_count <= 0;
            clk_counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (write_start) begin
                        state <= SEND_CMD;
                        cs_n <= 1'b0;
                        addr <= write_addr;
                        data <= write_data;
                        write_ready <= 1'b0;
                        write_busy <= 1'b1;
                        bit_count <= 7;
                    end
                end
                SEND_CMD: begin
                    if (clk_counter == CLK_DIV - 1) begin
                        sck <= ~sck;
                        if (sck) begin
                            mosi <= cmd[bit_count];
                            if (bit_count == 0) begin
                                state <= SEND_ADDR;
                                bit_count <= ADDR_WIDTH - 1;
                            end else begin
                                bit_count <= bit_count - 1;
                            end
                        end
                        clk_counter <= 0;
                    end else begin
                        clk_counter <= clk_counter + 1;
                    end
                end
                SEND_ADDR: begin
                    if (clk_counter == CLK_DIV - 1) begin
                        sck <= ~sck;
                        if (sck) begin
                            mosi <= addr[bit_count];
                            if (bit_count == 0) begin
                                state <= SEND_DATA;
                                bit_count <= DATA_WIDTH - 1;
                            end else begin
                                bit_count <= bit_count - 1;
                            end
                        end
                        clk_counter <= 0;
                    end else begin
                        clk_counter <= clk_counter + 1;
                    end
                end
                SEND_DATA: begin
                    if (clk_counter == CLK_DIV - 1) begin
                        sck <= ~sck;
                        if (sck) begin
                            mosi <= data[bit_count];
                            if (bit_count == 0) begin
                                state <= WAIT_BUSY;
                                cs_n <= 1'b1;
                            end else begin
                                bit_count <= bit_count - 1;
                            end
                        end
                        clk_counter <= 0;
                    end else begin
                        clk_counter <= clk_counter + 1;
                    end
                end
                WAIT_BUSY: begin
                    if (!miso) begin
                        state <= IDLE;
                        write_ready <= 1'b1;
                        write_busy <= 1'b0;
                    end
                end
            endcase
        end
    end

endmodule