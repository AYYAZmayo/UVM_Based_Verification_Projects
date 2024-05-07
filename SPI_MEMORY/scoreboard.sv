class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	function new(string name="scoreboard", uvm_component parent=null);
		super.new(name,parent);
	endfunction
	
  bit [7:0] array[31:0] ='{default:0};
	bit [7:0]data_rd;
	transaction tr;
	uvm_analysis_imp#(transaction,scoreboard) imp;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tr=transaction::type_id::create("tr");
		imp=new("imp",this);
	endfunction
	
virtual function void write(transaction tr);
  if(tr.opr == reset_dut)
              begin
                `uvm_info("SCO", "SYSTEM RESET DETECTED", UVM_NONE);
              end  
  else if (tr.opr == write_d)
      begin
        if(tr.err == 1'b1)
                begin
                  `uvm_info("SCO", "SLV ERROR during WRITE OP", UVM_NONE);
                end
              else
                begin
                array[tr.addr] = tr.din;
                  `uvm_info("SCO", $sformatf("DATA WRITE OP  addr:%0d, wdata:%0d arr_wr:%0d",tr.addr,tr.din,  array[tr.addr]), UVM_NONE);
                end
      end
  else if (tr.opr == read_d)
      begin
          if(tr.err == 1'b1)
                begin
                  `uvm_info("SCO", "SLV ERROR during READ OP", UVM_NONE);
                end
              else 
                begin
                  data_rd = array[tr.addr];
                  if (data_rd == tr.dout)
                    `uvm_info("SCO", $sformatf("DATA MATCHED : addr:%0d, rdata:%0d",tr.addr,tr.dout), UVM_NONE)
                         else
                     `uvm_info("SCO",$sformatf("TEST FAILED : addr:%0d, rdata:%0d data_rd_arr:%0d",tr.addr,tr.dout,data_rd), UVM_NONE) 
                end
 
      end
     
  
    $display("----------------------------------------------------------------");
    endfunction
  
  
  
  
endclass
////////////////////////////////////////////////////////////////////////////////////
