class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)
	function new(string name="monitor", uvm_component parent =null);
		super.new(name,parent);
	endfunction

	virtual top_if vif;
	uvm_analysis_port #(transaction) mon_ap;
	
	transaction tr;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mon_ap=new("mon_ap",this);
		if(!uvm_config_db#(virtual top_if)::get(this, "","vif",vif))
			`uvm_error(get_type_name(),"configDB access failed");
	endfunction
	
	
	virtual task run_phase(uvm_phase phase);
		forever begin
			@(posedge vif.pclk);
			if(vif.psel && vif.penable && vif.presetn) begin //if we reach there then we already consumed 2 clock ticks
				tr=transaction::type_id::create("tr");
				tr.paddr = vif.paddr;
				tr.pwrite = vif.pwrite;
				
				if(vif.pwrite)begin
                    tr.pwdata = vif.pwdata;
					@(posedge vif.pclk); // 3 clock ticks as in driver
					`uvm_info(get_type_name(),$sformatf("MODE : WRITE | pwdata : %0d | paddr : %0d | pwrite : %0d",vif.pwdata,vif.paddr,vif.pwrite),UVM_NONE)
				end
				else begin
					@(posedge vif.pclk); // 3 clock ticks as in driver for read
					`uvm_info(get_type_name(),$sformatf("MODE : READ | prdata : %0d | paddr : %0d | pwrite : %0d",vif.prdata,vif.paddr,vif.pwrite),UVM_NONE)
					tr.prdata= vif.prdata;
				end
              mon_ap.write(tr);
			end
		end
	endtask
endclass