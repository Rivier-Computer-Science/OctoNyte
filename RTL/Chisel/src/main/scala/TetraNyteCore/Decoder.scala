package TetraNyte

import chisel3._
import chisel3.util._
import RV32IOpcodes._

object RV32IDecoder {
  
  /** Helper signals for controlling the pipeline. */
  class DecodeSignals extends Bundle {
    // ALU
    val isALU    = Bool()
    val isImm    = Bool()
    val isAdder  = Bool()
    val isSub    = Bool()
    val isLogic  = Bool()
    val isShift  = Bool()
    val aluOp    = UInt(5.W)
    val a        = UInt(32.W)
    val b        = UInt(32.W)
    val imm      = UInt(32.W)

    val isLoad   = Bool()
    val isStore  = Bool()
    val isBranch = Bool()
    val isJAL    = Bool()
    val isJALR   = Bool()
    val isLUI    = Bool()
    val isAUIPC  = Bool()
    val isSystem = Bool()
    val isFence  = Bool()
  }

  // Sign-extension utilities (synthesizable to standard cells)
  // Sign bit for immediates is always in bit 31 and immediates are always sign extended
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

  //*****************************************************************
  //* Main decode function – all signals are generated in parallel. 
  //*****************************************************************
  def decodeInstr(instr: UInt): DecodeSignals = {
    val dec = Wire(new DecodeSignals)

    // Instruction field names
    val opcode = instr(6,0)
    val funct3 = instr(14,12)
    val funct7 = instr(31,25)

    val rs1 = instr(19,15)
    val rs2 = instr(24,20)    
    val rd  = instr(11,7)




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
