`timescale 1ns/1ps
module cu_sha (
	input      usr_clk    , // system clock signal
	input      usr_reset_n, // system global reset_n active low logic
	input      i_start    , // To start calculating hash just as enable
	input      i_cnt_flag , // FSM state driver flag from counter
	output reg o_cnt_en   , // counter enable signal as output
	output reg o_valid    ,
	output reg sel_1
);
	`include "msg_schdl_function.vh"
	`include "round_function.vh"
//--******** FSM here ***************--//

	//--*** STATE declaration **--//
	localparam IDLE  = 2'b00;
	localparam RESET = 2'b01;
	localparam BUSY  = 2'b10;
	localparam DONE  = 2'b11;
	//--*** STATE register **--//
	reg [1:0] current_state;
	reg [1:0] next_state   ;
	//--*** STATE initialization **--//
	always@(posedge usr_clk or negedge usr_reset_n) // asynchronus reset
		begin
			if (!usr_reset_n)
				begin
					current_state <= IDLE;
				end
			else
				begin
					current_state <= next_state;
				end
		end // always@(posedge usr_clk or usr_reset_n) // asynchronus reset

	//--*** STATE Transition **--//
	always@( current_state or i_start or i_cnt_flag)
		begin
			case (current_state)
				IDLE :
					next_state = RESET;
				RESET :
					if (i_start)
						next_state = BUSY;
				else
					next_state = RESET;
				BUSY :
					if (i_cnt_flag)
						next_state = DONE;
				else
					next_state = BUSY;
				DONE :
					next_state = IDLE;
				default :
					next_state = IDLE;
			endcase // case(current_state)
		end //always@(i_cnt_flag ,i_start,usr_reset_n)

	//--*** STATE Signal **--//
	always@ (*)
	begin
		case (current_state)
			IDLE :
				begin
					o_cnt_en = 1'b0;
					o_valid  = 1'b0;
					sel_1    = 1'b0;
				end
			RESET :
				begin
					o_cnt_en = 1'b0;
					o_valid  = 1'b0;
					sel_1    = 1'b0;
				end
			BUSY :
				begin
					o_cnt_en = 1'b1;
					o_valid  = 1'b0;
					sel_1    = 1'b0;

				end
			DONE :
				begin
					o_cnt_en = 1'b0;
					o_valid  = 1'b1;
					sel_1    = 1'b1;
				end
			default :
				begin
					o_cnt_en = 1'b0;
					o_valid  = 1'b0;
					sel_1    = 1'b0;
				end
		endcase //case (current_state)
	end // always@(*)
endmodule // cu_sha	