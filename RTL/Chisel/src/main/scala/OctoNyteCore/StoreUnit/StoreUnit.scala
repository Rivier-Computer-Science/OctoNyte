// Licensed under the BSD 3-Clause License. 
// See https://opensource.org/licenses/BSD-3-Clause for details.

package OctoNyte.StoreUnit

import chisel3._
import chisel3.util._
class StoreUnit extends Module {
  val io = IO(new Bundle {
    val addr = Input(UInt(32.W))    // Address to store data
    val data = Input(UInt(32.W))    // Data to be stored
    val storeType = Input(UInt(2.W)) // 00: Byte, 01: Halfword, 10: Word
    val memWrite = Output(UInt(32.W)) // Output memory write data
    val mask = Output(UInt(4.W))     // Write mask for memory
    val misaligned = Output(Bool())  // Alignment check flag
  })

  // Address Alignment Checks
  val halfwordAligned = io.addr(0) === 0.U
  val wordAligned = io.addr(1,0) === 0.U

  io.misaligned := Mux(io.storeType === 1.U, !halfwordAligned,
                     Mux(io.storeType === 2.U, !wordAligned, false.B))

  // Store Mask Generation
  io.mask := Mux(io.storeType === 0.U, (1.U(4.W) << io.addr(1, 0)), // SB: Store single byte
              Mux(io.storeType === 1.U, (3.U(4.W) << io.addr(1, 0)), // SH: Store two bytes
              Mux(io.storeType === 2.U, 15.U(4.W), 0.U(4.W)))) // SW: Store four bytes

  // Data Manipulation Based on Alignment
  io.memWrite := Mux(io.storeType === 0.U, (io.data(7, 0) << (io.addr(1, 0) * 8.U)), // SB
                Mux(io.storeType === 1.U, (io.data(15, 0) << (io.addr(1) * 16.U)), // SH
                Mux(io.storeType === 2.U, io.data, 0.U(32.W)))) // SW
}