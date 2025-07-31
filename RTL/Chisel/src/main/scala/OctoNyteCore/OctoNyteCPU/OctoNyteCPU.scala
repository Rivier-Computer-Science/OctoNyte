package OctoNyte.OctoNyteCPU

import chisel3._
import chisel3.util._
import OctoNyte.ExecutionUnits._
import OctoNyte.LoadUnits._
import OctoNyte.StoreUnits._
import OctoNyte.BranchUnit._

class OctoNyteCPU(width: Int = 32, depth: Int = 32, numThreads: Int = 4) extends Module {
  val io = IO(new Bundle {
    val memAddr = Output(UInt(32.W))  // Memory address for load/store
    val memData = Input(UInt(32.W))   // Memory data input (from data memory)
    val memWrite = Output(Bool())     // Memory write enable
    val inst = Input(UInt(32.W))      // Fetched instruction from external InstructionMemory
  })

  // Pipeline stages
  val IF_ID = RegInit(0.U(32.W))  // Instruction Register (IF/ID stage)
  val ID_EX = RegInit(0.U(32.W))  // Instruction Register (ID/EX stage)
  val EX_MEM = RegInit(0.U(32.W)) // Instruction Register (EX/MEM stage)
  val MEM_WB = RegInit(0.U(32.W)) // Instruction Register (MEM/WB stage)

  // Program Counter register
  val pc = RegInit(0.U(32.W))   // 32-bit Program Counter
  val nextPc = Wire(UInt(32.W)) // Next PC to be calculated by BranchUnit

  // Register File
  val regFile = Mem(depth, UInt(width.W))  // 32 registers, each 32 bits wide

  // Instruction Fetch (IF) Stage
  IF_ID := io.inst  // Use the instruction fetched from the external memory

  // Decoder
  val opcode = IF_ID(6, 0)     // 7-bit opcode
  val rs1 = IF_ID(19, 15)      // rs1 field
  val rs2 = IF_ID(24, 20)      // rs2 field
  val rd = IF_ID(11, 7)        // rd field
  val funct3 = IF_ID(14, 12)   // funct3 field
  val funct7 = IF_ID(31, 25)   // funct7 field
  val imm = Wire(UInt(32.W))   // Immediate value (depends on instruction type)
  val branchOp = Wire(UInt(3.W))  // Branch operation (from funct3)

  // Determine immediate based on instruction type
  imm := MuxCase(0.U, Seq(
    (opcode === "b0000011".U) -> IF_ID(31, 20),   // Load Immediate
    (opcode === "b1100011".U) -> IF_ID(31, 20),   // Branch instructions
    (opcode === "b0010011".U) -> IF_ID(31, 20),   // I-type arithmetic
    (opcode === "b1101111".U) -> IF_ID(31, 12)    // J-type jump
  ))

  // Decode Branch Operation
  branchOp := funct3

  // Branch Unit (used in the IF stage to compute next PC)
  val branchUnit = Module(new BranchUnit)
  branchUnit.io.rs1 := regFile(rs1)  // Read from register file for rs1
  branchUnit.io.rs2 := regFile(rs2)  // Read from register file for rs2
  branchUnit.io.pc := pc
  branchUnit.io.imm := imm.asSInt
  branchUnit.io.branchOp := branchOp
  branchUnit.io.valid := true.B
  nextPc := branchUnit.io.nextPc

  // ALU for execution
  val alu = Module(new ALU32)
  alu.io.a := regFile(rs1)  // Read rs1 from register file
  alu.io.b := regFile(rs2)  // Read rs2 from register file
  alu.io.opcode := IF_ID(5, 0) // Assuming 6-bit opcode for ALU operations

  // Load/Store Unit
  val loadUnit = Module(new LoadUnit)
  val storeUnit = Module(new StoreUnit)

  loadUnit.io.addr := alu.io.result
  loadUnit.io.dataIn := io.memData
  loadUnit.io.funct3 := funct3

  storeUnit.io.addr := alu.io.result
  storeUnit.io.dataIn := regFile(rs2)  // Use register value for store
  storeUnit.io.funct3 := funct3  

  // Memory Writeback
  MEM_WB := Mux(branchUnit.io.taken, branchUnit.io.target, alu.io.result)

  // PC update (increment by 4 unless branch taken)
  when(branchUnit.io.taken) {
    pc := nextPc  // Update PC to the next calculated address from BranchUnit
  }.otherwise {
    pc := pc + 4.U  // Default PC increment (sequential instructions)
  }

  // Register Writeback in MEM_WB stage
  when(MEM_WB =/= 0.U) {
    regFile(rd) := MEM_WB  // Write back to the destination register
  }

  // Outputs for memory system
  io.memAddr := storeUnit.io.addr
  io.memWrite := storeUnit.io.memWrite  // Assuming 'memWrite' is the correct field name
}