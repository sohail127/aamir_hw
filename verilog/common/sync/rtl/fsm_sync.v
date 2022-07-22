module fsm_sync 
	#(parameter DWIDTH=32)(
	input                   i_src_clk  , // Clock
  input                   i_dst_clk  , // Clock
  input                   rst_n      , // Asynchronous reset active low
  input      [DWIDTH-1:0] i_src_data ,
  input                   i_src_puls,
  output reg [DWIDTH-1:0] o_dst_data ,
  output                  o_dst_ready,
  output reg              o_dst_valid  // Not required, additionaly added for understanding
	);
	
	wire w_src_req			;	
	wire w_src_req_dbl_ff;
	
	//Request FSM
	parameter SRC_READY = 0;
	parameter SRC_BUSY  = 1;
	
	// Acknowledge FSM
	parameter DST_READY = 0;
	parameter DST_BUSY  = 1;

// state registers for FSMs
	reg current_src_state ; 
	reg next_src_state    ; 
	reg current_dst_state ; 
	reg next_dst_state    ; 

// state initilaization for Requeset FSM
always @(posedge i_src_clk or negedge rst_n) begin 
	if(~rst_n) begin
		current_src_state <= SRC_READY;
	end else begin
		current_src_state <= next_src_state;
	end
end

// state initilaization for ACK FSM
always @(posedge i_dst_clk or negedge rst_n) begin 
	if(~rst_n) begin
		current_dst_state <= DST_READY;
	end else begin
		current_dst_state <= next_dst_state;
	end
end

// state decoder for Request FSM
always@(current_src_state,i_src_puls,req_ack_dst) begin
case (current_src_state)
		SRC_READY : begin
			if (i_src_puls) begin
				next_src_state = SRC_BUSY;
			end else begin
				next_src_state = SRC_READY;
			end
		end
		SRC_BUSY  : begin
			if (req_ack_dst) begin
				next_src_state = SRC_READY;
			end else begin
				next_src_state = SRC_BUSY;
			end
		end
	default : next_src_state = SRC_READY;
endcase
end
// state decoder for ACK FSM
always@(current_dst_state,i_src_puls,req_ack_dst) begin
case (current_dst_state)
		DST_READY : begin
			if (w_src_req_dbl_ff) begin
				next_dst_state = DST_BUSY;
			end else begin
				next_dst_state = DST_READY;
			end
		end
		DST_BUSY  : begin
			next_dst_state = DST_READY;
			// if (req_ack_dst) begin
			// 	next_dst_state = DST_READY;
			// end else begin
			// 	next_dst_state = DST_BUSY;
			end
		end
	default : next_dst_state = SRC_READY;
endcase
end
 w_src_req = current_src_state;

// passing pulse to 2-FF sync at destination clock
	m_ff_sync #(.NUM_FF(2)) inst_dst_m_ff_sync (
		.clk   (i_dst_clk   		), // input  clk   ,
		.rst_n (rst_n       		), // input  rst_n ,
		.i_data(w_src_req				), // input  i_data,
		.o_data(w_src_req_dbl_ff)  // output o_data
	);

// feedback loop for sync at source domain
// passing pulse to 2-FF sync at destination clock
	m_ff_sync #(.NUM_FF(2)) inst_src_m_ff_sync (
		.clk   (i_src_clk   ), // input  clk   ,
		.rst_n (rst_n       ), // input  rst_n ,
		.i_data(w_dst_dbl_ff), // input  i_data,
		.o_data(w_src_dbl_ff)  // output o_data
	);


endmodule : fsm_sync