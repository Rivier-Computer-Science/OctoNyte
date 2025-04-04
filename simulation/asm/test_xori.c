#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define OUTPUT_FILE "xori_dump.txt"

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

// Function to perform `xori`
void bitwise_xor_immediate() {
    __asm__ volatile (
        "li t0, 0b10101010\n"  // Load binary 10101010 into t0
        "xori a0, t0, 0b11001100\n"  // Perform bitwise XOR with 11001100
        "ret\n"                // Return from function
    );
}

int main() {
    RegisterState state;

    // Call the function that executes `xori`
    __asm__ volatile (
        "call bitwise_xor_immediate\n"
    );

    // Capture register state after calling `xori`
    get_registers(&state);
    save_register_dump(&state);

    return 0;
}
