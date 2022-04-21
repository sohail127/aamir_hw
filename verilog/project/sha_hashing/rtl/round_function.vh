
  function [31:0] ch (input [31:0] e,f,g);
    reg [31:0] e_and_f;
    reg [31:0] not_e_and_g;
    begin
      e_and_f = e & f;
      not_e_and_g = ~e & g;

      ch = e_and_f ^ not_e_and_g;
    end
  endfunction // ch

  function [31:0] maj (input [31:0] a,b,c);
    reg [31:0]        a_and_b;
    reg [31:0]       a_and_c;
    reg [31:0]      b_and_c;
    begin
      a_and_b= a & b;
      a_and_c= a & c;
      b_and_c= b & c;

      maj = a_and_b ^ a_and_c ^ b_and_c;
    end
  endfunction // maj

  function  [31:0] sigma_a(input [31:0] a);

    reg [31:0] rot_28;
    reg [31:0] rot_34;
    reg [31:0] rot_39;
    begin
      /*
      rot_28 = {a[27:0],a[31:28]};
      rot_34 = {a[3:0],a[31:4]};
      rot_39 = {a[8:0],a[31:9]};
      */
      rot_28 = {a[1:0],a[31:2]};
      rot_34 = {a[12:0],a[31:13]};
      rot_39 = {a[21:0],a[31:22]};


      sigma_a= rot_28 ^ rot_34 ^ rot_39;
    end
  endfunction// sigma_a

  function  [31:0] sigma_e(input [31:0] e);

    reg [31:0] rot_14;
    reg [31:0] rot_18;
    reg [31:0] rot_41;
    begin
      rot_14 = {e[5:0],e[31:6]};
      rot_18 = {e[10:0],e[31:11]};
      rot_41 = {e[24:0],e[31:25]};

      sigma_e= rot_14 ^ rot_18 ^ rot_41;
    end
  endfunction// sigma_e

  function [31:0] cs(input [31:0] i_csa, i_csb);
    begin
      cs= i_csa + i_csb;

    end
  endfunction// cs

