
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VPipeline.h"  // generated from pipeline.v

// Simple instruction/data memory
static const uint32_t instr_mem[] = {
    0x00500093, // ADDI x1, x0, 5
    0x00A00113, // ADDI x2, x0, 10
    0x00F00193, // ADDI x3, x0, 15
    0x01400213, // ADDI x4, x0, 20
    0x01900293, // ADDI x5, x0, 25
    0x01E00313, // ADDI x6, x0, 30
    0x0000006F  // JAL  x0, 0 (infinite loop, no dependency)
};
static uint32_t data_mem[256];

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    VPipeline* dut = new VPipeline;
    VerilatedVcdC* tfp = nullptr;
    Verilated::traceEverOn(true);
    tfp = new VerilatedVcdC;
    dut->trace(tfp, 10);
    tfp->open("waveform.vcd");

    // Reset
    dut->rst = 1;
    dut->clk = 0;
    dut->eval();
    dut->clk = 1; dut->eval();
    dut->clk = 0; dut->eval();
    dut->rst = 0;

    // Run simulation for 50 cycles
    for (int cycle = 0; cycle < 50; cycle++) {
        // Drive instruction memory
        uint32_t pc = dut->instr_mem_addr;
        if (pc/4 < sizeof(instr_mem)/4)
            dut->instr_mem_data = instr_mem[pc/4];
        else
            dut->instr_mem_data = 0;

        // Drive data memory read
        dut->data_mem_rdata = data_mem[dut->data_mem_addr/4];

        // Toggle clock
        dut->clk = 1;
        dut->eval(); tfp->dump(2*cycle+1);
        dut->clk = 0;
        dut->eval(); tfp->dump(2*cycle+2);

        // Write to data memory on store
        if (dut->data_mem_write) {
            data_mem[dut->data_mem_addr/4] = dut->data_mem_wdata;
        }
    }

    // Finish
    tfp->close();
    dut->final();
    delete dut;
    return 0;
}
