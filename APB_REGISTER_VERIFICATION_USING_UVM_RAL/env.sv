class env extends uvm_env;
	`uvm_component_utils(env)
	
	function new(string name="env", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	agent agent_inst;
	scoreboard sco_inst;
	
	reg_block regmodel;
	top_adapter adapter_inst;
	uvm_reg_predictor#(transaction) predictor_inst;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent_inst = agent::type_id::create("agent_inst",this);
		sco_inst = scoreboard::type_id::create("sco_inst",this);
		
		regmodel = reg_block::type_id::create("regmodel",this);
		regmodel.build();
		
      
		predictor_inst =uvm_reg_predictor#(transaction)::type_id::create("predictor_inst",this);
      adapter_inst = top_adapter::type_id::create("adapter_inst");
		
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		agent_inst.mon.mon_ap.connect(sco_inst.sco_imp);
		agent_inst.mon.mon_ap.connect(predictor_inst.bus_in);
		
        regmodel.default_map.set_sequencer(.sequencer(agent_inst.seqr),.adapter(adapter_inst));
		regmodel.default_map.set_base_addr(0);
		
		predictor_inst.map = regmodel.default_map;
		predictor_inst.adapter = adapter_inst;
	
	endfunction
	
endclass