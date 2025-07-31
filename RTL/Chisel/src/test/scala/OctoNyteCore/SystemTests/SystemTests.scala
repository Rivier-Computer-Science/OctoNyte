//simulating the following pseudo-RISC-V instruction sequence in Chisel logic:
//addi x1, x0, 10        # x1 = 0 + 10 → x1 = 10
//addi x2, x1, 5         # x2 = x1 + 5 → x2 = 15
//sw   x2, 0(x0)         # Store x2 (15) at address 0x0 (we use 0x1000 in Chisel, but conceptually it's base + 0)
//lw   x3, 0(x0)         # Load from address 0x0 into x3 → x3 = 15
//beq  x3, x2, label     # If x3 == x2 (i.e., 15 == 15), branch to label

//label:
//# (End of test program / could loop or halt here)

package OctoNyte.SystemTests

import chisel3._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

import OctoNyte.ExecutionUnits._
import OctoNyte.BranchUnit._
import OctoNyte.LoadUnits._
import OctoNyte.StoreUnits._

class SystemLevelTester extends AnyFlatSpec with Matchers {

  "SystemLevel Flow" should "simulate ALU + Store + Load + Branch working together" in {

    simulate(new Module {
      val io = IO(new Bundle {}) // No top-level IO

      val alu1 = Module(new ALU32)
      val alu2 = Module(new ALU32)
      val store = Module(new StoreUnit)
      val load = Module(new LoadUnit)
      val branch = Module(new BranchUnit)

      // Simulated memory (one location)
      val simulatedMem = RegInit(0.U(32.W))

      // === Step 1: x1 = x0 + 10 ===
      alu1.io.a := 0.U
      alu1.io.b := 10.U
      alu1.io.opcode := "b00000".U // ADD
      val x1 = RegNext(alu1.io.result)

      // === Step 2: x2 = x1 + 5 ===
      alu2.io.a := x1
      alu2.io.b := 5.U
      alu2.io.opcode := "b00000".U
      val x2 = RegNext(alu2.io.result)

      // === Step 3: Store x2 to simulatedMem ===
      store.io.addr := 0x1000.U
      store.io.dataIn := x2
      store.io.funct3 := "b010".U // SW
      simulatedMem := store.io.memWrite

      // === Step 4: Load x3 from simulatedMem ===
      load.io.addr := 0x1000.U
      load.io.dataIn := simulatedMem
      load.io.funct3 := "b010".U
      val x3 = RegNext(load.io.dataOut)

      // === Step 5: BEQ x3, x2 ===
      branch.io.rs1 := x3
      branch.io.rs2 := x2
      branch.io.pc := 0.U
      branch.io.imm := 8.S
      branch.io.branchOp := 0.U // BEQ
      branch.io.valid := true.B
      val branchTaken = RegNext(branch.io.taken)
      val branchTarget = RegNext(branch.io.target)

      // Debug
      printf(p"System Test - x1: 0x${Hexadecimal(x1)}\n")
      printf(p"System Test - x2: 0x${Hexadecimal(x2)}\n")
      printf(p"System Test - Stored Mem: 0x${Hexadecimal(simulatedMem)}\n")
      printf(p"System Test - x3 (loaded): 0x${Hexadecimal(x3)}\n")
      printf(p"System Test - Branch Taken: $branchTaken, Target: 0x${Hexadecimal(branchTarget)}\n")

    }) { c =>
      c.clock.step(5)
    }
  }
}

object SystemLevelTest extends App {
  (new SystemLevelTester).execute()
}
