class driver extends uvm_driver#(transaction);
	`uvm_component_utils(driver)
	
	function new(string name="driver", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	virtual i2c_i vif;
	transaction req;
	
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
        req=transaction::type_id::create("req");
		if (!uvm_config_db#(virtual i2c_i)::get(this,"","vif",vif))
			`uvm_error(get_type_name(),"Config DB failed")
	endfunction
	
	task reset_dut();
      `uvm_info(get_type_name(),"DUT RESET at the START",UVM_LOW);
		repeat (5) begin
		//@(posedge vif.clk);
		vif.rst<=1;
		vif.addr<='b0;
		vif.wr<='b0;
		vif.din<='b0;
		end
		@(posedge vif.clk);
		//vif.rst<=0;
	endtask
	
	task run_phase(uvm_phase phase);
		reset_dut();
		forever begin
			seq_item_port.get_next_item(req);
				if(req.wr)begin
					vif.rst<=0;
					vif.addr<=req.addr;
					vif.wr<=req.wr;
					vif.din<=req.din;
                  @(posedge vif.clk);
                  `uvm_info(get_type_name(),$sformatf(" WRITE MODE DATA sent to DUT | rst= %0d , wr = %0d , addr = %0d , din = %0d",vif.rst,req.wr,req.addr,req.din),UVM_LOW);
				end
				else if(!req.wr) begin
					vif.rst<=0;
					vif.addr<=req.addr;
					vif.wr<=req.wr;
                  @(posedge vif.clk);
                  `uvm_info(get_type_name(),$sformatf("READ MODE DATA sent to DUT | rst= %0d , wr = %0d, addr = %0d ",vif.rst,req.wr,req.addr),UVM_LOW);
				end
			//`uvm_info(get_type_name(),$sformatf("DATA sent to DUT %s",req.sprint()),UVM_LOW);
			@(posedge vif.done);
			seq_item_port.item_done();
		end
	endtask 
endclass