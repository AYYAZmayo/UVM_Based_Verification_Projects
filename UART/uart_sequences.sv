class rand_baud_1_stop extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_baud_1_stop)
  function new(string name= "rand_baud_1_stop");
		super.new();
	endfunction
	
	transaction tr;
	
	virtual task body();
      repeat (10) begin
			tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = rand_baud_single_stop;
			tr.rst=0;
			tr.length= 8; //fixed length
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=1;
			tr.stop2 =0; // single stop
			finish_item(tr);
		end
	endtask
endclass
//////////////////////////////////////////////////////////////////////////////
class rand_length_1_stop extends uvm_sequence#(transaction);
  `uvm_object_utils(rand_length_1_stop)
  function new(string name= "rand_length_1_stop");
		super.new();
	endfunction
	
	transaction tr;
	
	virtual task body();
      repeat (10) begin
			tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = rand_length_single_stop;
			tr.rst=0;
			//tr.length= 8; //Random length
			tr.baud=9600;  //fix baud
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=1;
			tr.stop2 =0; // single stop
			finish_item(tr);
		end
	endtask
endclass
//////////////////////////////////////////////////////////////////////////////
class length_5_1_stop_with_parity extends uvm_sequence#(transaction);
  `uvm_object_utils(length_5_1_stop_with_parity)
  function new(string name="length_5_1_stop_with_parity");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
		repeat(10) begin
          	tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = length_5_single_stop_with_parity;
			tr.rst=0;
			tr.length= 5; //fix length=5
			//tr.baud=9600;  //random baud
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=1;
			tr.stop2 =0; // single stop
          finish_item(tr);
		end
	endtask
endclass
////////////////////////////////////////////////////////////////////////////////
class length_6_1_stop_with_parity extends uvm_sequence#(transaction);
  `uvm_object_utils(length_6_1_stop_with_parity)
  function new(string name="length_6_1_stop_with_parity");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
      repeat(10) begin
            tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = length_6_single_stop_with_parity;
			tr.rst=0;
			tr.length= 6; //fix length=6
			//tr.baud=9600;  //random baud
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=1; //with parity random type
			tr.stop2 =0; // single stop
			finish_item(tr);
		end
	endtask
endclass
////////////////////////////////////////////////////////////////////////////////
class length_7_1_stop_with_parity extends uvm_sequence#(transaction);
  `uvm_object_utils(length_7_1_stop_with_parity)
  function new(string name="length_7_1_stop_with_parity");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
      repeat(10) begin
            tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = length_7_single_stop_with_parity;
			tr.rst=0;
			tr.length= 7; //fix length=7
			//tr.baud=9600;  //random baud
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=1; //with parity random type
			tr.stop2 =0; // single stop
			finish_item(tr);
		end
	endtask
endclass
////////////////////////////////////////////////////////////////////////////////////////
class length_8_1_stop_with_parity extends uvm_sequence#(transaction);
  `uvm_object_utils(length_8_1_stop_with_parity)
  function new(string name="length_8_1_stop_with_parity");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
      repeat(10) begin
            tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = length_8_single_stop_with_parity;
			tr.rst=0;
			tr.length= 8; //fix length=8
			//tr.baud=9600;  //random baud
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=1; //with parity random type
			tr.stop2 =0; // single stop
			finish_item(tr);
		end
	endtask
endclass
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
class length_5_1_stop_withno_parity extends uvm_sequence#(transaction);
  `uvm_object_utils(length_5_1_stop_withno_parity)
  function new(string name="length_5_1_stop_withno_parity");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
		repeat(10) begin
          	tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = length_5_single_stop_withno_parity;
			tr.rst=0;
			tr.length= 5; //fix length=5
			//tr.baud=9600;  //random baud
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=0; //with no parity
			tr.stop2 =0; // single stop
          finish_item(tr);
		end
	endtask
endclass
////////////////////////////////////////////////////////////////////////////////
class length_6_1_stop_withno_parity extends uvm_sequence#(transaction);
  `uvm_object_utils(length_6_1_stop_withno_parity)
  function new(string name="length_6_1_stop_withno_parity");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
      repeat(10) begin
            tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = length_6_single_stop_withno_parity;
			tr.rst=0;
			tr.length= 6; //fix length=6
			//tr.baud=9600;  //random baud
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=0; //with no parity 
			tr.stop2 =0; // single stop
			finish_item(tr);
		end
	endtask
endclass
////////////////////////////////////////////////////////////////////////////////
class length_7_1_stop_withno_parity extends uvm_sequence#(transaction);
  `uvm_object_utils(length_7_1_stop_withno_parity)
  function new(string name="length_7_1_stop_withno_parity");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
      repeat(10) begin
            tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = length_7_single_stop_withno_parity;
			tr.rst=0;
			tr.length= 7; //fix length=7
			//tr.baud=9600;  //random baud
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=0; //with no parity 
			tr.stop2 =0; // single stop
			finish_item(tr);
		end
	endtask
endclass
////////////////////////////////////////////////////////////////////////////////////////
class length_8_1_stop_withno_parity extends uvm_sequence#(transaction);
  `uvm_object_utils(length_8_1_stop_withno_parity)
  function new(string name="length_8_1_stop_withno_parity");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
      repeat(10) begin
            tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.opr = length_8_single_stop_withno_parity;
			tr.rst=0;
			tr.length= 8; //fix length=8
			//tr.baud=9600;  //random baud
			tr.tx_start=1;
			tr.rx_start=1;
			tr.parity_en=0; //with no parity 
			tr.stop2 =0; // single stop
			finish_item(tr);
		end
	endtask
endclass
//////////////////////////////////////////////////////////////////////////////
class reset_seq extends uvm_sequence#(transaction);
	`uvm_object_utils(reset_seq)
	function new(string name="reset_seq");
		super.new(name);
	endfunction
	
	transaction tr;
	
	virtual task body();
		repeat(2) begin
			tr=transaction:: type_id::create("tr");
			start_item(tr);
			assert(tr.randomize());
			tr.rst=1'b1;
			finish_item(tr);
		end
	endtask
endclass
///////////////////////////////////////////////////////////////////////
