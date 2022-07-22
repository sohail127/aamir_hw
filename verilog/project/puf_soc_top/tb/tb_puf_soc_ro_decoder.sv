module tb_puf_soc_ro_decoder ();
//********************************************************************************
// ** Parameters Declaration
//********************************************************************************
	parameter MUX_LENGTH   = 16 ;
	int o_puf_en_q [$];
	int odd_prty;
	int evn_prty;
//********************************************************************************
// ** Inputs are reg
//********************************************************************************
	reg 												 clk 				 ;
	reg 												 rst_n 			 ;
	reg                          i_dcod_en 	 ;  
	reg [$clog2(MUX_LENGTH)-1:0] i_sel_mux_0 ;
	reg [$clog2(MUX_LENGTH)-1:0] i_sel_mux_1 ;
//********************************************************************************
// ** outputs are wire
//********************************************************************************
	wire [        MUX_LENGTH-1:0] o_puf_en ;
//********************************************************************************
// ** DUT initialization
//********************************************************************************

puf_soc_ro_decoder #(.MUX_LENGTH(MUX_LENGTH)) DUT(
	.clk        (clk        ), // input 															clk 			 ,
	.rst_n      (rst_n 			), // input 															rst_n 		 ,
	.i_dcod_en  (i_dcod_en  ), // input                               i_dcod_en  ,
	.i_sel_mux_0(i_sel_mux_0), // input      [$clog2(MUX_LENGTH)-1:0] i_sel_mux_0,
	.i_sel_mux_1(i_sel_mux_1), // input      [$clog2(MUX_LENGTH)-1:0] i_sel_mux_1,
	.o_puf_en   (o_puf_en   )  // output reg [        MUX_LENGTH-1:0] o_puf_en    
);

//********************************************************************************
// ** generate clock here
//********************************************************************************
	initial clk = 1'b1;
	always #(5) clk = ~ clk;
//********************************************************************************
// ** reset
//********************************************************************************
task sys_rst();
	repeat(5) begin
	  rst_n   		= {$bits(rst_n   ){1'b0}};  
	  i_dcod_en   = {$bits(i_dcod_en   ){1'b0}};  
		i_sel_mux_0 = {$bits(i_sel_mux_0 ){1'b0}}; 
		i_sel_mux_1 = {$bits(i_sel_mux_1 ){1'b0}}; 
		@(posedge clk);
	end
endtask : sys_rst

//********************************************************************************
// ** reset
//********************************************************************************

task gen_data();
	i_dcod_en   = 1'b1; 
	rst_n   		= 1'b1; 
	for (int ii = 0; ii < MUX_LENGTH; ii++) begin
		for (int jj = 0; jj < MUX_LENGTH; jj++) begin
			@(posedge clk);
			i_sel_mux_0 = ii;
			i_sel_mux_1 = jj;
			$display("o_puf_en::_______ %b i_sel_mux_0::_____ %d i_sel_mux_1::_____ %d", o_puf_en, i_sel_mux_0, i_sel_mux_1);
			o_puf_en_q.push_back(o_puf_en);
		end
	end
endtask : gen_data

//********************************************************************************
// ** reset
//********************************************************************************
task parity_chk();
	bit o_par;
	bit [15:0] par_pop;
	$display("Size of Queue is %d",o_puf_en_q.size());
	while(o_puf_en_q.size()>0) begin
		par_pop = o_puf_en_q.pop_front();
		o_par = ^ par_pop;
		$display("data %b and parity %d",par_pop,o_par);
		if (o_par) begin
			// $display("Error!!! even parity");
			odd_prty++;
		end else begin
			evn_prty++;
			// $display("Error!!! odd parity");
		end
	#1;	
	end
endtask : parity_chk

//********************************************************************************
// ** run_test
//********************************************************************************
	initial begin
		sys_rst() ;
		gen_data();
		parity_chk();
		$display("*************************************************************************");
		$display("**************_____________Test Statistics_________**********************");
		$display("****odd_parity: %d ****** even_parity: %d ********************",odd_prty,evn_prty);
		if(odd_prty=='d16) begin
			$display("*************************************************************************");
			$display("**********_________________TEST PASS!!!________________ *****************");
			$display("*************************************************************************");
		end else begin
			$display("*************************************************************************");
			$display("**********_________________TEST FAIL!!!________________ *****************");
			$display("*************************************************************************");
		end
		$display("*************************************************************************");
	$stop();
	end
endmodule : tb_puf_soc_ro_decoder
