module puf_soc_mux #(
	parameter N_BIT  = 1 ,
	parameter MUX_SZ = 16
) (
	input      [         N_BIT-1:0] i_data_0 ,
	input      [         N_BIT-1:0] i_data_1 ,
	input      [         N_BIT-1:0] i_data_2 ,
	input      [         N_BIT-1:0] i_data_3 ,
	input      [         N_BIT-1:0] i_data_4 ,
	input      [         N_BIT-1:0] i_data_5 ,
	input      [         N_BIT-1:0] i_data_6 ,
	input      [         N_BIT-1:0] i_data_7 ,
	input      [         N_BIT-1:0] i_data_8 ,
	input      [         N_BIT-1:0] i_data_9 ,
	input      [         N_BIT-1:0] i_data_10,
	input      [         N_BIT-1:0] i_data_11,
	input      [         N_BIT-1:0] i_data_12,
	input      [         N_BIT-1:0] i_data_13,
	input      [         N_BIT-1:0] i_data_14,
	input      [         N_BIT-1:0] i_data_15,
	input      [$clog2(MUX_SZ)-1:0] i_sel_mux,
	output reg [         N_BIT-1:0] o_mux
);

always@(*) begin
	case (i_sel_mux)
		4'd0	   :  o_mux = i_data_0  ; 		
		4'd1	   :  o_mux = i_data_1  ;									
		4'd2	   :  o_mux = i_data_2  ;							
		4'd3	   :  o_mux = i_data_3  ;				
		4'd4	   :  o_mux = i_data_4  ;				
		4'd5	   :  o_mux = i_data_5  ;				
		4'd6	   :  o_mux = i_data_6  ;				
		4'd7	   :  o_mux = i_data_7  ;				
		4'd8	   :  o_mux = i_data_8  ;				
		4'd9	   :  o_mux = i_data_9  ;				
		4'd10    :  o_mux = i_data_10  ;					
		4'd11    :  o_mux = i_data_11  ;					
		4'd12    :  o_mux = i_data_12  ;					
		4'd13    :  o_mux = i_data_13  ;					
		4'd14    :  o_mux = i_data_14  ;					
		4'd15    :  o_mux = i_data_15  ;					
		default : o_mux = {N_BIT{1'b0}};
	endcase
end


endmodule // puf_soc_mux