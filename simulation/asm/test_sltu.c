#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

#define OUTPUT_FILE "sltu_dump.txt"

// Define structure for register state
typedef struct {
    unsigned long ra, sp, gp, tp;
    unsigned long t0, t1, t2, t3;
    unsigned long s0, s1;
    unsigned long a0, a1, a2, a3, a4, a5, a6, a7;
    unsigned long s2, s3, s4, s5, s6, s7, s8;
    unsigned long s9, s10, s11;
} RegisterState;

// Function to save register values to a file
void save_register_dump(const RegisterState *state) {
    int fd;
    char buffer[512];
    int len, written, total_written = 0;

    // Open file
    fd = open(OUTPUT_FILE, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) {
        perror("Failed to open output file");
        return;
    }

    // Format the register values into a buffer
    len = snprintf(buffer, sizeof(buffer),
        "Register State:\n"
        "ra=%lu sp=%lu gp=%lu tp=%lu\n"
        "t0=%lu t1=%lu t2=%lu t3=%lu\n"
        "s0=%lu s1=%lu\n"
        "a0=%lu a1=%lu a2=%lu a3=%lu a4=%lu a5=%lu a6=%lu a7=%lu\n"
        "s2=%lu s3=%lu s4=%lu s5=%lu s6=%lu s7=%lu s8=%lu s9=%lu s10=%lu s11=%lu\n\n",
        state->ra, state->sp, state->gp, state->tp,
        state->t0, state->t1, state->t2, state->t3,
        state->s0, state->s1,
        state->a0, state->a1, state->a2, state->a3, state->a4, state->a5, state->a6, state->a7,
        state->s2, state->s3, state->s4, state->s5, state->s6, state->s7, state->s8, state->s9, state->s10, state->s11
    );

    // Write buffer to file with error handling
    while (total_written < len) {
        written = write(fd, buffer + total_written, len - total_written);
        if (written < 0) {
            perror("Failed to write to output file");
            close(fd);
            return;
        }
        total_written += written;
    }

    // Close file
    close(fd);
}

// Function to capture register state using inline RISC-V assembly
void get_registers(RegisterState *regs) {
    __asm__ volatile (
        "mv %0, ra\n"
        "mv %1, sp\n"
        "mv %2, gp\n"
        "mv %3, tp\n"
        "mv %4, t0\n"
        "mv %5, t1\n"
        "mv %6, t2\n"
        "mv %7, t3\n"
        "mv %8, s0\n"
        "mv %9, s1\n"
        "mv %10, a0\n"
        "mv %11, a1\n"
        "mv %12, a2\n"
        "mv %13, a3\n"
        "mv %14, a4\n"
        "mv %15, a5\n"
        "mv %16, a6\n"
        "mv %17, a7\n"
        "mv %18, s2\n"
        "mv %19, s3\n"
        "mv %20, s4\n"
        "mv %21, s5\n"
        "mv %22, s6\n"
        "mv %23, s7\n"
        "mv %24, s8\n"
        "mv %25, s9\n"
        "mv %26, s10\n"
        "mv %27, s11\n"
        : "=r"(regs->ra), "=r"(regs->sp), "=r"(regs->gp), "=r"(regs->tp),
          "=r"(regs->t0), "=r"(regs->t1), "=r"(regs->t2), "=r"(regs->t3),
          "=r"(regs->s0), "=r"(regs->s1), "=r"(regs->a0), "=r"(regs->a1),
          "=r"(regs->a2), "=r"(regs->a3), "=r"(regs->a4), "=r"(regs->a5),
          "=r"(regs->a6), "=r"(regs->a7), "=r"(regs->s2), "=r"(regs->s3),
          "=r"(regs->s4), "=r"(regs->s5), "=r"(regs->s6), "=r"(regs->s7),
          "=r"(regs->s8), "=r"(regs->s9), "=r"(regs->s10), "=r"(regs->s11)
    );
}

int main() {
    RegisterState state;

    // Initialize registers with sample values
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

    // Perform SLTU operation: t2 = (t0 < t1) ? 1 : 0 (unsigned comparison)
    __asm__ volatile (
        "sltu t2, t0, t1\n"
    );

    // Capture state after SLTU
    get_registers(&state);
    save_register_dump(&state);

    return 0;
}