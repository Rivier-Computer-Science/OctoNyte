package OctoNyte.OctoNyteCPU

import chisel3._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers

import OctoNyte.ExecutionUnits._
import OctoNyte.LoadUnits._
import OctoNyte.StoreUnits._
import OctoNyte.BranchUnit._

class OctoNyteCPUTester extends AnyFlatSpec with Matchers {

  "OctoNyteCPU System Test" should "simulate addi, sw, lw, beq logic" in {

    simulate(new Module {
      val io = IO(new Bundle {}) // No external I/O for system test

      val alu1 = Module(new ALU32)   // x1 = x0 + 10
      val alu2 = Module(new ALU32)   // x2 = x1 + 5
      val store = Module(new StoreUnit)
      val load = Module(new LoadUnit)
      val branch = Module(new BranchUnit)

      val mem = RegInit(0.U(32.W)) // Simulated memory cell

      // === Step 1: ADDI x1 = x0 + 10 ===
      alu1.io.a := 0.U
      alu1.io.b := 10.U
      alu1.io.opcode := "b00000".U // ADD opcode
      val x1 = RegNext(alu1.io.result)

      // === Step 2: ADDI x2 = x1 + 5 ===
      alu2.io.a := x1
      alu2.io.b := 5.U
      alu2.io.opcode := "b00000".U
      val x2 = RegNext(alu2.io.result)

      // === Step 3: sw x2 → mem[0x1000] ===
      store.io.addr := 0x1000.U
      store.io.dataIn := x2
      store.io.funct3 := "b010".U // sw
      val memWriteEnable = RegNext(store.io.memWrite)
      when(memWriteEnable === 1.U) {
        mem := x2
      }

      // === Step 4: lw x3 ← mem[0x1000] ===
      load.io.addr := 0x1000.U
      load.io.dataIn := mem
      load.io.funct3 := "b010".U // lw
      val x3 = RegNext(load.io.dataOut)

      // === Step 5: beq x3, x2 ===
      branch.io.rs1 := x3
      branch.io.rs2 := x2
      branch.io.pc := 0.U
      branch.io.imm := 8.S
      branch.io.branchOp := 0.U // BEQ
      branch.io.valid := true.B
      val branchTaken = RegNext(branch.io.taken)
      val branchTarget = RegNext(branch.io.target)

      // Debug printouts
      printf(p"x1: ${x1}, x2: ${x2}, Mem[0x1000]: ${mem}, x3 (loaded): ${x3}\n")
      printf(p"Branch Taken: ${branchTaken}, Branch Target: ${branchTarget}\n")

    }) { c =>
      c.clock.step(6)
    }
  }
}

object RunCPUTest extends App {
  (new OctoNyteCPUTester).execute()
}
