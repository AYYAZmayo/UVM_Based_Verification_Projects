# MUX4X1
 MUX is a combinational circuit that is used to transfer selectively one resource(signal) at a time to the output. This design contains a MUX which has 4 bits as input and a single bit as output, whereas a 2-bit sel line is used to select out of 4 bit inputs.
# Design Schematic
![Schematic](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/4a6bb2f1-fe62-4508-a697-d10b466b0e43)
# UVM Testbench Architecture
![UVM_architecture drawio (1)](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/c5685c86-e464-49bb-b6b0-05cc8c96ebde)
# Simulation Waveform
![waveform](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/1b976dd6-95e8-4e15-86ec-ee52599abcdf)
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
