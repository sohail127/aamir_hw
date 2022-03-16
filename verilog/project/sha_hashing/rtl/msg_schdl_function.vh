function [31:0] alpha_0(input [31:0] a);
   reg [31:0] rot_1;
   reg [31:0] rot_8;
   reg [31:0] rot_7;
   
   begin
      rot_1={a[6:0],a[31:7]};
      rot_8={a[17:0],a[31:18]};
      rot_7={3'b000,a[31:3]};
      
      alpha_0=rot_1 ^ rot_8 ^ rot_7;
   end
   
      
   
endfunction // alpha_0

function [31:0] alpha_1 (input [31:0] w);
   reg [31:0] rot_19;
   reg [31:0] rot_61;
   reg [31:0] rot_6;
   
   begin
      rot_19={w[16:0],w[31:17]};
      rot_61={w[18:0],w[31:19]};
      rot_6={10'b0000000000,w[31:10]};

      alpha_1=rot_19 ^ rot_61 ^ rot_6;
   end
endfunction // alpha_1


function [31:0] cs_4 (input [31:0] i_a,i_b,i_c,i_d);

	cs_4=i_a + i_b + i_c + i_d ;
	
endfunction