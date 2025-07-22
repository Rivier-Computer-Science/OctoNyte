# RISC-V cross compiler
CC = riscv64-linux-gnu-gcc

# Compiler flags: static linking, optimization, and all warnings enabled.
CFLAGS = -static -O2 -Wall

# List of target executables
TARGETS = test_xor test_srai test_sll test_sw test_lb test_srli test_slli test_xori test_ori test_andi test_bgeu test_bge test_bltu test_blt test_jal test_li test_subu test_sltu test_slt test_nand test_sub test_load test_div test_nop test_xor test_beq

# Directory to store the compiled binaries
BIN_DIR = bin

# Ensure bin directory exists before placing compiled files
$(shell mkdir -p $(BIN_DIR))

# Default target: build all executables
all: $(TARGETS)

# Build each test program
test_xor: test_xor.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_xor test_xor.c

test_beq: test_beq.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_beq test_beq.c

test_nop: test_nop.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_nop test_nop.c

test_div: test_div.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_div test_div.c

test_load: test_load.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_load test_load.c 

test_sub: test_sub.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_sub test_sub.c

test_nand: test_nand.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_nand test_nand.c

test_addi: test_addi.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_addi test_addi.c

test_slt: test_slt.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_slt test_slt.c

test_sll: test_sll.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_sll test_sll.c

test_sltu: test_sltu.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_sltu test_sltu.c

test_subu: test_subu.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_subu test_subu.c

test_li: test_li.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_li test_li.c

test_jal: test_jal.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_jal test_jal.c

test_bne: test_bne.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_bne test_bne.c

test_blt: test_blt.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_blt test_blt.c

test_bltu: test_bltu.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_bltu test_bltu.c

test_bge: test_bge.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_bge test_bge.c

test_bgeu: test_bgeu.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_bgeu test_bgeu.c

test_andi: test_andi.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_andi test_andi.c

test_ori: test_ori.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_ori test_ori.c

test_xori: test_xori.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_xori test_xori.c

test_slli: test_slli.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_slli test_slli.c

test_srli: test_srli.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_srli test_srli.c

test_srai: test_srai.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_srai test_srai.c

test_lb: test_lb.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_lb test_lb.c

test_sw: test_sw.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_sw test_sw.c

# Run all executables
run: all
	@echo "Running all test programs..."
	@for file in $(BIN_DIR)/*; do \
		if [ -x "$$file" ]; then \
			echo "Running $$file..."; \
			qemu-riscv64 "$$file"; \
		fi; \
	done

# Clean up build artifacts
clean:
	rm -f $(BIN_DIR)/*

.PHONY: all clean runb
