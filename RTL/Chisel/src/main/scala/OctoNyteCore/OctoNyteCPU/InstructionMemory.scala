package OctoNyte.OctoNyteCPU

import chisel3._

class InstructionMemory(depth: Int = 1024, width: Int = 32) extends Module {
  val io = IO(new Bundle {
    val addr = Input(UInt(32.W))  // Address to fetch instruction
    val inst = Output(UInt(width.W))  // Instruction data to be fetched
  })

  // Simple instruction memory (stub for now, replace with actual memory)
  val instMem = Mem(depth, UInt(width.W))

  // Fetch instruction from memory
  io.inst := instMem(io.addr(11, 2))  // Using 10-bit address for fetching instruction
}
