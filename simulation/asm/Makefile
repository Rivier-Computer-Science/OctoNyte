# RISC-V cross compiler
CC = riscv64-linux-gnu-gcc

# Compiler flags: static linking, optimization, and all warnings enabled.
CFLAGS = -static -O2 -Wall

# List of target executables
#TARGETS = reg_state test_addi asm_example
TARGETS = test_add test_addi 

# Default target: build both executables
all: $(TARGETS)

# Build reg_state from test_add.c
test_add: test_add.c
	$(CC) $(CFLAGS) -o bin/test_add test_add.c

# Build reg_state from test_addi.c
test_addi: test_addi.c
	$(CC) $(CFLAGS) -o bin/test_addi test_addi.c

# Build reg_state from reg_state.c
reg_state: reg_state.c
	$(CC) $(CFLAGS) -o reg_state reg_state.c

# Build asm_example from asm_example.c
asm_example: asm_example.c
	$(CC) $(CFLAGS) -o asm_example asm_example.c

# Clean up build artifacts
clean:
	rm -f $(TARGETS)

.PHONY: all clean
