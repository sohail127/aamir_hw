module proc_top #(
	parameter INST_WIDTH = 5   ,
	parameter DATA_WIDTH = 32  ,
	parameter MEM_DEPTH  = 1024,
	parameter ISA_DPTH   = 64  ,
	parameter MUX_SEL_SZ = 2   ,
	parameter PC_START   = 128 ,
	parameter REG_DPTH   = 32
) (
	input clk  , // Clock
	input rst_n  // Asynchronous reset active low
);

// internal signals here as wires
	wire [$clog2(ISA_DPTH)-1:0] w_opcd  ;
	wire                        w_ir_e  ;
	wire                        w_pc_e  ;
	wire                        w_mem_we;

// proc controller instantiation
	proc_control #(.ISA_DPTH(ISA_DPTH)) CU (
		.clk     (clk     ), // input                   clk     , // Clock
		.rst_n   (rst_n   ), // input                   rst_n   , // Asynchronous reset active low
		.i_opcd  (w_opcd  ), // input    [$clog2(ISA_DPTH)-1:0] i_opcd  , // processor instruction
		.o_ir_e  (w_ir_e  ), // output                  o_ir_e  ,
		.o_pc_e  (w_pc_e  ), // output                  o_pc_e  ,
		.o_mem_we(w_mem_we)  // output                  o_mem_we
	);

// proc data path here
	proc_data_pth #(
		.INST_WIDTH(INST_WIDTH),
		.DATA_WIDTH(DATA_WIDTH),
		.MEM_DEPTH (MEM_DEPTH ),
		.ISA_DPTH  (ISA_DPTH  ),
		.MUX_SEL_SZ(MUX_SEL_SZ),
		.PC_START  (PC_START  )
	) DP (
		.clk     (clk     ), // input                         clk     , // Clock
		.rst_n   (rst_n   ), // input                         rst_n   , // Asynchronous reset active low
		.i_ir_e  (w_ir_e  ), // input                         i_ir_e  ,
		.i_pc_e  (w_pc_e  ), // input                         i_pc_e  ,
		.i_mem_we(w_mem_we), // input                         i_mem_we,
		.O_opcd  (w_opcd  )  // output [$clog2(ISA_DPTH)-1:0] O_opcd
	);


endmodule : proc_top