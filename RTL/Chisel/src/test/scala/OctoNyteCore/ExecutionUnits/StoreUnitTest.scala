// Licensed under the BSD 3-Clause License. 
// See https://opensource.org/licenses/BSD-3-Clause for details.

package OctoNyte.StoreUnits

import chisel3._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

class StoreUnitTester extends AnyFlatSpec with Matchers {

  "StoreUnit" should "correctly store signed and unsigned data" in {
    // Test Case 1: SB (Store Byte)
    simulate(new StoreUnit()) { c =>
      c.io.addr.poke(0x1000.U)
      c.io.dataIn.poke("h00FF00FF".U)
      c.io.funct3.poke("b000".U)
      c.clock.step(1)
      c.io.memWrite.expect("h00FF".U)  // Expected store of least significant byte
    }

    // Test Case 2: SH (Store Halfword)
    simulate(new StoreUnit()) { c =>
      c.io.addr.poke(0x1004.U)
      c.io.dataIn.poke("h00FF00FF".U)
      c.io.funct3.poke("b001".U)
      c.clock.step(1)
      c.io.memWrite.expect("h00FF".U)  // Expected store of least significant halfword
    }

    // Test Case 3: SW (Store Word)
    simulate(new StoreUnit()) { c =>
      c.io.addr.poke(0x1008.U)
      c.io.dataIn.poke("h12345678".U)
      c.io.funct3.poke("b010".U)
      c.clock.step(1)
      c.io.memWrite.expect("h12345678".U)  // Expected store of entire word
    }

    // Test Case 4: Invalid funct3 value (no operation)
    simulate(new StoreUnit()) { c =>
      c.io.addr.poke(0x1010.U)
      c.io.dataIn.poke("hDEADBEEF".U)
      c.io.funct3.poke("b111".U)  // Invalid funct3
      c.clock.step(1)
      c.io.memWrite.expect("h00000000".U)  // No data written, default case
    }
  }
}

object StoreUnitTest extends App {
  (new StoreUnitTester).execute()
}
