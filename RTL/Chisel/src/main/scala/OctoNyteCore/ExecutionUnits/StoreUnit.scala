package OctoNyte.StoreUnits

import chisel3._
import chisel3.util._

class StoreUnit extends Module {
  val io = IO(new Bundle {
    val addr = Input(UInt(32.W))       // Address to store data
    val dataIn = Input(UInt(32.W))     // Data to be stored
    val funct3 = Input(UInt(3.W))      // Function code for store type (SB, SH, SW)
    val memWrite = Output(UInt(32.W))  // Memory write output
  })

  val dataOut = Wire(UInt(32.W))

  // Store Byte (SB), Store Halfword (SH), Store Word (SW)
  when(io.funct3 === "b000".U) {  // SB (Store Byte)
    dataOut := Cat(0.U(24.W), io.dataIn(7, 0))  // Store least significant byte
  } .elsewhen(io.funct3 === "b001".U) {  // SH (Store Halfword)
    dataOut := Cat(0.U(16.W), io.dataIn(15, 0))  // Store least significant half word
  } .elsewhen(io.funct3 === "b010".U) {  // SW (Store Word)
    dataOut := io.dataIn  // Store whole word
  } .otherwise {
    dataOut := 0.U  // Default case (no operation)
  }

  io.memWrite := dataOut
}

