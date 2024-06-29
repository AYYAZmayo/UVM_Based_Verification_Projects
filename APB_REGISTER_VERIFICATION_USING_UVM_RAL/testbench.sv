`include "package.sv"
module tb;
  
     import uvm_pkg::*;
	`include "uvm_macros.svh"
	 import apb_reg_pkg::*;
	 
  top_if vif();
    
  top dut (vif.pclk, vif.presetn, vif.paddr, vif.pwdata, vif.psel, vif.pwrite, vif.penable, vif.prdata);
 
  
  initial begin
   vif.pclk <= 0;
  end
 
  always #10 vif.pclk = ~vif.pclk;
 
  
  
  initial begin
    uvm_config_db#(virtual top_if)::set(null, "*", "vif", vif);
    run_test("test");
   end
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
 
  
endmodule