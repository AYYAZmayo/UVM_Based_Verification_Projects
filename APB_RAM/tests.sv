class base_test extends uvm_test;
	`uvm_component_utils(base_test)
	
	function new(string name="base_test", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	
	apb_mem_env env;
	
	function void build_phase(uvm_phase phase);
		env=apb_mem_env::type_id::create("env",this);
		 uvm_config_wrapper::set(this,"env.ag.seqncr.run_phase","default_sequence",
									one_write_one_read_seq::type_id::get());
		super.build_phase(phase);
		`uvm_info(get_type_name(),"test build Phase executed",UVM_HIGH);
	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
	
	function void check_phase(uvm_phase phase);
		//configuration checker method
		check_config_usage();
	endfunction
endclass
