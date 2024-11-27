# stm32f103-baremetal

Bare-metal programming for the stm32f103xx series microcontrollers.

### Build instructions

#### Debian Linux:

To build the flashable binary, install arm-none-eabi-gcc, clone this
repository, navigate to the repository directory and run make. Or copy and
paste the following commands on your terminal:

```
sudo apt-get install -y gcc-arm-none-eabi \
&& git clone https://github.com/fgiongo/stm32f103-baremetal \
&& cd stm32f103-baremetal \
&& make
```

### Flash instructions

#### Debian Linux:

To flash (via an USB to UART adapter), install stm32flash and run the flashing
script:

```
sudo apt-get install -y stm32flash \
&& sudo make flash
```
