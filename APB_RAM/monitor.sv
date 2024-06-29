class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)
	
	function new(string name="monitor", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	virtual apb_if vif;
	uvm_analysis_port#(transaction) send;
	transaction req;
	
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		req=transaction::type_id::create("req");
        send=new("send",this);
		if (!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
			`uvm_error(get_type_name(),"Config DB failed")
	endfunction
	
	
	task run_phase(uvm_phase phase);
		forever begin
          @(posedge vif.pclk);
     	  if(!vif.presetn)
       		 begin
       			 `uvm_info("MON", "SYSTEM RESET DETECTED", UVM_NONE);
				  req.presetn=vif.presetn;
				  req.optr = rst_dut;
       		 end
          else if(vif.presetn && vif.pwrite)begin
              		@(negedge vif.pready);
					req.optr = writereq;
					req.presetn = vif.presetn;
					req.paddr = vif.paddr;
					req.pwrite = vif.pwrite;
					req.pwdata = vif.pwdata;
					req.psel = vif.psel;
					req.prdata=vif.prdata;
					req.pslverr = vif.pslverr;
            `uvm_info(get_type_name(),$sformatf(" WRITE MODE DATA FROM DUT | presetn= %0d , psel = %0d , pwrite = %0d , paddr = %0d , pwdata = %0d , prdata = %0d , pslverr = %0d",vif.presetn,vif.psel,vif.pwrite,vif.paddr,vif.pwdata,vif.prdata,vif.pslverr),UVM_LOW);
				end
            else if(vif.presetn && !vif.pwrite) begin
                   @(negedge vif.pready);
					req.optr = readreq;
					req.presetn = vif.presetn;
					req.paddr = vif.paddr;
					req.pwrite = vif.pwrite;
					req.pwdata = vif.pwdata;
					req.psel = vif.psel;
					req.prdata=vif.prdata;
					req.pslverr = vif.pslverr;
            `uvm_info(get_type_name(),$sformatf(" READ MODE DATA FROM DUT | presetn= %0d , psel = %0d , pwrite = %0d , paddr = %0d , prdata = %0d , pslverr = %0d",vif.presetn,vif.psel,vif.pwrite,vif.paddr,vif.prdata,vif.pslverr),UVM_LOW);
			    end
		  send.write(req);
		end
	endtask 
endclass