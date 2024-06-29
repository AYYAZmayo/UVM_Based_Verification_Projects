class i2c_mem_env extends uvm_env;
	`uvm_component_utils(i2c_mem_env)
	
	agent ag;
	
	sco scb ;
	
	function new(string name="i2c_mem_env",uvm_component parent=null);
		super.new(name,parent);
	endfunction
		
	//build phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ag=agent::type_id::create("ag",this);
		scb=sco::type_id::create("scb",this);
	endfunction
	
	//connect phase
	virtual function void connect_phase(uvm_phase phase);
		ag.mon.send.connect(scb.recv);
		endfunction
endclass