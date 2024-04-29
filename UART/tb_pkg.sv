
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 typedef enum bit [9:0] {
						rand_baud_single_stop = 0,
						rand_length_single_stop = 1,
						length_5_single_stop_with_parity = 2,
						length_6_single_stop_with_parity = 3,
						length_7_single_stop_with_parity = 4,
						length_8_single_stop_with_parity = 5,
						length_5_single_stop_withno_parity = 6,
						length_6_single_stop_withno_parity = 7,
						length_7_single_stop_withno_parity = 8,
						length_8_single_stop_withno_parity = 9} operate_modes;
						
 `include "uart_transaction.sv"        // transaction class
 `include "uart_sequences.sv"          // sequence class
 `include "uart_driver.sv"             // driver class
 `include "uart_monitor.sv"            // monitor class
 `include "uart_agent.sv"              // agent class  
 `include "uart_coverage.sv"           // coverage class
 `include "uart_scoreboard.sv"		   // scoreboard class
 `include "uart_env.sv"                // environment class

 `include "uart_test.sv"               // test

endpackage
`endif 

