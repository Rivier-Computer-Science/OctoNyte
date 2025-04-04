#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define OUTPUT_FILE "srai_dump.txt"

// Structure to hold register values
typedef struct {
    int64_t input_value;
    uint64_t shift_amount;
    int64_t result;
} RegisterState;

// Function to capture register values
void get_registers(RegisterState *regs) {
    __asm__ volatile (
        "mv %0, a0\n"   // Save input value
        "mv %1, a1\n"   // Save shift amount
        "mv %2, a2\n"   // Save result
        : "=r"(regs->input_value), "=r"(regs->shift_amount), "=r"(regs->result)
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
        "Input Value = 0x%lx (%ld)\n"
        "Shift Amount = %lu\n"
        "Result = 0x%lx (%ld)\n",
        state->input_value, state->input_value,
        state->shift_amount,
        state->result, state->result
    );

    ssize_t bytes_written = write(fd, buffer, len);
    if (bytes_written < 0) {
        perror("Error writing to file");
    }

    close(fd);
}

// Function to perform `srai`
void shift_right_arithmetic_immediate() {
    int64_t input_value = -1234;  // Negative number to test sign extension
    uint64_t shift_amount = 3;    // Shift right by 3 bits
    int64_t result;

    __asm__ volatile (
        "mv a0, %1\n"      // Load input value into a0
        "li a1, %2\n"      // Load shift amount into a1
        "srai a2, a0, 3\n" // Perform SRAI (Shift Right Arithmetic Immediate)
        "mv %0, a2\n"      // Store result
        : "=r"(result)
        : "r"(input_value), "I"(shift_amount)
        : "a0", "a1", "a2"
    );

    RegisterState state = {input_value, shift_amount, result};
    save_register_dump(&state);
}

int main() {
    shift_right_arithmetic_immediate();
    return 0;
}
