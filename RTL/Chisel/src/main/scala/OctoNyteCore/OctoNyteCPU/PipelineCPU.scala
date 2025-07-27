package OctoNyte.OctoNyteCPU

import chisel3._
import chisel3.util._
import OctoNyte.ExecutionUnits._
import OctoNyte.BranchUnit._
import OctoNyte.LoadUnits._
import OctoNyte.StoreUnit._
import TetraNyte.RegFileMT2R1WVec // Import your regfile

class PipelineCPU extends Module {
  val io = IO(new Bundle {
    val memAddr  = Output(UInt(32.W))
    val memWData = Output(UInt(32.W))
    val memWrite = Output(Bool())
    val memMask  = Output(UInt(4.W))
    val memRData = Input(UInt(32.W))
  })

  // ------------
  // Integrated regfile
  // -------
  val regFile = Module(new RegFileMT2R1WVec(width = 32, depth = 32, numThreads = 4))
  regFile.io.threadID := 0.U // Single-thread mode 

  // ------------
  // PC and Instruction Memory
  // ------------
  val pc = RegInit(0.U(32.W))
  val instMem = Mem(1024, UInt(32.W))
  val fetchedInst = instMem(pc(11, 2))

  // ----------------
  // Pipeline Registers
  // ---------
  // IF/ID
  val IF_ID_pc   = Reg(UInt(32.W))
  val IF_ID_inst = Reg(UInt(32.W))

  // ID/EX
  val ID_EX_pc      = Reg(UInt(32.W))
  val ID_EX_rs1Val  = Reg(UInt(32.W))
  val ID_EX_rs2Val  = Reg(UInt(32.W))
  val ID_EX_rd      = Reg(UInt(5.W))
  val ID_EX_opcode  = Reg(UInt(7.W))
  val ID_EX_funct3  = Reg(UInt(3.W))
  val ID_EX_imm     = Reg(UInt(32.W))

  // EX/WB
  val EX_WB_result    = Reg(UInt(32.W))
  val EX_WB_rd        = Reg(UInt(5.W))
  val EX_WB_regWrite  = Reg(Bool())

  // --------
  // IF Stage
  // --------------------
  IF_ID_pc   := pc
  IF_ID_inst := fetchedInst
  pc := pc + 4.U

  // -----------------------------
  // ID Stage
  // -----------------------------
  val opcode = IF_ID_inst(6, 0)
  val rd     = IF_ID_inst(11, 7)
  val funct3 = IF_ID_inst(14, 12)
  val rs1    = IF_ID_inst(19, 15)
  val rs2    = IF_ID_inst(24, 20)

  val immI = Cat(Fill(20, IF_ID_inst(31)), IF_ID_inst(31, 20))

  // Connect register file reads
  regFile.io.src1 := rs1
  regFile.io.src2 := rs2
  val rs1Val = regFile.io.src1data
  val rs2Val = regFile.io.src2data

  ID_EX_pc      := IF_ID_pc
  ID_EX_rs1Val  := rs1Val
  ID_EX_rs2Val  := rs2Val
  ID_EX_rd      := rd
  ID_EX_opcode  := opcode
  ID_EX_funct3  := funct3
  ID_EX_imm     := immI

  // -----------------------------
  // EX Stage
  // -----------------------------
  val alu = Module(new ALU32)
  alu.io.a := ID_EX_rs1Val
  alu.io.b := Mux(opcode === "b0000011".U || opcode === "b0100011".U, ID_EX_imm, ID_EX_rs2Val)
  alu.io.opcode := ID_EX_opcode(5, 0)

  val branchUnit = Module(new BranchUnit)
  branchUnit.io.rs1 := ID_EX_rs1Val
  branchUnit.io.rs2 := ID_EX_rs2Val
  branchUnit.io.pc  := ID_EX_pc
  branchUnit.io.imm := ID_EX_imm.asSInt
  branchUnit.io.branchOp := ID_EX_funct3
  branchUnit.io.valid := (opcode === "b1100011".U)

  when(branchUnit.io.taken) {
    pc := branchUnit.io.target
  }

  val loadUnit = Module(new LoadUnit)
  loadUnit.io.addr := alu.io.result
  loadUnit.io.dataIn := io.memRData
  loadUnit.io.funct3 := ID_EX_funct3

  val storeUnit = Module(new StoreUnit)
  storeUnit.io.addr := alu.io.result
  storeUnit.io.data := ID_EX_rs2Val
  storeUnit.io.storeType := ID_EX_funct3(1, 0)

  io.memAddr  := alu.io.result
  io.memWData := storeUnit.io.memWrite
  io.memMask  := storeUnit.io.mask
  io.memWrite := (opcode === "b0100011".U)

  // -----------------------------
  // WB Stage
  // -----------------------------
  val wbData = Mux(opcode === "b0000011".U, loadUnit.io.dataOut, alu.io.result)
  EX_WB_result   := wbData
  EX_WB_rd       := ID_EX_rd
  EX_WB_regWrite := (ID_EX_rd =/= 0.U) && (opcode =/= "b0100011".U)

  // Connect RegFile Write
  regFile.io.dst1 := EX_WB_rd
  regFile.io.dst1data := EX_WB_result
  regFile.io.wen := EX_WB_regWrite
}