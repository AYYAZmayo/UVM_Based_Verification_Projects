# Clock Generator
  This is a clock generator design that can generate different clock frequencies based on the system clock signal (clk). Basically, this acts as a baud rate generator, and based on a specific input baud signal of 16 bit it generates respective clock frequency. The supported baud values are
  - 4800
  - 9600
  - 14400
  - 19200
  - 38400
  - 57600
# Design Schematic
![schematic](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/b757925f-45bc-413b-b4db-c27cb698584a)
# UVM Testbench Architecture
![UVM_architecture drawio (1)](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/c5685c86-e464-49bb-b6b0-05cc8c96ebde)
# Simulation Waveform
![waveform](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/35c592c7-5b8a-4f32-a0e4-4289a79ec3fc)
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
    ===============================================================
    |         Covergroup          |   Hits   |  Goal /  | Status  |
    |                             |          | At Least |         |
    ===============================================================
    | TYPE /coverage_sub/covg     | 100.000% | 100.000% | Covered |
    ===============================================================
    | INSTANCE <UNNAMED1>         | 100.000% | 100.000% | Covered |
    |-----------------------------|----------|----------|---------|
    | COVERPOINT <UNNAMED1>::BAUD | 100.000% | 100.000% | Covered |
    |-----------------------------|----------|----------|---------|
    | bin baud_val[4800]          |        4 |        1 | Covered |
    | bin baud_val[9600]          |        2 |        1 | Covered |
    | bin baud_val[14400]         |        1 |        1 | Covered |
    | bin baud_val[19200]         |        1 |        1 | Covered |
    | bin baud_val[38400]         |        5 |        1 | Covered |
    | bin baud_val[57600]         |        2 |        1 | Covered |
    ===============================================================
