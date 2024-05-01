# Clock Generator
  This is a clock generator desing which can generate different clock frequencies based on system clock signal (clk). Basically this acts as baud rate generator and based on specific input baud signal of 16 bit it generates respective clock frequency. The supported baud values are
  - 4800
  - 9600
  - 14400
  - 19200
  - 38400
  - 57600
# Design Schematic
!
# UVM Testbench Architecture
![UVM_architecture drawio (1)](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/c5685c86-e464-49bb-b6b0-05cc8c96ebde)
# Simulation Waveform
!
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
     =====================================================================
     |            Covergroup             |   Hits   |  Goal /  | Status  |
     |                                   |          | At Least |         |
     =====================================================================
     | TYPE /coverage_subscriber/dut_cov | 100.000% | 100.000% | Covered |
     =====================================================================
     | INSTANCE <UNNAMED1>               | 100.000% | 100.000% | Covered |
     |-----------------------------------|----------|----------|---------|
     | COVERPOINT <UNNAMED1>::sel        | 100.000% | 100.000% | Covered |
     |-----------------------------------|----------|----------|---------|
     | bin auto[0]                       |       13 |        1 | Covered |
     | bin auto[1]                       |       12 |        1 | Covered |
     | bin auto[2]                       |       12 |        1 | Covered |
     | bin auto[3]                       |       12 |        1 | Covered |
     |-----------------------------------|----------|----------|---------|
     | COVERPOINT <UNNAMED1>::x          | 100.000% | 100.000% | Covered |
     |-----------------------------------|----------|----------|---------|
     | bin auto[0]                       |        3 |        1 | Covered |
     | bin auto[1]                       |        3 |        1 | Covered |
     | bin auto[2]                       |        3 |        1 | Covered |
     | bin auto[3]                       |        3 |        1 | Covered |
     | bin auto[4]                       |        3 |        1 | Covered |
     | bin auto[5]                       |        3 |        1 | Covered |
     | bin auto[6]                       |        3 |        1 | Covered |
     | bin auto[7]                       |        3 |        1 | Covered |
     | bin auto[8]                       |        4 |        1 | Covered |
     | bin auto[9]                       |        3 |        1 | Covered |
     | bin auto[10]                      |        3 |        1 | Covered |
     | bin auto[11]                      |        3 |        1 | Covered |
     | bin auto[12]                      |        3 |        1 | Covered |
     | bin auto[13]                      |        3 |        1 | Covered |
     | bin auto[14]                      |        3 |        1 | Covered |
     | bin auto[15]                      |        3 |        1 | Covered |
     |-----------------------------------|----------|----------|---------|
     | COVERPOINT <UNNAMED1>::y          | 100.000% | 100.000% | Covered |
     |-----------------------------------|----------|----------|---------|
     | bin auto[0]                       |       37 |        1 | Covered |
     | bin auto[1]                       |       12 |        1 | Covered |
     =====================================================================
