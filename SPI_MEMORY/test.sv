class test extends uvm_test;
		`uvm_component_utils(test)
		function new(string name="test",uvm_component parent=null);
			super.new(name,parent);
		endfunction
		
		
		env e;
		write_data wr_data;
		read_data rd_data;
		rst_dut rst_design;
		write_error wr_err;
		read_error rd_err;
		write_read_random rand_wrrd;
		write_burst_read_burst wrrd_burst;
		
		virtual function void build_phase (uvm_phase phase);
			super.build_phase(phase);
			e=env::type_id::create("e",this);
			wr_data=write_data::type_id::create("wr_data");
			rd_data=read_data::type_id::create("rd_data");
			rst_design=rst_dut::type_id::create("rst_design");
			wr_err=write_error::type_id::create("wr_err");
			rd_err=read_error::type_id::create("rd_err");
			rand_wrrd=write_read_random::type_id::create("rand_wrrd");
			wrrd_burst= write_burst_read_burst::type_id::create("wrrd_burst");
		endfunction
		
		virtual task run_phase(uvm_phase phase);
			phase.raise_objection(this);
			
			wr_data.start(e.a.seqr);
			rd_data.start(e.a.seqr);
			rst_design.start(e.a.seqr);
            #10;
			wr_err.start(e.a.seqr);
			rd_err.start(e.a.seqr);
			rand_wrrd.start(e.a.seqr);
			wrrd_burst.start(e.a.seqr);
          phase.drop_objection(this);
		endtask
	endclass
	/////////////////////////////////////////////////////////////
