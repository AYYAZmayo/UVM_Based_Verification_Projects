//typedef enum bit [1:0] { write=0, read =1} mode;
class transaction extends uvm_sequence_item;
	//`uvm_object_utils(transaction)
	
	// Constructor
	
	function new(string name ="transaction");
		super.new(name);
	endfunction
	
	// signals
	//rand mode optr;
	logic wr, rst;
	rand logic [6:0]addr;
	rand logic [7:0]din;
	rand logic  [7:0]datard;
	
	`uvm_object_utils_begin(transaction)
		//`uvm_field_enum(mode,optr,UVM_ALL_ON);
		`uvm_field_int(wr,UVM_ALL_ON)
		`uvm_field_int(addr,UVM_ALL_ON)
		`uvm_field_int(din,UVM_ALL_ON)
		`uvm_field_int(datard,UVM_ALL_ON)
	`uvm_object_utils_end
	
	constraint addr_valid {addr <10;}
	
endclass

	