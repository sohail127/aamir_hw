module proc_control #(parameter ISA_DPTH=64) (
	input                             clk     , // Clock
	input                             rst_n   , // Asynchronous reset active low
	input      [$clog2(ISA_DPTH)-1:0] i_opcd  , // processor instruction
	output reg                        o_ir_e  ,
	output reg                        o_pc_e  ,
	output reg                        o_mem_we
);

// FSM for Control

// state Declaration
	localparam FETCH   = 0;
	localparam DECODE  = 1;
	localparam ADD_COMP = 2;
	localparam EXECUTE = 3;

// state registers
	reg [2:0] current_state;
	reg [2:0] next_state   ;

// state initialization
	always@(posedge clk) begin
		if (!rst_n) begin
			current_state <= FETCH;
		end
		else
			current_state <= next_state;
	end

// state tranisiton decodre table here
	always@(current_state) begin
		case(current_state)
			FETCH   : begin
				next_state = DECODE;
			end
			DECODE  : begin
				case (i_opcd[5:0])
					6'b100011:	next_state = ADD_COMP; // lw : load word
          6'b101011:	next_state = ADD_COMP; // sw : store word
          default : next_state =FETCH;
				endcase
			end
			ADD_COMP: begin
			end
			EXECUTE : begin
			end
			default : next_state = FETCH;
		endcase
	end
// state out decoder
	always@(current_state) begin
		case(current_state)
			FETCH   : begin
				o_ir_e 	 = 1'b1;
				o_pc_e 	 = 1'b1;
				o_mem_we = 1'b0;
			end
			DECODE  : begin
			end
			EXECUTE : begin
			end
			default : next_state = FETCH;
		endcase
	end
endmodule : proc_control