#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#define MAX_DUMPS 100  // Maximum number of state dumps

typedef struct {
    unsigned long ra, sp, gp, tp;
    unsigned long t0, t1, t2;
    unsigned long s0, s1;
    unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
    unsigned long s2, s3, s4, s5, s6, s7, s8;
    unsigned long s9, s10, s11;
    unsigned long t3, t4, t5, t6;
} RegisterState;

typedef struct {
    RegisterState states[MAX_DUMPS];
    int count;
} RegisterDump;

// Function to print register state
void print_register_state(const RegisterState *state) {
    printf("Register state:\n");
    printf("  ra = 0x%lx, sp = 0x%lx, gp = 0x%lx, tp = 0x%lx\n", state->ra, state->sp, state->gp, state->tp);
    printf("  t0 = 0x%lx, t1 = 0x%lx, t2 = 0x%lx\n", state->t0, state->t1, state->t2);
    printf("  s0 = 0x%lx, s1 = 0x%lx\n", state->s0, state->s1);
    printf("  a0 = 0x%lx, a1 = 0x%lx, a2 = 0x%lx, a3 = 0x%lx\n", state->a0, state->a1, state->a2, state->a3);
    printf("  a4 = 0x%lx, a5 = 0x%lx, a6 = 0x%lx, a7 = 0x%lx\n", state->a4, state->a5, state->a6, state->a7);
    printf("  s2 = 0x%lx, s3 = 0x%lx, s4 = 0x%lx, s5 = 0x%lx\n", state->s2, state->s3, state->s4, state->s5);
    printf("  s6 = 0x%lx, s7 = 0x%lx, s8 = 0x%lx\n", state->s6, state->s7, state->s8);
    printf("  s9 = 0x%lx, s10 = 0x%lx, s11 = 0x%lx\n", state->s9, state->s10, state->s11);
    printf("  t3 = 0x%lx, t4 = 0x%lx, t5 = 0x%lx, t6 = 0x%lx\n", state->t3, state->t4, state->t5, state->t6);
    printf("---------------------------------------\n");
}

// Function to fetch register values using RISC-V inline assembly
void get_registers(RegisterState *regs) {
    __asm__ volatile (
        "mv %0, ra\n"
        "mv %1, sp\n"
        "mv %2, gp\n"
        "mv %3, tp\n"
        "mv %4, t0\n"
        "mv %5, t1\n"
        "mv %6, t2\n"
        : "=r"(regs->ra), "=r"(regs->sp), "=r"(regs->gp), "=r"(regs->tp),
          "=r"(regs->t0), "=r"(regs->t1), "=r"(regs->t2)
    );

    __asm__ volatile (
        "mv %0, s0\n"
        "mv %1, s1\n"
        "mv %2, a0\n"
        "mv %3, a1\n"
        "mv %4, a2\n"
        "mv %5, a3\n"
        "mv %6, a4\n"
        : "=r"(regs->s0), "=r"(regs->s1), "=r"(regs->a0), "=r"(regs->a1),
          "=r"(regs->a2), "=r"(regs->a3), "=r"(regs->a4)
    );

    __asm__ volatile (
        "mv %0, a5\n"
        "mv %1, a6\n"
        "mv %2, a7\n"
        "mv %3, s2\n"
        "mv %4, s3\n"
        "mv %5, s4\n"
        "mv %6, s5\n"
        : "=r"(regs->a5), "=r"(regs->a6), "=r"(regs->a7), "=r"(regs->s2),
          "=r"(regs->s3), "=r"(regs->s4), "=r"(regs->s5)
    );

    __asm__ volatile (
        "mv %0, s6\n"
        "mv %1, s7\n"
        "mv %2, s8\n"
        "mv %3, s9\n"
        "mv %4, s10\n"
        "mv %5, s11\n"
        "mv %6, t3\n"
        : "=r"(regs->s6), "=r"(regs->s7), "=r"(regs->s8), "=r"(regs->s9),
          "=r"(regs->s10), "=r"(regs->s11), "=r"(regs->t3)
    );

    __asm__ volatile (
        "mv %0, t4\n"
        "mv %1, t5\n"
        "mv %2, t6\n"
        : "=r"(regs->t4), "=r"(regs->t5), "=r"(regs->t6)
    );
}

// Function to save register dumps to a file
void save_register_dump(RegisterDump *regs, const char *filename) {
    FILE *file = fopen(filename, "w");
    if (!file) {
        perror("Failed to open file");
        return;
    }

    for (int i = 0; i < regs->count; i++) {
        RegisterState *state = &regs->states[i];
        fprintf(file, "Dump %d:\n", i + 1);
        fprintf(file, "ra = 0x%lx, sp = 0x%lx, gp = 0x%lx, tp = 0x%lx\n",
                state->ra, state->sp, state->gp, state->tp);
        fprintf(file, "t0 = 0x%lx, t1 = 0x%lx, t2 = 0x%lx\n",
                state->t0, state->t1, state->t2);
        fprintf(file, "---------------------------\n");
    }

    fclose(file);
}

int main() {
    RegisterDump regs;
    regs.count = 0;
    RegisterState state;

    // Initial register state
    printf("Initial register state:\n");
    get_registers(&state);
    print_register_state(&state);
    regs.states[regs.count++] = state;

    // Test SH (Store Halfword)
    uint16_t memory_array[512];  // Array to store halfword in memory
    uint16_t value_to_store = 0x1234;  // Value to store (halfword)
    unsigned long address_to_store = (unsigned long)&memory_array[50];  // Address to store at

    __asm__ volatile (
        "sh %0, 0(%1)\n"  // Store halfword (SH) instruction
        : // No outputs
        : "r"(value_to_store), "r"(address_to_store)  // Input operands
        : "memory"  // Memory is affected
    );

    printf("SH Execution Result: Stored value 0x%04X at address 0x%lx\n", value_to_store, address_to_store);

    // Get register state after executing SH
    get_registers(&state);
    print_register_state(&state);
    regs.states[regs.count++] = state;

    // Save register dumps
    save_register_dump(&regs, "../test_compare/test_sh_dump.txt");

    return 0;
}
