//********************************************************************************
// Define MACRO
//********************************************************************************
// populate expected data q
`define PUSH_Q(VAL) 								 							 		\
	o_mux_q.push_back(i_data_``VAL);								 		\
	`ifdef DEBUG										 										\
		$display("data_value pushed is: %d",i_data_``VAL);\
	`endif

module tb_puf_soc_mux ();

//********************************************************************************
// ** Parameters here
//********************************************************************************
	parameter N_BIT  = 1 ;
	parameter MUX_SZ = 16;

// Queues to store inputs
	int i_sel_q[$];
	int o_mux_q[$];

	int match    = 0;
	int mismatch = 0;
//********************************************************************************
// ** Outputs are wire
//********************************************************************************
	wire [N_BIT-1:0] o_mux;
//********************************************************************************
// ** Inputs as reg
//********************************************************************************
	reg [         N_BIT-1:0] i_data_0 ;
	reg [         N_BIT-1:0] i_data_1 ;
	reg [         N_BIT-1:0] i_data_2 ;
	reg [         N_BIT-1:0] i_data_3 ;
	reg [         N_BIT-1:0] i_data_4 ;
	reg [         N_BIT-1:0] i_data_5 ;
	reg [         N_BIT-1:0] i_data_6 ;
	reg [         N_BIT-1:0] i_data_7 ;
	reg [         N_BIT-1:0] i_data_8 ;
	reg [         N_BIT-1:0] i_data_9 ;
	reg [         N_BIT-1:0] i_data_10;
	reg [         N_BIT-1:0] i_data_11;
	reg [         N_BIT-1:0] i_data_12;
	reg [         N_BIT-1:0] i_data_13;
	reg [         N_BIT-1:0] i_data_14;
	reg [         N_BIT-1:0] i_data_15;
	reg [$clog2(MUX_SZ)-1:0] i_sel_mux;
//********************************************************************************
// ** Module instantiation
//********************************************************************************
	puf_soc_mux #(
		.N_BIT (N_BIT ),
		.MUX_SZ(MUX_SZ)
	) DUT (
		.i_data_0 (i_data_0 ), // input      [         N_BIT-1:0] i_data_0 ,
		.i_data_1 (i_data_1 ), // input      [         N_BIT-1:0] i_data_1 ,
		.i_data_2 (i_data_2 ), // input      [         N_BIT-1:0] i_data_2 ,
		.i_data_3 (i_data_3 ), // input      [         N_BIT-1:0] i_data_3 ,
		.i_data_4 (i_data_4 ), // input      [         N_BIT-1:0] i_data_4 ,
		.i_data_5 (i_data_5 ), // input      [         N_BIT-1:0] i_data_5 ,
		.i_data_6 (i_data_6 ), // input      [         N_BIT-1:0] i_data_6 ,
		.i_data_7 (i_data_7 ), // input      [         N_BIT-1:0] i_data_7 ,
		.i_data_8 (i_data_8 ), // input      [         N_BIT-1:0] i_data_8 ,
		.i_data_9 (i_data_9 ), // input      [         N_BIT-1:0] i_data_9 ,
		.i_data_10(i_data_10), // input      [         N_BIT-1:0] i_data_10,
		.i_data_11(i_data_11), // input      [         N_BIT-1:0] i_data_11,
		.i_data_12(i_data_12), // input      [         N_BIT-1:0] i_data_12,
		.i_data_13(i_data_13), // input      [         N_BIT-1:0] i_data_13,
		.i_data_14(i_data_14), // input      [         N_BIT-1:0] i_data_14,
		.i_data_15(i_data_15), // input      [         N_BIT-1:0] i_data_15,
		.i_sel_mux(i_sel_mux), // input      [$clog2(MUX_SZ)-1:0] i_sel_mux,
		.o_mux    (o_mux    )  // output reg [         N_BIT-1:0] o_mux
	);


//********************************************************************************
// task generate data
//********************************************************************************
	task gen_data();
		begin
			$display("***********___Generate Data__****************");
			i_data_0  = $random();
			i_data_1  = $random();
			i_data_2  = $random();
			i_data_3  = $random();
			i_data_4  = $random();
			i_data_5  = $random();
			i_data_6  = $random();
			i_data_7  = $random();
			i_data_8  = $random();
			i_data_9  = $random();
			i_data_10 = $random();
			i_data_11 = $random();
			i_data_12 = $random();
			i_data_13 = $random();
			i_data_14 = $random();
			i_data_15 = $random();
			// For Debugging
			`ifdef DEBUG
				begin
					$display("******____i_data_0______****** %d",i_data_0);
					$display("******____i_data_1______****** %d",i_data_1);
					$display("******____i_data_2______****** %d",i_data_2);
					$display("******____i_data_3______****** %d",i_data_3);
					$display("******____i_data_4______****** %d",i_data_4);
					$display("******____i_data_5______****** %d",i_data_5);
					$display("******____i_data_6______****** %d",i_data_6);
					$display("******____i_data_7______****** %d",i_data_7);
					$display("******____i_data_8______****** %d",i_data_8);
					$display("******____i_data_9______****** %d",i_data_9);
					$display("******____i_data_10_____****** %d",i_data_10);
					$display("******____i_data_11_____****** %d",i_data_11);
					$display("******____i_data_12_____****** %d",i_data_12);
					$display("******____i_data_13_____****** %d",i_data_13);
					$display("******____i_data_14_____****** %d",i_data_14);
					$display("******____i_data_15_____****** %d",i_data_15);
				end
			`endif
			// push input data into q
			`PUSH_Q(0);
			`PUSH_Q(1);
			`PUSH_Q(2);
			`PUSH_Q(3);
			`PUSH_Q(4);
			`PUSH_Q(5);
			`PUSH_Q(6);
			`PUSH_Q(7);
			`PUSH_Q(8);
			`PUSH_Q(9);
			`PUSH_Q(10);
			`PUSH_Q(11);
			`PUSH_Q(12);
			`PUSH_Q(13);
			`PUSH_Q(14);
			`PUSH_Q(15);

			//Generate select inputs
			for (int i = 0; i < MUX_SZ; i++) begin
				i_sel_mux = i;
				i_sel_q.push_back(i);
				`ifdef DEBUG
					$display("***********___Mux Select Value is__:**************** %d",i_sel_mux);
				`endif
				#1;
			end
		end
	endtask : gen_data

//********************************************************************************
// task checker data00
//********************************************************************************
	task sim_checker();
		int exp_out	 ;
		int exp_sel	 ;
		int trans_cnt;
		$display("***********___Simulation Checker__*******************************************");
		forever begin
			// check size of queue
			wait (i_sel_q.size()>0) begin
				exp_out = o_mux_q.pop_front();
				exp_sel = i_sel_q.pop_front();
				#0.5;
				if (o_mux == exp_out) begin
					++match;
					`ifdef DEBUG
						$display("*[MATCH]______ %d *****___EXP_DATA: %d___*** ___RCV_DATA: %d___***",match,exp_out,o_mux);
					`endif
				end else begin
					++mismatch;
					`ifdef DEBUG
						$display("*[MISMATCH]___ %d *****___EXP_DATA: %d___*** ___RCV_DATA: %d___***",mismatch,exp_out,o_mux);
					`endif
				end
			end
			trans_cnt = match + mismatch;
			if (trans_cnt==16) begin
				break;
			end
		end
		if (mismatch>0) begin
			$display("*****************************************************************************");
			$display("_____________________________ TEST FAILED ___________________________________");
			$display("******__Matches____::%d **********__MisMatches____::%d: ******",match,mismatch);
			$display("*****************************************************************************");
		end else begin
			$display("*****************************************************************************");
			$display("_____________________________ TEST PASSED ___________________________________");
			$display("*****************************************************************************");
			$display("******__Matches____::%d  *******__MisMatches____::%d******    ",match,mismatch);
			$display("*****************************************************************************");
		end
	endtask : sim_checker


//********************************************************************************
// run_test
//********************************************************************************
	initial begin
		$display("***********___Start Simulation__**********************************************");

		fork
			// Thread 1
			begin : Generate_Data
				$display("***********___Thread 1__*****************************************************");
				gen_data();
			end 	: Generate_Data
			// Thread 2
			begin : Scorebod
				$display("***********___Thread 2__****************************************************");
				sim_checker();
			end 	: Scorebod
		join


		$display("*******************************************************************************");
		$display("_____________________________ END SIMULATION ___________________________________");
		$display("*******************************************************************************");

	end

endmodule // tb_puf_soc_mux