// Licensed under the BSD 3-Clause License.
// See https://opensource.org/licenses/BSD-3-Clause for details.

package OctoNyte.BranchUnit

import chisel3._
import chisel3.util._

class BranchUnit extends Module {
  val io = IO(new Bundle {
    // Inputs
    val rs1 = Input(UInt(32.W))      // First register operand
    val rs2 = Input(UInt(32.W))      // Second register operand
    val pc = Input(UInt(32.W))       // Current PC (32-bit)
    val imm = Input(SInt(12.W))      // 12-bit immediate (sign-extended)
    val branchOp = Input(UInt(3.W))  // Branch operation (BEQ/BNE/BLT/BGE/BLTU/BGEU)
    val valid = Input(Bool())        // Instruction valid
    
    // Outputs
    val taken = Output(Bool())       // Branch taken signal
    val target = Output(UInt(32.W))  // 32-bit target address
    val nextPc = Output(UInt(32.W))  // Next PC value
    val misaligned = Output(Bool())  // Alignment check flag
  })

  // Target address calculation (32-bit result)
  val targetAddr = (io.pc.asSInt + io.imm).asUInt
  io.target := targetAddr & "hFFFF_FFFC".U  // Force 32-bit alignment
  
  // Alignment check (RV32I requires 32-bit aligned branches)
  io.misaligned := targetAddr(1, 0) =/= 0.U

  // Branch condition evaluation
  io.taken := Mux(io.branchOp === 0.U, io.rs1 === io.rs2,          // BEQ
              Mux(io.branchOp === 1.U, io.rs1 =/= io.rs2,          // BNE
              Mux(io.branchOp === 4.U, io.rs1.asSInt < io.rs2.asSInt,  // BLT
              Mux(io.branchOp === 5.U, io.rs1.asSInt >= io.rs2.asSInt, // BGE
              Mux(io.branchOp === 6.U, io.rs1 < io.rs2,            // BLTU
              Mux(io.branchOp === 7.U, io.rs1 >= io.rs2,           // BGEU
              false.B)))))) && io.valid && !io.misaligned

  //Next PC calculation
  io.nextPc := Mux(io.taken, io.target, io.pc + 4.U)
  
}