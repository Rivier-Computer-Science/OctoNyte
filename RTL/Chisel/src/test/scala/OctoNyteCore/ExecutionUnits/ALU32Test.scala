// Licensed under the BSD 3-Clause License.
// See https://opensource.org/licenses/BSD-3-Clause for details.

//  sbt "testOnly OctoNyte.ExecutionUnits.ALU32Test"

package OctoNyte.ExecutionUnits

import chisel3._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.flatspec.AnyFlatSpec
import OctoNyte.ExecutionUnits.ALU32.Opcode

class ALU32Test extends AnyFlatSpec{
  "ALU32" should "correctly compute arithmetic, logical, and shift operations for all opcodes" in {
    simulate(new ALU32) { dut =>
      val printDebugInfo = false

      def testOperation(a: BigInt, b: BigInt, opcode: UInt, expected: BigInt): Unit = {
        dut.io.a.poke(a.U(32.W))
        dut.io.b.poke(b.U(32.W))
        dut.io.opcode.poke(opcode)
        dut.clock.step()

        val result = dut.io.result.peek().litValue & 0xFFFFFFFFL // Mask to 32 bits

        if (printDebugInfo) println(s"[ALU32 - Result] -- Result: $result")
         assert(result == (expected & 0xFFFFFFFFL), 
         s"[ALU32] -- Expected result 0x${(expected & 0xFFFFFFFFL).toString(16)} but got 0x${result.toString(16)} for opcode $opcode")
      }


      def testArithmetic(): Unit = {
        testOperation(4, 3, Opcode.ADD, 4 + 3)
        testOperation(4, 3, Opcode.SUB, 4 - 3)
      }

      def testLogic(): Unit = {
        testOperation(0xF0F0F0F0L, 0x0F0F0F0FL, Opcode.AND, 0xF0F0F0F0L & 0x0F0F0F0FL)
        testOperation(0xF0F0F0F0L, 0x0F0F0F0FL, Opcode.OR, 0xF0F0F0F0L | 0x0F0F0F0FL)
        testOperation(0xF0F0F0F0L, 0x0F0F0F0FL, Opcode.XOR, 0xF0F0F0F0L ^ 0x0F0F0F0FL)
      }

      def testShift(): Unit = {
        testOperation(0xF0F0F0F0L, 4, Opcode.SLL, 0xF0F0F0F0L << 4)
        testOperation(0xF0F0F0F0L, 4, Opcode.SRL, 0xF0F0F0F0L >> 4)
        testOperation(0xF0F0F0F0L, 4, Opcode.SRA, (0xF0F0F0F0L.toInt >> 4) & 0xFFFFFFFFL)
      }

      def testComparison(): Unit = {
        testOperation(4, 5, Opcode.SLT, 1)
        testOperation(5, 4, Opcode.SLT, 0)
        testOperation(4, 5, Opcode.SLTU, 1)
        testOperation(5, 4, Opcode.SLTU, 0)
      }

      testArithmetic()
      testLogic()
      testShift()
      testComparison()
    }
  }
}
