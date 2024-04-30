# 4-Bit-Adder 
This design contains a 4-bit adder which is a pure combinational circuit. It has two inputs a and b which are of 4 bits added to gather and generate a sum of 5 bits.
# Design Schematic
![image](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/fbc67709-2d34-463b-99f1-05449d5a59cc)
# UVM Testbench Architecture
![UVM_architecture drawio (1)](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/c5685c86-e464-49bb-b6b0-05cc8c96ebde)
# Simulation Waveform
![image](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/3dc919cf-ec01-445e-a4ce-4054343c5ebf)
# Coverage Report
SUMMARY
    =============================================
    |    Coverage Type    | Weight | Hits/Total |
    =============================================
    | Covergroup Coverage |      1 |    80.208% |
    |---------------------|--------|------------|
    | Types               |        |      0 / 1 |
    =============================================
    WEIGHTED AVERAGE: 80.208%


    COVERGROUP COVERAGE
    ===================================================================
    |          Covergroup           |   Hits   |  Goal /  |  Status   |
    |                               |          | At Least |           |
    ===================================================================
    | TYPE /coverage_subscriber/cov |  80.208% | 100.000% | Uncovered |
    ===================================================================
    | INSTANCE <UNNAMED1>           |  80.208% | 100.000% | Uncovered |
    |-------------------------------|----------|----------|-----------|
    | COVERPOINT <UNNAMED1>::a      | 100.000% | 100.000% | Covered   |
    |-------------------------------|----------|----------|-----------|
    | bin auto[0]                   |        3 |        1 | Covered   |
    | bin auto[1]                   |        3 |        1 | Covered   |
    | bin auto[2]                   |        3 |        1 | Covered   |
    | bin auto[3]                   |        3 |        1 | Covered   |
    | bin auto[4]                   |        3 |        1 | Covered   |
    | bin auto[5]                   |        3 |        1 | Covered   |
    | bin auto[6]                   |        3 |        1 | Covered   |
    | bin auto[7]                   |        3 |        1 | Covered   |
    | bin auto[8]                   |        4 |        1 | Covered   |
    | bin auto[9]                   |        3 |        1 | Covered   |
    | bin auto[10]                  |        3 |        1 | Covered   |
    | bin auto[11]                  |        3 |        1 | Covered   |
    | bin auto[12]                  |        3 |        1 | Covered   |
    | bin auto[13]                  |        3 |        1 | Covered   |
    | bin auto[14]                  |        3 |        1 | Covered   |
    | bin auto[15]                  |        3 |        1 | Covered   |
    |-------------------------------|----------|----------|-----------|
    | COVERPOINT <UNNAMED1>::b      | 100.000% | 100.000% | Covered   |
    |-------------------------------|----------|----------|-----------|
    | bin auto[0]                   |        3 |        1 | Covered   |
    | bin auto[1]                   |        3 |        1 | Covered   |
    | bin auto[2]                   |        3 |        1 | Covered   |
    | bin auto[3]                   |        3 |        1 | Covered   |
    | bin auto[4]                   |        3 |        1 | Covered   |
    | bin auto[5]                   |        4 |        1 | Covered   |
    | bin auto[6]                   |        3 |        1 | Covered   |
    | bin auto[7]                   |        3 |        1 | Covered   |
    | bin auto[8]                   |        3 |        1 | Covered   |
    | bin auto[9]                   |        3 |        1 | Covered   |
    | bin auto[10]                  |        3 |        1 | Covered   |
    | bin auto[11]                  |        3 |        1 | Covered   |
    | bin auto[12]                  |        3 |        1 | Covered   |
    | bin auto[13]                  |        3 |        1 | Covered   |
    | bin auto[14]                  |        3 |        1 | Covered   |
    | bin auto[15]                  |        3 |        1 | Covered   |
    |-------------------------------|----------|----------|-----------|
    | COVERPOINT <UNNAMED1>::y      |  40.625% | 100.000% | Uncovered |
    |-------------------------------|----------|----------|-----------|
    | bin auto[0]                   |        0 |        1 | Zero      |
    | bin auto[1]                   |        0 |        1 | Zero      |
    | bin auto[2]                   |        0 |        1 | Zero      |
    | bin auto[3]                   |        3 |        1 | Covered   |
    | bin auto[4]                   |        0 |        1 | Zero      |
    | bin auto[5]                   |        3 |        1 | Covered   |
    | bin auto[6]                   |        0 |        1 | Zero      |
    | bin auto[7]                   |        3 |        1 | Covered   |
    | bin auto[8]                   |        0 |        1 | Zero      |
    | bin auto[9]                   |        3 |        1 | Covered   |
    | bin auto[10]                  |        0 |        1 | Zero      |
    | bin auto[11]                  |        3 |        1 | Covered   |
    | bin auto[12]                  |        0 |        1 | Zero      |
    | bin auto[13]                  |        7 |        1 | Covered   |
    | bin auto[14]                  |        0 |        1 | Zero      |
    | bin auto[15]                  |        6 |        1 | Covered   |
    | bin auto[16]                  |        0 |        1 | Zero      |
    | bin auto[17]                  |        6 |        1 | Covered   |
    | bin auto[18]                  |        0 |        1 | Zero      |
    | bin auto[19]                  |        3 |        1 | Covered   |
    | bin auto[20]                  |        0 |        1 | Zero      |
    | bin auto[21]                  |        3 |        1 | Covered   |
    | bin auto[22]                  |        0 |        1 | Zero      |
    | bin auto[23]                  |        3 |        1 | Covered   |
    | bin auto[24]                  |        0 |        1 | Zero      |
    | bin auto[25]                  |        3 |        1 | Covered   |
    | bin auto[26]                  |        0 |        1 | Zero      |
    | bin auto[27]                  |        3 |        1 | Covered   |
    | bin auto[28]                  |        0 |        1 | Zero      |
    | bin auto[29]                  |        0 |        1 | Zero      |
    | bin auto[30]                  |        0 |        1 | Zero      |
    | bin auto[31]                  |        0 |        1 | Zero      |
     =================================================================
