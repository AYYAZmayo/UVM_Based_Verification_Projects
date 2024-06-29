
package i2c_mem_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"

  `include "transaction.sv"        // transaction class
  `include "monitor.sv"            // monitor class
  `include "sequencer.sv"
  `include "seqs_lib.sv"          // sequence class
  `include "driver.sv"             // driver class
  `include "agent.sv"              // agent class  
// `include "coverage.sv"           // coverage class
  `include "scoreboard.sv"		   // scoreboard class
  `include "env.sv"                // environment class

 `include "tests.sv"               // test

endpackage