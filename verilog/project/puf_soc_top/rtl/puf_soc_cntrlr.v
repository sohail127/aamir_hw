module puf_soc_cntrlr #(
	parameter MUX_LENGTH   = 16,
	parameter REG_BIT_SIZE = 40
) (
	input                                   clk          , // Clock
	input                                   rst_n        , // active low reset
	input                                   i_start      ,
	input                                   i_op_mode    ,
	input                                   i_rx_ready   ,
	input                                   i_rx_valid   ,
	input                                   i_rx_done    ,
	input      [          REG_BIT_SIZE-1:0] i_rx_data    ,
	input                                   i_exec_done  ,
	input                                   i_tx_done    ,
	output     [                       2:0] o_fsm_state  ,
	output reg                              o_dcod_ready ,
	output reg                              o_dcod_enable,
	output reg                              o_exec_enable,
	output reg                              o_tx_enable  ,
	output reg                              o_dump_enable,
	output reg [    $clog2(MUX_LENGTH)-1:0] o_sel_mux_0  ,
	output reg [    $clog2(MUX_LENGTH)-1:0] o_sel_mux_1  ,
	output reg [8*($clog2(MUX_LENGTH))-1:0] o_max_count  ,
	output reg 															o_sft_rst 
);

// state Declartion
	localparam RESET    = 3'b000; // 0
	localparam WAIT     = 3'b001; // 1
	localparam RECEIVE  = 3'b010; // 2
	localparam DECODE   = 3'b011; // 3
	localparam EXECUTE  = 3'b100; // 4
	localparam TRANSMIT = 3'b101; // 5
	localparam DUMP     = 3'b110; // 6
// state register declaration
	reg [             2:0] current_state;
	reg [             2:0] next_state   ;
	reg [             2:0] stack_pntr   ;
	reg                    isr_call     ;
	reg                    isr_done     ;
	reg [REG_BIT_SIZE-1:0] r_rx_data    ;

// state initilization
	always@(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			current_state <= RESET ;
		end else begin
			current_state <= next_state;
		end
	end

// state transition decoder
	always@(current_state or i_op_mode or i_start or i_rx_valid or i_rx_done or i_exec_done or i_tx_done or i_rx_ready or stack_pntr or isr_call or isr_done) begin
		case (current_state)
			RESET : begin
				if (i_start) begin
					next_state = WAIT;
				end
				else begin
					next_state = RESET;
				end
			end
			WAIT : begin
				if (i_op_mode) begin
					next_state = DUMP ;
				end
				else begin
					if (i_rx_valid & i_rx_ready) begin
						next_state = RECEIVE;
					end
					else begin
						next_state = WAIT;
					end
				end
			end
			RECEIVE : begin
				if (i_op_mode) begin
					next_state = DUMP ;
				end
				else begin
					if (i_rx_done) begin
						next_state = DECODE;
					end
					else begin
						next_state = RECEIVE;
					end
				end
			end
			DECODE : begin
				if (i_op_mode) begin
					next_state = DUMP;
				end else begin
					next_state = EXECUTE;
				end
			end
			EXECUTE : begin
				if (i_op_mode) begin
					next_state = DUMP ;
				end
				else begin
					if (i_exec_done) begin
						next_state = TRANSMIT;
					end else begin
						next_state = EXECUTE;
					end
				end
			end
			TRANSMIT : begin
				if (i_tx_done) begin
					// if (stack_pntr == EXECUTE & isr_call == 0) begin
					if (isr_call) begin
						next_state = DUMP;
					end else begin
						next_state = RESET ;
					end
				end  else begin
					next_state = TRANSMIT ;
				end
			end
			DUMP : begin
				if (isr_done) begin
					next_state = stack_pntr ;
				end else begin
					if (i_exec_done) begin
						next_state = TRANSMIT ;
					end else	begin
						next_state = DUMP ;
					end
				end
			end

			default : next_state = RESET ;
		endcase
	end

	// Output decoder
	// state transition decoder
	always@(*) begin
		case (current_state)
			RESET : begin
				o_dcod_ready  = 1'b0;
				o_dcod_enable = 1'b0;
				o_exec_enable = 1'b0;
				o_tx_enable   = 1'b0;
				o_dump_enable = 1'b0;
				o_sel_mux_0   = {$clog2(MUX_LENGTH){1'b0}};
				o_sel_mux_1   = {$clog2(MUX_LENGTH){1'b0}};
				o_max_count   = {8*($clog2(MUX_LENGTH)){1'b0}};
				o_sft_rst    	= 1'b1; 
			end
			WAIT : begin
				o_dcod_ready  = 1'b0;
				o_dcod_enable = 1'b0;
				o_exec_enable = 1'b0;
				o_tx_enable   = 1'b0;
				o_dump_enable = 1'b0;
				o_sel_mux_0   = r_rx_data[3:0];
				o_sel_mux_1   = r_rx_data[7:4];
				o_max_count   = r_rx_data[39:8];
				o_sft_rst    	= 1'b0; 
			end
			RECEIVE : begin
				o_dcod_ready  = 1'b1;
				o_dcod_enable = 1'b0;
				o_exec_enable = 1'b0;
				o_tx_enable   = 1'b0;
				o_dump_enable = 1'b0;
				o_sel_mux_0   = r_rx_data[3:0];
				o_sel_mux_1   = r_rx_data[7:4];
				o_max_count   = r_rx_data[39:8];
				o_sft_rst    	= 1'b0; 
			end
			DECODE : begin
				o_dcod_ready  = 1'b0;
				o_dcod_enable = 1'b1;
				o_exec_enable = 1'b0;
				o_tx_enable   = 1'b0;
				o_dump_enable = 1'b0;
				o_sel_mux_0   = r_rx_data[3:0];
				o_sel_mux_1   = r_rx_data[7:4];
				o_max_count   = r_rx_data[39:8];
				o_sft_rst    	= 1'b0; 
			end
			EXECUTE : begin
				o_dcod_ready  = 1'b0;
				o_dcod_enable = 1'b0;
				o_exec_enable = 1'b1;
				o_tx_enable   = 1'b0;
				o_dump_enable = 1'b0;
				o_sel_mux_0   = r_rx_data[3:0];
				o_sel_mux_1   = r_rx_data[7:4];
				o_max_count   = r_rx_data[39:8];
				o_sft_rst    	= 1'b0; 


			end
			TRANSMIT : begin
				o_dcod_ready  = 1'b0;
				o_dcod_enable = 1'b0;
				o_exec_enable = 1'b0;
				o_tx_enable   = 1'b1;
				o_dump_enable = 1'b0;
				o_sel_mux_0   = r_rx_data[3:0];
				o_sel_mux_1   = r_rx_data[7:4];
				o_max_count   = r_rx_data[39:8];
				o_sft_rst    	= 1'b0; 

			end
			DUMP : begin
				o_dcod_ready  = 1'b0;
				o_dcod_enable = 1'b0;
				o_exec_enable = 1'b0;
				o_tx_enable   = 1'b0;
				o_dump_enable = 1'b1;
				o_sel_mux_0   = r_rx_data[3:0];
				o_sel_mux_1   = r_rx_data[7:4];
				o_max_count   = r_rx_data[39:8];
				o_sft_rst    	= 1'b0; 

			end
			default : begin
				o_dcod_ready  = 1'b0;
				o_dcod_enable = 1'b0;
				o_exec_enable = 1'b0;
				o_tx_enable   = 1'b0;
				o_dump_enable = 1'b0;
				o_sel_mux_0   = {$clog2(MUX_LENGTH){1'b0}};
				o_sel_mux_1   = {$clog2(MUX_LENGTH){1'b0}};
				o_max_count   = {8*($clog2(MUX_LENGTH)){1'b0}};
				o_sft_rst    	= 1'b1; 
			end
		endcase
	end
	// fsm-state is passed as output
	assign o_fsm_state = current_state;

	// copy dump register values
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			stack_pntr <= 3'b000 ;
			isr_call   <= 1'b0 	 ;
		end else begin
			if (i_op_mode) begin
				stack_pntr <= current_state;
				isr_call   <= 1'b1 			;
			end else begin
				if (isr_done) begin
					isr_call   <= 1'b0 ;
					stack_pntr <= stack_pntr;
				end else begin
					isr_call   <= isr_call  ;
					stack_pntr <= stack_pntr;
				end
			end
		end
	end

// isr_done
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			isr_done <= 1'b0;
		end else begin
			if (i_tx_done & isr_call) begin
				isr_done <= 1'b1;
			end else begin
				isr_done <= 1'b0;
			end
		end
	end


// flop receiver data
	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			r_rx_data <= {REG_BIT_SIZE{1'b0}};
		end else begin
			if (i_rx_done) begin
				r_rx_data <= i_rx_data ;
			end else begin
				r_rx_data <= r_rx_data ;
			end
		end
	end
endmodule : puf_soc_cntrlr

