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
