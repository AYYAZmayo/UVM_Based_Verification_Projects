class test extends uvm_test;
		`uvm_component_utils(test)
		function new(string name="test",uvm_component parent=null);
			super.new(name,parent);
		endfunction
		
		
		env e;
		reset_seq rst_uart;
		rand_baud_1_stop rbss;
		rand_length_1_stop rlss;
		length_5_1_stop_with_parity l5sswp;
		length_6_1_stop_with_parity l6sswp;
		length_7_1_stop_with_parity l7sswp;
		length_8_1_stop_with_parity l8sswp;
		length_5_1_stop_withno_parity l5sswnp;
		length_6_1_stop_withno_parity l6sswnp;
		length_7_1_stop_withno_parity l7sswnp;
		length_8_1_stop_withno_parity l8sswnp;
		
		
		virtual function void build_phase (uvm_phase phase);
			super.build_phase(phase);
			e=env::type_id::create("e",this);
			rst_uart= reset_seq::type_id::create("rst_uart",this);
			rbss=rand_baud_1_stop::type_id::create("rbss",this);
			rlss=rand_length_1_stop::type_id::create("rlss",this);
			
			l5sswp=length_5_1_stop_with_parity::type_id::create("l5sswp",this);
			l6sswp=length_6_1_stop_with_parity::type_id::create("l6sswp",this);
			l7sswp=length_7_1_stop_with_parity::type_id::create("l7sswp",this);
			l8sswp=length_8_1_stop_with_parity::type_id::create("l8sswp",this);
			
			l5sswnp=length_5_1_stop_withno_parity::type_id::create("l5sswnp",this);
			l6sswnp=length_6_1_stop_withno_parity::type_id::create("l6sswnp",this);
			l7sswnp=length_7_1_stop_withno_parity::type_id::create("l7sswnp",this);
			l8sswnp=length_8_1_stop_withno_parity::type_id::create("l8sswnp",this);
		endfunction
		
		virtual task run_phase(uvm_phase phase);
			phase.raise_objection(this);
				rbss.start(e.a.seqr);
				#20;
				rlss.start(e.a.seqr);
				#20;
				l5sswp.start(e.a.seqr); //length_5_single_stop_with_parity
				#20
				l6sswp.start(e.a.seqr); //length_6_single_stop_with_parity
				#20
				l7sswp.start(e.a.seqr); //length_7_single_stop_with_parity
				#20
				l8sswp.start(e.a.seqr); //length_8_single_stop_with_parity
				#20
				l5sswnp.start(e.a.seqr); //length_5_single_stop_withno_parity
				#20
				l6sswnp.start(e.a.seqr); //length_6_single_stop_withno_parity
				#20
				l7sswnp.start(e.a.seqr); //length_7_single_stop_withno_parity
				#20
				l8sswnp.start(e.a.seqr); //length_8_single_stop_withno_parity
				
			phase.drop_objection(this);
        endtask
		
	endclass
	/////////////////////////////////////////////////////////////
