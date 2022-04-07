module tb_cu_sha ();

	localparam CLK_PRD = 10;
//--******** Signal Declaration *******************--//
	reg  usr_clk    ; // system clock signal
	reg  usr_reset_n; // system global reset_n active low logic
	reg  i_start    ; // To start calculating hash just as enable
	reg  i_cnt_flag ; // FSM state driver flag from counter
	wire o_cnt_en   ; // counter enable signal as output
	wire o_valid    ;
	wire sel_1      ;

	cu_sha DUT (
		.usr_clk    (usr_clk    ), // system clock signal
		.usr_reset_n(usr_reset_n), // system global reset_n active low logic
		.i_start    (i_start    ), // To start calculating hash just as enable
		.i_cnt_flag (i_cnt_flag ), // FSM state driver flag from counter
		.o_cnt_en   (o_cnt_en   ), // counter enable signal as .
		.o_valid    (o_valid    ),
		.sel_1      (sel_1      )
	);

	//--******* Define clock here --**************************//
	initial usr_clk = 1'b1;
	always # (CLK_PRD/2) usr_clk= ! usr_clk;

	//--******** Start Stimulus ***************--//
	initial
		begin
			usr_reset_n=1'b0;
			i_start=1'b0;
			#1	$display ("\n");
			$display ("//--******** Start Stimulus ***************--// \n");
			$display ("//--******** System Inputs ***************--// \n");
			$display ("	Reset_Value |	Start	|	Counter_Flag");
			$display ("		%b		|  	%b		|		%b	", usr_reset_n, i_start,i_cnt_flag);
			$display ("\n");
			$display ("//--******** System Outputs ***************--// \n");
			$display("Counter_enable	|	o_valid		|	Mux_sel	");
			$display("	%b			|		%b		|		%b	", o_cnt_en, o_valid,sel_1);

			#14
				usr_reset_n=1'b1;
			i_start=1'b1;
			$display ("//--******** System Inputs ***************--// \n");
			$display ("	Reset_Value |	Start	|	Counter_Flag");
			$display ("		%b		|  	%b		|		%b	", usr_reset_n, i_start,i_cnt_flag);
			$display ("\n");
			$display ("//--******** System Outputs ***************--// \n");
			$display("Counter_enable	|	o_valid		|	Mux_sel	");
			$display("	%b			|		%b		|		%b	", o_cnt_en, o_valid,sel_1);
		end
//--************** For loop base stimulus --**************************//
	integer i = 0;
	initial
		begin

			for (i=0; i<64;)
				if (i==63)
					begin
						#5	i_cnt_flag = 1'b1;
						i=63;
						$display ("//--******** System Inputs ***************--// \n");
						$display ("	Reset_Value |	Start	|	Counter_Flag");
						$display ("		%b		|  	%b		|		%b	", usr_reset_n, i_start,i_cnt_flag);
						$display ("//--******** System Outputs ***************--// \n");
						$display("Counter_enable	|	o_valid		|	Mux_sel	");
						$display("	%b			|		%b		|		%b	", o_cnt_en, o_valid,sel_1);
						#10
							if (i_cnt_flag==1'b1)
								begin
									$display ("//--******** System Outputs ***************--// \n");
									$display("Counter_enable	|	o_valid		|	Mux_sel	");
									$display("	%b			|		%b		|		%b	", o_cnt_en, o_valid,sel_1);
									$display ("\n Simulation Test is passed!\n");
									$finish;
								end
						else $display("Simulation in process!");
					end
			else
				begin
					# 5 i_cnt_flag = 1'b0;
					#5	i=i+1;
					$display ("Counter is running with value %d :" , i);
				end
		end

endmodule // tb_cu_sha	