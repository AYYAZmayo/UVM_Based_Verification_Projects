class write_data extends uvm_sequence#(transaction);
	`uvm_object_utils(write_data);
	
	transaction tr;
	
	
	function new(string name="write_data");
		super.new(name);
	endfunction
	
	task body();
      repeat(50) begin
			tr=transaction::type_id::create("tr");
			//applying address constraints
			tr.addr_valid.constraint_mode(1);
			tr.addr_invalid.constraint_mode(0);
			start_item(tr);
			assert(tr.randomize());
			tr.opr=write_d; // write mode selected
			finish_item(tr);
		end
	endtask
	
endclass
//////////////////////////////////////////////////////////////
class read_data extends uvm_sequence#(transaction);
	`uvm_object_utils(read_data)
	
	function new(string name="read_data");
		super.new(name);
	endfunction
	
	
	transaction tr;
	
	task body();
      repeat(50)begin
			tr=transaction::type_id::create("tr");
			tr.addr_valid.constraint_mode(1);
			tr.addr_invalid.constraint_mode(0);
			start_item(tr);
			assert(tr.randomize());
			tr.opr=read_d;
			finish_item(tr);
		end
	
	endtask
endclass
///////////////////////////////////////////////////////
class rst_dut extends uvm_sequence#(transaction);
	`uvm_object_utils(rst_dut)
	transaction tr;
	
	function new(string name="rst_dut");
		super.new(name);
	endfunction
	
	
	task body();
		repeat(1) begin
			tr=transaction::type_id::create("tr");
          	tr.addr_valid.constraint_mode(1);
			tr.addr_invalid.constraint_mode(0);
			start_item(tr);
			assert(tr.randomize());
			tr.opr=reset_dut;
			finish_item(tr);
		end
	endtask
endclass

//////////////////////////////////////////////////////
class write_error extends uvm_sequence#(transaction);
	`uvm_object_utils(write_error)
	
	transaction tr;
	
	function new(string name ="write_error");
		super.new(name);
	endfunction
	
	task body();
      repeat(5)begin
			tr=transaction::type_id::create("tr");
        	tr.addr_invalid.constraint_mode(1);
        	tr.addr_valid.constraint_mode(0);
        
			start_item(tr);
			assert(tr.randomize());
			tr.opr=write_d;
			finish_item(tr);
		end
	endtask
	
endclass
/////////////////////////////////////////////////////////////	
class read_error extends uvm_sequence#(transaction);
	`uvm_object_utils(read_error)
	
	transaction tr;
	
	function new(string name ="read_error");
		super.new(name);
	endfunction
	
	task body();
      repeat(5)begin
			tr=transaction::type_id::create("tr");
        	tr.addr_invalid.constraint_mode(1);	
        	tr.addr_valid.constraint_mode(0);
        
			start_item(tr);
			assert(tr.randomize());
			tr.opr=read_d;
			finish_item(tr);
		end
	endtask
endclass
///////////////////////////////////////////////////////////////////////	
class write_read_random extends uvm_sequence#(transaction);
	`uvm_object_utils(write_read_random)
	
	transaction tr;
	
	function new(string name ="write_read_random");
		super.new(name);
	endfunction
	
	task body();
      	repeat(250)begin
			tr=transaction::type_id::create("tr");
          	tr.addr_valid.constraint_mode(1);
			tr.addr_invalid.constraint_mode(0);
			start_item(tr);
			assert(tr.randomize());
            if(tr.wr)
				tr.opr=write_d;
            else
            	tr.opr=read_d;
          
		  finish_item(tr);
		end
	endtask
endclass
/////////////////////////////////////////////////////////////////////////////////////
class write_burst_read_burst extends uvm_sequence#(transaction);
	`uvm_object_utils(write_burst_read_burst)
	
	transaction tr;
	
	function new(string name ="write_burst_read_burst");
		super.new(name);
	endfunction
	
	task body();
		//write burst
            repeat(50)begin
			tr=transaction::type_id::create("tr");
          	tr.addr_valid.constraint_mode(1);
			tr.addr_invalid.constraint_mode(0);
			start_item(tr);
			assert(tr.randomize());
			tr.opr=write_d;
			finish_item(tr);
		end
		
		//Read burst
            repeat(50)begin
			tr=transaction::type_id::create("tr");
          	tr.addr_valid.constraint_mode(1);
			tr.addr_invalid.constraint_mode(0);
			start_item(tr);
			assert(tr.randomize());
			tr.opr=read_d;
			finish_item(tr);
		end
	endtask
endclass
//////////////////////////////////////////////////////////////////////