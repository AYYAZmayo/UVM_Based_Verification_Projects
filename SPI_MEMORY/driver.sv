class driver extends uvm_driver#(transaction);
	`uvm_component_utils(driver)
	
	function new(string name="driver", uvm_component parent =null);
		super.new(name,parent);
	endfunction
	
	transaction tr;
	virtual spi_i vif;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		if(!uvm_config_db#(virtual spi_i)::get(this,"","vif",vif))
			`uvm_error("driver","Config_DB acess failed");
	endfunction
	
  task rstdut();
 
    repeat(1) 
    begin
    vif.rst      <= 1'b1;  ///active high reset
    vif.addr     <= 'h0;
    vif.din      <= 'h0;
    vif.wr       <= 1'b0; 
   `uvm_info("DRV", "System Reset : Start of Simulation", UVM_MEDIUM);
    @(posedge vif.clk);
      end
  endtask
  
  task drive();
    rstdut();
   forever begin
     
         seq_item_port.get_next_item(tr);
     
     
                   if(tr.opr == reset_dut)
                          begin
                          vif.rst   <= 1'b1;
                          @(posedge vif.clk);  
                            `uvm_info("DRV", "System Reset : Reset sequence is applied", UVM_MEDIUM);
                          end
 
                   else if(tr.opr == write_d)
                          begin
					      vif.rst <= 1'b0;
                          vif.wr  <= 1'b1;
                          vif.addr <= tr.addr;
                          vif.din  <= tr.din;
                          @(posedge vif.clk);
                          `uvm_info("DRV", $sformatf("mode : Write addr:%0d din:%0d", vif.addr, vif.din), UVM_NONE);
                          @(posedge vif.done);
                          end
                else if(tr.opr ==  read_d)
                          begin
					      vif.rst  <= 1'b0;
                          vif.wr   <= 1'b0;
                          vif.addr <= tr.addr;
                          vif.din  <= tr.din;
                          @(posedge vif.clk);
                            `uvm_info("DRV", $sformatf("mode : Read addr:%0d din:%0d", vif.addr, vif.din), UVM_NONE);
                          @(posedge vif.done);
                          end
       seq_item_port.item_done();
     
   end
  endtask
  
  
  
    virtual task run_phase(uvm_phase phase);
    drive();
  endtask
endclass
