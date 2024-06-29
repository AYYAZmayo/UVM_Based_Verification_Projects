class sco extends uvm_scoreboard;
`uvm_component_utils(sco)
 
  uvm_analysis_imp#(transaction,sco) recv;
  bit [31:0] arr[32] = '{default:0};
  bit [31:0] data_rd = 0;
 
 
 
    function new(input string inst = "sco", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    recv = new("recv", this);
    endfunction
    
    
  virtual function void write(transaction tr);
  
    if(tr.presetn == 1'b0)begin
        `uvm_info("SCO", "SYSTEM RESET DETECTED", UVM_NONE);
    end  
	
    else if (tr.optr == writereq) begin
		if(tr.pslverr)begin
			`uvm_info("SCO", $sformatf("SLVAE ERROR : paddr:%0d, prdata:%0d",tr.paddr,tr.prdata), UVM_NONE)
		end
		else begin
			arr[tr.paddr] = tr.pwdata;
			`uvm_info("SCO", $sformatf("DATA WRITE OP  paddr:%0d, pwdata:%0d, arr_wr:%0d",tr.paddr,tr.pwdata,  arr[tr.paddr]), UVM_NONE);
		end
	end
 
    else if (tr.optr == readreq) begin
		if(tr.pslverr)begin
			`uvm_info("SCO", $sformatf("SLVAE ERROR : paddr:%0d, prdata:%0d",tr.paddr,tr.prdata), UVM_NONE)
		end
		else begin
			data_rd = arr[tr.paddr];
			if (data_rd == tr.prdata)
				`uvm_info("SCO", $sformatf("DATA MATCHED : paddr:%0d, prdata:%0d",tr.paddr,tr.prdata), UVM_NONE)
            else
				`uvm_info("SCO",$sformatf("TEST FAILED : paddr:%0d, prdata:%0d data_rd_arr:%0d",tr.paddr,tr.prdata,data_rd), UVM_NONE) 
        end
     
	end
    $display("----------------------------------------------------------------");
    endfunction
 
endclass
 
