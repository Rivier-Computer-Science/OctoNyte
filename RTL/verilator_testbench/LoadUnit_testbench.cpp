#include "verilated.h"
#include "VLoadUnit.h"  // Include the Verilog module
#include <iostream>

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    VLoadUnit* top = new VLoadUnit;

    // Initialize inputs
    top->io_addr = 0x1000;
    top->io_dataIn = 0x12345678;
    top->io_funct3 = 0b010;  // Load Word (LW)

    // Simulate one cycle
    top->eval();

    // Print output
    std::cout << "Output Data: " << std::hex << top->io_dataOut << std::endl;

    delete top;
    return 0;
}


