# UART 
UART, or universal asynchronous receiver-transmitter, is one of the most used device-to-device communication protocols. UART is a serial communication device that performs parallel-to serial data conversion at the transmitter side and serial-to-parallel data conversion at the receiver side. It is universal because parameters like transfer speed, data speed, etc. are configurable. The letter ‘A’ in UART stands for Asynchronous i.e. there is no clock signal to synchronize or validate the data transmitted from the transmitter and received by the receiver (Asynchronous Serial Communication). This is in contrast to Synchronous Serial Communication, which uses a clock signal that is shared between the transmitter and receiver to “Synchronize” the data between them. If there is no clock between the transmitter and receiver, then how does the receiver know when to read the data? In UART, the transmitter and receiver must agree on timing parameters beforehand (e.g. Baud Rate). Also, UART uses special bits (start and stop bits) at the beginning and ending of each data word to synchronize the transmitter and receiver.
# Structure of UART Data Packet 
The data in UART serial communication is organized into blocks called Packets. The structure of the UART Data Packet is shown in the following image.

![image](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/779e4621-6d81-4413-bcf2-79c867291ce8)
- Configurable Baud Rates are {4800, 9600, 14400, 19200, 38400, 57600}.
- Configurable Data lengths are {5,6,7,8} bits long.
# Design Schematic
![image](https://github.com/AYYAZmayo/UVM_Based_Verification_Projects/assets/43933912/d2cb78d3-196b-4100-80e8-23b0165316d1)
