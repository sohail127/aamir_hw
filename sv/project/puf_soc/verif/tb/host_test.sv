class host_test ;
	
	// class member instance
	host_env env;
	
	// class construct
	function new ();
		env = new() ; 
	endfunction : new 

	// task for run
	task run();
		env.run();
	endtask : run

endclass : host_test


