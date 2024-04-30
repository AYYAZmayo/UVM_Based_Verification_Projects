# D-FlipFlop
This design contains a single D-flipflop which is a pure sequential circuit. It has a clock, data-in and reset as input signals, and single data-out as output. It has synchronous reset as the DFF will only reset at the posedge of the clock.
# Design Schematic
![schematic](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/8e1642f8-b950-496e-96ff-ecf7a7fbbdb3)
# UVM Testbench Architecture
![UVM_architecture drawio (1)](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/c5685c86-e464-49bb-b6b0-05cc8c96ebde)
# Simulation Waveform
![image](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/3dc919cf-ec01-445e-a4ce-4054343c5ebf)
# Coverage Report

 SUMMARY
     =============================================
     |    Coverage Type    | Weight | Hits/Total |
     =============================================
     | Covergroup Coverage |      1 |   100.000% |
     |---------------------|--------|------------|
     | Types               |        |      1 / 1 |
     =============================================
     WEIGHTED AVERAGE LOCAL: 100.000%
 
 
     COVERGROUP COVERAGE
     =================================================================
     |          Covergroup           |   Hits   |  Goal /  | Status  |
     |                               |          | At Least |         |
     =================================================================
     | TYPE /coverage_sub/cov        | 100.000% | 100.000% | Covered |
     =================================================================
     | INSTANCE <UNNAMED1>           | 100.000% | 100.000% | Covered |
     |-------------------------------|----------|----------|---------|
     | COVERPOINT <UNNAMED1>::RST    | 100.000% | 100.000% | Covered |
     |-------------------------------|----------|----------|---------|
     | bin rst_high[1]               |       11 |        1 | Covered |
     | bin rst_low[0]                |       23 |        1 | Covered |
     |-------------------------------|----------|----------|---------|
     | COVERPOINT <UNNAMED1>::Din    | 100.000% | 100.000% | Covered |
     |-------------------------------|----------|----------|---------|
     | bin din_high[1]               |       15 |        1 | Covered |
     | bin din_low[0]                |       19 |        1 | Covered |
     |-------------------------------|----------|----------|---------|
     | COVERPOINT <UNNAMED1>::Dout   | 100.000% | 100.000% | Covered |
     |-------------------------------|----------|----------|---------|
     | bin dout_high[1]              |       14 |        1 | Covered |
     | bin dout_low[0]               |       20 |        1 | Covered |
     |-------------------------------|----------|----------|---------|
     | CROSS <UNNAMED1>::RST_x_Din   | 100.000% | 100.000% | Covered |
     |-------------------------------|----------|----------|---------|
     | bin <rst_high[1],din_high[1]> |        1 |        1 | Covered |
     | bin <rst_high[1],din_low[0]>  |       10 |        1 | Covered |
     | bin <rst_low[0],din_high[1]>  |       14 |        1 | Covered |
     | bin <rst_low[0],din_low[0]>   |        9 |        1 | Covered |
     =================================================================
