#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <cstdint>
#include <cassert>
#include "VALU32.h"
#include "verilated.h"

struct RegisterState {
    uint32_t s2, s3, s4;
};

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

            ss >> temp >> equal >> state.s2;
            ss >> temp >> equal >> state.s3;
            ss >> temp >> equal >> state.s4;
            
            dumpStates.push_back(state);
        }
    }

    file.close();
    return dumpStates;
}

void verifyAddiTest() {
    std::vector<RegisterState> expectedResults = readDumpFile("../test_compare/test_addi_dump.txt");

    if (expectedResults.empty()) {
        std::cerr << "Error: No data found in test_addi_dump.txt" << std::endl;
        return;
    }

    VALU32* top = new VALU32;
    const uint32_t OPCODE_ADDI = 0x0;

    top->A = 0;
    top->B = 0xAB;
    top->ALUOp = OPCODE_ADDI;
    top->eval();

    uint32_t aluResult = top->ALUResult;

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
