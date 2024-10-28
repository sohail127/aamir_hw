module fifo #(
    parameter WIDTH = 16,
    parameter DEPTH = 256
)(
    input wire clk,
    input wire rst_n,
    input wire write_en,
    input wire read_en,
    input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out,
    output wire full,
    output wire empty
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];
    reg [$clog2(DEPTH)-1:0] write_ptr, read_ptr;
    reg [$clog2(DEPTH):0] count;

    assign full = (count == DEPTH);
    assign empty = (count == 0);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            write_ptr <= 0;
            read_ptr <= 0;
            count <= 0;
            data_out <= 0;
        end else begin
            if (write_en && !full) begin
                mem[write_ptr] <= data_in;
                write_ptr <= write_ptr + 1;
                count <= count + 1;
            end

            if (read_en && !empty) begin
                data_out <= mem[read_ptr];
                read_ptr <= read_ptr + 1;
                count <= count - 1;
            end
        end
    end

endmodule