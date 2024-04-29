class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)
	//Constructor
	function new(string name="transaction");
		super.new(name);
	endfunction
	//Signals
	operate_modes opr;
	logic tx_start, rx_start, rst, stop2, tx_done, rx_done, tx_err, rx_err;
	logic [7:0] rx_out;
	rand logic [7:0] tx_data;
	rand logic[16:0] baud;
	rand logic [3:0]length;
	rand logic parity_en, parity_type;
	//constraints
	constraint buad_c {baud inside {4800, 9600, 14400, 19200, 38400, 57600};}
  constraint length_c {length inside {5,6,7,8};}
endclass