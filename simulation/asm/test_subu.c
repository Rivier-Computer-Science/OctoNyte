#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

// Define output file path
#define OUTPUT_FILE "slt_dump.txt"

// Structure to hold register values
typedef struct {
    unsigned long ra, sp, gp, tp;
    unsigned long t0, t1, t2, t3, t4, t5, t6;
    unsigned long s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
    unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
} RegisterState;

// Function to capture register values
void get_registers(RegisterState *regs) {
    __asm__ volatile (
        "mv %0, t0\n"
        "mv %1, t1\n"
        "mv %2, t2\n"
        "mv %3, t3\n"
        : "=r"(regs->t0), "=r"(regs->t1), "=r"(regs->t2), "=r"(regs->t3)
    );
}

// Function to save register values to a file
void save_register_dump(const RegisterState *state) {
    int fd;
    char buffer[512];
    int len;

    // Open file
    fd = open(OUTPUT_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) {
        perror("Error opening file");
        return;
    }

    // Format register values into buffer
    len = snprintf(buffer, sizeof(buffer),
        "Register State:\n"
        "t0=%lu t1=%lu t2=%lu t3=%lu\n",
        state->t0, state->t1, state->t2, state->t3
    );

    // Write buffer to file with error checking
    ssize_t bytes_written = write(fd, buffer, len);
    if (bytes_written < 0) {
        perror("Error writing to file");
    } else if (bytes_written != len) {
        fprintf(stderr, "Warning: Partial write occurred!\n");
    }

    // Close file
    close(fd);
}

// Main function
int main() {
    RegisterState state;

    // Initialize values
    state.t0 = 0xAAAA;
    state.t1 = 0x5555;

    // Load values into registers using inline assembly
    __asm__ volatile (
        "mv t0, %0\n"
        "mv t1, %1\n"
        :
        : "r"(state.t0), "r"(state.t1)
    );

    // Capture initial register state
    get_registers(&state);
    save_register_dump(&state);

    // Perform SUBU operation: t3 = t0 - t1
    __asm__ volatile (
        "sub t3, t0, t1\n"
    );

    // Capture state after SUBU
    get_registers(&state);
    save_register_dump(&state);

    printf("Execution complete. Check '%s' for results.\n", OUTPUT_FILE);

    return 0;
}
