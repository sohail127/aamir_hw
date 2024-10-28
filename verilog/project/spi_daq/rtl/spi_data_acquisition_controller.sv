module spi_data_acquisition_controller #(
    parameter SENSOR_COUNT = 3,
    parameter DATA_WIDTH = 16,
    parameter FIFO_DEPTH = 256,
    parameter FLASH_ADDR_WIDTH = 24
)(
    input wire clk,
    input wire rst_n,
    
    // Sensor SPI interfaces
    output wire [SENSOR_COUNT-1:0] sensor_sck,
    output wire [SENSOR_COUNT-1:0] sensor_cs_n,
    output wire [SENSOR_COUNT-1:0] sensor_mosi,
    input wire [SENSOR_COUNT-1:0] sensor_miso,
    
    // Flash SPI interface
    output wire flash_sck,
    output wire flash_cs_n,
    output wire flash_mosi,
    input wire flash_miso,
    
    // Control and status
    input wire start_acquisition,
    output wire acquisition_done,
    output wire [SENSOR_COUNT-1:0] sensor_data_valid,
    output wire flash_write_busy
);

    // Internal signals
    wire [SENSOR_COUNT-1:0] sensor_data_ready;
    wire [SENSOR_COUNT-1:0] fifo_full;
    wire [SENSOR_COUNT-1:0] fifo_empty;
    wire [SENSOR_COUNT-1:0] fifo_read;
    wire [DATA_WIDTH-1:0] fifo_data [SENSOR_COUNT-1:0];
    wire flash_write_ready;
    wire [DATA_WIDTH-1:0] flash_write_data;
    wire flash_write_start;

    // Instantiate SPI Sensor Interfaces
    genvar i;
    generate
        for (i = 0; i < SENSOR_COUNT; i = i + 1) begin : sensor_interfaces
            spi_sensor_interface #(
                .DATA_WIDTH(DATA_WIDTH)
            ) sensor_if (
                .clk(clk),
                .rst_n(rst_n),
                .sck(sensor_sck[i]),
                .cs_n(sensor_cs_n[i]),
                .mosi(sensor_mosi[i]),
                .miso(sensor_miso[i]),
                .data_ready(sensor_data_ready[i]),
                .data_valid(sensor_data_valid[i])
            );
        end
    endgenerate

    // Instantiate FIFO Buffers
    generate
        for (i = 0; i < SENSOR_COUNT; i = i + 1) begin : fifo_buffers
            fifo #(
                .WIDTH(DATA_WIDTH),
                .DEPTH(FIFO_DEPTH)
            ) fifo_inst (
                .clk(clk),
                .rst_n(rst_n),
                .write_en(sensor_data_ready[i]),
                .read_en(fifo_read[i]),
                .data_in(sensor_data_valid[i]),
                .data_out(fifo_data[i]),
                .full(fifo_full[i]),
                .empty(fifo_empty[i])
            );
        end
    endgenerate

    // Instantiate SPI Flash Controller
    spi_flash_controller #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(FLASH_ADDR_WIDTH)
    ) flash_ctrl (
        .clk(clk),
        .rst_n(rst_n),
        .sck(flash_sck),
        .cs_n(flash_cs_n),
        .mosi(flash_mosi),
        .miso(flash_miso),
        .write_data(flash_write_data),
        .write_addr(flash_write_addr),
        .write_start(flash_write_start),
        .write_ready(flash_write_ready),
        .write_busy(flash_write_busy)
    );

    // Instantiate Arbitration Logic
    arbitration_logic #(
        .SENSOR_COUNT(SENSOR_COUNT),
        .DATA_WIDTH(DATA_WIDTH)
    ) arb_logic (
        .clk(clk),
        .rst_n(rst_n),
        .start_acquisition(start_acquisition),
        .fifo_empty(fifo_empty),
        .fifo_data(fifo_data),
        .flash_write_ready(flash_write_ready),
        .fifo_read(fifo_read),
        .flash_write_data(flash_write_data),
        .flash_write_start(flash_write_start),
        .flash_write_addr(flash_write_addr),
        .acquisition_done(acquisition_done)
    );

endmodule