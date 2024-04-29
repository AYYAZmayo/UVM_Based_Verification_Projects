class driver extends uvm_driver #(transaction);
  `uvm_component_utils(driver)
  
  virtual uart_if vif;
  transaction tr;
  
  
  function new(input string path = "drv", uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
 virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     tr = transaction::type_id::create("tr");
      
   if(!uvm_config_db#(virtual uart_if)::get(this,"","vif",vif)) 
     `uvm_error("driver","Unable to access Interface");
  endfunction
  //task for dut reset
  task reset_dut();
 
    repeat(2) 
    begin
    vif.rst      <= 1'b1;  ///active high reset
    vif.tx_start <= 1'b0;
    vif.rx_start <= 1'b0;
    vif.tx_data  <= 8'h00;
    vif.baud     <= 16'h0;
    vif.length   <= 4'h0;
    vif.parity_type <= 1'b0;
    vif.parity_en   <= 1'b0;
    vif.stop2  <= 1'b0;
   `uvm_info("driver", "System Reset : Start of Simulation", UVM_MEDIUM);
    @(posedge vif.clk);
      end
  endtask
  
  task drive();
    reset_dut();
   forever begin
     
         seq_item_port.get_next_item(tr); 
		 
							case(tr.length)
							5:begin
								vif.tx_data     <= {3'b000,tr.tx_data[7:3]};
								end
							6:begin
								vif.tx_data     <= {2'b00,tr.tx_data[7:2]};
								end
							7:begin
								vif.tx_data     <= {1'b0,tr.tx_data[7:1]};
								end
							8:begin
								vif.tx_data     <= tr.tx_data;
								end
							endcase
							
                            vif.rst         <= 1'b0;
                            vif.tx_start    <= tr.tx_start;
                            vif.rx_start    <= tr.rx_start;
                            
                            vif.baud        <= tr.baud;
                            vif.length      <= tr.length;
                            vif.parity_type <= tr.parity_type;
                            vif.parity_en   <= tr.parity_en;
                            vif.stop2       <= tr.stop2;
     `uvm_info("driver",$sformatf("Baud = %0d, length = %0d, tx_data = %0d, tx_start = %0d, rx_sart = %0d, parity_en =%0d, parity_type =%0d, stop2 =%0d",
										tr.baud,tr.length,tr.tx_data, tr.tx_start, tr.rx_start, tr.parity_en,tr.parity_type, tr.stop2),UVM_NONE);
                            @(posedge vif.clk); 
                            @(posedge vif.tx_done);
							@(negedge vif.rx_done);
                            
     
       seq_item_port.item_done();
     
   end
  endtask
  
 
  virtual task run_phase(uvm_phase phase);
    drive();
  endtask
 
  
endclass
////////////////////////////////////////////////////////////////////////////////////////// 
