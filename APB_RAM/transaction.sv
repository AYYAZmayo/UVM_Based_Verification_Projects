
class transaction extends uvm_sequence_item;
	//`uvm_object_utils(transaction)
	
	// Constructor
	function new(string name ="transaction");
		super.new(name);
	endfunction
	
	// signals
  rand operation optr;
  logic              presetn;
  rand logic       [31:0] paddr;
  logic              pwrite;
  rand logic       [31:0] pwdata;
  logic              psel;
  logic       [31:0] prdata;
  logic              pslverr;
	
	`uvm_object_utils_begin(transaction)
		`uvm_field_enum(operation,optr,UVM_DEFAULT)
		`uvm_field_int(presetn,UVM_ALL_ON)
		`uvm_field_int(psel,UVM_ALL_ON)
		`uvm_field_int(pwrite,UVM_ALL_ON)
		`uvm_field_int(paddr,UVM_ALL_ON)
		`uvm_field_int(pwdata,UVM_ALL_ON)
		`uvm_field_int(prdata,UVM_ALL_ON)
		`uvm_field_int(pslverr,UVM_ALL_ON)
	`uvm_object_utils_end
	
	constraint paddr_valid {paddr <=31;}
	
endclass

	