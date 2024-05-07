class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)
	
	function new(string name="transaction");
		super.new();
	endfunction
	
	rand operate_modes opr;
	randc logic [7:0]addr;
	randc logic [7:0]din;
	
	rand logic wr;
	logic rst;
	logic [7:0] dout;
	logic err;
	
  constraint addr_valid {addr <=31;}
  constraint addr_invalid {addr > 31;}
	
endclass
