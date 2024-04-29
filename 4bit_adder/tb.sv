`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;

	function new(string name="transaction");
		super.new(name);
	endfunction
	
	rand bit [3:0]a;
	rand bit [3:0]b;
	bit [4:0]y;
	
	`uvm_object_utils_begin(transaction)
	`uvm_field_int(a,UVM_DEFAULT)
	`uvm_field_int(b,UVM_DEFAULT)
	`uvm_field_int(y,UVM_DEFAULT)
	`uvm_object_utils_end
	
endclass
//uvm_sequence is an object class a parameterized class so add parameter	
class sequence1 extends uvm_sequence#(transaction);
	`uvm_object_utils(sequence1)
	
	function new(string name ="sequence1");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
		tr=transaction::type_id::create("tr");
		//no. of transactions to be Generated
		repeat(10)begin
		start_item(tr);
		tr.randomize();
          `uvm_info("Sequence1",$sformatf("Stimulus Generated a =%0d , b=%0d",tr.a,tr.b),UVM_NONE);
		finish_item(tr);
		end
	endtask
endclass

class driver extends uvm_driver#(transaction);

	`uvm_component_utils(driver)
	
	function new (string name ="dirver",uvm_component parent =null);
		super.new(name,parent);
	endfunction
	
	transaction tr;
	virtual add_if aif;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		if(!uvm_config_db#(virtual add_if)::get(this,"","aif",aif))
			`uvm_error("driver","Config_DB Access failed");
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(tr);
			aif.a<= tr.a;
			aif.b<= tr.b;
			`uvm_info("driver", $sformatf("Trigger DUT with DATA a =%0d , b =%0d",tr.a,tr.b),UVM_NONE);
			seq_item_port.item_done();
			#10;
		end
		
    endtask
endclass
	
	class monitor extends uvm_monitor;
	
		`uvm_component_utils(monitor)
		function new (string name ="monitor", uvm_component parent =null);
			super.new(name,parent);
		endfunction
		transaction tc;
		virtual add_if aif;
		
		uvm_analysis_port#(transaction) send_port;
		
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			tc=transaction::type_id::create("tc");
			if(!uvm_config_db#(virtual add_if)::get(this,"","aif",aif))
				`uvm_error("monitor","Config_DB Access is failed");
			send_port= new("send_port",this);
		endfunction
		
		virtual task run_phase(uvm_phase phase);
			forever begin
			#10;
			tc.a =aif.a;
			tc.b =aif.b;
			tc.y =aif.y;
            `uvm_info("Monitor", $sformatf("DATA RECEIVED FROM DUT a= %0d , b= %0d , y= %0d",tc.a,tc.b,tc.y),UVM_NONE);
			send_port.write(tc);
			end
        endtask
	endclass
	
	class scoreboard extends uvm_scoreboard;
		`uvm_component_utils(scoreboard)
		function new(string path="scoreboard" , uvm_component parent =null);
			super.new(path,parent);
		endfunction
		
		transaction tr;
      uvm_analysis_imp#(transaction,scoreboard) imp_port;
		
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			tr=transaction::type_id::create("tr");
			imp_port =new("imp_port",this);
		endfunction
		
		// write method of analysis port
		virtual function void write (input transaction ts);
			tr=ts;
			`uvm_info("scoreboard", $sformatf("DATA RECEIVED in SCO a =%0d , b =%0d ,y =%0d",tr.a,tr.b,tr.y),UVM_NONE);
          if(tr.y == tr.a + tr.b)begin
              `uvm_info("scoreboard"," SCO TEST PASSED",UVM_NONE);
          end
		  else begin
              `uvm_info("scoreboard"," SCO TEST Failed",UVM_NONE);
            end
		endfunction
	endclass
	
	class agent extends uvm_agent;
		`uvm_component_utils(agent)
		function new (string name ="agent" , uvm_component parent =null);
			super.new(name,parent);
		endfunction
		
		driver drv;
		monitor mon;
		uvm_sequencer#(transaction) seqncer;
		
		virtual function void build_phase (uvm_phase phase);
			super.build_phase(phase);
			drv= driver::type_id::create("drv",this);
			mon= monitor::type_id::create("mon",this);
			seqncer =uvm_sequencer#(transaction)::type_id::create("seqncer",this);
		endfunction
		// here driver's seq_item_port is connected with sequencer's seq_item_export
		virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			drv.seq_item_port.connect(seqncer.seq_item_export);
		endfunction
		
	endclass
	
	class env extends uvm_env;
		`uvm_component_utils(env)
		function new (string path= "env", uvm_component parent=null);
			super.new(path,parent);
		endfunction
		
		agent ag;
		scoreboard sco;
		
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			ag=agent::type_id::create("ag",this);
			sco=scoreboard::type_id::create("sco",this);
		endfunction
		
		virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			ag.mon.send_port.connect(sco.imp_port);
		endfunction
		
	endclass
	
	class test extends uvm_test;
		`uvm_component_utils(test)
		function new (string path="test", uvm_component parent=null);
			super.new(path,parent);
		endfunction
		
		env ev;
		sequence1 seq1;

		
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			ev=env::type_id::create("ev",this);
			seq1=sequence1::type_id::create("seq1");

		endfunction
		
		virtual task run_phase(uvm_phase phase);
			phase.raise_objection(this);
			seq1.start(ev.ag.seqncer);
			phase.drop_objection(this);
			
		endtask
    endclass
/////////////////////////////////////////////////////////////////////////
module tb;
	
	add_if aif();
	adder_comb dut(.a(aif.a),.b(aif.b),.y(aif.y));
	
	initial begin
      uvm_config_db#(virtual add_if)::set(null,"uvm_test_top.ev.ag*","aif",aif);
		run_test("test");
	end
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end
	
	endmodule
