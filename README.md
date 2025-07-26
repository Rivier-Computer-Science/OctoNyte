# OctoNyte
A RISC-V Multithreaded Core Targeting the Skywater 0.13um ASIC library

## Native Ubuntu 24.04 Installation (or Virtualbox)

From cloned github repository

```bash
sh ./.devcontainer/install.sh
```

## Github Codespace

It should build automatically

## Mac / Native Windows / WSL Windows

You're on your own. Good luck!

# Install Test Framework on Ubuntu 24.04

## RISC-V Cross Compiler

```bash
sudo apt-get install gcc-riscv64-linux-gnu qemu-user
export CC=riscv64-linux-gnu-gcc

#optional. Only do this if you are exclusively using your distro for RISC-V development
echo 'export CC=riscv64-linux-gnu-gcc' >> ~/.bashrc
```

## Spike Simulator

```bash
sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev device-tree-compiler
```

```bash
mkdir ~/spike && cd ~/spike
```

```bash
git clone https://github.com/riscv/riscv-isa-sim.git # Spike
mkdir build && cd build
../configure --prefix=/opt/riscv --host=riscv64-linux-gnu

# 4 parallel make. You can change the number -j$(nproc)
make -j4
sudo make install
echo 'export PATH=$PATH:/opt/riscv/bin' >> ~/.bashrc
source ~/.bashrc
```


### pk (spike proxy kernel support)

```bash
cd ~/spike
git clone https://github.com/riscv/riscv-pk.git      # Proxy Kernel
mkdir build && cd build
../configure --prefix=/opt/riscv --host=riscv64-linux-gnu
make -j4
sudo make install
```

### Test simple c  code
hello.c
```c
#include <stdio.h>

int main() {
    printf("Hello, RISC-V Spike!\n");
    return 0;
}
```
Compile and run it
```bash
export CC=riscv64-linux-gnu-gcc
export CFLAGS="-static -O2"
export LDFLAGS="-static"
riscv64-linux-gnu-gcc -static -o hello hello.c
spike pk hello
```



