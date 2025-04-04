#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define OUTPUT_FILE "li_dump.txt"

// Structure to hold register values
typedef struct {
    uint64_t t0, t1, t2;
} RegisterState;

// Function to capture register values
void get_registers(RegisterState *regs) {
    __asm__ volatile (
        "mv %0, t0\n"
        "mv %1, t1\n"
        "mv %2, t2\n"
        : "=r"(regs->t0), "=r"(regs->t1), "=r"(regs->t2)
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
        "t1 = 0x%lx\n"
        "t2 (t0 ^ t1) = 0x%lx\n",
        state->t0, state->t1, state->t2
    );

    ssize_t bytes_written = write(fd, buffer, len);
    if (bytes_written < 0) {
        perror("Error writing to file");
    }

    close(fd);
}

int main() {
    RegisterState state;

    // Load immediate values into registers using `li`
    __asm__ volatile (
        "li t0, 0x1234\n"  // Load immediate value 0x1234 into t0
        "li t1, 0xABCD\n"  // Load immediate value 0xABCD into t1
    );

    // Capture state before XOR
    get_registers(&state);
    save_register_dump(&state);

    // Perform XOR operation using `t0` and `t1`, store result in `t2`
    __asm__ volatile (
        "xor t2, t0, t1\n"
    );

    // Capture state after XOR
    get_registers(&state);
    save_register_dump(&state);

    return 0;
}