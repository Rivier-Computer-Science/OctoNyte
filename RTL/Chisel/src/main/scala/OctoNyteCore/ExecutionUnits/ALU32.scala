// Licensed under the BSD 3-Clause License. 
// See https://opensource.org/licenses/BSD-3-Clause for details.

package OctoNyte.ExecutionUnits

import chisel3._
import chisel3.util._


////Test Adding repository to SP25 branch
// Opcodes
object ALU32 {
  object Opcode {
    val ADD  = "b00000".U
    val SUB  = "b00001".U
    val XOR  = "b01000".U
    val OR   = "b01100".U
    val AND  = "b01110".U
    val SLL  = "b00010".U
    val SRL  = "b01010".U
    val SRA  = "b01011".U
    val SLT  = "b00100".U  
    val SLTU = "b00110".U

  }
}

class ALU32 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))
    val b = Input(UInt(32.W))
    val result = Output(UInt(32.W))
    val opcode = Input(UInt(6.W)) 
  })

  val printDebugInfo = false

  // Debug internals of ALU
  if(printDebugInfo) printf(p"[Inside ALU32] --\n") 

  //********************
  //  operations
  //********************
  val result = MuxCase(0.U(32.W), Seq(
    (io.opcode(3, 0) === "b0000".U) -> (io.a.asSInt +& io.b.asSInt).asUInt, // Signed ADD
    (io.opcode(3, 0) === "b0001".U) -> (io.a.asSInt -& io.b.asSInt).asUInt, // Signed SUB
    (io.opcode(3, 0) === "b1000".U) -> (io.a ^ io.b), // XOR
    (io.opcode(3, 0) === "b1100".U) -> (io.a | io.b), // OR
    (io.opcode(3, 0) === "b1110".U) -> (io.a & io.b), // AND
    (io.opcode(3, 0) === "b0010".U) -> (io.a << io.b(5, 0)), // SLL
    (io.opcode(3, 0) === "b1010".U) -> (io.a >> io.b(5, 0)), // SRL
    (io.opcode(3, 0) === "b1011".U) -> (io.a.asSInt >> io.b(5, 0)).asUInt, // SRA
    (io.opcode(3, 0) === "b0100".U) -> Mux(io.a.asSInt < io.b.asSInt, 1.U, 0.U), // SLT
    (io.opcode(3, 0) === "b0110".U) -> Mux(io.a < io.b, 1.U, 0.U) // SLTU
  ))

  if(printDebugInfo) printf(p"  result =     0x${Hexadecimal(result)}\n")

  //**************************
  // Assign results to outputs
  //**************************
  io.result := result

}