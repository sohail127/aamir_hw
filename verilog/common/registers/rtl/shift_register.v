module shift_register #(parameter BUS_WIDTH=32) (
	input                  clk       , // clock
	input                  rst_n     , // active low reset
	input                  i_ld_data , // 1: to load data
	input                  i_sht_lr  , // shift_lr : 1 for right shift, 0: for left shift
	input  [BUS_WIDTH-1:0] i_reg_data, // register data
	output                 o_busy    , // 1: when shifiting
	output                 o_shift   , // serial output
	output                 o_valid     // 1: when output is valid
);

	// register declaration
	reg [        BUS_WIDTH-1:0] reg_data     ;
	reg [$clog2(BUS_WIDTH)-1:0] reg_shift_cnt; // shift counter
	reg                         reg_o_shift  ;
	reg                         reg_o_busy   ;
	reg                         reg_o_valid  ;
	// load and shift logic here
	always@(posedge clk) begin
		if (!rst_n) begin
			reg_data    <= {BUS_WIDTH{1'b0}};
			reg_o_busy  <= 1'b0;
			reg_o_valid <= 1'b0;
			reg_o_shift <= 1'b0;
		end
		else	begin
			if (i_ld_data) begin // laod data
				reg_data <= i_reg_data;
			end
			else	begin
				if (i_sht_lr) begin // 1: for righr shift
					if (reg_shift_cnt==BUS_WIDTH-1) begin // to check shift count
						reg_o_busy  <= 'b0;
						reg_o_valid <= 'b0;
					end
					else begin
						reg_o_shift <= reg_data[0];
						reg_data    <= {1'b0,reg_data[BUS_WIDTH-1:1]};// shift right
						reg_o_busy  <= 1'b1;
						reg_o_valid <= 1'b1;
					end
				end
				else	begin
					if (reg_shift_cnt==BUS_WIDTH-1) begin
						reg_o_busy  <= 'b0;
						reg_o_valid <= 'b0;
					end
					else begin
						reg_o_shift <= reg_data[BUS_WIDTH-1];
						reg_data    <= {reg_data[BUS_WIDTH-2:0],1'b0}; /*{1'b0,reg_data[BUS_WIDTH-1:1]}*/// shift left
						reg_o_busy  <= 1'b1;
						reg_o_valid <= 1'b1;
					end
				end
			end
		end
	end

	// shifting counter logic here
	always@(posedge clk) begin
		if (!rst_n | i_ld_data) begin
			reg_shift_cnt <= {$clog2(BUS_WIDTH){1'b0}};
		end
		else begin
			if (reg_o_valid) begin
				if (reg_shift_cnt != BUS_WIDTH-1) begin
					reg_shift_cnt <= reg_shift_cnt+1;
				end
			end
		end
	end

	assign o_busy  = reg_o_busy  ;
	assign o_valid = reg_o_valid ;
	assign o_shift = reg_o_shift ;

endmodule