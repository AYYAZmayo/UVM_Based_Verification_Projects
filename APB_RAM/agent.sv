class agent extends uvm_agent;
	`uvm_component_utils(agent)
	
	monitor mon;
	sequencer seqncr;
	driver drv;
	
	//constructor
	function new(string name="agent",uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mon = monitor::type_id::create("mon",this);
		if(is_active==UVM_ACTIVE)begin
			seqncr=sequencer::type_id::create("seqncr",this);
			drv=driver::type_id::create("drv",this);
		end
	endfunction
	
	//connect phase
	virtual function void connect_phase(uvm_phase phase);
		if(is_active==UVM_ACTIVE)
			drv.seq_item_port.connect(seqncr.seq_item_export);
	endfunction
	
endclass
		