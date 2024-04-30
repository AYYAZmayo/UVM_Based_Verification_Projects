`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)
	function new (string name ="transaction");
		super.new(name);
	endfunction
	
	rand bit rst;
	rand bit din;
	bit dout;
	
endclass
/////////////////////////////////////////////////////
//Sequence 1 : DFF is reset  
class rst_dff extends uvm_sequence#(transaction);
	`uvm_object_utils(rst_dff)
	function new(string name ="rst_dff");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
      
      repeat(2) begin
        tr=transaction::type_id::create("tr");
		start_item(tr);
		assert(tr.randomize());
		tr.rst=1'b1;
     	 `uvm_info("rst_dff",$sformatf("rst = %0d ,din = %0d",tr.rst,tr.din),UVM_NONE);
	finish_item(tr);
    end
	endtask
	
endclass
////////////////////////////////////////////////////////
//Sequence 2 : DFF Valid Data In  
class valid_dff_input extends uvm_sequence#(transaction);
	`uvm_object_utils(valid_dff_input)
	function new(string name ="valid_dff_input");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
    
	repeat(15) begin
    tr=transaction::type_id::create("tr");
	start_item(tr);
	assert(tr.randomize());
	tr.rst=1'b0;
      `uvm_info("valid_dff_input",$sformatf("rst = %0d ,din = %0d",tr.rst,tr.din),UVM_NONE);
	finish_item(tr);
    end
	endtask
	
endclass
////////////////////////////////////////////////////////////////////////////////
//Sequence 3 : Random RST and Data-In
class rand_dff_din_rst extends uvm_sequence#(transaction);
	`uvm_object_utils(rand_dff_din_rst)
	function new(string name ="rand_dff_din_rst");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
    
	repeat(15) begin
    tr=transaction::type_id::create("tr");
	start_item(tr);
	assert(tr.randomize());
      `uvm_info("rand_dff_din_rst",$sformatf("rst = %0d ,din = %0d",tr.rst,tr.din),UVM_NONE);
	finish_item(tr);
    end
	endtask
	
endclass
//////////////////////////////////////////////////////////////////////////////////
class driver extends uvm_driver#(transaction);
	`uvm_component_utils(driver)
	function new(string name="driver", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	transaction tr;
	virtual dff_if dif;
	
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		if(!uvm_config_db#(virtual dff_if)::get(this,"","dif",dif))
			`uvm_error("driver","Config_DB Acess failed");
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(tr); //sending request and getting next item
			dif.rst<= tr.rst;
			dif.din<= tr.din;
			
			`uvm_info("driver",$sformatf(" rst= %0d , din =%0d", tr.rst,tr.din),UVM_NONE);
			repeat(2) @(posedge dif.clk);
			seq_item_port.item_done(); //sending acknowledge 	
		end
	endtask
endclass
/////////////////////////////////////////////////////////////////////////////////////
class monitor extends uvm_component;
	`uvm_component_utils(monitor)
	
  function new(string name , uvm_component parent =null);
		super.new(name,parent);
	endfunction
	
	
	uvm_analysis_port#(transaction) send_data;
	transaction tr;
	virtual dff_if dif;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		send_data =new("send_data",this);
		tr=transaction::type_id::create("tr");
		if(!uvm_config_db#(virtual dff_if)::get(this,"","dif",dif))
			`uvm_error("Monitor","Config_DB Acess is failed");
	endfunction
	
  virtual task run_phase(uvm_phase phase);
		forever begin
		repeat(2) @(posedge dif.clk);
		tr.rst=dif.rst;
		tr.din=dif.din;
		tr.dout=dif.dout;
          `uvm_info("Monitor",$sformatf(" rst= %0d , din =%0d ,dout =%0d", tr.rst,tr.din,tr.dout),UVM_NONE);
		send_data.write(tr);
		end
	endtask
	
	
endclass
///////////////////////////////////////////////////////////////////////////////	
class scoreboard extends uvm_scoreboard;
		`uvm_component_utils(scoreboard)
		function new(string name ="scoreboard", uvm_component parent=null);
          super.new(name,parent);
			
		endfunction
		
		uvm_analysis_imp#(transaction,scoreboard) imp;
		transaction tr;
		
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			imp=new("imp",this);
			tr=transaction::type_id::create("tr");
		endfunction
		
		virtual function void write(input transaction ts);
			tr=ts;
			`uvm_info("scoreboard",$sformatf("rst =%0d , din =%0d , dout =%0d",tr.rst,tr.din,tr.dout),UVM_NONE);
          if(tr.rst==1'b1 && tr.dout == 1'b0)begin
				`uvm_info("scoreboard","RESET is Apllied",UVM_NONE);
          end
          else if (tr.rst==1'b0 && tr.dout == tr.din)begin
				`uvm_info("scoreboard","TEST Passed",UVM_NONE);
          end
			else begin
				`uvm_info("scoreboard","TEST Failed",UVM_NONE);
            end
          $display("-----------------------------------------------------------------");
		endfunction
		
	endclass
/////////////////////////////////////////////////////////////////////////////////////////////////////	
class agent extends uvm_agent;
	`uvm_component_utils(agent)
	
	function new(string name, uvm_component parent =null);
		super.new(name,parent);
	endfunction
	
	driver drv;
	monitor mon;
	uvm_sequencer#(transaction) seqr;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv=driver::type_id::create("drv",this);
		mon=monitor::type_id::create("mon",this);
		seqr=uvm_sequencer#(transaction)::type_id::create("seqr",this);
	endfunction
	
	
  virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(seqr.seq_item_export);
	endfunction
	
endclass
///////////////////////////////////////////////////////////////////////////////////////////////////
class coverage_sub extends uvm_subscriber#(transaction);
  `uvm_component_utils(coverage_sub)
  
  transaction tr;
  
  function new(string name="coverage_sub",uvm_component parent =null);
    super.new(name,parent);
    tr=transaction::type_id::create("tr");
    cov=new();
  endfunction
  
  covergroup cov;
    option.per_instance=1;
    
    RST:coverpoint tr.rst{
      bins rst_high[]={1};
      bins rst_low[]={0};
    }
	
    Din:coverpoint tr.din{
      bins din_high[]={1};
      bins din_low[]={0};
    }
    
    Dout:coverpoint tr.dout{
      bins dout_high[]={1};
      bins dout_low[]={0};
    }
    
    RST_x_Din:cross RST,Din;
  endgroup
  
  virtual function void write(transaction t);
    tr=t;
    cov.sample();
  endfunction
  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %0f",cov.get_coverage()),UVM_NONE);
  endfunction
  
endclass
///////////////////////////////////////////////////////////////////////////////////////////////////
  
class env extends uvm_env;
	`uvm_component_utils(env)
	
	function new(string name ="env", uvm_component parent =null);
		super.new(name,parent);
	endfunction
	
	agent ag;
	scoreboard sco;
	coverage_sub covs;
  
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ag=agent::type_id::create("ag",this);
		sco=scoreboard::type_id::create("sco",this);
        covs=coverage_sub::type_id::create("covs",this);
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		ag.mon.send_data.connect(sco.imp);
        ag.mon.send_data.connect(covs.analysis_export);
	endfunction
	
endclass
////////////////////////////////////////////////////////////////////////////////////////////////////
  
class test extends uvm_test;
	`uvm_component_utils(test)
	function new (string name="test", uvm_component parent =null);
		super.new(name,parent);
	endfunction
	
	env en;
	rst_dff seq1;
	valid_dff_input seq2;
	rand_dff_din_rst seq3;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		en=env::type_id::create("en", this);
      seq1 =rst_dff::type_id::create("seq1");
      seq2 = valid_dff_input::type_id::create("seq2");
      seq3 = rand_dff_din_rst::type_id::create("seq3");
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
			seq1.start(en.ag.seqr);
			#20;
			seq2.start(en.ag.seqr);
			#20;
			seq3.start(en.ag.seqr);
		phase.drop_objection(this);
		
	endtask
	
	endclass
//////////////////////////////////////////////////////////////////////	
module tb;

	dff_if dif();
	
	dff dut(.clk(dif.clk), .rst(dif.rst), .din(dif.din), .dout(dif.dout));
	
	
	initial begin
	dif.clk=0;
	uvm_config_db#(virtual dff_if)::set(null,"*","dif",dif);
	run_test("test");
	end
	always #5 dif.clk=~dif.clk;
	
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end
	
endmodule
	