#include <iostream>
#include "VStoreUnit.h"
#include "verilated.h"

// Simulate one store operation cycle
void testStoreUnit(VStoreUnit* dut, uint32_t addr, uint32_t data, bool wen) {
    // Set inputs
    dut->reset = 0;
    dut->address = addr;
    dut->data_in = data;
    dut->wen = wen;

    // Toggle clock low→high to simulate a cycle
    dut->clock = 0;
    dut->eval();

    dut->clock = 1;
    dut->eval();

    // Print the result
    std::cout << "Addr: 0x" << std::hex << addr
              << " | Data In: 0x" << data
              << " | WEN: " << wen
              << " | Mem Out: 0x" << dut->mem_out
              << std::endl;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    VStoreUnit* dut = new VStoreUnit;

    // Apply reset
    dut->reset = 1;
    dut->clock = 0;
    dut->eval();
    dut->clock = 1;
    dut->eval();
    dut->reset = 0;

    std::cout << "Starting Store Unit Tests...\n";

    // Test Cases
    testStoreUnit(dut, 0x10, 0xAABBCCDD, 1);  // Normal write
    testStoreUnit(dut, 0x20, 0x11223344, 1);  // Write to different address
    testStoreUnit(dut, 0x10, 0x00000000, 0);  // No write (wen = 0)

    std::cout << "Store Unit Tests Completed.\n";

    delete dut;
    return 0;
}
