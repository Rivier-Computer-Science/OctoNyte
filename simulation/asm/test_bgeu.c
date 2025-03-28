#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

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

// Function to save register dumps to a text file
void save_register_dump(const RegisterDump *dump, const char *filename) {
    FILE *file = fopen(filename, "w");
    if (!file) {
        perror("Failed to open file");
        return;
    }

    for (int i = 0; i < dump->count; i++) {
        RegisterState state = dump->states[i];
        fprintf(file, "Dump %d:\n", i + 1);
        fprintf(file, "ra=%lu sp=%lu gp=%lu tp=%lu\n", state.ra, state.sp, state.gp, state.tp);
        fprintf(file, "t0=%lu t1=%lu t2=%lu s0=%lu s1=%lu\n", state.t0, state.t1, state.t2, state.s0, state.s1);
        fprintf(file, "a0=%lu a1=%lu a2=%lu a3=%lu a4=%lu a5=%lu a6=%lu a7=%lu\n",
                state.a0, state.a1, state.a2, state.a3, state.a4, state.a5, state.a6, state.a7);
        fprintf(file, "s2=%lu s3=%lu s4=%lu s5=%lu s6=%lu s7=%lu s8=%lu s9=%lu s10=%lu s11=%lu\n",
                state.s2, state.s3, state.s4, state.s5, state.s6, state.s7, state.s8, state.s9, state.s10, state.s11);
        fprintf(file, "t3=%lu t4=%lu t5=%lu t6=%lu\n\n", state.t3, state.t4, state.t5, state.t6);
    }

    fclose(file);
}

int main() {
    RegisterDump regs;
    regs.count = 0;

    // Initialize RegisterState with default values
    RegisterState state = {0};

    // Set registers based on the image content
    // Assuming rs1 = t1, rs2 = t2
    state.t1 = 0x51;  // rs1 = 0x51 (81 in decimal)
    state.t2 = 0x50;  // rs2 = 0x50 (80 in decimal)

    printf("Initial register state:\n");
    printf("  t1 (rs1) = 0x%lx, t2 (rs2) = 0x%lx\n", state.t1, state.t2);

    // Implement BGEU logic
    if (state.t1 >= state.t2) {  // Unsigned comparison
        printf("Branch taken: t1 (0x%lx) >= t2 (0x%lx)\n", state.t1, state.t2);
        // Perform branch operation (e.g., jump to a label)
    } else {
        printf("Branch not taken: t1 (0x%lx) < t2 (0x%lx)\n", state.t1, state.t2);
    }

    // Save the register dump after BGEU logic
    regs.states[regs.count++] = state;
    save_register_dump(&regs, "../test_compare/test_bgeu_dump.txt");

    return 0;
}