#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define OUTPUT_FILE "slli_dump.txt"

// Structure to hold register values
typedef struct {
    uint64_t t0;
    uint64_t result;
} RegisterState;

// Function to capture register values
void get_registers(RegisterState *regs) {
    __asm__ volatile (
        "mv %0, t0\n"
        "mv %1, a0\n"
        : "=r"(regs->t0), "=r"(regs->result)
    );
}

// Function to save register dump to a file
void save_register_dump(const RegisterState *state) {
    int fd = open(OUTPUT_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) {
        perror("Error opening file");
        return;
    }

    char buffer[128];
    int len = snprintf(buffer, sizeof(buffer),
        "Register Dump:\n"
        "t0 = 0x%lx\n"
        "result = 0x%lx\n",
        state->t0, state->result
    );

    ssize_t bytes_written = write(fd, buffer, len);
    if (bytes_written < 0) {
        perror("Error writing to file");
    }

    close(fd);
}

// Function to perform `slli`
void shift_left_logical_immediate() {
    __asm__ volatile (
        "li t0, 0x1\n"    // Load 1 into t0
        "slli a0, t0, 3\n" // Shift t0 left by 3 bits, store in a0 (1 << 3 = 8)
        "ret\n"           // Return from function
    );
}

int main() {
    RegisterState state;

    // Call the function that executes `slli`
    __asm__ volatile (
        "call shift_left_logical_immediate\n"
    );

    // Capture register state after executing `slli`
    get_registers(&state);
    save_register_dump(&state);

    return 0;
}
