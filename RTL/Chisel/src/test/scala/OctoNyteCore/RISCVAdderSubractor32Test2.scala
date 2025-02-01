// Licensed under the BSD 3-Clause License. 
// See https://opensource.org/licenses/BSD-3-Clause for details.

package OctoNyte.ExecutionUnits

import chisel3._
import chisel3.simulator.EphemeralSimulator._
import org.scalatest.flatspec.AnyFlatSpec
import OctoNyte.ExecutionUnits.RISCVAdderSubtractor32
import OctoNyte.ExecutionUnits.RISCVAdderSubtractor32.Opcode

class RISCVAdderSubtractor32Test2 extends AnyFlatSpec {
  "RISCVAdderSubtractor32" should "correctly compute addition and subtraction" in {
    simulate(new RISCVAdderSubtractor32) { dut =>
      val printDebugInfo = false

      testArithmetic()
      testAdd()

      def testOperation(a: BigInt, b: BigInt, opcode: UInt, expected: BigInt, 
                        expectedFlag: Boolean, expectedZeroFlag: Boolean, expectedNegativeFlag: Boolean): Unit = {
        val isSigned = opcode(2).litToBoolean

        if (isSigned) {
          // Handle signed inputs
          dut.io.a.poke(a.S(32.W).asUInt) // Convert signed BigInt to SInt, then to UInt
          dut.io.b.poke(b.S(32.W).asUInt) // Convert signed BigInt to SInt, then to UInt
        } else {
          // Handle unsigned inputs
          dut.io.a.poke(a.U(32.W)) // Ensure BigInt is treated as non-negative
          dut.io.b.poke(b.U(32.W))
        }
        dut.io.opcode.poke(opcode)
        dut.clock.step()
        val result = dut.io.result.peek().litValue
        val carryOut = dut.io.carryOut.peek().litValue == 1 // Convert UInt(1.W) to Boolean by comparing to 1
        val overflowFlag = dut.io.overflowFlag.peek().litValue == 1
        val zeroFlag = dut.io.zeroFlag.peek().litValue == 1
        val negativeFlag = dut.io.negativeFlag.peek().litValue == 1
        if(printDebugInfo) println(s"[ALU32 - Result] -- Sum: $result, Carry: $carryOut, zeroFlag: $zeroFlag, negativeFlag $negativeFlag")
        
        assert(result == expected, s"[ALU32] -- Expected result 0x${expected.toString(16)} but got 0x${result.toString(16)} for opcode $opcode")
        if( isSigned ) {
          assert(overflowFlag == expectedFlag, s"[ALU32] -- Expected Overflow Flag $expectedFlag but got overflowFlag $overflowFlag for opcode= $opcode and isSigned= $isSigned")
        } else {
          assert(carryOut == expectedFlag, s"[ALU32] -- ExpectedFlag $expectedFlag but got carryOut $carryOut for opcode $opcode")
        }

        assert(zeroFlag == expectedZeroFlag, s"[ALU32] -- ExpectedZeroFlag $expectedZeroFlag but got zeroFlag $zeroFlag for opcode $opcode")
      }

    def testArithmetic(): Unit = {
      // Test cases for all opcodes
      val opcodes = Seq(
        (Opcode.ADD_U32, false, 32), (Opcode.SUB_U32, false, 32), 
        (Opcode.ADD_S32, true, 32),  (Opcode.SUB_S32, true, 32)
      )

      for ((opcode, signed, width) <- opcodes) {
 
        val isSub = opcode(3).litToBoolean        
        val isAdd = !isSub


        // Non-corner case: 4 + 3 or 4 - 3
        val expected = if (isSub) (4 - 3)  else (4 + 3)

        if(printDebugInfo)
        {
          println(s"[ALU32] -- Opcode: $opcode, Signed: $signed, Width: $width")
          println(s"[ALU32] -- a: 4, b: 3")
          println(s"[ALU32] -- ExpectedResult: $expected, ExpectedCarry: 0")
        }
        if (isAdd) testOperation(4, 3, opcode, expected, false, false, false)
        if (isSub) testOperation(4, 3, opcode, expected, false, false, false) 

        
        //Set up corner case values
        val maxValUnsigned: BigInt = (BigInt(1) <<  width) - 1       // Unsigned maximum
        val minValUnsigned: BigInt = 0
        
        val minValNegSigned: BigInt =  -(BigInt(1) << (width - 1))       
        val maxValPosSigned: BigInt =   (BigInt(1) << (width - 1)) - 1
        
        val truncMask = (BigInt(1) << width) - 1

        //#######################
        //# Unsigned Carry/Borrow
        //#######################
        if(!signed)
        {
          // Test carryOut
  
          if (isAdd) {
            val a: BigInt = maxValUnsigned 
            val b: BigInt = 1 // Addend to cause overflow

            val overflowExpected = minValUnsigned
            val overflowCarry = true
            val zeroFlag = true       
            val negativeFlag = false

            if(printDebugInfo)
            {  
              println(s"[ALU64 - Add - Overflow} -- Opcode: $opcode, Signed: $signed, Width: $width")
              println(s"[ALU64 - Add - Overflow] -- MaxValUnsigned: $maxValUnsigned, MinValUnsigned: $minValUnsigned")
              println(s"[ALU64 - Add - Overflow] -- a: $a, b: 1")
              println(s"[ALU64 - Add - Overflow] -- ExpectedResult: $overflowExpected, ExpectedCarry: $overflowCarry")
            }

            testOperation(a, b, opcode, overflowExpected, overflowCarry, zeroFlag, negativeFlag)
          }

          //#######################
          //# Unsigned Borrow
          //#######################
          // Test borrow case
          if (isSub) {
            val a: BigInt = 0 
            val b: BigInt = 1 // Subtrahend to cause a borrow

            val borrowExpectedResult: BigInt = maxValUnsigned // Maximum unsigned value
            val borrowCarry = true 
            val zeroFlag = false
            val negativeFlag = false

            if(printDebugInfo)
            {
              println(s"[ALU32 - Sub - Borrow] -- Opcode: $opcode, Signed: $signed, Width: $width")
              println(s"[ALU32 - Sub - Borrow] -- MaxValUnsigned: $maxValUnsigned, MinVal: $minValUnsigned")
              println(s"[ALU32 - Sub - Borrow] -- a: $a, b: $b")
              println(s"[ALU32 - Sub - Borrow] -- ExpectedResult: ${borrowExpectedResult.toString(16)}, ExpectedCarry: $borrowCarry")
            }

            testOperation(a, b, opcode, borrowExpectedResult, borrowCarry, zeroFlag, negativeFlag)
         }          
        }

        //#######################
        //# Signed Overflow
        //#######################
        if(signed)
        {
          if(isAdd)
          {
            val a: BigInt = maxValPosSigned
            val b: BigInt = 1

            val overflowExpectedResult: BigInt = minValNegSigned.abs  //Result comes back as a UInt
            val overflowExpectedFlag = true
            val zeroFlag = false
            val negativeFlag = true

            if(printDebugInfo)
            {
              println(s"[ALU32 - Add - Overflow] -- Opcode: $opcode, Signed: $signed, Width: $width")
              println(s"[ALU32 - Add - Overflow] -- MaxValPosSigned: $maxValPosSigned, MinValNegSigned: $minValNegSigned")
              println(s"[ALU32 - Add - Overflow] -- a: $a, b: $b")
              println(s"[ALU32 - Add - Overflow] -- ExpectedResult: ${overflowExpectedResult.toString(16)}, overflowExpectedFlag: $overflowExpectedFlag")
            }
           
           testOperation(a, b, opcode, overflowExpectedResult, overflowExpectedFlag, zeroFlag, negativeFlag)
          }
          //#######################
          //# Signed Underflow
          //#######################         
          if (isSub) {
            val a: BigInt = minValNegSigned // Smallest negative number
            val b: BigInt = 1              // Subtract 1

            val underflowExpectedResult: BigInt = maxValPosSigned // Result wraps around to maximum positive value
            val underflowExpectedFlag = true // Overflow flag should be set for signed subtraction underflow
            val zeroFlag = false
            val negativeFlag = false

            if (printDebugInfo) {
              println(s"[ALU32 - Sub - Underflow] -- Opcode: $opcode, Signed: $signed, Width: $width")
              println(s"[ALU32 - Sub - Underflow] -- MaxValPosSigned: $maxValPosSigned, MinValNegSigned: $minValNegSigned")
              println(s"[ALU32 - Sub - Underflow] -- a: $a, b: $b")
              println(s"[ALU32 - Sub - Underflow] -- ExpectedResult: ${underflowExpectedResult.toString(16)}, underflowExpectedFlag: $underflowExpectedFlag")
            }

            testOperation(a, b, opcode, underflowExpectedResult, underflowExpectedFlag, zeroFlag, negativeFlag)
          }          
        }
        
        //#######################
        //# Zero Flag
        //#######################
        if(!signed && isSub) {       
          val a: BigInt = 5 // Fits in all datatypes
          val b: BigInt = 5

          val expectedResult: BigInt = 0
          val expectedCarryFlag: Boolean = false
          val expectedZeroFlag: Boolean = true
          val expectedNegativeFlag: Boolean = false

          if (printDebugInfo) {
            println(s"[ALU64 - Zero Test] -- Opcode: $opcode, Signed: $signed, Width: $width")
            println(s"[ALU64 - Zero Test] -- a: $a, b: $b")
            println(s"[ALU64 - Zero Test] -- ExpectedResult: ${expectedResult.toString(16)}, ZeroFlag: $expectedZeroFlag")
          }

          testOperation(a, b, opcode, expectedResult, expectedCarryFlag, expectedZeroFlag, expectedNegativeFlag)
        }
        if(signed) {       
          val a: BigInt = 5 // Fits in all datatypes
          val b: BigInt = if (isAdd) -5 else 5

          val expectedResult: BigInt = 0
          val expectedCarryFlag: Boolean = false
          val expectedZeroFlag: Boolean = true
          val expectedNegativeFlag: Boolean = false

          if (printDebugInfo) {
            println(s"[ALU64 - Zero Test] -- Opcode: $opcode, Signed: $signed, Width: $width")
            println(s"[ALU64 - Zero Test] -- a: $a, b: $b")
            println(s"[ALU64 - Zero Test] -- ExpectedResult: ${expectedResult.toString(16)}, ZeroFlag: $expectedZeroFlag")
          }

          testOperation(a, b, opcode, expectedResult, expectedCarryFlag, expectedZeroFlag, expectedNegativeFlag)
        }
      }

    }
    def testAdd(): Unit = {
      val testCases = Seq(
        (123, 678, Opcode.ADD_U32, 801, false, false, false),  // Addition
        (250, 150, Opcode.ADD_U32, 400, false, false, false), // Addition
        (1234, 789, Opcode.SUB_U32, 445, false, false, false),  //UnSigned Subtraction
        (2500, 150, Opcode.SUB_U32, 2350, false, false, false),  //UnSigned Subtraction
        (123, 678, Opcode.ADD_S32, 801, false, false, false),  //Signed Addition 
        (250, 150, Opcode.ADD_S32, 400, false, false, false),  //Signed Addition 
        (167, 123, Opcode.SUB_S32, 44, false, false, false),  //Signed Subtraction
        (250, 150, Opcode.SUB_S32, 100, false, false, false),  //Signed Subtraction

        //(40000.U, 15000.U, Opcode.ADD_U32, 25000.U, false, false, false),  // Subtraction
        //(500000.U, 123456.U, Opcode.ADD_U32, 623456.U, false, false, false), // Addition
        //(1000000.U, 500000.U, Opcode.ADD_U32, 500000.U, false, false, false) // Subtraction

      )
    for ((a, b, opcode, expected, expectedFlag, expectedZeroFlag, expectedNegativeFlag) <- testCases) {
        testOperation(BigInt(a), BigInt(b), opcode, BigInt(expected), expectedFlag, expectedZeroFlag, expectedNegativeFlag)
    }
  }
    }
  }
}