
class host_item;
	// data members
	int 		 rspns ;
	rand int  kk   ;
	rand int  jj   ;

	rand int 			challenge_q [$];
	rand int 			challenge      ;
	rand bit [$clog2(MUX_LENGTH)-1:0] sel_mux0_d [] ;
	rand bit [$clog2(MUX_LENGTH)-1:0] sel_mux1_d [] ;

	// print the objects of data member
	task print_hst_item();
		$display("*****************************");
		$display("*******[HOST_ITEM]***********");
		$display("*****************************");
		$display("HOST_ITEM___:: value of challange  is 			 %0d" , challenge    		 );
		$display("HOST_ITEM___:: value of response   is 			 %0d" , rspns 		    		 );
		$display("HOST_ITEM___:: size of challange_q is 			 %0d" , challenge_q.size());
		$display("HOST_ITEM___:: all generated challanges are  %0p", challenge_q 			 );
		$display("HOST_ITEM___:: allpossible select pin of  	 %0p", sel_mux0_d 			 );
		$display("HOST_ITEM___:: all generated challanges are  %0p", sel_mux1_d 			 );
		
	endtask : print_hst_item

	// constraint on start index of mux array
	constraint sel_mux0_d_idx_c { jj == 0;}
	constraint sel_mux1_d_idx_c { kk == 0;}

	// adding constraint on size of queue. 
	constraint challenge_q_size_c { challenge_q.size() == XACT_CNT;}

	// // constraint to generate challange i.e. any 2bits can be one at a time 
	// constraint challenge_q_cntnt_c { 
																		
	// 																	foreach(challenge_q[ii])  
	// 																		challenge_q[ii] ==  {sel_mux1_d[jj],sel_mux0_d[kk]};
	// 																		kk == kk+1;
	// 																		if(kk==MUX_LENGTH) 
	// 																			jj == jj+ 1;
																		
	// }
	
	// generata all possible challanges
	constraint sel_mux0_d_c { 
														sel_mux0_d.size() == MUX_LENGTH; 
														foreach(sel_mux0_d[ii])
															sel_mux0_d[ii] == ii;
		
	}

	// generata all possible challanges
	constraint sel_mux1_d_c { 
														sel_mux1_d.size() == MUX_LENGTH;
														foreach(sel_mux1_d[ii])
															sel_mux1_d[ii] == ii;
		
	}

	function void post_randomize();
		for (int ii =0; ii < challenge_q.size(); ii++) begin
			challenge_q [ii] = {sel_mux1_d[jj],sel_mux1_d[kk]} ;

			if (jj == MUX_LENGTH -1) begin
				jj = 0 ;
				kk++;
			end
			jj++;
		end
	endfunction : post_randomize 

endclass : host_item