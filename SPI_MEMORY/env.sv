class env extends uvm_env;
		`uvm_component_utils(env)
		function new(string name="env", uvm_component parent=null);
			super.new(name,parent);
		endfunction
		
		agent a;
		scoreboard sco;
		coverage_sub covsb;
  
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			a=agent::type_id::create("a",this);
			sco=scoreboard::type_id::create("sco",this);
            covsb=coverage_sub::type_id::create("covsb",this);
		endfunction
		
		virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			a.mon.send.connect(sco.imp);
            a.mon.send.connect(covsb.analysis_export);
		endfunction
	endclass
	
///////////////////////////////////////////////////////////////////////
