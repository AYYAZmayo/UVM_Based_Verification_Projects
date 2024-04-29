`include "uvm_macros.svh"
import uvm_pkg::*;
typedef enum bit [1:0] {reset_clk=0, random_buad_rate=1} operation_mode;


class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)
	function new(string name="transaction");
		super.new(name);
	endfunction
	
	rand logic [16:0] buad;
	logic tx_clk;
	operation_mode mode;
	real period;
	// constraining the buad rate
	constraint baud_c {
		buad inside {4800, 9600, 14400, 19200, 38400, 57600};
	}
endclass
	
class reset_seq extends uvm_sequence#(transaction);
	`uvm_object_utils(reset_seq)
	function new(string name="reset_seq");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
		// no. of sitimulai
      repeat(1) begin
			tr=transaction::type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.mode=reset_clk;
			finish_item(tr);
		end
	endtask
endclass

class baud_rate_seq extends uvm_sequence#(transaction);
	`uvm_object_utils(baud_rate_seq)
	function new(string name="baud_rate_seq");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
		// no. of sitimulai
      repeat(15) begin
          	tr=transaction::type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.mode=random_buad_rate;
			finish_item(tr);
		end
	endtask
endclass
	
class driver extends uvm_driver#(transaction);
	`uvm_component_utils(driver)
	function new(string name="driver", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	transaction tr;
	virtual clk_if vif;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		if(!uvm_config_db#(virtual clk_if)::get(this,"","vif",vif))
			`uvm_error("driver","Config_DB access failed");
	endfunction
	
	virtual task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(tr);
			if(tr.mode == reset_clk)begin
				vif.rst<=1;
				`uvm_info("driver","RESET is Applied",UVM_NONE);
				@(posedge vif.clk);
			end
			else if(tr.mode==random_buad_rate)begin
				vif.rst<=0;
				vif.baud<=tr.buad;
				`uvm_info("driver",$sformatf("Input Buad rate = %0d",tr.buad),UVM_NONE);
				@(posedge vif.clk);
				@(posedge vif.tx_clk); //slow clock edge to detect the t-strart tick
				@(posedge vif.tx_clk); //slow clock edge to detect the t-end tick
			end
			seq_item_port.item_done();
		end
	endtask
	endclass
	
	class monitor extends uvm_monitor;
		`uvm_component_utils(monitor)
		function new(string name="monitor", uvm_component parent=null);
			super.new(name,parent);
		endfunction
		
		transaction tr;
		virtual clk_if vif;
		uvm_analysis_port#(transaction) send;
		real on_time;
		real off_time;
		
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			tr=transaction::type_id::create("tr");
			send=new("send",this);
			if(!uvm_config_db#(virtual clk_if)::get(this,"","vif",vif))
				`uvm_error("monitor","config_db access failed");
		endfunction
		
		virtual task run_phase(uvm_phase phase);
			forever begin
				@(posedge vif.clk);
				if(vif.rst==1)begin
					tr.mode=reset_clk;
					`uvm_info("monitor","RESET is detected",UVM_NONE);
					on_time=0;
					off_time=0;
				end
				else begin
					tr.buad=vif.baud;
					tr.mode=random_buad_rate;
					on_time=0;
					off_time=0;
					
					@(posedge vif.tx_clk);
					on_time=$realtime; // time in ns
					@(posedge vif.tx_clk);
					off_time=$realtime; // time in ns
					tr.period = off_time - on_time; // total time elapsed for on clk-tick of slow clock
                  `uvm_info("monitor",$sformatf("Recieved Buad rate = %0d , Period =%0t",tr.buad,tr.period),UVM_NONE);
				end
				send.write(tr);
			end
		endtask
	endclass
		
class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	function new (string name ="scoreboard", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	real count=0;
	transaction tr;
	uvm_analysis_imp#(transaction,scoreboard) imp;
	
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		imp=new("imp",this);
	endfunction
	
	virtual function void write(input transaction ts);
		tr=ts;
		
		if(tr.mode == reset_clk)begin
			`uvm_info("scoreboard",$sformatf("RESET state detected"),UVM_NONE);
		end
		else if(tr.mode == random_buad_rate)begin
			// w.r.t 50 MHz one tick will be equal to 20 ns so divide by 20 to get number of ticks for the apllied buad rate
			count=tr.period/20; 
          case(tr.buad)
				4800 :	begin 
							if(count == 10418)	begin	//tx_max <=14'd10416= one rising edge+10416 + rising edge =10418
                              `uvm_info("scoreboard",$sformatf("TEST PASSED w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
							else begin
                              `uvm_info("scoreboard",$sformatf("TEST Failed w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
			            end
				9600  : begin
							if(count == 5210)	begin	//tx_max <=14'd5208= one rising edge+ 5208 + rising edge =5210
                              `uvm_info("scoreboard",$sformatf("TEST PASSED w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
							else begin
                              `uvm_info("scoreboard",$sformatf("TEST Failed w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
				    	end
				14400 : begin 
							if(count == 3474)	begin	//tx_max <=14'd3472= one rising edge+ 3472 + rising edge =3474
                              `uvm_info("scoreboard",$sformatf("TEST PASSED w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
							else begin
                              `uvm_info("scoreboard",$sformatf("TEST Failed w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
				    	end							
				19200 : begin 
							if(count == 2606)	begin	//tx_max <=14'd2604= one rising edge+ 2604 + rising edge =2606
                              `uvm_info("scoreboard",$sformatf("TEST PASSED w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
							else begin
                              `uvm_info("scoreboard",$sformatf("TEST Failed w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
						end
				38400: begin
							if(count == 1304)	begin	//tx_max <=14'd1302= one rising edge+ 1302 + rising edge =1304
                              `uvm_info("scoreboard",$sformatf("TEST PASSED w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
							else begin
                              `uvm_info("scoreboard",$sformatf("TEST Failed w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
						end
				57600 : begin 
							if(count == 870)	begin	//tx_max <=14'd868= one rising edge+ 868 + rising edge =870
                              `uvm_info("scoreboard",$sformatf("TEST PASSED w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
							else begin
                              `uvm_info("scoreboard",$sformatf("TEST Failed w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end	
						end 						
				default: begin 
							if(count == 5210)	begin	//tx_max <=14'd5208= one rising edge+ 5208 + rising edge =5210
                              `uvm_info("scoreboard",$sformatf("TEST PASSED w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
							else begin
                              `uvm_info("scoreboard",$sformatf("TEST Failed w.r.t baud Rate =%0d",tr.buad),UVM_NONE);
							end
						end
			endcase
		end
      $display("----------------------------------------------------------------");
		endfunction
       
	endclass
////     
	class agent extends uvm_agent;
	`uvm_component_utils(agent)
	function new(string name="agent",uvm_component parent =null);
		super.new(name,parent);
		
	endfunction
	
	driver drv;
	monitor mon;
	uvm_sequencer#(transaction) seqr;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mon = monitor::type_id::create("mon",this);
		drv = driver::type_id::create("drv",this);
		seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this);
  
	endfunction
	
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(seqr.seq_item_export);
	endfunction
	
	endclass
///////////////////////////////////////////////////////////////////////////
	class env extends uvm_env;
	`uvm_component_utils(env)
	
	function new(string name="env", uvm_component parent=null);
		super.new(name,parent);
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
		ag.mon.send.connect(sco.imp);
	endfunction
	
	endclass
	
	
	class test extends uvm_test;
		`uvm_component_utils(test)
	
		function new(string name="test", uvm_component parent=null);
			super.new(name,parent);
		endfunction
		
		env envr;
		reset_seq rst_seq;
		baud_rate_seq baud_seq;
		
		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);
			envr=env::type_id::create("envr",this);
			rst_seq=reset_seq::type_id::create("rst_seq");
			baud_seq=baud_rate_seq::type_id::create("baud_seq");
		endfunction
		
		virtual task run_phase(uvm_phase phase);
			phase.raise_objection(this);
			rst_seq.start(envr.ag.seqr);
			//#20;
			baud_seq.start(envr.ag.seqr);
			#20;
			phase.drop_objection(this);
		endtask
	endclass
	////////////////////////////////
	module tb;
	
		clk_if vif();
		
		clk_gen dut(.clk(vif.clk),.rst(vif.rst),.baud(vif.baud),.tx_clk(vif.tx_clk));
		initial begin
		vif.clk<=0;
		uvm_config_db#(virtual clk_if)::set(null,"*","vif",vif);
		run_test("test");
		end
		
		always #10 vif.clk<=~vif.clk;  // 50MHz //1/50 20nsec
		
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
		
	endmodule