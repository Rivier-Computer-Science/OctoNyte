package RV32IOpcode

import chisel3._
import chisel3.util._


//***************************************
//* Instruction Types
//***************************************
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

//*******************************************
//* R-Type Instructions
//*******************************************
//*
//* instr = funct7      + funct3 + opcode
//* alu   = funct7(6,5) + funct3
case class ROpcodes(
  instr   : UInt, // Using all the instruction fields
  alu     : UInt, // Alu opcode bits
  isAdder : Bool,
  isSub   : Bool,
  isLogic : Bool,
  isShift : Bool,
)

object OpcodeR {    
  val ADD  = ROpcodes ( // Signed 32-bit add
            instr   = Cat("b0000000".U(7.W), "b000".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b000".U(3.W)),
            isAdder = true.B, isSub = false.B,
            isLogic = false.B, isShift = false.B)

  val SUB  = ROpcodes( // Signed 32-bit subtract
            instr   = Cat("b0100000".U(7.W), "b000".U(3.W), Itype.OP_R),
            alu     = Cat("b01".U(2.W), "b000".U(3.W)),
            isAdder = true.B, isSub = true.B,
            isLogic = false.B, isShift = false.B)
      
  val SLL  = ROpcodes( // Shift Left Logical
            instr   = Cat("b0000000".U(7.W), "b001".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b001".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = false.B, isShift = true.B)
  
  val SLT  = ROpcodes(  // Set Less Than Signed
            instr   = Cat("b0000000".U(7.W), "b010".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b010".U(3.W)),
            isAdder = true.B, isSub = true.B,
            isLogic = false.B, isShift = false.B)

  val SLTU = ROpcodes (  // Set Less Than Unsigned
            instr   = Cat("b0000000".U(7.W), "b011".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b011".U(3.W)),
            isAdder = true.B, isSub = true.B,
            isLogic = false.B, isShift = false.B)

  val XOR  = ROpcodes(  // exclusive OR
            instr   = Cat("b0000000".U(7.W), "b100".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b100".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = true.B, isShift = false.B)

  val SRL  = ROpcodes(  // Shift Right Logical
            instr   = Cat("b0000000".U(7.W), "b101".U(3.W), Itype.OP_R),
            alu     = Cat("b00".U(2.W), "b101".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = false.B, isShift = true.B)

  val SRA  = ROpcodes(  //Shift Right Arithmetic
            instr   = Cat("b0100000".U(7.W), "b101".U(3.W), Itype.OP_R),
            alu     = Cat("b01".U(2.W), "b101".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = false.B, isShift = true.B)

  val OR   = ROpcodes(  // logical OR
            instr   = Cat("b0000000".U(7.W), "b110".U(3.W), Itype.OP_R),
            alu     = Cat("b01".U(2.W), "b110".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = true.B, isShift = false.B)

  val AND  = ROpcodes(  // Logical AND
            instr   = Cat("b0000000".U(7.W), "b111".U(3.W), Itype.OP_R),
            alu     = Cat("b01".U(2.W), "b111".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = true.B, isShift = false.B)
}

//*******************************************
//* I-Type Instructions
//*******************************************
//*
//* instr = funct7      + funct3 + opcode
//* alu   = funct7(6,5) + funct3
case class IOpcodes(
  instr   : BitPat, // Using all the instruction fields
  alu     : UInt, // Alu opcode bits
  isAdder : Bool,
  isSub   : Bool,
  isLogic : Bool,
  isShift : Bool,
)

object OpcodeI {    
  val ADDI  = IOpcodes ( // Signed 32-bit add immediate
            instr   = Cat(BitPat("b???????"), "b000".U(3.W), Itype.OP_I),
            alu     = Cat("b00".U(2.W), "b000".U(3.W)),
            isAdder = true.B, isSub = false.B,
            isLogic = false.B, isShift = false.B)
      
  // SUBI doesn't exist in RISC-V but all immediates are signed

  val SLLI = IOpcodes( // Shift Left Logical Immediate
            instr   = Cat("b0000000".U(7.W), "b001".U(3.W), Itype.OP_I),
            alu     = Cat("b00".U(2.W), "b001".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = false.B, isShift = true.B)
  
  val SLTI  = IOpcodes(  // Set Less Than Immediate Signed
            instr   = Cat(BitPat("b???????"), "b010".U(3.W), Itype.OP_I),
            alu     = Cat("b00".U(2.W), "b010".U(3.W)),
            isAdder = true.B, isSub = true.B,
            isLogic = false.B, isShift = false.B)

  val SLTIU = IOpcodes (  // Set Less Than Immediate Unsigned
            instr   = Cat(BitPat("b???????"), "b011".U(3.W), Itype.OP_I),
            alu     = Cat("b00".U(2.W), "b011".U(3.W)),
            isAdder = true.B, isSub = true.B,
            isLogic = false.B, isShift = false.B)

  val XORI  = IOpcodes(  // exclusive OR Immediate
            instr   = Cat(BitPat("b???????"), "b100".U(3.W), Itype.OP_I),
            alu     = Cat("b00".U(2.W), "b100".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = true.B, isShift = false.B)

  val SRLI  = IOpcodes(  // Shift Right Logical Immediate
            instr   = Cat("b0000000".U(7.W), "b101".U(3.W), Itype.OP_I),
            alu     = Cat("b00".U(2.W), "b101".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = false.B, isShift = true.B)

  val SRAI  = IOpcodes(  //Shift Right Arithmetic Immediate
            instr   = Cat("b0100000".U(7.W), "b101".U(3.W), Itype.OP_I),
            alu     = Cat("b01".U(2.W), "b101".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = false.B, isShift = true.B)

  val ORI   = IOpcodes(  // logical OR Immediate
            instr   = Cat(BitPat("b???????"), "b110".U(3.W), Itype.OP_I),
            alu     = Cat("b01".U(2.W), "b110".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = true.B, isShift = false.B)

  val ANDI  = IOpcodes(  // Logical AND Immediate
            instr   = Cat(BitPat("b???????"), "b111".U(3.W), Itype.OP_I),
            alu     = Cat("b01".U(2.W), "b111".U(3.W)),
            isAdder = false.B, isSub = false.B,
            isLogic = true.B, isShift = false.B)
}
