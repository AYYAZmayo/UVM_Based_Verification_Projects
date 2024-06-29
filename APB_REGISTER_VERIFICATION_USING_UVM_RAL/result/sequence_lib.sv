class cntrl_wr extends uvm_sequence;
	`uvm_object_utils(cntrl_wr)
	
	function new(string name="cntrl_wr");
		super.new(name);
	endfunction
	
	
	reg_block regmodel;
	
	task body();
		uvm_status_e status;
		bit [3:0] wdata;
       for(int i=0; i<2; i++)begin
			wdata =$urandom();
			regmodel.cntrl_inst.write(status,wdata);
		end
	endtask
endclass
////////////////////////////////////////////////////
class cntrl_rd extends uvm_sequence;
	`uvm_object_utils(cntrl_rd)
	
	function new(string name="cntrl_rd");
		super.new(name);
	endfunction
	
	
	reg_block regmodel;
	
	task body();
		uvm_status_e status;
		bit [3:0] rdata;
      for(int i=0; i<2; i++)begin
			regmodel.cntrl_inst.read(status,rdata);
		end
	endtask
endclass
////////////////////////////////////////////////////
class reg1_wr extends uvm_sequence;
  `uvm_object_utils(reg1_wr)
  
  function new(string name="reg1_wr");
    super.new(name);
  endfunction
  
  reg_block regmodel;
  
  task body();
    uvm_status_e status;
    bit [31:0] wrdata;
    for(int i=0; i<2; i++)begin
      wrdata=$urandom();
      regmodel.reg1_inst.write(status,wrdata);
    end
  endtask
endclass
//////////////////////////////////////////////////////
class reg1_rd extends uvm_sequence;
  `uvm_object_utils(reg1_rd)
  function new(string name="reg1_rd");
    super.new(name);
  endfunction
  
  reg_block regmodel;
  task body();
    uvm_status_e status;
    bit [31:0] rdata;
    for(int i=0; i<2; i++)begin
      regmodel.reg1_inst.read(status,rdata);
    end
  endtask
endclass
/////////////////////////////////////////////////////
////////////////////////////////////////////////////
class reg2_wr extends uvm_sequence;
  `uvm_object_utils(reg2_wr)
  
  function new(string name="reg2_wr");
    super.new(name);
  endfunction
  
  reg_block regmodel;
  
  task body();
    uvm_status_e status;
    bit [31:0] wrdata;
    for(int i=0; i<2; i++)begin
      wrdata=$urandom();
      regmodel.reg2_inst.write(status,wrdata);
    end
  endtask
endclass
//////////////////////////////////////////////////////
class reg2_rd extends uvm_sequence;
  `uvm_object_utils(reg2_rd)
  function new(string name="reg2_rd");
    super.new(name);
  endfunction
  
  reg_block regmodel;
  task body();
    uvm_status_e status;
    bit [31:0] rdata;
    for(int i=0; i<2; i++)begin
      regmodel.reg2_inst.read(status,rdata);
    end
  endtask
endclass
/////////////////////////////////////////////////////
////////////////////////////////////////////////////
class reg3_wr extends uvm_sequence;
  `uvm_object_utils(reg3_wr)
  
  function new(string name="reg3_wr");
    super.new(name);
  endfunction
  
  reg_block regmodel;
  
  task body();
    uvm_status_e status;
    bit [31:0] wrdata;
    for(int i=0; i<2; i++)begin
      wrdata=$urandom();
      regmodel.reg3_inst.write(status,wrdata);
    end
  endtask
endclass
//////////////////////////////////////////////////////
class reg3_rd extends uvm_sequence;
  `uvm_object_utils(reg3_rd)
  function new(string name="reg3_rd");
    super.new(name);
  endfunction
  
  reg_block regmodel;
  task body();
    uvm_status_e status;
    bit [31:0] rdata;
    for(int i=0; i<2; i++)begin
      regmodel.reg3_inst.read(status,rdata);
    end
  endtask
endclass
/////////////////////////////////////////////////////
////////////////////////////////////////////////////
class reg4_wr extends uvm_sequence;
  `uvm_object_utils(reg4_wr)
  
  function new(string name="reg4_wr");
    super.new(name);
  endfunction
  
  reg_block regmodel;
  
  task body();
    uvm_status_e status;
    bit [31:0] wrdata;
    for(int i=0; i<2; i++)begin
      wrdata=$urandom();
      regmodel.reg4_inst.write(status,wrdata);
    end
  endtask
endclass
//////////////////////////////////////////////////////
class reg4_rd extends uvm_sequence;
  `uvm_object_utils(reg4_rd)
  function new(string name="reg4_rd");
    super.new(name);
  endfunction
  
  reg_block regmodel;
  task body();
    uvm_status_e status;
    bit [31:0] rdata;
    for(int i=0; i<2; i++)begin
      regmodel.reg4_inst.read(status,rdata);
    end
  endtask
endclass
/////////////////////////////////////////////////////