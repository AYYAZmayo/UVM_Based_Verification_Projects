class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)
	
	transaction tr;
	virtual spi_i vif;
	uvm_analysis_port#(transaction) send;
	
	function new(string name="monitor", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		send=new("send",this);
		if(!uvm_config_db#(virtual spi_i)::get(this,"","vif",vif))
			`uvm_error("Monitor","Config_db failed");
	endfunction
	  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.clk);
      if(vif.rst)
        begin
        tr.opr      = reset_dut; 
        `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);
        send.write(tr);
        end
      else if (!vif.rst && vif.wr)
         begin
          @(posedge vif.done);
          tr.opr     = write_d;
          tr.din    = vif.din;
          tr.addr   = vif.addr;
          tr.err    = vif.err;
          `uvm_info("MON", $sformatf("DATA WRITE addr:%0d data:%0d err:%0d",tr.addr,tr.din,tr.err), UVM_NONE); 
          send.write(tr);
         end
      else if (!vif.rst && !vif.wr)
         begin
          @(posedge vif.done);
          tr.opr     = read_d; 
          tr.addr   = vif.addr;
          tr.err    = vif.err;
          tr.dout   = vif.dout; 
          `uvm_info("MON", $sformatf("DATA READ addr:%0d data:%0d slverr:%0d",tr.addr,tr.dout,tr.err), UVM_NONE); 
          send.write(tr);
         end
    
    end
   endtask 
  
endclass
	