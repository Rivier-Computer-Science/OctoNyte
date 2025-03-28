#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct {
    unsigned long t0, t1;
    int label_flag;
} RegisterState;

// Function to get register values
void get_registers(RegisterState *regs) {
    __asm__ volatile (
        "mv %0, t0\n"
        "mv %1, t1\n"
        : "=r"(regs->t0), "=r"(regs->t1)
    );
}

// Function to save register state to a file
void save_register_dump(RegisterState *regs, const char *filename) {
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        perror("Error opening file");
        return;
    }
    fprintf(file, "Register state:\n");
    fprintf(file, "  t0 = 0x%lx, t1 = 0x%lx\n", regs->t0, regs->t1);
    fprintf(file, "  label_flag = %d\n", regs->label_flag);
    fclose(file);
}

int main() {
    RegisterState state;
    state.label_flag = 0;  // Initialize flag

    printf("Before executing BLT:\n");
    get_registers(&state);
    save_register_dump(&state, "../test_compare/test_blt_dump_before.txt"); // Save before execution

    __asm__ volatile (
        "li t0, 3\n"          // Load 3 into t0
        "li t1, 5\n"          // Load 5 into t1
        "blt t0, t1, label\n" // If t0 < t1, branch to 'label'
        "li %0, 1\n"          // If branch does NOT happen, set flag to 1
        "j end\n"             // Jump to end

        "label:\n"
        "li %0, 2\n"          // If branch happens, set flag to 2

        "end:\n"
        : "=r"(state.label_flag) // Output operand
        :                        // No input operands
        : "t0", "t1"             // Clobbered registers
    );

    printf("After executing BLT:\n");
    get_registers(&state);
    save_register_dump(&state, "../test_compare/test_blt_dump_after.txt"); // Save after execution

    return 0;
}
