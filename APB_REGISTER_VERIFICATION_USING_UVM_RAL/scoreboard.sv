class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)
	function new(string name="scoreboard", uvm_component parent =null);
		super.new(name,parent);
	endfunction
	
	uvm_analysis_imp#(transaction,scoreboard) sco_imp;

	
  bit [31:0] arr [20]= '{default:0};
    bit [31:0] tmp_data;
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sco_imp=new("sco_imp",this);
		
	endfunction
	
	virtual function void write(transaction tr);
		if(tr.pwrite)begin
			arr[tr.paddr] = tr.pwdata;
			`uvm_info(get_type_name(),$sformatf("WRITE DATA Stored | pWDATA : %0d | pADDR : %0d",tr.pwdata,tr.paddr),UVM_NONE)
		end
		else begin
			tmp_data = arr[tr.paddr];
			if(tr.prdata == tmp_data)begin
				`uvm_info(get_type_name(),$sformatf("TEST PASSED | pRDATA : %0d | pADDR : %0d",tr.prdata,tr.paddr),UVM_NONE);
			end
			else begin
				`uvm_info(get_type_name(),"TEST FAILED DATA MISMATCHED",UVM_NONE);
			end
		end
	$display("--------------------------------------------------");
	endfunction
	
endclass