// Licensed under the BSD 3-Clause License. 
// See https://opensource.org/licenses/BSD-3-Clause for details.

package scabook

import chisel3._
import chisel3.util._

class Decoder(n: Int) extends Module {
  val io = IO(new Bundle {
    val input = Input(UInt(log2Ceil(n).W)) // Input signal, width depends on n
    val output = Output(UInt(n.W))        // Output is n bits wide
  })

  // Default: all outputs are 0
  io.output := 0.U

  // Decode input to one-hot output
  io.output := 1.U << io.input
}