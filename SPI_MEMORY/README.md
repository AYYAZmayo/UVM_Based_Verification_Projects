# SPI MEMORY
This design contains an SPI interface to perform a write and read transaction to and from the memory. Here, SPI controller acts as SPI master and generates resquest to SPI slave based on wr-enable from the top. The SPI controller sends 16 bits(8 bit data-in + 8bit addr) on the MOSI pin when the chip select(CS) is de-asserted. SPI-slave recevies the data and store it into the memory. Similarly upon read request from SPI master controller SPI-slave sends 8 bit of data by from the provided address. The schematic of SPI-memory,SPI controller fsm and slave fsm are shown below. 

# Schematic
![image](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/bc02009d-be55-44ef-b197-70a66628e6e4)

# SPI Controller FSM

![image](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/5aaec2fd-3627-497e-81f5-59a6908a3114)

# SPI SLAVE MEMORY FSM
![image](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/2bac9062-49bf-49f9-9187-38c986a49160)

# UVM TestBench Architechture
![image](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/ffb2a5ed-2e6a-4a9d-9297-f92c99404095)

# Coverage Report

      SUMMARY
     =============================================
     |    Coverage Type    | Weight | Hits/Total |
     =============================================
     | Covergroup Coverage |      1 |    86.121% |
     |---------------------|--------|------------|
     | Types               |        |      0 / 1 |
     =============================================
     WEIGHTED AVERAGE LOCAL: 86.121%
 
 
     COVERGROUP COVERAGE
     ==============================================================================
     |                Covergroup                |   Hits   |  Goal /  |  Status   |
     |                                          |          | At Least |           |
     ==============================================================================
     | TYPE /\package tb_pkg\/coverage_sub/covg |  86.121% | 100.000% | Uncovered |
     ==============================================================================
     | INSTANCE <UNNAMED1>                      |  86.121% | 100.000% | Uncovered |
     |------------------------------------------|----------|----------|-----------|
     | COVERPOINT <UNNAMED1>::addr              |  16.731% | 100.000% | Uncovered |
     |------------------------------------------|----------|----------|-----------|
     | bin addr_valid[0]                        |       13 |        1 | Covered   |
     | bin addr_valid[1]                        |       15 |        1 | Covered   |
     | bin addr_valid[2]                        |       13 |        1 | Covered   |
     | bin addr_valid[3]                        |       15 |        1 | Covered   |
     | bin addr_valid[4]                        |       12 |        1 | Covered   |
     | bin addr_valid[5]                        |       14 |        1 | Covered   |
     | bin addr_valid[6]                        |       12 |        1 | Covered   |
     | bin addr_valid[7]                        |       15 |        1 | Covered   |
     | bin addr_valid[8]                        |       16 |        1 | Covered   |
     | bin addr_valid[9]                        |       15 |        1 | Covered   |
     | bin addr_valid[10]                       |       15 |        1 | Covered   |
     | bin addr_valid[11]                       |       12 |        1 | Covered   |
     | bin addr_valid[12]                       |       14 |        1 | Covered   |
     | bin addr_valid[13]                       |       13 |        1 | Covered   |
     | bin addr_valid[14]                       |       14 |        1 | Covered   |
     | bin addr_valid[15]                       |       13 |        1 | Covered   |
     | bin addr_valid[16]                       |       16 |        1 | Covered   |
     | bin addr_valid[17]                       |       15 |        1 | Covered   |
     | bin addr_valid[18]                       |       14 |        1 | Covered   |
     | bin addr_valid[19]                       |       16 |        1 | Covered   |
     | bin addr_valid[20]                       |       14 |        1 | Covered   |
     | bin addr_valid[21]                       |       14 |        1 | Covered   |
     | bin addr_valid[22]                       |       16 |        1 | Covered   |
     | bin addr_valid[23]                       |       14 |        1 | Covered   |
     | bin addr_valid[24]                       |       11 |        1 | Covered   |
     | bin addr_valid[25]                       |       14 |        1 | Covered   |
     | bin addr_valid[26]                       |       16 |        1 | Covered   |
     | bin addr_valid[27]                       |       14 |        1 | Covered   |
     | bin addr_valid[28]                       |       15 |        1 | Covered   |
     | bin addr_valid[29]                       |       15 |        1 | Covered   |
     | bin addr_valid[30]                       |       14 |        1 | Covered   |
     | bin addr_valid[31]                       |       12 |        1 | Covered   |
     | bin addr_invalid[31]                     |       12 |        1 | Covered   |
     | bin addr_invalid[32]                     |        0 |        1 | Zero      |
     | bin addr_invalid[33]                     |        0 |        1 | Zero      |
     | bin addr_invalid[34]                     |        0 |        1 | Zero      |
     | bin addr_invalid[35]                     |        0 |        1 | Zero      |
     | bin addr_invalid[36]                     |        0 |        1 | Zero      |
     | bin addr_invalid[37]                     |        0 |        1 | Zero      |
     | bin addr_invalid[38]                     |        0 |        1 | Zero      |
     | bin addr_invalid[39]                     |        0 |        1 | Zero      |
     | bin addr_invalid[40]                     |        0 |        1 | Zero      |
     | bin addr_invalid[41]                     |        0 |        1 | Zero      |
     | bin addr_invalid[42]                     |        0 |        1 | Zero      |
     | bin addr_invalid[43]                     |        0 |        1 | Zero      |
     | bin addr_invalid[44]                     |        0 |        1 | Zero      |
     | bin addr_invalid[45]                     |        0 |        1 | Zero      |
     | bin addr_invalid[46]                     |        0 |        1 | Zero      |
     | bin addr_invalid[47]                     |        0 |        1 | Zero      |
     | bin addr_invalid[48]                     |        0 |        1 | Zero      |
     | bin addr_invalid[49]                     |        0 |        1 | Zero      |
     | bin addr_invalid[50]                     |        0 |        1 | Zero      |
     | bin addr_invalid[51]                     |        0 |        1 | Zero      |
     | bin addr_invalid[52]                     |        1 |        1 | Covered   |
     | bin addr_invalid[53]                     |        0 |        1 | Zero      |
     | bin addr_invalid[54]                     |        0 |        1 | Zero      |
     | bin addr_invalid[55]                     |        0 |        1 | Zero      |
     | bin addr_invalid[56]                     |        0 |        1 | Zero      |
     | bin addr_invalid[57]                     |        0 |        1 | Zero      |
     | bin addr_invalid[58]                     |        0 |        1 | Zero      |
     | bin addr_invalid[59]                     |        0 |        1 | Zero      |
     | bin addr_invalid[60]                     |        0 |        1 | Zero      |
     | bin addr_invalid[61]                     |        1 |        1 | Covered   |
     | bin addr_invalid[62]                     |        0 |        1 | Zero      |
     | bin addr_invalid[63]                     |        0 |        1 | Zero      |
     | bin addr_invalid[64]                     |        0 |        1 | Zero      |
     | bin addr_invalid[65]                     |        0 |        1 | Zero      |
     | bin addr_invalid[66]                     |        0 |        1 | Zero      |
     | bin addr_invalid[67]                     |        0 |        1 | Zero      |
     | bin addr_invalid[68]                     |        0 |        1 | Zero      |
     | bin addr_invalid[69]                     |        0 |        1 | Zero      |
     | bin addr_invalid[70]                     |        0 |        1 | Zero      |
     | bin addr_invalid[71]                     |        0 |        1 | Zero      |
     | bin addr_invalid[72]                     |        0 |        1 | Zero      |
     | bin addr_invalid[73]                     |        0 |        1 | Zero      |
     | bin addr_invalid[74]                     |        0 |        1 | Zero      |
     | bin addr_invalid[75]                     |        1 |        1 | Covered   |
     | bin addr_invalid[76]                     |        0 |        1 | Zero      |
     | bin addr_invalid[77]                     |        0 |        1 | Zero      |
     | bin addr_invalid[78]                     |        0 |        1 | Zero      |
     | bin addr_invalid[79]                     |        0 |        1 | Zero      |
     | bin addr_invalid[80]                     |        0 |        1 | Zero      |
     | bin addr_invalid[81]                     |        0 |        1 | Zero      |
     | bin addr_invalid[82]                     |        0 |        1 | Zero      |
     | bin addr_invalid[83]                     |        0 |        1 | Zero      |
     | bin addr_invalid[84]                     |        0 |        1 | Zero      |
     | bin addr_invalid[85]                     |        0 |        1 | Zero      |
     | bin addr_invalid[86]                     |        0 |        1 | Zero      |
     | bin addr_invalid[87]                     |        0 |        1 | Zero      |
     | bin addr_invalid[88]                     |        0 |        1 | Zero      |
     | bin addr_invalid[89]                     |        0 |        1 | Zero      |
     | bin addr_invalid[90]                     |        0 |        1 | Zero      |
     | bin addr_invalid[91]                     |        0 |        1 | Zero      |
     | bin addr_invalid[92]                     |        0 |        1 | Zero      |
     | bin addr_invalid[93]                     |        0 |        1 | Zero      |
     | bin addr_invalid[94]                     |        0 |        1 | Zero      |
     | bin addr_invalid[95]                     |        0 |        1 | Zero      |
     | bin addr_invalid[96]                     |        0 |        1 | Zero      |
     | bin addr_invalid[97]                     |        0 |        1 | Zero      |
     | bin addr_invalid[98]                     |        0 |        1 | Zero      |
     | bin addr_invalid[99]                     |        0 |        1 | Zero      |
     | bin addr_invalid[100]                    |        0 |        1 | Zero      |
     | bin addr_invalid[101]                    |        0 |        1 | Zero      |
     | bin addr_invalid[102]                    |        0 |        1 | Zero      |
     | bin addr_invalid[103]                    |        0 |        1 | Zero      |
     | bin addr_invalid[104]                    |        0 |        1 | Zero      |
     | bin addr_invalid[105]                    |        0 |        1 | Zero      |
     | bin addr_invalid[106]                    |        0 |        1 | Zero      |
     | bin addr_invalid[107]                    |        0 |        1 | Zero      |
     | bin addr_invalid[108]                    |        0 |        1 | Zero      |
     | bin addr_invalid[109]                    |        0 |        1 | Zero      |
     | bin addr_invalid[110]                    |        0 |        1 | Zero      |
     | bin addr_invalid[111]                    |        0 |        1 | Zero      |
     | bin addr_invalid[112]                    |        0 |        1 | Zero      |
     | bin addr_invalid[113]                    |        0 |        1 | Zero      |
     | bin addr_invalid[114]                    |        0 |        1 | Zero      |
     | bin addr_invalid[115]                    |        0 |        1 | Zero      |
     | bin addr_invalid[116]                    |        0 |        1 | Zero      |
     | bin addr_invalid[117]                    |        0 |        1 | Zero      |
     | bin addr_invalid[118]                    |        0 |        1 | Zero      |
     | bin addr_invalid[119]                    |        0 |        1 | Zero      |
     | bin addr_invalid[120]                    |        0 |        1 | Zero      |
     | bin addr_invalid[121]                    |        0 |        1 | Zero      |
     | bin addr_invalid[122]                    |        0 |        1 | Zero      |
     | bin addr_invalid[123]                    |        0 |        1 | Zero      |
     | bin addr_invalid[124]                    |        0 |        1 | Zero      |
     | bin addr_invalid[125]                    |        0 |        1 | Zero      |
     | bin addr_invalid[126]                    |        0 |        1 | Zero      |
     | bin addr_invalid[127]                    |        0 |        1 | Zero      |
     | bin addr_invalid[128]                    |        0 |        1 | Zero      |
     | bin addr_invalid[129]                    |        0 |        1 | Zero      |
     | bin addr_invalid[130]                    |        0 |        1 | Zero      |
     | bin addr_invalid[131]                    |        0 |        1 | Zero      |
     | bin addr_invalid[132]                    |        0 |        1 | Zero      |
     | bin addr_invalid[133]                    |        0 |        1 | Zero      |
     | bin addr_invalid[134]                    |        0 |        1 | Zero      |
     | bin addr_invalid[135]                    |        0 |        1 | Zero      |
     | bin addr_invalid[136]                    |        1 |        1 | Covered   |
     | bin addr_invalid[137]                    |        0 |        1 | Zero      |
     | bin addr_invalid[138]                    |        0 |        1 | Zero      |
     | bin addr_invalid[139]                    |        0 |        1 | Zero      |
     | bin addr_invalid[140]                    |        0 |        1 | Zero      |
     | bin addr_invalid[141]                    |        0 |        1 | Zero      |
     | bin addr_invalid[142]                    |        0 |        1 | Zero      |
     | bin addr_invalid[143]                    |        0 |        1 | Zero      |
     | bin addr_invalid[144]                    |        0 |        1 | Zero      |
     | bin addr_invalid[145]                    |        0 |        1 | Zero      |
     | bin addr_invalid[146]                    |        0 |        1 | Zero      |
     | bin addr_invalid[147]                    |        0 |        1 | Zero      |
     | bin addr_invalid[148]                    |        0 |        1 | Zero      |
     | bin addr_invalid[149]                    |        0 |        1 | Zero      |
     | bin addr_invalid[150]                    |        0 |        1 | Zero      |
     | bin addr_invalid[151]                    |        0 |        1 | Zero      |
     | bin addr_invalid[152]                    |        0 |        1 | Zero      |
     | bin addr_invalid[153]                    |        1 |        1 | Covered   |
     | bin addr_invalid[154]                    |        0 |        1 | Zero      |
     | bin addr_invalid[155]                    |        0 |        1 | Zero      |
     | bin addr_invalid[156]                    |        0 |        1 | Zero      |
     | bin addr_invalid[157]                    |        0 |        1 | Zero      |
     | bin addr_invalid[158]                    |        0 |        1 | Zero      |
     | bin addr_invalid[159]                    |        0 |        1 | Zero      |
     | bin addr_invalid[160]                    |        0 |        1 | Zero      |
     | bin addr_invalid[161]                    |        0 |        1 | Zero      |
     | bin addr_invalid[162]                    |        0 |        1 | Zero      |
     | bin addr_invalid[163]                    |        0 |        1 | Zero      |
     | bin addr_invalid[164]                    |        0 |        1 | Zero      |
     | bin addr_invalid[165]                    |        0 |        1 | Zero      |
     | bin addr_invalid[166]                    |        0 |        1 | Zero      |
     | bin addr_invalid[167]                    |        0 |        1 | Zero      |
     | bin addr_invalid[168]                    |        0 |        1 | Zero      |
     | bin addr_invalid[169]                    |        0 |        1 | Zero      |
     | bin addr_invalid[170]                    |        0 |        1 | Zero      |
     | bin addr_invalid[171]                    |        0 |        1 | Zero      |
     | bin addr_invalid[172]                    |        0 |        1 | Zero      |
     | bin addr_invalid[173]                    |        0 |        1 | Zero      |
     | bin addr_invalid[174]                    |        0 |        1 | Zero      |
     | bin addr_invalid[175]                    |        0 |        1 | Zero      |
     | bin addr_invalid[176]                    |        0 |        1 | Zero      |
     | bin addr_invalid[177]                    |        0 |        1 | Zero      |
     | bin addr_invalid[178]                    |        0 |        1 | Zero      |
     | bin addr_invalid[179]                    |        0 |        1 | Zero      |
     | bin addr_invalid[180]                    |        0 |        1 | Zero      |
     | bin addr_invalid[181]                    |        0 |        1 | Zero      |
     | bin addr_invalid[182]                    |        0 |        1 | Zero      |
     | bin addr_invalid[183]                    |        1 |        1 | Covered   |
     | bin addr_invalid[184]                    |        0 |        1 | Zero      |
     | bin addr_invalid[185]                    |        0 |        1 | Zero      |
     | bin addr_invalid[186]                    |        0 |        1 | Zero      |
     | bin addr_invalid[187]                    |        0 |        1 | Zero      |
     | bin addr_invalid[188]                    |        0 |        1 | Zero      |
     | bin addr_invalid[189]                    |        0 |        1 | Zero      |
     | bin addr_invalid[190]                    |        0 |        1 | Zero      |
     | bin addr_invalid[191]                    |        0 |        1 | Zero      |
     | bin addr_invalid[192]                    |        0 |        1 | Zero      |
     | bin addr_invalid[193]                    |        0 |        1 | Zero      |
     | bin addr_invalid[194]                    |        0 |        1 | Zero      |
     | bin addr_invalid[195]                    |        1 |        1 | Covered   |
     | bin addr_invalid[196]                    |        0 |        1 | Zero      |
     | bin addr_invalid[197]                    |        0 |        1 | Zero      |
     | bin addr_invalid[198]                    |        0 |        1 | Zero      |
     | bin addr_invalid[199]                    |        0 |        1 | Zero      |
     | bin addr_invalid[200]                    |        0 |        1 | Zero      |
     | bin addr_invalid[201]                    |        0 |        1 | Zero      |
     | bin addr_invalid[202]                    |        1 |        1 | Covered   |
     | bin addr_invalid[203]                    |        0 |        1 | Zero      |
     | bin addr_invalid[204]                    |        0 |        1 | Zero      |
     | bin addr_invalid[205]                    |        0 |        1 | Zero      |
     | bin addr_invalid[206]                    |        0 |        1 | Zero      |
     | bin addr_invalid[207]                    |        0 |        1 | Zero      |
     | bin addr_invalid[208]                    |        0 |        1 | Zero      |
     | bin addr_invalid[209]                    |        0 |        1 | Zero      |
     | bin addr_invalid[210]                    |        0 |        1 | Zero      |
     | bin addr_invalid[211]                    |        0 |        1 | Zero      |
     | bin addr_invalid[212]                    |        0 |        1 | Zero      |
     | bin addr_invalid[213]                    |        0 |        1 | Zero      |
     | bin addr_invalid[214]                    |        0 |        1 | Zero      |
     | bin addr_invalid[215]                    |        0 |        1 | Zero      |
     | bin addr_invalid[216]                    |        0 |        1 | Zero      |
     | bin addr_invalid[217]                    |        0 |        1 | Zero      |
     | bin addr_invalid[218]                    |        0 |        1 | Zero      |
     | bin addr_invalid[219]                    |        0 |        1 | Zero      |
     | bin addr_invalid[220]                    |        0 |        1 | Zero      |
     | bin addr_invalid[221]                    |        0 |        1 | Zero      |
     | bin addr_invalid[222]                    |        0 |        1 | Zero      |
     | bin addr_invalid[223]                    |        0 |        1 | Zero      |
     | bin addr_invalid[224]                    |        0 |        1 | Zero      |
     | bin addr_invalid[225]                    |        0 |        1 | Zero      |
     | bin addr_invalid[226]                    |        0 |        1 | Zero      |
     | bin addr_invalid[227]                    |        0 |        1 | Zero      |
     | bin addr_invalid[228]                    |        0 |        1 | Zero      |
     | bin addr_invalid[229]                    |        0 |        1 | Zero      |
     | bin addr_invalid[230]                    |        0 |        1 | Zero      |
     | bin addr_invalid[231]                    |        0 |        1 | Zero      |
     | bin addr_invalid[232]                    |        0 |        1 | Zero      |
     | bin addr_invalid[233]                    |        0 |        1 | Zero      |
     | bin addr_invalid[234]                    |        0 |        1 | Zero      |
     | bin addr_invalid[235]                    |        0 |        1 | Zero      |
     | bin addr_invalid[236]                    |        1 |        1 | Covered   |
     | bin addr_invalid[237]                    |        0 |        1 | Zero      |
     | bin addr_invalid[238]                    |        0 |        1 | Zero      |
     | bin addr_invalid[239]                    |        0 |        1 | Zero      |
     | bin addr_invalid[240]                    |        1 |        1 | Covered   |
     | bin addr_invalid[241]                    |        0 |        1 | Zero      |
     | bin addr_invalid[242]                    |        0 |        1 | Zero      |
     | bin addr_invalid[243]                    |        0 |        1 | Zero      |
     | bin addr_invalid[244]                    |        0 |        1 | Zero      |
     | bin addr_invalid[245]                    |        0 |        1 | Zero      |
     | bin addr_invalid[246]                    |        0 |        1 | Zero      |
     | bin addr_invalid[247]                    |        0 |        1 | Zero      |
     | bin addr_invalid[248]                    |        0 |        1 | Zero      |
     | bin addr_invalid[249]                    |        0 |        1 | Zero      |
     | bin addr_invalid[250]                    |        0 |        1 | Zero      |
     | bin addr_invalid[251]                    |        0 |        1 | Zero      |
     | bin addr_invalid[252]                    |        0 |        1 | Zero      |
     | bin addr_invalid[253]                    |        0 |        1 | Zero      |
     | bin addr_invalid[254]                    |        0 |        1 | Zero      |
     | bin addr_invalid[255]                    |        0 |        1 | Zero      |
     |------------------------------------------|----------|----------|-----------|
     | COVERPOINT <UNNAMED1>::din               | 100.000% | 100.000% | Covered   |
     |------------------------------------------|----------|----------|-----------|
     | bin low_din                              |      199 |        1 | Covered   |
     | bin medium_din                           |      140 |        1 | Covered   |
     | bin high_din                             |      122 |        1 | Covered   |
     |------------------------------------------|----------|----------|-----------|
     | COVERPOINT <UNNAMED1>::wr                | 100.000% | 100.000% | Covered   |
     |------------------------------------------|----------|----------|-----------|
     | bin write[1]                             |      230 |        1 | Covered   |
     | bin read[0]                              |      231 |        1 | Covered   |
     |------------------------------------------|----------|----------|-----------|
     | COVERPOINT <UNNAMED1>::rst               | 100.000% | 100.000% | Covered   |
     |------------------------------------------|----------|----------|-----------|
     | bin low[0]                               |      460 |        1 | Covered   |
     | bin high[1]                              |        2 |        1 | Covered   |
     |------------------------------------------|----------|----------|-----------|
     | COVERPOINT <UNNAMED1>::dout              | 100.000% | 100.000% | Covered   |
     |------------------------------------------|----------|----------|-----------|
     | bin low_din                              |      146 |        1 | Covered   |
     | bin medium_din                           |      197 |        1 | Covered   |
     | bin high_din                             |       68 |        1 | Covered   |
     |------------------------------------------|----------|----------|-----------|
     | COVERPOINT <UNNAMED1>::err               | 100.000% | 100.000% | Covered   |
     |------------------------------------------|----------|----------|-----------|
     | bin low[0]                               |      451 |        1 | Covered   |
     | bin high[1]                              |       10 |        1 | Covered   |
     ==============================================================================
