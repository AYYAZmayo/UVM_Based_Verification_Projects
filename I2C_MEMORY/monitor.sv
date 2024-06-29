class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)
	
	function new(string name="monitor", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	virtual i2c_i vif;
	uvm_analysis_port#(transaction) send;
	transaction req;
	
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		req=transaction::type_id::create("req");
        send=new("send",this);
		if (!uvm_config_db#(virtual i2c_i)::get(this,"","vif",vif))
			`uvm_error(get_type_name(),"Config DB failed")
	endfunction
	
	
	task run_phase(uvm_phase phase);
		forever begin
          @(posedge vif.clk);
     	  if(vif.rst)
       		 begin
       			 `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);
				  req.rst=vif.rst;
       		 end
          else begin
            if(vif.wr)begin
					req.rst=vif.rst;
					req.addr=vif.addr;
					req.wr=vif.wr;
					req.din=vif.din;
                    @(posedge vif.done);
					req.datard=vif.datard;
					//`uvm_info(get_type_name(),$sformatf("DATA Received from DUT %s",req.sprint()),UVM_LOW);
              `uvm_info(get_type_name(),$sformatf(" WRITE MODE DATA Received from DUT | rst= %0d , wr = %0d , addr = %0d , din = %0d",req.rst,req.wr,req.addr,req.din),UVM_LOW);
				end
            else if(!vif.wr) begin
					req.rst=vif.rst;
					req.addr=vif.addr;
					req.wr=vif.wr;
					req.din=vif.din;
                    @(posedge vif.done);
					req.datard=vif.datard;
					//`uvm_info(get_type_name(),$sformatf("DATA Received from DUT %s",req.sprint()),UVM_LOW);
              `uvm_info(get_type_name(),$sformatf(" READ MODE DATA Received from DUT | rst= %0d , wr = %0d , addr = %0d , datard = %0d",req.rst,req.wr,req.addr,req.datard),UVM_LOW);
				end
          end
		  send.write(req);
		end
	endtask 
endclass