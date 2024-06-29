class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)
	
	
	function new(string name="transaction");
		super.new(name);
	endfunction
	
	rand bit pwrite;
	rand bit [31:0] paddr;
	rand bit [31:0] pwdata;
		 bit [31:0] prdata;
	
	
	constraint reg_addr {
		paddr inside{0,4,8,12,16}; // {ctrl-addr ,reg1-addr ,reg2-addr ,reg3-addr,reg4-addr}
	}
endclass