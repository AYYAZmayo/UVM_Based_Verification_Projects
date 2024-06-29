
package apb_reg_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

  `include "transaction.sv"        // transaction class
  `include "monitor.sv"            // monitor class
  `include "reg_block.sv"
  
  `include "sequence_lib.sv"          // sequence class
  `include "driver.sv"             // driver class
  `include "agent.sv"   // agent class  
  `include "reg_adapter.sv"
// `include "coverage.sv"           // coverage class
  `include "scoreboard.sv"		   // scoreboard class
  `include "env.sv"                // environment class

 `include "test.sv"               // test

endpackage