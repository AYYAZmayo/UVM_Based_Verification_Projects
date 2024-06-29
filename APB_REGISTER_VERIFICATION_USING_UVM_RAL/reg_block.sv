class cntrl_reg extends uvm_reg;
	`uvm_object_utils(cntrl_reg)
	
	function new(string name="cntrl_reg");
		super.new(name,4,UVM_NO_COVERAGE);
	endfunction
	
	rand uvm_reg_field cntrl;
	
	function void build();
		cntrl = uvm_reg_field::type_id::create("cntrl");
      cntrl.configure(this,4,0,"RW",0,4'h0,1,1,1); //(this,reg-size,lsb_position,acess_type,volatile,reset_value,rest_en,...)
	endfunction
	
endclass

class reg1_reg extends uvm_reg;
	`uvm_object_utils(reg1_reg)
	
	function new(string name="reg1_reg");
		super.new(name,32,UVM_NO_COVERAGE);
	endfunction
	
	rand uvm_reg_field reg1;
	
	function void build();
		reg1= uvm_reg_field::type_id::create("reg1");
      reg1.configure(this,32,0,"RW", 0,32'h0,1,1,1);
	endfunction
	
endclass

class reg2_reg extends uvm_reg;
	`uvm_object_utils(reg2_reg)
	
	function new(string name = "reg2_reg");
		super.new(name,32,UVM_NO_COVERAGE);
	endfunction
	
	rand uvm_reg_field reg2;
	
	function void build();
	
		reg2 = uvm_reg_field::type_id::create("reg2");
      reg2.configure(this,32,0,"RW", 0,32'h0,1,1,1);
		
	endfunction
endclass

class reg3_reg extends uvm_reg;
	`uvm_object_utils(reg3_reg)
	
	function new(string name = "reg3_reg");
		super.new(name,32,UVM_NO_COVERAGE);
	endfunction
	
	rand uvm_reg_field reg3;
	
	function void build();
	
		reg3 = uvm_reg_field::type_id::create("reg3");
      reg3.configure(this,32,0,"RW", 0,32'h0,1,1,1);
		
	endfunction
endclass

class reg4_reg extends uvm_reg;
	`uvm_object_utils(reg4_reg)
	
	function new(string name = "reg4_reg");
		super.new(name,32,UVM_NO_COVERAGE);
	endfunction
	
	rand uvm_reg_field reg4;
	
	function void build();
	
		reg4 = uvm_reg_field::type_id::create("reg4");
      reg4.configure(this,32,0,"RW", 0,32'h0,1,1,1);
		
	endfunction
endclass


class reg_block extends uvm_reg_block;
	`uvm_object_utils(reg_block)
	
	function new(string name="reg_block");
		super.new(name,UVM_NO_COVERAGE);
	endfunction
	
	cntrl_reg cntrl_inst;
	reg1_reg reg1_inst;
	reg2_reg reg2_inst;
	reg3_reg reg3_inst;
	reg4_reg reg4_inst;
	
	
	function void build();
		
		// cntrl reg
		cntrl_inst=cntrl_reg::type_id::create("cntrl_inst");
		cntrl_inst.build();
		cntrl_inst.configure(this);
		
		// reg1
		reg1_inst=reg1_reg::type_id::create("reg1_inst");
		reg1_inst.build();
		reg1_inst.configure(this);
		
		
		//reg2
		reg2_inst=reg2_reg::type_id::create("reg2_inst");
		reg2_inst.build();
		reg2_inst.configure(this);
		
		
		//reg3
		reg3_inst=reg3_reg::type_id::create("reg3_inst");
		reg3_inst.build();
		reg3_inst.configure(this);
		
		
		//reg4
		reg4_inst=reg4_reg::type_id::create("reg4_inst");
		reg4_inst.build();
		reg4_inst.configure(this);
		
		//create address MAP
      default_map =create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);
		
		default_map.add_reg(cntrl_inst, 'h0, "RW"); //(reg , offset_addr, access_type)
		default_map.add_reg(reg1_inst, 'h4, "RW");
		default_map.add_reg(reg2_inst, 'h8, "RW");
		default_map.add_reg(reg3_inst, 'hc, "RW");
        default_map.add_reg(reg4_inst, 'h10, "RW");
		
		lock_model();
		
	endfunction
		
endclass
	