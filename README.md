# stm32f103-baremetal

Bare-metal programming for the stm32f103xx series microcontrollers.

### Build instructions

#### Debian Linux:

To build the flashable binary, on the command line, clone this repository,
navigate to the repository directory and run make:


```
git clone https://github.com/fgiongo/stm32f103-baremetal
cd stm32f103-baremetal
make
```

### Flash instructions

#### Debian Linux:

To flash (via an USB to UART adapter), install stm32flash and run the flashing
script:

```
sudo apt-get install -y stm32flash```
sudo make flash
```
