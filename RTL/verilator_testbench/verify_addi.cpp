#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <cstdint>
#include <cassert>
#include "VALU32.h"
#include "verilated.h"

// Structure to store register states from test_addi_dump.txt
struct RegisterState {
    uint32_t s2, s3, s4;
};

// Function to parse test_addi_dump.txt
std::vector<RegisterState> readDumpFile(const std::string& filename) {
    std::vector<RegisterState> dumpStates;
    std::ifstream file(filename);
    if (!file.is_open()) {
        std::cerr << "Error: Could not open " << filename << std::endl;
        return dumpStates;
    }

    std::string line;
    while (std::getline(file, line)) {
        if (line.find("s2=") != std::string::npos) {
            RegisterState state;
            std::stringstream ss(line);
            std::string temp;
            char equal;

            // Extract register values properly
            ss >> temp >> equal >> state.s2;
            ss >> temp >> equal >> state.s3;
            ss >> temp >> equal >> state.s4;
            
            dumpStates.push_back(state);
        }
    }
    
    file.close();
    return dumpStates;
}

// Function to run Verilator ALU simulation and verify ADDI
void verifyAddiTest() {
    // Read expected results from test_addi_dump.txt
    std::vector<RegisterState> expectedResults = readDumpFile("RTL/verilator_testbench/test_compare/test_addi_dump.txt");


    if (expectedResults.empty()) {
        std::cerr << "Error: No data found in test_addi_dump.txt" << std::endl;
        return;
    }

    // Initialize Verilator
    VALU32* top = new VALU32;

    // Step 1: Simulate initial register state (zeroed)
    top->io_a = 0;
    top->io_b = 0;

    top->io_opcode = 0x0; // Dummy opcode (ADD)
    top->eval();

    // Step 2: Perform ADDI operation
    const uint32_t OPCODE_ADDI = 0x0;  // ALU opcode from ALU32.v
    top->io_a = 1;
    top->io_b = 2;

    top->io_opcode = OPCODE_ADDI;
    top->eval();

    // Get ALU output
    uint32_t aluResult = top->io_result;

    // Check for valid expected results
    if (expectedResults.size() > 1) {
        if (aluResult == expectedResults[1].s2) {
            std::cout << "ADDI Test Passed. ALU Result = " << aluResult << std::endl;
        } else {
            std::cerr << "ADDI Test Failed. Expected = " << expectedResults[1].s2
                      << ", Got = " << aluResult << std::endl;
        }
    } else {
        std::cerr << "Insufficient data in test_addi_dump.txt for comparison." << std::endl;
    }

    delete top;
}

int main() {
    std::cout << "Starting ADDI Verification..." << std::endl;
    verifyAddiTest();
    return 0;
}
