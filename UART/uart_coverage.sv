
class uart_coverage extends uvm_subscriber #(transaction);

  `uvm_component_utils(uart_coverage)

  function new(string name="uart_coverage",uvm_component parent);
    super.new(name,parent);
    dut_cov=new();
  endfunction

  transaction tr;
  real cov;

  covergroup dut_cov;
    option.per_instance=1;
    
    BAUD:coverpoint tr.baud ;
    LENGTH:coverpoint tr.length;
	PARITY:coverpoint tr.parity_type;
	
    BAUD_X_LENGTH:cross BAUD,LENGTH;
    
    TX_DATA:coverpoint tr.tx_data { option.auto_bin_max=255; }
    
  endgroup:dut_cov

  //---------------------  write method ----------------------------------------
  virtual function void write(input transaction t);
    tr=t;
    dut_cov.sample();
  endfunction
  //----------------------------------------------------------------------------
  
  virtual function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=dut_cov.get_coverage();
  endfunction

  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------
  
endclass
