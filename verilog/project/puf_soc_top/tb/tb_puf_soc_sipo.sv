module tb_puf_soc_sipo ();
//********************************************************************************
// ** Parameters here
//********************************************************************************
	parameter       N_BIT     = 40;
	parameter       CLK_PRD   = 10;
	reg [N_BIT-1:0] data_buff = 0 ;

//********************************************************************************
// ** Outputs are wire
//********************************************************************************
	wire [N_BIT-1:0] o_rx_data ;
	wire             o_rx_ready;
	wire             o_rx_valid;
//********************************************************************************
// ** Inputs as reg
//********************************************************************************
	reg clk       ;
	reg rst_n     ;
	reg i_rx_valid;
	reg i_rx_data ;
	reg i_rx_ready;
//********************************************************************************
// ** Module instantiation
//********************************************************************************

	puf_soc_sipo #(.N_BIT(N_BIT)) DUT (
		.clk       (clk       ), // input              clk    	 , // Clock
		.rst_n     (rst_n     ), // input              rst_n  	 , // Asynchronous reset active low
		.i_rx_ready(i_rx_ready), // input              i_rx_ready, // Actve High to read parallel data
		.i_rx_valid(i_rx_valid), // input              i_rx_valid, // Actve High fo valid
		.i_rx_data (i_rx_data ), // input              i_rx_data , // Serial Dat input
		.o_rx_ready(o_rx_ready), // output             o_rx_ready, // active high
		.o_rx_valid(o_rx_valid), // output             o_rx_valid  // active high
		.o_rx_data (o_rx_data )  // output [N_BIT-1:0] o_rx_data , // Serial Dat input
	);

// clock generation
	initial clk = 1'b1;
	always #((CLK_PRD/2)) clk = ~clk;

//********************************************************************************
// ** Reset Task
//********************************************************************************
	task sys_rst();
		rst_n   = {$bits(rst_n  ){1'b0}};
		i_rx_valid = {$bits(i_rx_valid){1'b0}};
		i_rx_data 	= {$bits(i_rx_data ){1'b0}};
		i_rx_ready = {$bits(i_rx_ready){1'b0}};
		// assert reset for 5 clock cycles
		repeat (5) begin
			@(posedge clk) ;
		end
		@(posedge clk);
		rst_n 	= 1'b1;
		@(posedge clk);
	endtask : sys_rst
//********************************************************************************
// ** generate data
//********************************************************************************
	task gen_data();
		
		wait (o_rx_ready) begin
			for (int i = 0; i < N_BIT; i++) begin
				// if (o_ready) begin
				@(posedge clk);
				i_rx_valid  = 1'b1 		 ;
				i_rx_data 	 = $random();
				$display("Serial Input:____ %b for index:____ %d",i_rx_data,i);
				data_buff = {i_rx_data,data_buff[N_BIT-1:1]};
				// end
			end
		end
		// #1000 i_ready = 1'b1;
	endtask : gen_data
//********************************************************************************
// ** generate data
//********************************************************************************
	task sys_checker();
		forever begin
			@(posedge clk);
			if (o_rx_valid) begin
				if (o_rx_data==data_buff) begin
					$display("***********************************************************************************");
					$display("________________________________ TEST PASSED ______________________________________");
					$display("Expected output:______%b  ************* Actual output:_________ %b",data_buff,o_rx_data);
					$display("***********************************************************************************");
					break;
				end
				else begin
					$display("***********************************************************************************");
					$display("________________________________ TEST FAILED ______________________________________");
					$display("Expected output:______%b  ************* Actual output:_________ %b",data_buff,o_rx_data);
					$display("***********************************************************************************");
					repeat(5) begin
						@(posedge clk);
					end
					break;
				end
			end
		end
	endtask : sys_checker
//********************************************************************************
// ** back_pressure
//********************************************************************************
task hold_data();
	@(posedge clk);
	i_rx_ready = 1'b1;
	if (o_rx_ready) begin
		repeat (N_BIT-2) begin
			@(posedge clk);
		end
	end
	i_rx_ready = 1'b0;
	repeat (5) begin
			@(posedge clk);
		end
	i_rx_ready = 1'b1;
endtask : hold_data
//********************************************************************************
// run_test
//********************************************************************************
	initial begin
		sys_rst();
		fork
			// Thread 1
			begin
				gen_data();
			end
			// Thread 2
			begin
				sys_checker();
			end
			// Thread 3
			begin
				hold_data();
			end
		join
		$stop();
	end
endmodule : tb_puf_soc_sipo