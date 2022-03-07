module proc_data_pth #(
	parameter INST_WIDTH = 5   ,
	parameter DATA_WIDTH = 32  ,
	parameter MEM_DEPTH  = 1024,
	parameter ISA_DPTH   = 64  ,
	parameter MUX_SEL_SZ = 2   ,
	parameter PC_START   = 128 ,
	parameter REG_DPTH   = 32
) (
	input                         clk     , // Clock
	input                         rst_n   , // Asynchronous reset active low
	input                         i_ir_e  ,
	input                         i_pc_e  ,
	input                         i_mem_we,
	output [$clog2(ISA_DPTH)-1:0] O_opcd
);

// Internal Signals here
	wire [2**INST_WIDTH-1:0] w_inst_prse;
	wire [   DATA_WIDTH-1:0] w_mux_data ;
	wire [   DATA_WIDTH-1:0] w_mem_data ;

// proc instruction parser here
	proc_inst_prse #(.INST_WIDTH(INST_WIDTH)) PRSE (
		.i_inst_prse(w_inst_prse), //  input  [2**INST_WIDTH-1:0] i_inst_prse,
		.o_inst_opcd(O_opcd     )  //  output [   INST_WIDTH-1:0] o_inst_opcd,
	);

// Mux instatiation here
	proc_mux #(
		.DATA_WIDTH(DATA_WIDTH),
		.MUX_SEL_SZ(MUX_SEL_SZ)
	) DATA_MUX (
		.i_mux_data_a(w_mem_data), // input [DATA_WIDTH-1:0] i_mux_data_a,
		.i_mux_data_b(          ), // input [DATA_WIDTH-1:0] i_mux_data_b,
		.i_mux_data_c(          ), // input [DATA_WIDTH-1:0] i_mux_data_c,
		.i_mux_data_d(          ), // input [DATA_WIDTH-1:0] i_mux_data_d,
		.i_mux_sel   (          ), // input [MUX_SEL_SZ-1:0] i_mux_sel
		.o_mux_data  (w_mux_data)  // input [DATA_WIDTH-1:0] o_mux_data
	);
// Instruction register initialization here
	proc_reg #(.DATA_WIDTH(DATA_WIDTH)) IR (
		.clk       (clk        ), // input                   clk      , // Clock
		.rst_n     (rst_n      ), // input                   rst_n    , // Asynchronous reset active low
		.i_reg_en  (i_ir_e     ), // input                   i_reg_en  , // Clock Enable
		.i_reg_data(w_mux_data ), // input  [DATA_WIDTH-1:0] i_reg_data
		.o_reg_data(w_inst_prse)  // output [DATA_WIDTH-1:0] o_reg_data
	);
// Register file instantiation here
	proc_reg_file #(
		.BUS_WIDTH(DATA_WIDTH),
		.REG_DPTH (REG_DPTH )
	) RF (
		.clk        (clk  ), // input                         clk        , // Clock
		.rst_n      (rst_n), // input                         rst_n      , // Asynchronous reset active low
		.i_reg_we   (     ), // input                         i_reg_we   , // i_reg_we : 1 for write,
		.i_regw_add (     ), // input  [$clog2(REG_DPTH)-1:0] i_regw_add , // input register write address
		.i_rega_add (     ), // input  [$clog2(REG_DPTH)-1:0] i_rega_add ,
		.i_regb_add (     ), // input  [$clog2(REG_DPTH)-1:0] i_regb_add ,
		.i_reg_data (     ), // input  [       BUS_WIDTH-1:0] i_reg_data ,
		.o_rega_data(     ), // output [       BUS_WIDTH-1:0] o_rega_data,
		.o_regb_data(     )  // output [       BUS_WIDTH-1:0] o_regb_data
	);
// ALU instantiation here
	proc_alu #(
		.DATA_WIDTH(DATA_WIDTH),
		.ISA_DPTH  (ISA_DPTH  )
	) ALU (
		.i_opcode  (), // input  [$clog2(ISA_DPTH)-1:0] i_opcode  ,
		.i_data_a  (), // input  [      DATA_WIDTH-1:0] i_data_a  ,
		.i_data_b  (), // input  [      DATA_WIDTH-1:0] i_data_b  ,
		.o_data_alu()  // output [      DATA_WIDTH-1:0] o_data_alu
	);

// Memory instantiation
	proc_memory #(
		.DATA_WIDTH(DATA_WIDTH),
		.MEM_DEPTH (MEM_DEPTH )
	) PM (
		.clk       (clk       ), // input                          clk       , // Clock
		.i_mem_we  (i_mem_we  ), // input                          i_mem_we  , // i_mem_we : 1 to write
		.i_mem_add (          ), // input  [$clog2(MEM_DEPTH)-1:0] i_mem_add , // address to read and write
		.i_mem_data(          ), // input  [       DATA_WIDTH-1:0] i_mem_data, //  data to write
		.o_mem_data(w_mem_data)  // output [       DATA_WIDTH-1:0] o_mem_data  // read data
	);
// program counter here
	proc_pc #(
		.PC_START   (PC_START  ),
		.DATA_WIDTH (DATA_WIDTH)
	) PC(
		.clk     (clk  ) ,//  input                    clk    , // Clock
		.rst_n   (rst_n) ,//  input                    rst_n  , // Asynchronous reset active low
		.i_ld_pc () ,//  input                    i_ld_pc,
		.i_pc    () ,//  input  [DATA_WIDTH-1:0]  i_pc   ,
		.o_pc    () //  output [DATA_WIDTH-1:0]  o_pc
	);


endmodule : proc_data_pth