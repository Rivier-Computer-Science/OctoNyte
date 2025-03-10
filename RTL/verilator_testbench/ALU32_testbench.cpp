#include "verilated.h"
#ifdef TRACE
#include "verilated_vcd_c.h"
#endif

#include "VALU32.h"  // Generated header for ALU32
#include <iostream>
#include <cassert>
#include <cstdint>

// Helper function to perform a test operation.
// This mimics the testOperation function from your Scala test.
void testOperation(VALU32* top, uint32_t a, uint32_t b, uint32_t opcode, uint32_t expected) {
    // Set inputs
    top->io.a = a;
    top->io.b = b;
    top->io.opcode = opcode;

    

    // Evaluate the model (combinational logic; if your design were sequential you might toggle a clock)
    top->eval();

    // Capture output
    uint32_t result = top->io.result;

    // Check the result (masking to 32 bits for safety)
    if (result != (expected & 0xFFFFFFFF)) {
        std::cerr << "Test failed: a = " << a << ", b = " << b 
                  << ", opcode = " << opcode 
                  << ", expected = 0x" << std::hex << expected 
                  << ", got = 0x" << result << std::dec << std::endl;
        assert(false);
    } else {
        std::cout << "Test passed: " << a << " (opcode " << opcode << ") with b = " 
                  << b << " produced 0x" << std::hex << result << std::dec << std::endl;
    }
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);

#ifdef TRACE
    VerilatedVcdC* tfp = new VerilatedVcdC;
#endif

    // Instantiate the design
    VALU32* top = new VALU32;

#ifdef TRACE
    top->trace(tfp, 99);  // Trace up to 99 levels of hierarchy (adjust as needed)
    tfp->open("wave.vcd");
#endif

    // Define opcodes to match your Chisel definition.
    // In your Chisel code, the lower nibble of the opcode is used.
    const uint32_t OPCODE_ADD  = 0x00; // "b00000"
    const uint32_t OPCODE_SUB  = 0x01; // "b00001"
    const uint32_t OPCODE_XOR  = 0x08; // "b01000"
    const uint32_t OPCODE_OR   = 0x0C; // "b01100"
    const uint32_t OPCODE_AND  = 0x0E; // "b01110"
    const uint32_t OPCODE_SLL  = 0x02; // "b00010"
    const uint32_t OPCODE_SRL  = 0x0A; // "b01010"
    const uint32_t OPCODE_SRA  = 0x0B; // "b01011"
    const uint32_t OPCODE_SLT  = 0x04; // "b00100"
    const uint32_t OPCODE_SLTU = 0x06; // "b00110"

    // ====== Test Arithmetic ======
    // Test ADD: 4 + 3 = 7
    testOperation(top, 4, 3, OPCODE_ADD, 4 + 3);
    // Test SUB: 4 - 3 = 1
    testOperation(top, 4, 3, OPCODE_SUB, 4 - 3);

    // ====== Test Logical Operations ======
    // Test AND
    testOperation(top, 0xF0F0F0F0, 0x0F0F0F0F, OPCODE_AND, 0xF0F0F0F0 & 0x0F0F0F0F);
    // Test OR
    testOperation(top, 0xF0F0F0F0, 0x0F0F0F0F, OPCODE_OR, 0xF0F0F0F0 | 0x0F0F0F0F);
    // Test XOR
    testOperation(top, 0xF0F0F0F0, 0x0F0F0F0F, OPCODE_XOR, 0xF0F0F0F0 ^ 0x0F0F0F0F);

    // ====== Test Shift Operations ======
    // Test SLL: Logical left shift by 4 bits
    testOperation(top, 0xF0F0F0F0, 4, OPCODE_SLL, 0xF0F0F0F0 << 4);
    // Test SRL: Logical right shift by 4 bits
    testOperation(top, 0xF0F0F0F0, 4, OPCODE_SRL, 0xF0F0F0F0 >> 4);
    // Test SRA: Arithmetic right shift by 4 bits.
    // Cast to int32_t to simulate signed arithmetic right shift.
    int32_t a_signed = static_cast<int32_t>(0xF0F0F0F0);
    testOperation(top, 0xF0F0F0F0, 4, OPCODE_SRA, static_cast<uint32_t>(a_signed >> 4));

    // ====== Test Comparison Operations ======
    // SLT: If 4 < 5, expect 1; if 5 < 4, expect 0.
    testOperation(top, 4, 5, OPCODE_SLT, 1);
    testOperation(top, 5, 4, OPCODE_SLT, 0);
    // SLTU: Unsigned comparison.
    testOperation(top, 4, 5, OPCODE_SLTU, 1);
    testOperation(top, 5, 4, OPCODE_SLTU, 0);

#ifdef TRACE
    tfp->close();
    delete tfp;
#endif

    top->final();
    delete top;

    std::cout << "All tests passed." << std::endl;
    return 0;
}
