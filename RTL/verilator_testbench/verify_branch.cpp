#include "VOctoNyteCPU.h"
#include "verilated.h"
#include <fstream>
#include <string>
#include <cassert>
#include <iostream>

static const uint32_t MAX_CYCLES = 1000000;

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    VOctoNyteCPU* top = new VOctoNyteCPU;

    // Load instructions (from hex to io_inst)
    std::ifstream hexin("RTL/verilator_testbench/test_branch.hex");

    if (!hexin) {
        std::cerr << "ERROR: Could not open test_branch.hex\n";
        return 1;
    }

    std::string line;
    uint32_t pc = 0;
    while (std::getline(hexin, line)) {
        if (line.empty()) continue;
        uint32_t inst = std::stoul(line, nullptr, 16);

        // Feed instruction manually
        for (int cycle = 0; cycle < 4; ++cycle) {
            top->io_inst = inst;
            top->clock = 0; top->eval();
            top->clock = 1; top->eval();
        }
        ++pc;
    }
    hexin.close();

    // Reset
    top->reset = 1;
    for (int i = 0; i < 2; i++) {
        top->clock = 0; top->eval();
        top->clock = 1; top->eval();
    }
    top->reset = 0;

    // Simulate
    bool done = false;
    for (uint32_t cycle = 0; cycle < MAX_CYCLES; ++cycle) {
        top->clock = 0; top->eval();
        top->clock = 1; top->eval();

        // Optional: Monitor PC to detect trap/halt manually
        // done = (top->pc == 0xDEADBEEF);  // example trap value
    }

    std::cout << "Simulation done.\n";


    delete top;
    return 0;
}
