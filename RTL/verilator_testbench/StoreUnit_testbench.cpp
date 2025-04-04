#include <iostream>
#include "VStoreUnit.h"
#include "verilated.h"

void testStoreUnit(VStoreUnit* dut, uint32_t addr, uint32_t data, uint32_t storeType) {
    dut->io_addr = addr;
    dut->io_data = data;
    dut->io_storeType = storeType;
    
    dut->eval(); // Evaluate the model

    std::cout << "Addr: " << std::hex << addr 
              << " Data: " << std::hex << data 
              << " StoreType: " << storeType 
              << " Misaligned: " << dut->io_misaligned 
              << " Mask: " << std::hex << (int)dut->io_mask 
              << " MemWrite: " << std::hex << dut->io_memWrite 
              << std::endl;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    
    VStoreUnit* dut = new VStoreUnit;  // Create Store Unit module
    
    std::cout << "Starting Store Unit Tests...\n";

    // Test Cases
    testStoreUnit(dut, 0x1000, 0xAABBCCDD, 2);  // SW - Word aligned
    testStoreUnit(dut, 0x1001, 0xAABBCCDD, 2);  // SW - Word misaligned (should flag misaligned)
    testStoreUnit(dut, 0x1002, 0x11223344, 1);  // SH - Halfword misaligned
    testStoreUnit(dut, 0x1004, 0x11223344, 1);  // SH - Halfword aligned
    testStoreUnit(dut, 0x1005, 0x55, 0);        // SB - Store Byte at offset 1

    std::cout << "Store Unit Tests Completed.\n";

    delete dut;
    return 0;
}
