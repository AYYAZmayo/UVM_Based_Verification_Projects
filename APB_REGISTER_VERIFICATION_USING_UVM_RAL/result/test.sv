class test extends uvm_test;
	`uvm_component_utils(test)
	function new(string name ="test", uvm_component parent=null );
		super.new(name, parent);
	endfunction
	
	env e;
	cntrl_wr cnwr;
	cntrl_rd  cnrd;
  
	reg1_wr r1wr;
	reg1_rd  r1rd;
  
  	reg2_wr r2wr;
	reg2_rd  r2rd;
  
  	reg3_wr r3wr;
	reg3_rd  r3rd;
  
  	reg4_wr r4wr;
	reg4_rd  r4rd;
  
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		e=env::type_id::create("e",this);
		cnwr=cntrl_wr::type_id::create("cnwr");
		cnrd=cntrl_rd::type_id::create("cnrd");
      r1wr=reg1_wr::type_id::create("r1wr");
      r1rd=reg1_rd::type_id::create("r1rd");
      
      r2wr=reg2_wr::type_id::create("r2wr");
      r2rd=reg2_rd::type_id::create("r2rd");
      
      r3wr=reg3_wr::type_id::create("r3wr");
      r3rd=reg3_rd::type_id::create("r3rd");
      
      r4wr=reg4_wr::type_id::create("r4wr");
      r4rd=reg4_rd::type_id::create("r4rd");
		
	endfunction
	
  virtual task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	cnwr.regmodel=e.regmodel;
	cnwr.start(e.agent_inst.seqr);
	
	cnrd.regmodel=e.regmodel;
	cnrd.start(e.agent_inst.seqr);
    
    r1wr.regmodel=e.regmodel;
	r1wr.start(e.agent_inst.seqr);
	
	r1rd.regmodel=e.regmodel;
	r1rd.start(e.agent_inst.seqr);
    
    
	r2wr.regmodel=e.regmodel;
	r2wr.start(e.agent_inst.seqr);
	
	r2rd.regmodel=e.regmodel;
	r2rd.start(e.agent_inst.seqr);
    
    r3wr.regmodel=e.regmodel;
	r3wr.start(e.agent_inst.seqr);
	
	r3rd.regmodel=e.regmodel;
	r3rd.start(e.agent_inst.seqr);
    
    r4wr.regmodel=e.regmodel;
	r4wr.start(e.agent_inst.seqr);
	
	r4rd.regmodel=e.regmodel;
	r4rd.start(e.agent_inst.seqr);
    
	phase.drop_objection(this);
	phase.phase_done.set_drain_time(this,200);
	
	endtask
	
endclass
	
	