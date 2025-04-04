#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define OUTPUT_FILE "sll_dump.txt"

// Structure to hold register values
typedef struct {
    uint64_t input_value;
    uint64_t shift_amount;
    uint64_t result;
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
        "Input Value = 0x%lx (%lu)\n"
        "Shift Amount = %lu\n"
        "Result = 0x%lx (%lu)\n",
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

// Function to perform `sll`
void shift_left_logical() {
    uint64_t input_value = 0x1234;
    uint64_t shift_amount = 3;
    uint64_t result;

    __asm__ volatile (
        "mv a0, %1\n"     // Load input value into a0
        "mv a1, %2\n"     // Load shift amount into a1
        "sll a2, a0, a1\n" // Perform SLL (Shift Left Logical)
        "mv %0, a2\n"     // Store result
        : "=r"(result)
        : "r"(input_value), "r"(shift_amount)
        : "a0", "a1", "a2"
    );

    RegisterState state = {input_value, shift_amount, result};
    save_register_dump(&state);
}

int main() {
    shift_left_logical();
    return 0;
}
