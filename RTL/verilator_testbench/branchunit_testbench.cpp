#include <iostream>
#include "VBranchUnit.h"
#include "verilated.h"

// BranchOp encoding: same as funct3
enum BranchOp {
    BEQ  = 0b000,
    BNE  = 0b001,
    BLT  = 0b100,
    BGE  = 0b101,
    BLTU = 0b110,
    BGEU = 0b111
};

void testBranch(VBranchUnit* dut, uint32_t rs1, uint32_t rs2, uint8_t funct3, bool expectedTaken) {
    dut->rs1 = rs1;
    dut->rs2 = rs2;
    dut->funct3 = funct3;

    dut->eval(); // simulate

    bool result = dut->branch_taken;
    std::string outcome = (result == expectedTaken) ? "PASSED" : "FAILED";

    std::cout << "Test [funct3=" << (int)funct3
              << ", rs1=" << rs1
              << ", rs2=" << rs2
              << "] => branch_taken=" << result
              << " | Expected=" << expectedTaken
              << " --> " << outcome << "\n";
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);

    VBranchUnit* dut = new VBranchUnit;

    std::cout << "Running Branch Unit Tests...\n";

    testBranch(dut, 10, 10, BEQ,  true);   // BEQ: rs1 == rs2
    testBranch(dut, 10, 5,  BNE,  true);   // BNE: rs1 != rs2
    testBranch(dut, -5, 3,  BLT,  true);   // BLT: signed rs1 < rs2
    testBranch(dut, 10, 10, BGE,  true);   // BGE: signed rs1 >= rs2
    testBranch(dut, 5, 10,  BLTU, true);   // BLTU: unsigned rs1 < rs2
    testBranch(dut, 10, 5,  BGEU, true);   // BGEU: unsigned rs1 >= rs2
    testBranch(dut, 10, 10, BEQ,  true);   // repeat BEQ: rs1 == rs2
    testBranch(dut, 20, 20, BNE,  false);  // BNE: rs1 == rs2 → not taken

    delete dut;
    return 0;
}
