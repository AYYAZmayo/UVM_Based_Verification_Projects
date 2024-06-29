class base_seq extends uvm_sequence#(transaction);
	`uvm_object_utils(base_seq)
	
	function new(string name ="base_seq");
		super.new(name);
	endfunction
	
	virtual task pre_body();
		uvm_phase phase;
		// For UVM_VERSION 1.2
		phase = get_starting_phase();
		
		if(phase!=null)begin
			phase.raise_objection(this,get_type_name());
			`uvm_info(get_type_name(),"Raise Phase Objection",UVM_LOW);
		end
	endtask
	
	
	virtual task post_body();
		uvm_phase phase;
		
		// For UVM_VERSION 1.2
		phase = get_starting_phase();
		
		if(phase !=null) begin
			phase.drop_objection(this,get_type_name());
			`uvm_info(get_type_name(),"Drop Phase Objection",UVM_LOW);
		end
	
	endtask
	
endclass

class one_write_one_read_seq extends base_seq;
	`uvm_object_utils(one_write_one_read_seq)
	
	function new(string name ="one_write_one_read_seq");
		super.new(name);
	endfunction
	
	virtual task body();
			`uvm_info(get_type_name(),"Executing one_write_one_read_seq Sequence",UVM_LOW);
			// 1 write transaction
			`uvm_do_with(req,{req.optr==writereq; req.paddr==0;});
			// 1 read transaction
			`uvm_do_with(req,{req.optr==readreq; req.paddr==0;});
	endtask
	
endclass