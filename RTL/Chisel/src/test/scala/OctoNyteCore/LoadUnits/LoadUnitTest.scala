// Licensed under the BSD 3-Clause License. 
// See https://opensource.org/licenses/BSD-3-Clause for details.

package OctoNyte.LoadUnits

import chisel3._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
class LoadUnitTester extends AnyFlatSpec with Matchers {

  "LoadUnit" should "correctly load signed and unsigned data" in {
    // Test Case 1: LB (Load Byte, signed)
     simulate(new LoadUnit()) { c =>
      c.io.addr.poke(0x1000.U)
      c.io.dataIn.poke("hFF00FF00".U) // Treat as UInt
      c.io.funct3.poke("b000".U)
      c.clock.step(1)
      c.io.dataOut.expect("h00".U)  // Expected signed Lower Byte
    }

    // Test Case 2: LH (Load Halfword, signed)
    simulate(new LoadUnit()) { c =>
      c.io.addr.poke(0x1004.U)
      c.io.dataIn.poke("h00FF00FF".U)
      c.io.funct3.poke("b001".U)
      c.clock.step(1)
      c.io.dataOut.expect("hFF".U)  // Expected signed Higher half word
    }

    // Test Case 3: LW (Load Word, signed)
    simulate(new LoadUnit()) { c =>
      c.io.addr.poke(0x1008.U)
      c.io.dataIn.poke("h12345678".U)
      c.io.funct3.poke("b010".U)
      c.clock.step(1)
      c.io.dataOut.expect("h12345678".U)  // Expected signed word
    }

    // Test Case 4: LBU (Load Byte, unsigned)
    simulate(new LoadUnit()) { c =>
      c.io.addr.poke(0x100C.U)
      c.io.dataIn.poke("hFF00FF00".U)
      c.io.funct3.poke("b100".U)
      c.clock.step(1)
      c.io.dataOut.expect("h00".U)  // Expected unsigned Lower byte
    }

    // Test Case 5: LHU (Load Halfword, unsigned)
    simulate(new LoadUnit()) { c =>
      c.io.addr.poke(0x1010.U)
      c.io.dataIn.poke("hFFFF00FF".U)
      c.io.funct3.poke("b101".U)
      c.clock.step(1)
      c.io.dataOut.expect("h00FF".U)  // Expected unsigned lower half word
    }

    // Test Case 6: LBU with a different byte value (check unsigned byte behavior)
    simulate(new LoadUnit()) { c =>
      c.io.addr.poke(0x1014.U)
      c.io.dataIn.poke("h00FF00FF".U)
      c.io.funct3.poke("b100".U)
      c.clock.step(1)
      c.io.dataOut.expect("h000000FF".U)  // Expected unsigned (lower byte)
    }
  }
}

object LoadUnitTest extends App {
  (new LoadUnitTester).execute()
}
