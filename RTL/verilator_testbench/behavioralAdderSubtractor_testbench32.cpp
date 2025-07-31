#include "verilated.h"
#include "VBehavioralAdderSubtractor4.h"  // Verilator-generated header for BehavioralAdderSubtractor4
#include <iostream>
#include <cstdint>

// Global simulation time (in time units)
vluint64_t main_time = 0;

// This function is called by $time in the Verilog model
double sc_time_stamp() {
    return main_time;
}

// Toggle the clock and advance simulation time
void tick(VBehavioralAdderSubtractor4* top) {
    // Falling edge
    top->clock = 0;
    top->eval();
    main_time += 5;
    // Rising edge
    top->clock = 1;
    top->eval();
    main_time += 5;
}

int main(int argc, char** argv) {
    // Initialize Verilator with command line arguments
    Verilated::commandArgs(argc, argv);
    VBehavioralAdderSubtractor4* top = new VBehavioralAdderSubtractor4;

    // Apply reset for a couple of clock cycles
    top->reset = 1;
    for (int i = 0; i < 2; i++) {
        tick(top);
    }
    top->reset = 0;

    // -----------------------------
    // Test 1: 4-bit Addition
    // Example: 3 + 4 should yield 7.
    top->io_a       = 3;    // 0x3
    top->io_b       = 4;    // 0x4
    top->io_subtract = 0;   // 0 => perform addition
    tick(top);
    std::cout << "Addition Test: 3 + 4 = " 
              << int(top->io_sum) << std::endl;

    // -----------------------------
    // Test 2: 4-bit Subtraction
    // Example: 9 - 5 should yield 4.
    top->io_a       = 9;    // 0x9
    top->io_b       = 5;    // 0x5
    top->io_subtract = 1;   // 1 => perform subtraction
    tick(top);
    std::cout << "Subtraction Test: 9 - 5 = " 
              << int(top->io_sum) << std::endl;

    // -----------------------------
    // Test 3: Subtraction with a negative result (wrapped modulo 16)
    // Example: 2 - 7 should yield (2-7 = -5) modulo 16 = 11.
    top->io_a       = 2;
    top->io_b       = 7;
    top->io_subtract = 1;
    tick(top);
    std::cout << "Subtraction Test: 2 - 7 = " 
              << int(top->io_sum) << " (4-bit result)" << std::endl;

    // -----------------------------
    // Test 4: Addition with potential overflow (results are modulo 16)
    // Example: 9 + 8 = 17 modulo 16 = 1.
    top->io_a       = 9;
    top->io_b       = 8;
    top->io_subtract = 0;
    tick(top);
    std::cout << "Addition Test: 9 + 8 = " 
              << int(top->io_sum) << " (4-bit result)" << std::endl;

    // Finish simulation
    top->final();
    delete top;
    return 0;
}