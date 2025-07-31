package OctoNyte.OctoNyteCPU

import chisel3._

class TopModule extends Module {
  val io = IO(new Bundle {
    // Add other I/O ports as needed
  })

  // Instantiate the CPU and Instruction Memory
  val cpu = Module(new OctoNyteCPU())
  val instMem = Module(new InstructionMemory())

  // Connect Instruction Memory to CPU
  instMem.io.addr := cpu.pc  // Use the CPU's program counter as the address for instruction memory
  cpu.io.inst := instMem.io.inst  // Pass the fetched instruction from InstructionMemory to CPU

  // Additional wiring as needed for memory or other peripherals (e.g., data memory)
  // Example: if you have memory or other I/O to connect, add the necessary wiring here.
}
