package RISCVOpcodes

import chisel3._
import chisel3.util._

object RV32IDecode {
  // Common opcodes
  val OP_R    = "b0110011".U(7.W)
  val OP_I    = "b0010011".U(7.W)
  val LOAD    = "b0000011".U(7.W)
  val STORE   = "b0100011".U(7.W)
  val BRANCH  = "b1100011".U(7.W)
  val JAL     = "b1101111".U(7.W)
  val JALR    = "b1100111".U(7.W)
  val LUI     = "b0110111".U(7.W)
  val AUIPC   = "b0010111".U(7.W)
  val SYSTEM  = "b1110011".U(7.W)
  val FENCE   = "b0001111".U(7.W)

  /** Helper signals for controlling the pipeline. */
  class DecodeSignals extends Bundle {
    val isALU    = Bool()
    val isLoad   = Bool()
    val isStore  = Bool()
    val isBranch = Bool()
    val isJAL    = Bool()
    val isJALR   = Bool()
    val isLUI    = Bool()
    val isAUIPC  = Bool()
    val isSystem = Bool()
    val isFence  = Bool()

    val aluOp    = UInt(5.W)
    val imm      = UInt(32.W)
  }

  // Sign-extension utilities (synthesizable to standard cells)
  def signExt12(value: UInt): UInt = {
    val sign = value(11)
    Cat(Fill(20, sign), value)
  }
  def signExt13(value: UInt): UInt = {
    val sign = value(12)
    Cat(Fill(19, sign), value)
  }
  def signExt20(value: UInt): UInt = {
    val sign = value(19)
    Cat(Fill(12, sign), value)
  }
  def signExt21(value: UInt): UInt = {
    val sign = value(20)
    Cat(Fill(11, sign), value)
  }

  /** Main decode function – all signals are generated in parallel. */
  def decodeInstr(instr: UInt): DecodeSignals = {
    val dec = Wire(new DecodeSignals)
    // Default assignments for ASIC reliability:
    dec.isALU    := false.B
    dec.isLoad   := false.B
    dec.isStore  := false.B
    dec.isBranch := false.B
    dec.isJAL    := false.B
    dec.isJALR   := false.B
    dec.isLUI    := false.B
    dec.isAUIPC  := false.B
    dec.isSystem := false.B
    dec.isFence  := false.B
    dec.aluOp    := 0.U
    dec.imm      := 0.U

    // Extract instruction fields.
    val opcode = instr(6,0)
    val funct3 = instr(14,12)
    val funct7 = instr(31,25)

    // --- Boolean Flag Generation (combinational, parallel) ---
    dec.isALU    := (opcode === OP_R) || (opcode === OP_I)
    dec.isLoad   := (opcode === LOAD)
    dec.isStore  := (opcode === STORE)
    dec.isBranch := (opcode === BRANCH)
    dec.isJAL    := (opcode === JAL)
    dec.isJALR   := (opcode === JALR)
    dec.isLUI    := (opcode === LUI)
    dec.isAUIPC  := (opcode === AUIPC)
    dec.isSystem := (opcode === SYSTEM)
    dec.isFence  := (opcode === FENCE)

    // --- ALU Operation Decoding ---
    // R-type: Combine funct7 and funct3 as key.
    val aluOpR = MuxLookup(Cat(funct7, funct3), 0.U(5.W), Array(
      Cat("b0000000".U, "b000".U) -> 0.U,  // ADD
      Cat("b0100000".U, "b000".U) -> 1.U,  // SUB
      Cat("b0000000".U, "b001".U) -> 2.U,  // SLL
      Cat("b0000000".U, "b010".U) -> 3.U,  // SLT
      Cat("b0000000".U, "b011".U) -> 4.U,  // SLTU
      Cat("b0000000".U, "b100".U) -> 5.U,  // XOR
      Cat("b0000000".U, "b101".U) -> 6.U,  // SRL
      Cat("b0100000".U, "b101".U) -> 7.U,  // SRA
      Cat("b0000000".U, "b110".U) -> 8.U,  // OR
      Cat("b0000000".U, "b111".U) -> 9.U   // AND
    ))

    // I-type: Use bit 30 for distinguishing SRLI/SRAI when funct3 is "101".
    val aluOpI = MuxLookup(Cat(Mux(funct3 === "b101".U, instr(30), 0.U(1.W)), funct3), 0.U(5.W), Array(
      Cat(0.U(1.W), "b000".U) -> 0.U,   // ADDI
      Cat(0.U(1.W), "b010".U) -> 3.U,   // SLTI
      Cat(0.U(1.W), "b011".U) -> 4.U,   // SLTIU
      Cat(0.U(1.W), "b100".U) -> 5.U,   // XORI
      Cat(0.U(1.W), "b110".U) -> 8.U,   // ORI
      Cat(0.U(1.W), "b111".U) -> 9.U,   // ANDI
      Cat(0.U(1.W), "b001".U) -> 2.U,   // SLLI
      Cat(1.U(1.W), "b101".U) -> 7.U,   // SRAI
      Cat(0.U(1.W), "b101".U) -> 6.U    // SRLI
    ))

    // Select ALU operation based on opcode.
    dec.aluOp := Mux(opcode === OP_R, aluOpR,
                  Mux(opcode === OP_I, aluOpI, 0.U(5.W)))

    // --- Immediate Generation ---
    // Compute immediates in parallel.
    val immI        = signExt12(instr(31,20))
    val storeImm    = Cat(instr(31,25), instr(11,7))
    val immLoad     = signExt12(instr(31,20))
    val branchImm   = Cat(instr(31), instr(7), instr(30,25), instr(11,8), 0.U(1.W))
    val immBranch   = signExt13(branchImm) // 13-bit immediate.
    val jumpImm     = Cat(instr(31), instr(19,12), instr(20), instr(30,21), 0.U(1.W))
    val immJAL      = signExt21(jumpImm)
    val immJALR     = signExt12(instr(31,20))
    val immLUI_AUIPC = Cat(instr(31,12), Fill(12, 0.U))

    // Select the appropriate immediate.
    dec.imm := MuxCase(0.U(32.W), Array(
      (opcode === OP_I)   -> immI,
      (opcode === LOAD)   -> immLoad,
      (opcode === STORE)  -> signExt12(storeImm),
      (opcode === BRANCH) -> immBranch,
      (opcode === JAL)    -> immJAL,
      (opcode === JALR)   -> immJALR,
      (opcode === LUI)    -> immLUI_AUIPC,
      (opcode === AUIPC)  -> immLUI_AUIPC
    ))

    dec
  }
}
