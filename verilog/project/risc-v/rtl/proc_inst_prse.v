module proc_inst_prse #(parameter INST_WIDTH=5) (
	input  [2**INST_WIDTH-1:0] i_inst_prse,
	output [   INST_WIDTH-1:0] o_inst_opcd
);
	assign o_inst_opcd = i_inst_prse [31:26];
endmodule

// input [31:0] inst,
// output [5:0] opcode,
// output [5:0] funct,
// output [4:0] rs, rt, rd,
// output [15:0] imm,
// output [4:0] shamt,
// output [25:0] jtarget
// );

// assign opcode[5:0] = inst[31:26];
// assign rs[4:0] = inst[25:21];
// assign rt[4:0] = inst[20:16];
// assign rd[4:0] = inst[15:11];
// assign shamt[4:0] = inst[10:6];
// assign funct[5:0] = inst[5:0];
// assign imm[15:0] = inst[15:0];
// assign jtarget[25:0] = inst[25:0];