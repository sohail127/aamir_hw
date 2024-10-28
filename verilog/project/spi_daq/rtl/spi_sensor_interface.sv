module spi_sensor_interface #(
    parameter DATA_WIDTH = 16,
    parameter CLK_DIV = 4
)(
    input wire clk,
    input wire rst_n,
    output reg sck,
    output reg cs_n,
    output reg mosi,
    input wire miso,
    output reg data_ready,
    output reg [DATA_WIDTH-1:0] data_valid
);

    localparam IDLE = 2'b00;
    localparam TRANSMIT = 2'b01;
    localparam RECEIVE = 2'b10;

    reg [1:0] state;
    reg [DATA_WIDTH-1:0] shift_reg;
    reg [$clog2(DATA_WIDTH)-1:0] bit_count;
    reg [DATA_WIDTH-1:0] rx_data;
    reg [$clog2(CLK_DIV)-1:0] clk_counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            sck <= 1'b0;
            cs_n <= 1'b1;
            mosi <= 1'b0;
            data_ready <= 1'b0;
            data_valid <= {DATA_WIDTH{1'b0}};
            shift_reg <= {DATA_WIDTH{1'b0}};
            bit_count <= {$clog2(DATA_WIDTH){1'b0}};
            rx_data <= {DATA_WIDTH{1'b0}};
            clk_counter <= {$clog2(CLK_DIV){1'b0}};
        end else begin
            case (state)
                IDLE: begin
                    cs_n <= 1'b0;
                    state <= TRANSMIT;
                    bit_count <= DATA_WIDTH - 1;
                    data_ready <= 1'b0;
                end
                TRANSMIT: begin
                    if (clk_counter == CLK_DIV - 1) begin
                        sck <= ~sck;
                        if (sck) begin
                            mosi <= shift_reg[bit_count];
                            if (bit_count == 0) begin
                                state <= RECEIVE;
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
                RECEIVE: begin
                    if (clk_counter == CLK_DIV - 1) begin
                        sck <= ~sck;
                        if (!sck) begin
                            rx_data[bit_count] <= miso;
                            if (bit_count == 0) begin
                                state <= IDLE;
                                cs_n <= 1'b1;
                                data_ready <= 1'b1;
                                data_valid <= rx_data;
                            end else begin
                                bit_count <= bit_count - 1;
                            end
                        end
                        clk_counter <= 0;
                    end else begin
                        clk_counter <= clk_counter + 1;
                    end
                end
            endcase
        end
    end

endmodule