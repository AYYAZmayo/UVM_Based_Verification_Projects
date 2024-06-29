class driver extends uvm_driver#(transaction);
	`uvm_component_utils(driver)
	
	function new(string name="driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	transaction tr;
	virtual top_if vif;
	
	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		//tr=transaction::type_id::create("tr");
		if(!uvm_config_db#(virtual top_if)::get(this,"","vif",vif))
			`uvm_error(get_type_name(),"CONFIG_DB Access is failed");
	endfunction
	
	task write ();
		@(posedge vif.pclk);
		vif.psel <= 1'b1;
		vif.pwrite <= 1'b1;
		vif.paddr <= tr.paddr;
		vif.pwdata <= tr.pwdata;
		@(posedge vif.pclk);
		vif.penable <= 1'b1;
		`uvm_info(get_type_name(),$sformatf("MODE : WRITE | pwdata : %0d | paddr : %0d | pwrite : %0d",tr.pwdata,tr.paddr,vif.pwrite),UVM_NONE)
		@(posedge vif.pclk);
		vif.psel <= 1'b0;
		vif.penable <= 1'b0;
	endtask
	
	task read ();
		@(posedge vif.pclk);
		vif.psel <= 1'b1;
		vif.pwrite <= 1'b0;
		vif.paddr <= tr.paddr;

		@(posedge vif.pclk);
		vif.penable <= 1'b1;
      `uvm_info(get_type_name(),$sformatf("MODE : READ | paddr : %0d | pwrite : %0d",tr.paddr,vif.pwrite),UVM_NONE)
		@(posedge vif.pclk);
		vif.psel <= 1'b0;
		vif.penable <= 1'b0;
		tr.prdata <= vif.prdata;
	endtask
	
	virtual task run_phase(uvm_phase phase);
		vif.presetn <= 1'b1;
		vif.psel <= 1'b0;
		vif.penable <= 1'b0;
		vif.pwrite <= 1'b0;
		vif.pwdata <= 'b0;
		vif.paddr <= 'b0;
		forever begin
			tr=transaction::type_id::create("tr");
			seq_item_port.get_next_item(tr);
			if(tr.pwrite)begin
				write();
			end
			else begin
				read();
			end
			seq_item_port.item_done();
		end
    endtask
endclass