class coverage_sub extends uvm_subscriber#(transaction);
  `uvm_component_utils(coverage_sub)
  transaction tr;
  
  function new(string name="coverage_sub",uvm_component parent=null);
    super.new(name,parent);
	covg=new();
  endfunction
  
  covergroup covg;
    option.per_instance=1;
    
    addr:coverpoint tr.addr{
      bins addr_valid[]={[0:31]};
      bins addr_invalid[]={[31:255]};
    }
    
    din:coverpoint tr.din{
      bins low_din={[0:100]};
      bins medium_din ={[101:200]};
      bins high_din ={[201:255]};
    
    }
    
    wr:coverpoint tr.wr{
      bins write[]={1};
      bins read[]={0};
    }
    rst:coverpoint tr.rst{
      bins low[]={0};
      bins high[]={1};
    }
    
    dout:coverpoint tr.dout{
      bins low_din={[0:100]};
      bins medium_din ={[101:200]};
      bins high_din ={[201:255]};
    
    }
	
	err:coverpoint tr.err{
      bins low[]={0};
      bins high[]={1};
    }
	
	endgroup
	
	virtual function void write(transaction t);
		tr=t;
		covg.sample();
	endfunction
	
	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(),$sformatf("Coverage is %0f",covg.get_coverage()),UVM_NONE);
	endfunction
	
endclass