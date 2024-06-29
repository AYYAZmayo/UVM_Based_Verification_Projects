class driver extends uvm_driver#(transaction);
	`uvm_component_utils(driver)
	
	function new(string name="driver", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	virtual apb_if vif;
	transaction req;
	
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
        req=transaction::type_id::create("req");
		if (!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
			`uvm_error(get_type_name(),"Config DB failed")
	endfunction
	
	task reset_dut();
      `uvm_info(get_type_name(),"DUT RESET at the START",UVM_LOW);
		repeat (5) begin
		vif.presetn<=0;
		vif.paddr<='b0;
		vif.pwrite<='b0;
		vif.pwdata<='b0;
		vif.psel<='b0;
		vif.penable<='b0;
		end
		@(posedge vif.pclk);
	endtask
	
	task run_phase(uvm_phase phase);
		reset_dut();
		forever begin
			seq_item_port.get_next_item(req);
			if(req.optr==rst_dut)begin
				vif.presetn<=0;
				vif.paddr<='b0;
				vif.pwrite<='b0;
				vif.pwdata<='b0;
				vif.psel<='b0;
				vif.penable<='b0;
				@(posedge vif.pclk);
                `uvm_info(get_type_name()," DUT RESET IS APPLIED",UVM_LOW);
				seq_item_port.item_done();
			end
			else begin
				if(req.optr==writereq)begin
					vif.presetn<=1;
					vif.paddr<=req.paddr;
					vif.pwrite<='b1;
					vif.pwdata<=req.pwdata;
					vif.psel<='b1;
					@(posedge vif.pclk);
					vif.penable<='b1;
                  `uvm_info(get_type_name(),$sformatf(" WRITE MODE DATA sent to DUT | presetn= %0d , psel = %0d , pwrite = %0d , paddr = %0d , pwdata = %0d",vif.presetn,vif.psel,vif.pwrite,vif.paddr,vif.pwdata),UVM_LOW);
					@(negedge vif.pready);
					vif.penable<='b0;
				end
				else if(req.optr==readreq) begin
					vif.presetn<=1;
					vif.paddr<=req.paddr;
					vif.pwrite<='b0;
					//vif.pwdata<=req.pwdata;
					vif.psel<='b1;
					@(posedge vif.pclk);
					vif.penable<='b1;
                  `uvm_info(get_type_name(),$sformatf(" READ MODE DATA sent to DUT | presetn= %0d , psel = %0d , pwrite = %0d , paddr = %0d",vif.presetn,vif.psel,vif.pwrite,vif.paddr),UVM_LOW);
					@(negedge vif.pready);
					vif.penable<='b0;
				end
				seq_item_port.item_done();
			end
		end
	endtask 
endclass