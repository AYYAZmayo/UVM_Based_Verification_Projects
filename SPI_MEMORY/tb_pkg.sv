
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 typedef enum bit [2:0] {write_d=0, read_d=1, reset_dut=2,write_err=3, read_err=4} operate_modes;
						
 `include "transaction.sv"        // transaction class
 `include "sequences.sv"          // sequence class
 `include "driver.sv"             // driver class
 `include "monitor.sv"            // monitor class
 `include "agent.sv"              // agent class  
 `include "coverage.sv"           // coverage class
 `include "scoreboard.sv"		   // scoreboard class
 `include "env.sv"                // environment class

 `include "test.sv"               // test

endpackage
`endif 

