# OctoNyte
A RISC-V Multithreaded Core Targeting the Skywater 0.13um ASIC library

## Native Ubuntu 24.04 Installation (or Virtualbox)

From cloned github repository INTO YOUR HOME DIRECTORY

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



### Python

### Install uv and venv

https://docs.astral.sh/uv/#installation

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

```bash
uv venv --python 3.10 
```

Activate the environment

```bash
source .venv/bin/activate
```

### Install Python requirements.txt

```bash
uv pip install -r requirements.txt
```



### Install the entire RISC-V Toolchain Prebuilt from Collab

```bash
cd /tmp 

wget https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2025.07.16/riscv32-elf-ubuntu-24.04-gcc-nightly-2025.07.16-nightly.tar.xz 

sudo mkdir -p /opt/riscv/collab

sudo tar -xvf riscv32-elf-ubuntu-24.04-gcc-nightly-2025.07.16-nightly.tar.xz -C /opt/riscv/collab --strip-components=1

echo 'export PATH=/opt/riscv/collab/bin:$PATH' >> ~/.bashrc 

source ~/.bashrc
```

### Install RISCOF framework (if requirements.txt doesn't work)

```bash
# Python 3.10 is known to work. 3.8 and 3.12 do not work as of August 2025

# A newer known compatible version
uv pip install riscv-isac==0.18.0
uv pip install riscv-config==3.20.0
uv pip install riscof==1.25.3

# An older Known compatible version
uv pip install riscv-isac==0.17.0
uv pip install riscv-config==3.12.0  
uv pip install riscof==1.24.0

# There are a lot of known compatibility issues. You can also try the latest dev branch
uv pip install git+https://github.com/riscv/riscv-config.git # 3.20.0
uv pip install git+https://github.com/riscv/riscv-isac.git # 0.18.0
uv pip install git+https://github.com/riscv/riscof.git   # 1.25.3
```



### Check out the RV32I tests

From top-level OctoNyte

```bash
git submodule add \
  https://github.com/riscv-non-isa/riscv-arch-test.git \
  external/riscv-arch-test
git -C external/riscv-arch-test checkout
```



### Make Sure Tests are Up-to-date

```bash
git submodule update --init --recursive tests/external/riscv-arch-test
```

### Initialize RISC-V Single ADD Test and Check Config Files

```bash
cd tests
riscof setup --dutname=tetranyte --refname=spike 
riscof validateyaml --config=riscof_cfg/ref.yaml
echo "addi-01" > single_tests.txt
riscof testlist --config=config.ini --suite=external/riscv-arch-test/riscv-test-suite/rv32i_m/I/ --env=external/riscv-arch-test/riscv-test-suite/env
cd riscof_work
# Edit testfile.yaml and leave a single add testcase
```

#### Run the ADD test

```bash
riscof run --config=config.ini --suite=external/riscv-arch-test/riscv-test-suite/rv32i_m/I/ --env=external/riscv-arch-test/riscv-test-suite/env --no-browser
```

#### 

### Run the Verilog RTL tests on a Subset

#### Generate the full list of RV32I tests to be run:

```bash
riscof testlist --config=config.ini --suite=external/riscv-arch-test/riscv-test-suite/rv32i_m/I/ --env=external/riscv-arch-test/riscv-test-suite/env
```

#### Run the RV32I full test suite

```bash
riscof run --config=config.ini --suite=external/riscv-arch-test/riscv-test-suite/rv32i_m/I/ --env=external/riscv-arch-test/riscv-test-suite/env --no-browser
```

#### Check the Result

```bash
cat riscof_work/report.html
```

#### Run the entire suite

```bash
asdf
```

### Flow:

1. **Top Level Test Bench**: /home/octonyte/OctoNyte/RTL/Chisel/generators/generated/verilog_hierarchical_timed_rtl/Top.v
   - This needs to be generated from Chisel code. I've put a simple one there for now.
2. **Your testbench** (`tb_compliance.cpp`) needs to:
   - Load the hex file into memory
   - Run the simulation
   - Write the signature to `rtl.sig` file
3. **Expected workflow**:
   - RISCOF compiles each test to ELF
   - Your plugin converts ELF to hex
   - Verilator simulates your RTL with the hex file
   - Your testbench writes the signature
   - RISCOF compares signatures between your RTL and Spike
