`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
	
	function new(string path="transaction");
		super.new(path);
	endfunction
	rand bit [1:0] sel;
	rand bit [3:0] x;
	bit y;
  `uvm_object_utils_begin(transaction)
	`uvm_field_int(sel,UVM_DEFAULT);
	`uvm_field_int(x,UVM_DEFAULT);
	`uvm_field_int(y,UVM_DEFAULT);
	`uvm_object_utils_end
	
	
	endclass
	
class seq1 extends uvm_sequence#(transaction);
	`uvm_object_utils(seq1)
	transaction trans;
	function new(string path="seq1");
		super.new(path);
	endfunction
	
	virtual task body();
		trans=transaction::type_id::create("trans");
		repeat(16) begin
		start_item(trans);
		trans.randomize();
          `uvm_info("seq1",$sformatf("DATA send to driver sel=%0d , x=%0b",trans.sel,trans.x),UVM_NONE);
		finish_item(trans);
		end
		endtask
endclass

class driver extends uvm_driver#(transaction);

`uvm_component_utils(driver)
function new(string path="driver", uvm_component parent = null);
	super.new(path,parent);
	endfunction
	
	transaction tr;
	virtual mux_if mif;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		if(!uvm_config_db#(virtual mux_if)::get(this,"","mif",mif))
			`uvm_error("driver","Access to config db failed");
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		forever begin
		seq_item_port.get_next_item(tr);
		mif.sel<= tr.sel;
		mif.x<= tr.x;
		seq_item_port.item_done();
		#10;
		end
		endtask
endclass

class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)
	function new(string path ="monitor", uvm_component parent=null);
		super.new(path,parent);
	endfunction
	
	transaction tr;
	uvm_analysis_port#(transaction) send;
	virtual mux_if mif;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		send=new("tr",this);
		if (!uvm_config_db#(virtual mux_if)::get(this,"","mif",mif))
			`uvm_error("monitor","Config_db Access failed");
	
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		forever begin
		#10;
			tr.sel=mif.sel;
			tr.x=mif.x;
			tr.y=mif.y;
		send.write(tr);
          `uvm_info("monitor",$sformatf(" sel = %0d, x=%0b ,y=%0d",tr.sel,tr.x,tr.y),UVM_NONE)
		end
		
	endtask
endclass

class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	function new(string path="scoreboard", uvm_component parent =null);
		super.new(path,parent);
	endfunction
	
	transaction tr;
  uvm_analysis_imp#(transaction,scoreboard) imp;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		imp =new("imp",this);
	endfunction
	
	virtual function void write(input transaction trans);
			tr=trans;
      	
		if(tr.sel==2'b00)begin
          if (tr.y==tr.x[0])begin
            `uvm_info("SCO","TEST PASSED",UVM_NONE);end
			else begin
              `uvm_info("SCO","TEST Failed",UVM_NONE);end
		end
		else if(tr.sel==2'b01)begin
          if (tr.y==tr.x[1])begin
            `uvm_info("SCO","TEST PASSED",UVM_NONE);end
			else begin
              `uvm_info("SCO","TEST Failed",UVM_NONE);end
		end
		else if(tr.sel==2'b10)begin
          if (tr.y==tr.x[2])begin
            `uvm_info("SCO","TEST PASSED",UVM_NONE);end
			else begin
              `uvm_info("SCO","TEST Failed",UVM_NONE);end
		end
		else if(tr.sel==2'b11)begin
          if (tr.y==tr.x[3])begin
            `uvm_info("SCO","TEST PASSED",UVM_NONE);end
			else begin
              `uvm_info("SCO","TEST Failed",UVM_NONE);end
		end
	endfunction
	endclass
	
	class agent extends uvm_agent;
		`uvm_component_utils(agent)
		function new(string path="agent", uvm_component parent=null);
			super.new(path,parent);
		endfunction
		driver drv;
		monitor mon;
		uvm_sequencer#(transaction) seqr;
		
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			drv= driver::type_id::create("drv",this);
			mon= monitor::type_id::create("mon",this);
			seqr=uvm_sequencer#(transaction)::type_id::create("seqr",this);
		endfunction
		virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			drv.seq_item_port.connect(seqr.seq_item_export);
		
		endfunction
	endclass
	
	class env extends uvm_env;
		`uvm_component_utils(env)
		function new(string path="env", uvm_component parent=null);
			super.new(path,parent);
		endfunction
		
		agent ag;
		scoreboard sco;
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			ag= agent::type_id::create("ag",this);
			sco= scoreboard::type_id::create("sco",this);

		endfunction
		virtual function void connect_phase(uvm_phase phase);
			super.connect_phase(phase);
			ag.mon.send.connect(sco.imp);
		endfunction
	endclass
	
	class test extends uvm_test;
	`uvm_component_utils(test)
	
	function new(string path ="test", uvm_component parent =null);
		super.new(path,parent);
	endfunction
	
	seq1 seq;
	env e;
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seq= seq1::type_id::create("seq");
		e  = env::type_id::create("e",this);
	endfunction
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			seq.start(e.ag.seqr);
		phase.drop_objection(this);
	endtask
	endclass
	
	module tb;
	
	mux_if mif();
	
      MUX4x1 dut(.sel(mif.sel),.x(mif.x),.y(mif.y));
	
	initial begin
		uvm_config_db#(virtual mux_if)::set(null,"uvm_test_top.e.ag*","mif",mif);
		run_test("test");
	end
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end
	endmodule
	
	