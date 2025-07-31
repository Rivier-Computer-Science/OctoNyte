// loadunit_testbench.cpp
#include "VLoadUnit.h"
#include "verilated.h"
#include <iostream>
#include <cstdint>

// Function to toggle the clock for one cycle
void tick(VLoadUnit* top, int ticks = 1) {
    for (int i = 0; i < ticks; i++) {
        top->clock = 0;
        top->eval();
        top->clock = 1;
        top->eval();
    }
}

bool check(uint32_t expected, uint32_t actual, const std::string &testName) {
    if (expected != actual) {
        std::cerr << testName << " FAILED: Expected 0x" 
                  << std::hex << expected << " got 0x" << actual << std::dec << std::endl;
        return false;
    } else {
        std::cout << testName << " PASSED: Output = 0x" 
                  << std::hex << actual << std::dec << std::endl;
        return true;
    }
}

int main(int argc, char **argv) {
    // Initialize Verilator
    Verilated::commandArgs(argc, argv);
    
    // Create instance of module
    VLoadUnit* top = new VLoadUnit;
    
    // Perform global reset
    top->reset = 1;
    tick(top, 2);
    top->reset = 0;
    tick(top, 1);
    
    bool allPassed = true;

    // Test Case 1: LB (Load Byte, signed)
    // Inputs: addr = 0x1000, dataIn = 0xFF00FF00, funct3 = 0b000 (LB)
    // Expected: lower byte is extracted; for signed byte, given 0xFF00FF00 lower 8 bits = 0x00,
    // so output 0x00000000.
    top->io_addr    = 0x1000;
    top->io_dataIn  = 0xFF00FF00;
    top->io_funct3  = 0b000; 
    tick(top, 1);
    allPassed &= check(0x00000000, top->io_dataOut, "Test Case 1 (LB)");

    // Test Case 2: LH (Load Halfword, signed)
    // Inputs: addr = 0x1004, dataIn = 0x00FF00FF, funct3 = 0b001 (LH)
    // Expected: lower halfword is extracted; lower 16 bits of 0x00FF00FF is 0x00FF,
    // so output 0x000000FF.
    top->io_addr    = 0x1004;
    top->io_dataIn  = 0x00FF00FF;
    top->io_funct3  = 0b001; 
    tick(top, 1);
    allPassed &= check(0x000000FF, top->io_dataOut, "Test Case 2 (LH)");

    // Test Case 3: LW (Load Word, signed)
    // Inputs: addr = 0x1008, dataIn = 0x12345678, funct3 = 0b010 (LW)
    // Expected: output equals the full word 0x12345678.
    top->io_addr    = 0x1008;
    top->io_dataIn  = 0x12345678;
    top->io_funct3  = 0b010; 
    tick(top, 1);
    allPassed &= check(0x12345678, top->io_dataOut, "Test Case 3 (LW)");

    // Test Case 4: LBU (Load Byte, unsigned)
    // Inputs: addr = 0x100C, dataIn = 0xFF00FF00, funct3 = 0b100 (LBU)
    // Expected: lower byte extracted unsigned => 0x00000000.
    top->io_addr    = 0x100C;
    top->io_dataIn  = 0xFF00FF00;
    top->io_funct3  = 0b100; 
    tick(top, 1);
    allPassed &= check(0x00000000, top->io_dataOut, "Test Case 4 (LBU)");

    // Test Case 5: LHU (Load Halfword, unsigned)
    // Inputs: addr = 0x1010, dataIn = 0xFFFF00FF, funct3 = 0b101 (LHU)
    // Expected: lower halfword extracted unsigned => lower 16 bits = 0x00FF, so output 0x000000FF.
    top->io_addr    = 0x1010;
    top->io_dataIn  = 0xFFFF00FF;
    top->io_funct3  = 0b101; 
    tick(top, 1);
    allPassed &= check(0x000000FF, top->io_dataOut, "Test Case 5 (LHU)");

    // Test Case 6: LBU with a different byte value (unsigned)
    // Inputs: addr = 0x1014, dataIn = 0x00FF00FF, funct3 = 0b100 (LBU)
    // Expected: lower byte = 0xFF, so output should be 0x000000FF.
    top->io_addr    = 0x1014;
    top->io_dataIn  = 0x00FF00FF;
    top->io_funct3  = 0b100; 
    tick(top, 1);
    allPassed &= check(0x000000FF, top->io_dataOut, "Test Case 6 (LBU alternate)");

    if (allPassed) {
        std::cout << "All test cases PASSED." << std::endl;
    } else {
        std::cerr << "Some test cases FAILED." << std::endl;
    }

    // Final model cleanup
    top->final();
    delete top;
    return allPassed ? 0 : 1;
}
