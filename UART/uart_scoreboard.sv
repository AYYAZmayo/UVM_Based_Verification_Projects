class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	function new(string name="scoreboard", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
	uvm_analysis_imp#(transaction,scoreboard) imp;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		imp=new("imp",this);
	endfunction
	
	virtual function void write(input transaction ts);
		if(ts.rst)begin
			`uvm_info("scoreboard","Reset state dected",UVM_NONE);
		end
		else begin
          if(ts.rx_out ==ts.tx_data) begin
				`uvm_info("scoreboard",$sformatf("TEST PASSED : tx_data =%0d, tx_err=%0d , rx_out=%0d, rx_err=%0d ",ts.tx_data,ts.tx_err,ts.rx_out,ts.rx_err),UVM_NONE);
			end
			else begin
              `uvm_info("scoreboard",$sformatf("TEST Failed : tx_data =%0d, tx_err=%0d , rx_out=%0d, rx_err=%0d ",ts.tx_data,ts.tx_err,ts.rx_out,ts.rx_err),UVM_NONE);
			end
		end
      $display("-------------------------------------------------------------------------------");
	endfunction
endclass
////////////////////////////////////////////////////////////////////////////////////
