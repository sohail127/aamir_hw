module puf_soc_ro_bank #(
	parameter PUF_LENGTH   = 16,
	parameter NO_PUF_STAGE = 24
) (
	input  [PUF_LENGTH-1:0] i_puf_en, // i_puf_en
	output [PUF_LENGTH-1:0] o_puf_ro
);

	genvar ii;
// Instantiation of puf ro
	generate
		for ( ii = 0; ii < PUF_LENGTH; ii= ii + 1 ) begin
			puf_soc_ro #(.N_STAGE(NO_PUF_STAGE))
				inst_puf_soc_ro(
					.i_en (i_puf_en[ii]),
					.o_ro (o_puf_ro[ii])
				);
		end
	endgenerate

endmodule : puf_soc_ro_bank