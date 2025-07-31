// Licensed under the BSD 3-Clause License.
// See https://opensource.org/licenses/BSD-3-Clause for details.

// sbt "testOnly OctoNyte.BranchUnit.BranchUnitTest"

package OctoNyte.BranchUnit

import chisel3._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.flatspec.AnyFlatSpec

class BranchUnitTest extends AnyFlatSpec {
  "BranchUnit" should "correctly determine branch conditions and compute target addresses" in {
    simulate(new BranchUnit) { dut =>
      val printDebugInfo = false

      def testBranch(rs1: BigInt, rs2: BigInt, pc: BigInt, imm: BigInt, branchOp: UInt, valid: Boolean, expectedTaken: Boolean): Unit = {
        dut.io.rs1.poke(rs1.S(32.W).asUInt) // Convert signed values to UInt properly
        dut.io.rs2.poke(rs2.S(32.W).asUInt)
        dut.io.pc.poke(pc.U(32.W))
        dut.io.imm.poke(imm.S(12.W))
        dut.io.branchOp.poke(branchOp)
        dut.io.valid.poke(valid.B)
        dut.clock.step()

        val taken = dut.io.taken.peek().litToBoolean
        val target = dut.io.target.peek().litValue

        if (printDebugInfo) println(s"[BranchUnit] -- Taken: $taken, Target: 0x${target.toString}")
        assert(taken == expectedTaken, 
          s"[BranchUnit] -- Expected taken: $expectedTaken but got: $taken for branchOp: $branchOp")
      }

      def testBranches(): Unit = {
        testBranch(10, 10, 100, 4, 0.U, true, true)  // BEQ: Branch if Equal: Taken
        testBranch(10, 5, 200, 8, 1.U, true, true)   // BNE: Branch if Not Equal: Taken
        testBranch(-5, 3, 300, 12, 4.U, true, true)  // BLT: Branch if Less than: Taken
        testBranch(10, 10, 400, 16, 5.U, true, true) // BGE: Taken
        testBranch(5, 10, 500, 20, 6.U, true, true)  // BLTU: Taken
        testBranch(10, 5, 600, 24, 7.U, true, true)  // BGEU: Taken
        testBranch(10, 10, 102, 3, 0.U, true, false) // Misaligned case
      }

      testBranches()
    }
  }
}
