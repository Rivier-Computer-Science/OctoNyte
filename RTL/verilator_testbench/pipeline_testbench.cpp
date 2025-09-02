#include "VTop.h"
#include "verilated.h"
#ifdef VM_TRACE
#  include "verilated_vcd_c.h"
#endif

#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>

static vluint64_t main_time = 0;               // Verilator time in ticks
double sc_time_stamp() { return main_time; }   // Called by $time in Verilog

// Handle +WAVES and +MAX_CYCLES=<n>
static void parse_plusargs(int argc, char** argv, bool& waves, uint64_t& max_cycles) {
    for (int i = 1; i < argc; ++i) {
        const char* a = argv[i];
        if (!a || a[0] != '+') continue;
        if (strcmp(a, "+WAVES") == 0) {
            waves = true;
        } else if (strncmp(a, "+MAX_CYCLES=", 12) == 0) {
            const char* v = a + 12;
            if (*v) {
                char* endp = nullptr;
                unsigned long long tmp = strtoull(v, &endp, 0);
                if (endp && *endp == '\0') max_cycles = (uint64_t)tmp;
            }
        }
    }
}

int main(int argc, char** argv) {
    // Forward args to Verilog so $value$plusargs sees +MEMFILE=...
    Verilated::commandArgs(argc, argv);

    bool waves = false;
    uint64_t max_cycles = 2000;      // guard if trap never asserts
    parse_plusargs(argc, argv, waves, max_cycles);

    auto* top = new VTop{};

#ifdef VM_TRACE
    VerilatedVcdC* tfp = nullptr;
    if (waves) {
        Verilated::traceEverOn(true);
        tfp = new VerilatedVcdC{};
        top->trace(tfp, 99);
        tfp->open("waves.vcd");
    }
#endif

    // Reset for a few half cycles
    top->clock = 0;
    top->reset = 1;
    for (int i = 0; i < 8; ++i) {
        top->eval();
#ifdef VM_TRACE
        if (tfp) tfp->dump(main_time);
#endif
        main_time += 5;
        top->clock = !top->clock;
    }
    top->reset = 0;

    bool done = false;
    uint64_t cycles = 0;

    while (!done && !Verilated::gotFinish()) {
        // Rising edge
        top->clock = 1;
        top->eval();
#ifdef VM_TRACE
        if (tfp) tfp->dump(main_time);
#endif
        main_time += 5;

        // Falling edge
        top->clock = 0;
        top->eval();
#ifdef VM_TRACE
        if (tfp) tfp->dump(main_time);
#endif
        main_time += 5;

        ++cycles;

        if (top->trap) {
            std::printf("[TB] trap asserted at cycle %llu\n",
                        (unsigned long long)cycles);
            // If you mark the regfile public in Top.v, you can print here:
            // /* verilator public_flat */ reg [31:0] registers [0:31];
            // std::printf("[TB] x2=0x%08x x3=0x%08x\n", top->registers[2], top->registers[3]);
            done = true;
        }
        if (cycles >= max_cycles) {
            std::printf("[TB] Reached MAX_CYCLES=%llu without trap; stopping.\n",
                        (unsigned long long)max_cycles);
            done = true;
        }
    }

#ifdef VM_TRACE
    if (tfp) { tfp->close(); delete tfp; tfp = nullptr; }
#endif
    top->final();
    delete top;
    return 0;
}
