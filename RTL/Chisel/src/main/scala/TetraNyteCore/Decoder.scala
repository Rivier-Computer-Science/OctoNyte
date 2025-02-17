package RISCVOpcodes

import chisel3._
import chisel3.util._

object RV32IDecode {

  

  




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
  // Sign bit for immediates is always in bit 31 and always sign extended
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



 // Instruction Types from opcode field
object Itype {
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
}


// instr = funct7      + funct3 + opcode
// alu   = funct7(6,5) + funct3
case class ROpcodes(
  instr   : UInt, // Using all the instruction fields
  alu     : UInt, // Alu opcode bits
  isALU   : Bool, // Control Signals
  isAdder : Bool,
  isSub   : Bool,
  isLogic : Bool,
  isShift : Bool,
)

object OpcodeR {    
  val ADD  = ROpcodes ( // Signed 32-bit add
            instr   = Cat("b0000000".U(7.W), "b000".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b000".U(3.W)),
            isALU   = true.B, isAdder = true.B, isSub = false.B,
            isLogic = false.B, isShift = false.B)

  val SUB  = ROpcodes( // Signed 32-bit subtract
            instr   = Cat("b0100000".U(7.W), "b000".U(3.W), Itype.OP_R),
            alu     = Cat("b01".U(2.W), "b000".U(3.W)),
            isALU   = true.B, isAdder = true.B, isSub = true.B,
            isLogic = false.B, isShift = false.B)
      
  val SLL  = ROpcodes( // Shift Left Logical
            instr   = Cat("b0000000".U(7.W), "b001".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b001".U(3.W)),
            isALU   = false.B, isAdder = false.B, isSub = false.B,
            isLogic = false.B, isShift = true.B)
  
  
  val SLT  = ROpcodes(  // Set Less Than Signed
            instr   = Cat("b0000000".U(7.W), "b010".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b010".U(3.W)),
            isALU   = true.B, isAdder = true.B, isSub = true.B,
            isLogic = false.B, isShift = false.B)

  val SLTU = ROpcodes (  // Set Less Than Unsigned
            instr   = Cat("b0000000".U(7.W), "b011".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b011".U(3.W)),
            isALU   = true.B, isAdder = true.B, isSub = true.B,
            isLogic = false.B, isShift = false.B)



  val XOR  : UInt = Cat("b0000000".U(7.W), "b100".U(3.W), Itype.OP_R)
  val SRL  : UInt = Cat("b0000000".U(7.W), "b101".U(3.W), Itype.OP_R)
  val SRA  : UInt = Cat("b0100000".U(7.W), "b101".U(3.W), Itype.OP_R)
  val OR   : UInt = Cat("b0000000".U(7.W), "b110".U(3.W), Itype.OP_R)
  val AND  : Uint = Cat("b0000000".U(7.W), "b111".U(3.W), Itype.OP_R)
}

  object AluOpR {  //   funct7(6,5)    funct3
    val ADD  : UInt = 
    val SUB  : UInt = 
    val SLL  : UInt = 
    val SLT  : UInt = 
    val SLTU : UInt = 
    
  }

  /** Main decode function – all signals are generated in parallel. */
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




    val instructionKey: UInt = Cat(funct7,     funct3, opcode)
    val aluOpKey:       UInt = Cat(funct7(6,5) funct3)

    io.aluOp := MuxLookup(instructionKey, aluOpKey, Seq(
      Opcode.ADD  -> ALUOps.ADD)


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
