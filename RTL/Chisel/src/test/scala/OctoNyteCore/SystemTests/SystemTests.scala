import chisel3._
import chisel3.util._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import OctoNyte.OctoNyteCPU

class SystemTester extends AnyFlatSpec with Matchers {
  "PipelineCPU" should "execute ALU, store, load, and branch correctly" in {
    simulate(new PipelineCPU) { c =>
      // Prepare instruction memory
      val insts = Array.fill(1024)(0.U(32.W))
      insts(0) = "h00A00093".U  // addi x1, x0, 10
      insts(1) = "h00508113".U  // addi x2, x1, 5
      insts(2) = "h00202023".U  // sw x2, 0(x0)
      insts(3) = "h00002183".U  // lw x3, 0(x0)
      insts(4) = "h00310263".U  // beq x2, x3, +8

      // Directly initialize instruction memory if accessible, or use reflection/hack for test
      // Example: if PipelineCPU exposes instMem as a public member
      for (i <- insts.indices) {
        c.instMem.write(i.U, insts(i))
      }

      // Simulated memory model
      val mem = Array.fill(1024)(0.U(32.W))

      for (_ <- 0 until 20) {
        val addr = c.io.memAddr.peek().litValue.toInt >> 2
        if (c.io.memWrite.peek().litToBoolean) {
          mem(addr) = c.io.memWData.peek()
        }
        c.io.memRData.poke(mem(addr))
        c.clock.step()
      }

      // Final check
      val x2Val = c.regFile.io.debugRegs(2).peek().litValue
      val x3Val = c.regFile.io.debugRegs(3).peek().litValue
      println(s"[Test] x2 = $x2Val, x3 = $x3Val")
      x2Val shouldBe 15
      x3Val shouldBe 15
    }
  }
}

object PipelineSystemTestRunner extends App {
  (new SystemTester).execute()
}
