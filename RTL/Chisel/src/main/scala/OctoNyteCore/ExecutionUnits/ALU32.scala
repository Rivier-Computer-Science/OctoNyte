#include "verilated.h"
#ifdef TRACE
#include "verilated_vcd_c.h"
#endif
#include "VALU32.h"    // The generated header for the ALU32 module

#include <iostream>

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    
#ifdef TRACE
    VerilatedVcdC* tfp = new VerilatedVcdC;
    
#endif

    // Instantiate the top-level module
    VALU32* top = new VALU32;

#ifdef TRACE
    // Enable waveform tracing
    top->trace(tfp, 99);  // Trace 99 levels of hierarchy (adjust as needed)
    tfp->open("wave.vcd");
#endif

    // Test case 1: ADD operation
    // For ADD, opcode lower nibble should be "0000"
    top->io_a = 10;
    top->io_b = 5;
    top->io_opcode = 0x00;  // Opcode corresponding to ADD
    top->eval();            // Evaluate the model
#ifdef TRACE
    tfp->dump(0);           // Dump trace at time 0
#endif
    std::cout << "ADD Test: " << top->io_a << " + " << top->io_b
              << " = " << top->io_result << std::endl;

    // Test case 2: SUB operation
    // For SUB, opcode lower nibble should be "0001"
    top->io_a = 10;
    top->io_b = 5;
    top->io_opcode = 0x01;  // Opcode corresponding to SUB
    top->eval();
#ifdef TRACE
    tfp->dump(10);          // Dump trace at time 10
#endif
    std::cout << "SUB Test: " << top->io_a << " - " << top->io_b
              << " = " << top->io_result << std::endl;

    // Add additional test cases as needed, for example:
    // XOR, OR, AND, SLL, SRL, SRA, SLT, SLTU
    // Ensure you set the inputs (io_a, io_b) and proper io_opcode values
    // according to your Chisel ALU32 definition.

#ifdef TRACE
    tfp->close();
    delete tfp;
#endif

    top->final();
    delete top;
    return 0;
}
