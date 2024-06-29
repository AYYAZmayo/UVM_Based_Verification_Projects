`include "i2c_mem_pkg.sv"

module top;
  
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	import i2c_mem_pkg::*;
	
	i2c_i vif();
  
    i2c_mem dut (.clk(vif.clk), .rst(vif.rst), .wr(vif.wr), .addr(vif.addr), .din(vif.din), .datard(vif.datard), .done(vif.done));
  
	initial begin
		vif.clk <= 0;
	end
	// Generate clock
	always #10 vif.clk <= ~vif.clk;
 
	initial begin
		uvm_config_db#(virtual i2c_i)::set(null, "*", "vif", vif);
		run_test("base_test");
	end
  
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end
  
endmodule 