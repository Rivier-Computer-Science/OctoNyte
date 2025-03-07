CC = riscv64-linux-gnu-gcc
CFLAGS = -march=rv64gc -mabi=lp64d -Wall -O2 -I/usr/riscv64-linux-gnu/include
LDFLAGS = -L/usr/riscv64-linux-gnu/lib -lc

SRC = src/main.c src/and_or.c
OBJ = build/main.o build/and_or.o
BIN = build/main.elf
QEMU = qemu-riscv64 -L /usr/riscv64-linux-gnu  # Use correct linker path

all: $(BIN)

$(BIN): $(OBJ)
	$(CC) $(OBJ) -o $(BIN) $(LDFLAGS)

build/%.o: src/%.c
	mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf build

run: all
	@if ! command -v qemu-riscv64 >/dev/null 2>&1; then \
	    echo "Error: QEMU is not installed. Install with: sudo apt install qemu-user"; \
	    exit 1; \
	fi
	$(QEMU) $(BIN)
