module arbitration_logic #(
    parameter SENSOR_COUNT = 3,
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 24
)(
    input wire clk,
    input wire rst_n,
    input wire start_acquisition,
    input wire [SENSOR_COUNT-1:0] fifo_empty,
    input wire [DATA_WIDTH-1:0] fifo_data [SENSOR_COUNT-1:0],
    input wire flash_write_ready,
    output reg [SENSOR_COUNT-1:0] fifo_read,
    output reg [DATA_WIDTH-1:0] flash_write_data,
    output reg [ADDR_WIDTH-1:0] flash_write_addr,
    output reg flash_write_start,
    output reg acquisition_done
);

    localparam IDLE = 2'b00;
    localparam WRITE_DATA = 2'b01;
    localparam WAIT_WRITE = 2'b10;

    reg [1:0] state;
    reg [SENSOR_COUNT-1:0] current_sensor;
    reg [ADDR_WIDTH-1:0] write_addr;
    reg [$clog2(SENSOR_COUNT)-1:0] sensor_index;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            current_sensor <= {SENSOR_COUNT{1'b0}};
            fifo_read <= {SENSOR_COUNT{1'b0}};
            flash_write_data <= {DATA_WIDTH{1'b0}};
            flash_write_addr <= {ADDR_WIDTH{1'b0}};
            flash_write_start <= 1'b0;
            acquisition_done <= 1'b0;
            write_addr <= {ADDR_WIDTH{1'b0}};
            sensor_index <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start_acquisition) begin
                        state <= WRITE_DATA;
                        current_sensor <= 1;
                        acquisition_done <= 1'b0;
                    end
                end
                WRITE_DATA: begin
                    if (!fifo_empty[sensor_index] && flash_write_ready) begin
                        fifo_read[sensor_index] <= 1'b1;
                        flash_write_data <= fifo_data[sensor_index];
                        flash_write_addr <= write_addr;
                        flash_write_start <= 1'b1;
                        write_addr <= write_addr + 1;
                        state <= WAIT_WRITE;
                    end else begin
                        fifo_read[sensor_index] <= 1'b0;
                        sensor_index <= (sensor_index + 1) % SENSOR_COUNT;
                        if (sensor_index == SENSOR_COUNT - 1 && &fifo_empty) begin
                            state <= IDLE;
                            acquisition_done <= 1'b1;
                        end
                    end
                end
                WAIT_WRITE: begin
                    fifo_read <= {SENSOR_COUNT{1'b0}};
                    flash_write_start <= 1'b0;
                    if (flash_write_ready) begin
                        state <= WRITE_DATA;
                        sensor_index <= (sensor_index + 1) % SENSOR_COUNT;
                    end
                end
            endcase
        end
    end

endmodule