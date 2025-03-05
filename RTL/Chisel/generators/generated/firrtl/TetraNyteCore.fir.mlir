module {
  sv.macro.decl @SYNTHESIS
  sv.macro.decl @VERILATOR
  emit.fragment @RANDOM_INIT_FRAGMENT {
    sv.verbatim "// Standard header to adapt well known macros for register randomization."
    sv.verbatim "\0A// RANDOM may be set to an expression that produces a 32-bit random unsigned value."
    sv.ifdef  @RANDOM {
    } else {
      sv.macro.def @RANDOM "$random"
    }
    sv.verbatim "\0A// Users can define INIT_RANDOM as general code that gets injected into the\0A// initializer block for modules with registers."
    sv.ifdef  @INIT_RANDOM {
    } else {
      sv.macro.def @INIT_RANDOM ""
    }
    sv.verbatim "\0A// If using random initialization, you can also define RANDOMIZE_DELAY to\0A// customize the delay used, otherwise 0.002 is used."
    sv.ifdef  @RANDOMIZE_DELAY {
    } else {
      sv.macro.def @RANDOMIZE_DELAY "0.002"
    }
    sv.verbatim "\0A// Define INIT_RANDOM_PROLOG_ for use in our modules below."
    sv.ifdef  @INIT_RANDOM_PROLOG_ {
    } else {
      sv.ifdef  @RANDOMIZE {
        sv.ifdef  @VERILATOR {
          sv.macro.def @INIT_RANDOM_PROLOG_ "`INIT_RANDOM"
        } else {
          sv.macro.def @INIT_RANDOM_PROLOG_ "`INIT_RANDOM #`RANDOMIZE_DELAY begin end"
        }
      } else {
        sv.macro.def @INIT_RANDOM_PROLOG_ ""
      }
    }
  }
  emit.fragment @RANDOM_INIT_MEM_FRAGMENT {
    sv.verbatim "\0A// Include rmemory initializers in init blocks unless synthesis is set"
    sv.ifdef  @RANDOMIZE {
    } else {
      sv.ifdef  @RANDOMIZE_MEM_INIT {
        sv.macro.def @RANDOMIZE ""
      }
    }
    sv.ifdef  @SYNTHESIS {
    } else {
      sv.ifdef  @ENABLE_INITIAL_MEM_ {
      } else {
        sv.macro.def @ENABLE_INITIAL_MEM_ ""
      }
    }
    sv.verbatim ""
  }
  emit.fragment @RANDOM_INIT_REG_FRAGMENT {
    sv.verbatim "\0A// Include register initializers in init blocks unless synthesis is set"
    sv.ifdef  @RANDOMIZE {
    } else {
      sv.ifdef  @RANDOMIZE_REG_INIT {
        sv.macro.def @RANDOMIZE ""
      }
    }
    sv.ifdef  @SYNTHESIS {
    } else {
      sv.ifdef  @ENABLE_INITIAL_REG_ {
      } else {
        sv.macro.def @ENABLE_INITIAL_REG_ ""
      }
    }
    sv.verbatim ""
  }
  sv.macro.decl @ENABLE_INITIAL_REG_
  sv.macro.decl @ENABLE_INITIAL_MEM_
  sv.macro.decl @FIRRTL_BEFORE_INITIAL
  sv.macro.decl @FIRRTL_AFTER_INITIAL
  sv.macro.decl @RANDOMIZE_MEM_INIT
  sv.macro.decl @RANDOMIZE_REG_INIT
  sv.macro.decl @RANDOMIZE
  sv.macro.decl @RANDOMIZE_DELAY
  sv.macro.decl @RANDOM
  sv.macro.decl @INIT_RANDOM
  sv.macro.decl @INIT_RANDOM_PROLOG_
  hw.generator.schema @FIRRTLMem, "FIRRTL_Memory", ["depth", "numReadPorts", "numWritePorts", "numReadWritePorts", "readLatency", "writeLatency", "width", "maskGran", "readUnderWrite", "writeUnderWrite", "writeClockIDs", "initFilename", "initIsBinary", "initIsInline"]
  hw.module private @RegFileMT2R1WVec(in %clock : i1, in %reset : i1, in %io_threadID : i2, in %io_src1 : i5, in %io_src2 : i5, in %io_dst1 : i5, in %io_wen : i1, in %io_dst1data : i32, out io_src1data : i32, out io_src2data : i32) attributes {emit.fragments = [@RANDOM_INIT_REG_FRAGMENT, @RANDOM_INIT_FRAGMENT]} {
    %0 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<128xi32>
    %_regs_WIRE = sv.wire sym @sym_0 {hw.verilogName = "_regs_WIRE"} : !hw.inout<array<128xi32>>
    sv.assign %_regs_WIRE, %0 : !hw.array<128xi32>
    %io = sv.wire sym @sym {hw.verilogName = "io"} : !hw.inout<struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>>
    %1 = sv.read_inout %io : !hw.inout<struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>>
    %threadID = hw.struct_extract %1["threadID"] : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
    %2 = sv.read_inout %io : !hw.inout<struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>>
    %src1 = hw.struct_extract %2["src1"] : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
    %3 = sv.read_inout %io : !hw.inout<struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>>
    %src2 = hw.struct_extract %3["src2"] : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
    %4 = sv.read_inout %io : !hw.inout<struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>>
    %dst1 = hw.struct_extract %4["dst1"] : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
    %5 = sv.read_inout %io : !hw.inout<struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>>
    %src1data = hw.struct_extract %5["src1data"] : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
    %6 = sv.read_inout %io : !hw.inout<struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>>
    %src2data = hw.struct_extract %6["src2data"] : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
    %regs = sv.reg sym @sym_1 {hw.verilogName = "regs"} : !hw.inout<array<128xi32>> 
    %7 = comb.concat %threadID, %src1 : i2, i5
    %effectiveSrc1 = sv.wire sym @sym_2 {hw.verilogName = "effectiveSrc1"} : !hw.inout<i7>
    sv.assign %effectiveSrc1, %7 : i7
    %8 = comb.concat %threadID, %src2 : i2, i5
    %effectiveSrc2 = sv.wire sym @sym_3 {hw.verilogName = "effectiveSrc2"} : !hw.inout<i7>
    sv.assign %effectiveSrc2, %8 : i7
    %9 = comb.concat %threadID, %dst1 : i2, i5
    %effectiveDst1 = sv.wire sym @sym_4 {hw.verilogName = "effectiveDst1"} : !hw.inout<i7>
    sv.assign %effectiveDst1, %9 : i7
    %10 = sv.read_inout %effectiveSrc1 : !hw.inout<i7>
    %11 = sv.read_inout %regs : !hw.inout<array<128xi32>>
    %12 = hw.array_get %11[%10] : !hw.array<128xi32>, i7
    %13 = sv.read_inout %regs : !hw.inout<array<128xi32>>
    %14 = sv.read_inout %effectiveSrc2 : !hw.inout<i7>
    %15 = hw.array_get %13[%14] : !hw.array<128xi32>, i7
    %16 = hw.struct_create (%io_threadID, %io_src1, %io_src2, %io_dst1, %io_wen, %io_dst1data, %12, %15) : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
    sv.assign %io, %16 : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
    sv.always posedge %clock {
      sv.if %reset {
        %17 = sv.read_inout %_regs_WIRE : !hw.inout<array<128xi32>>
        sv.passign %regs, %17 : !hw.array<128xi32>
      } else {
        %17 = sv.read_inout %io : !hw.inout<struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>>
        %wen = hw.struct_extract %17["wen"] : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
        sv.if %wen {
          %18 = sv.read_inout %io : !hw.inout<struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>>
          %dst1data = hw.struct_extract %18["dst1data"] : !hw.struct<threadID: i2, src1: i5, src2: i5, dst1: i5, wen: i1, dst1data: i32, src1data: i32, src2data: i32>
          %19 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
          %20 = sv.array_index_inout %regs[%19] : !hw.inout<array<128xi32>>, i7
          sv.passign %20, %dst1data : i32
        }
      }
    }
    sv.ifdef  @ENABLE_INITIAL_REG_ {
      sv.ordered {
        sv.ifdef  @FIRRTL_BEFORE_INITIAL {
          sv.verbatim "`FIRRTL_BEFORE_INITIAL"
        }
        sv.initial {
          %_RANDOM = sv.logic {hw.verilogName = "_RANDOM"} : !hw.inout<uarray<128xi32>>
          sv.ifdef.procedural  @INIT_RANDOM_PROLOG_ {
            sv.verbatim "`INIT_RANDOM_PROLOG_"
          }
          sv.ifdef.procedural  @RANDOMIZE_REG_INIT {
            %c-1_i7 = hw.constant -1 : i7
            %c-2_i7 = hw.constant -2 : i7
            %c-3_i7 = hw.constant -3 : i7
            %c-4_i7 = hw.constant -4 : i7
            %c-5_i7 = hw.constant -5 : i7
            %c-6_i7 = hw.constant -6 : i7
            %c-7_i7 = hw.constant -7 : i7
            %c-8_i7 = hw.constant -8 : i7
            %c-9_i7 = hw.constant -9 : i7
            %c-10_i7 = hw.constant -10 : i7
            %c-11_i7 = hw.constant -11 : i7
            %c-12_i7 = hw.constant -12 : i7
            %c-13_i7 = hw.constant -13 : i7
            %c-14_i7 = hw.constant -14 : i7
            %c-15_i7 = hw.constant -15 : i7
            %c-16_i7 = hw.constant -16 : i7
            %c-17_i7 = hw.constant -17 : i7
            %c-18_i7 = hw.constant -18 : i7
            %c-19_i7 = hw.constant -19 : i7
            %c-20_i7 = hw.constant -20 : i7
            %c-21_i7 = hw.constant -21 : i7
            %c-22_i7 = hw.constant -22 : i7
            %c-23_i7 = hw.constant -23 : i7
            %c-24_i7 = hw.constant -24 : i7
            %c-25_i7 = hw.constant -25 : i7
            %c-26_i7 = hw.constant -26 : i7
            %c-27_i7 = hw.constant -27 : i7
            %c-28_i7 = hw.constant -28 : i7
            %c-29_i7 = hw.constant -29 : i7
            %c-30_i7 = hw.constant -30 : i7
            %c-31_i7 = hw.constant -31 : i7
            %c-32_i7 = hw.constant -32 : i7
            %c-33_i7 = hw.constant -33 : i7
            %c-34_i7 = hw.constant -34 : i7
            %c-35_i7 = hw.constant -35 : i7
            %c-36_i7 = hw.constant -36 : i7
            %c-37_i7 = hw.constant -37 : i7
            %c-38_i7 = hw.constant -38 : i7
            %c-39_i7 = hw.constant -39 : i7
            %c-40_i7 = hw.constant -40 : i7
            %c-41_i7 = hw.constant -41 : i7
            %c-42_i7 = hw.constant -42 : i7
            %c-43_i7 = hw.constant -43 : i7
            %c-44_i7 = hw.constant -44 : i7
            %c-45_i7 = hw.constant -45 : i7
            %c-46_i7 = hw.constant -46 : i7
            %c-47_i7 = hw.constant -47 : i7
            %c-48_i7 = hw.constant -48 : i7
            %c-49_i7 = hw.constant -49 : i7
            %c-50_i7 = hw.constant -50 : i7
            %c-51_i7 = hw.constant -51 : i7
            %c-52_i7 = hw.constant -52 : i7
            %c-53_i7 = hw.constant -53 : i7
            %c-54_i7 = hw.constant -54 : i7
            %c-55_i7 = hw.constant -55 : i7
            %c-56_i7 = hw.constant -56 : i7
            %c-57_i7 = hw.constant -57 : i7
            %c-58_i7 = hw.constant -58 : i7
            %c-59_i7 = hw.constant -59 : i7
            %c-60_i7 = hw.constant -60 : i7
            %c-61_i7 = hw.constant -61 : i7
            %c-62_i7 = hw.constant -62 : i7
            %c-63_i7 = hw.constant -63 : i7
            %c-64_i7 = hw.constant -64 : i7
            %c63_i7 = hw.constant 63 : i7
            %c62_i7 = hw.constant 62 : i7
            %c61_i7 = hw.constant 61 : i7
            %c60_i7 = hw.constant 60 : i7
            %c59_i7 = hw.constant 59 : i7
            %c58_i7 = hw.constant 58 : i7
            %c57_i7 = hw.constant 57 : i7
            %c56_i7 = hw.constant 56 : i7
            %c55_i7 = hw.constant 55 : i7
            %c54_i7 = hw.constant 54 : i7
            %c53_i7 = hw.constant 53 : i7
            %c52_i7 = hw.constant 52 : i7
            %c51_i7 = hw.constant 51 : i7
            %c50_i7 = hw.constant 50 : i7
            %c49_i7 = hw.constant 49 : i7
            %c48_i7 = hw.constant 48 : i7
            %c47_i7 = hw.constant 47 : i7
            %c46_i7 = hw.constant 46 : i7
            %c45_i7 = hw.constant 45 : i7
            %c44_i7 = hw.constant 44 : i7
            %c43_i7 = hw.constant 43 : i7
            %c42_i7 = hw.constant 42 : i7
            %c41_i7 = hw.constant 41 : i7
            %c40_i7 = hw.constant 40 : i7
            %c39_i7 = hw.constant 39 : i7
            %c38_i7 = hw.constant 38 : i7
            %c37_i7 = hw.constant 37 : i7
            %c36_i7 = hw.constant 36 : i7
            %c35_i7 = hw.constant 35 : i7
            %c34_i7 = hw.constant 34 : i7
            %c33_i7 = hw.constant 33 : i7
            %c32_i7 = hw.constant 32 : i7
            %c31_i7 = hw.constant 31 : i7
            %c30_i7 = hw.constant 30 : i7
            %c29_i7 = hw.constant 29 : i7
            %c28_i7 = hw.constant 28 : i7
            %c27_i7 = hw.constant 27 : i7
            %c26_i7 = hw.constant 26 : i7
            %c25_i7 = hw.constant 25 : i7
            %c24_i7 = hw.constant 24 : i7
            %c23_i7 = hw.constant 23 : i7
            %c22_i7 = hw.constant 22 : i7
            %c21_i7 = hw.constant 21 : i7
            %c20_i7 = hw.constant 20 : i7
            %c19_i7 = hw.constant 19 : i7
            %c18_i7 = hw.constant 18 : i7
            %c17_i7 = hw.constant 17 : i7
            %c16_i7 = hw.constant 16 : i7
            %c15_i7 = hw.constant 15 : i7
            %c14_i7 = hw.constant 14 : i7
            %c13_i7 = hw.constant 13 : i7
            %c12_i7 = hw.constant 12 : i7
            %c11_i7 = hw.constant 11 : i7
            %c10_i7 = hw.constant 10 : i7
            %c9_i7 = hw.constant 9 : i7
            %c8_i7 = hw.constant 8 : i7
            %c7_i7 = hw.constant 7 : i7
            %c6_i7 = hw.constant 6 : i7
            %c5_i7 = hw.constant 5 : i7
            %c4_i7 = hw.constant 4 : i7
            %c3_i7 = hw.constant 3 : i7
            %c2_i7 = hw.constant 2 : i7
            %c1_i7 = hw.constant 1 : i7
            %c0_i7 = hw.constant 0 : i7
            %c1_i8 = hw.constant 1 : i8
            %c-128_i8 = hw.constant -128 : i8
            %c0_i8 = hw.constant 0 : i8
            sv.for %i = %c0_i8 to %c-128_i8 step %c1_i8 : i8 {
              %RANDOM = sv.macro.ref.expr.se @RANDOM() : () -> i32
              %401 = comb.extract %i from 0 : (i8) -> i7
              %402 = sv.array_index_inout %_RANDOM[%401] : !hw.inout<uarray<128xi32>>, i7
              sv.bpassign %402, %RANDOM : i32
            } {hw.verilogName = "i"}
            %17 = sv.array_index_inout %_RANDOM[%c0_i7] : !hw.inout<uarray<128xi32>>, i7
            %18 = sv.read_inout %17 : !hw.inout<i32>
            %19 = sv.array_index_inout %regs[%c0_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %19, %18 : i32
            %20 = sv.array_index_inout %_RANDOM[%c1_i7] : !hw.inout<uarray<128xi32>>, i7
            %21 = sv.read_inout %20 : !hw.inout<i32>
            %22 = sv.array_index_inout %regs[%c1_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %22, %21 : i32
            %23 = sv.array_index_inout %_RANDOM[%c2_i7] : !hw.inout<uarray<128xi32>>, i7
            %24 = sv.read_inout %23 : !hw.inout<i32>
            %25 = sv.array_index_inout %regs[%c2_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %25, %24 : i32
            %26 = sv.array_index_inout %_RANDOM[%c3_i7] : !hw.inout<uarray<128xi32>>, i7
            %27 = sv.read_inout %26 : !hw.inout<i32>
            %28 = sv.array_index_inout %regs[%c3_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %28, %27 : i32
            %29 = sv.array_index_inout %_RANDOM[%c4_i7] : !hw.inout<uarray<128xi32>>, i7
            %30 = sv.read_inout %29 : !hw.inout<i32>
            %31 = sv.array_index_inout %regs[%c4_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %31, %30 : i32
            %32 = sv.array_index_inout %_RANDOM[%c5_i7] : !hw.inout<uarray<128xi32>>, i7
            %33 = sv.read_inout %32 : !hw.inout<i32>
            %34 = sv.array_index_inout %regs[%c5_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %34, %33 : i32
            %35 = sv.array_index_inout %_RANDOM[%c6_i7] : !hw.inout<uarray<128xi32>>, i7
            %36 = sv.read_inout %35 : !hw.inout<i32>
            %37 = sv.array_index_inout %regs[%c6_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %37, %36 : i32
            %38 = sv.array_index_inout %_RANDOM[%c7_i7] : !hw.inout<uarray<128xi32>>, i7
            %39 = sv.read_inout %38 : !hw.inout<i32>
            %40 = sv.array_index_inout %regs[%c7_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %40, %39 : i32
            %41 = sv.array_index_inout %_RANDOM[%c8_i7] : !hw.inout<uarray<128xi32>>, i7
            %42 = sv.read_inout %41 : !hw.inout<i32>
            %43 = sv.array_index_inout %regs[%c8_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %43, %42 : i32
            %44 = sv.array_index_inout %_RANDOM[%c9_i7] : !hw.inout<uarray<128xi32>>, i7
            %45 = sv.read_inout %44 : !hw.inout<i32>
            %46 = sv.array_index_inout %regs[%c9_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %46, %45 : i32
            %47 = sv.array_index_inout %_RANDOM[%c10_i7] : !hw.inout<uarray<128xi32>>, i7
            %48 = sv.read_inout %47 : !hw.inout<i32>
            %49 = sv.array_index_inout %regs[%c10_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %49, %48 : i32
            %50 = sv.array_index_inout %_RANDOM[%c11_i7] : !hw.inout<uarray<128xi32>>, i7
            %51 = sv.read_inout %50 : !hw.inout<i32>
            %52 = sv.array_index_inout %regs[%c11_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %52, %51 : i32
            %53 = sv.array_index_inout %_RANDOM[%c12_i7] : !hw.inout<uarray<128xi32>>, i7
            %54 = sv.read_inout %53 : !hw.inout<i32>
            %55 = sv.array_index_inout %regs[%c12_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %55, %54 : i32
            %56 = sv.array_index_inout %_RANDOM[%c13_i7] : !hw.inout<uarray<128xi32>>, i7
            %57 = sv.read_inout %56 : !hw.inout<i32>
            %58 = sv.array_index_inout %regs[%c13_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %58, %57 : i32
            %59 = sv.array_index_inout %_RANDOM[%c14_i7] : !hw.inout<uarray<128xi32>>, i7
            %60 = sv.read_inout %59 : !hw.inout<i32>
            %61 = sv.array_index_inout %regs[%c14_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %61, %60 : i32
            %62 = sv.array_index_inout %_RANDOM[%c15_i7] : !hw.inout<uarray<128xi32>>, i7
            %63 = sv.read_inout %62 : !hw.inout<i32>
            %64 = sv.array_index_inout %regs[%c15_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %64, %63 : i32
            %65 = sv.array_index_inout %_RANDOM[%c16_i7] : !hw.inout<uarray<128xi32>>, i7
            %66 = sv.read_inout %65 : !hw.inout<i32>
            %67 = sv.array_index_inout %regs[%c16_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %67, %66 : i32
            %68 = sv.array_index_inout %_RANDOM[%c17_i7] : !hw.inout<uarray<128xi32>>, i7
            %69 = sv.read_inout %68 : !hw.inout<i32>
            %70 = sv.array_index_inout %regs[%c17_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %70, %69 : i32
            %71 = sv.array_index_inout %_RANDOM[%c18_i7] : !hw.inout<uarray<128xi32>>, i7
            %72 = sv.read_inout %71 : !hw.inout<i32>
            %73 = sv.array_index_inout %regs[%c18_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %73, %72 : i32
            %74 = sv.array_index_inout %_RANDOM[%c19_i7] : !hw.inout<uarray<128xi32>>, i7
            %75 = sv.read_inout %74 : !hw.inout<i32>
            %76 = sv.array_index_inout %regs[%c19_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %76, %75 : i32
            %77 = sv.array_index_inout %_RANDOM[%c20_i7] : !hw.inout<uarray<128xi32>>, i7
            %78 = sv.read_inout %77 : !hw.inout<i32>
            %79 = sv.array_index_inout %regs[%c20_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %79, %78 : i32
            %80 = sv.array_index_inout %_RANDOM[%c21_i7] : !hw.inout<uarray<128xi32>>, i7
            %81 = sv.read_inout %80 : !hw.inout<i32>
            %82 = sv.array_index_inout %regs[%c21_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %82, %81 : i32
            %83 = sv.array_index_inout %_RANDOM[%c22_i7] : !hw.inout<uarray<128xi32>>, i7
            %84 = sv.read_inout %83 : !hw.inout<i32>
            %85 = sv.array_index_inout %regs[%c22_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %85, %84 : i32
            %86 = sv.array_index_inout %_RANDOM[%c23_i7] : !hw.inout<uarray<128xi32>>, i7
            %87 = sv.read_inout %86 : !hw.inout<i32>
            %88 = sv.array_index_inout %regs[%c23_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %88, %87 : i32
            %89 = sv.array_index_inout %_RANDOM[%c24_i7] : !hw.inout<uarray<128xi32>>, i7
            %90 = sv.read_inout %89 : !hw.inout<i32>
            %91 = sv.array_index_inout %regs[%c24_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %91, %90 : i32
            %92 = sv.array_index_inout %_RANDOM[%c25_i7] : !hw.inout<uarray<128xi32>>, i7
            %93 = sv.read_inout %92 : !hw.inout<i32>
            %94 = sv.array_index_inout %regs[%c25_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %94, %93 : i32
            %95 = sv.array_index_inout %_RANDOM[%c26_i7] : !hw.inout<uarray<128xi32>>, i7
            %96 = sv.read_inout %95 : !hw.inout<i32>
            %97 = sv.array_index_inout %regs[%c26_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %97, %96 : i32
            %98 = sv.array_index_inout %_RANDOM[%c27_i7] : !hw.inout<uarray<128xi32>>, i7
            %99 = sv.read_inout %98 : !hw.inout<i32>
            %100 = sv.array_index_inout %regs[%c27_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %100, %99 : i32
            %101 = sv.array_index_inout %_RANDOM[%c28_i7] : !hw.inout<uarray<128xi32>>, i7
            %102 = sv.read_inout %101 : !hw.inout<i32>
            %103 = sv.array_index_inout %regs[%c28_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %103, %102 : i32
            %104 = sv.array_index_inout %_RANDOM[%c29_i7] : !hw.inout<uarray<128xi32>>, i7
            %105 = sv.read_inout %104 : !hw.inout<i32>
            %106 = sv.array_index_inout %regs[%c29_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %106, %105 : i32
            %107 = sv.array_index_inout %_RANDOM[%c30_i7] : !hw.inout<uarray<128xi32>>, i7
            %108 = sv.read_inout %107 : !hw.inout<i32>
            %109 = sv.array_index_inout %regs[%c30_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %109, %108 : i32
            %110 = sv.array_index_inout %_RANDOM[%c31_i7] : !hw.inout<uarray<128xi32>>, i7
            %111 = sv.read_inout %110 : !hw.inout<i32>
            %112 = sv.array_index_inout %regs[%c31_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %112, %111 : i32
            %113 = sv.array_index_inout %_RANDOM[%c32_i7] : !hw.inout<uarray<128xi32>>, i7
            %114 = sv.read_inout %113 : !hw.inout<i32>
            %115 = sv.array_index_inout %regs[%c32_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %115, %114 : i32
            %116 = sv.array_index_inout %_RANDOM[%c33_i7] : !hw.inout<uarray<128xi32>>, i7
            %117 = sv.read_inout %116 : !hw.inout<i32>
            %118 = sv.array_index_inout %regs[%c33_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %118, %117 : i32
            %119 = sv.array_index_inout %_RANDOM[%c34_i7] : !hw.inout<uarray<128xi32>>, i7
            %120 = sv.read_inout %119 : !hw.inout<i32>
            %121 = sv.array_index_inout %regs[%c34_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %121, %120 : i32
            %122 = sv.array_index_inout %_RANDOM[%c35_i7] : !hw.inout<uarray<128xi32>>, i7
            %123 = sv.read_inout %122 : !hw.inout<i32>
            %124 = sv.array_index_inout %regs[%c35_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %124, %123 : i32
            %125 = sv.array_index_inout %_RANDOM[%c36_i7] : !hw.inout<uarray<128xi32>>, i7
            %126 = sv.read_inout %125 : !hw.inout<i32>
            %127 = sv.array_index_inout %regs[%c36_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %127, %126 : i32
            %128 = sv.array_index_inout %_RANDOM[%c37_i7] : !hw.inout<uarray<128xi32>>, i7
            %129 = sv.read_inout %128 : !hw.inout<i32>
            %130 = sv.array_index_inout %regs[%c37_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %130, %129 : i32
            %131 = sv.array_index_inout %_RANDOM[%c38_i7] : !hw.inout<uarray<128xi32>>, i7
            %132 = sv.read_inout %131 : !hw.inout<i32>
            %133 = sv.array_index_inout %regs[%c38_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %133, %132 : i32
            %134 = sv.array_index_inout %_RANDOM[%c39_i7] : !hw.inout<uarray<128xi32>>, i7
            %135 = sv.read_inout %134 : !hw.inout<i32>
            %136 = sv.array_index_inout %regs[%c39_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %136, %135 : i32
            %137 = sv.array_index_inout %_RANDOM[%c40_i7] : !hw.inout<uarray<128xi32>>, i7
            %138 = sv.read_inout %137 : !hw.inout<i32>
            %139 = sv.array_index_inout %regs[%c40_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %139, %138 : i32
            %140 = sv.array_index_inout %_RANDOM[%c41_i7] : !hw.inout<uarray<128xi32>>, i7
            %141 = sv.read_inout %140 : !hw.inout<i32>
            %142 = sv.array_index_inout %regs[%c41_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %142, %141 : i32
            %143 = sv.array_index_inout %_RANDOM[%c42_i7] : !hw.inout<uarray<128xi32>>, i7
            %144 = sv.read_inout %143 : !hw.inout<i32>
            %145 = sv.array_index_inout %regs[%c42_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %145, %144 : i32
            %146 = sv.array_index_inout %_RANDOM[%c43_i7] : !hw.inout<uarray<128xi32>>, i7
            %147 = sv.read_inout %146 : !hw.inout<i32>
            %148 = sv.array_index_inout %regs[%c43_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %148, %147 : i32
            %149 = sv.array_index_inout %_RANDOM[%c44_i7] : !hw.inout<uarray<128xi32>>, i7
            %150 = sv.read_inout %149 : !hw.inout<i32>
            %151 = sv.array_index_inout %regs[%c44_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %151, %150 : i32
            %152 = sv.array_index_inout %_RANDOM[%c45_i7] : !hw.inout<uarray<128xi32>>, i7
            %153 = sv.read_inout %152 : !hw.inout<i32>
            %154 = sv.array_index_inout %regs[%c45_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %154, %153 : i32
            %155 = sv.array_index_inout %_RANDOM[%c46_i7] : !hw.inout<uarray<128xi32>>, i7
            %156 = sv.read_inout %155 : !hw.inout<i32>
            %157 = sv.array_index_inout %regs[%c46_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %157, %156 : i32
            %158 = sv.array_index_inout %_RANDOM[%c47_i7] : !hw.inout<uarray<128xi32>>, i7
            %159 = sv.read_inout %158 : !hw.inout<i32>
            %160 = sv.array_index_inout %regs[%c47_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %160, %159 : i32
            %161 = sv.array_index_inout %_RANDOM[%c48_i7] : !hw.inout<uarray<128xi32>>, i7
            %162 = sv.read_inout %161 : !hw.inout<i32>
            %163 = sv.array_index_inout %regs[%c48_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %163, %162 : i32
            %164 = sv.array_index_inout %_RANDOM[%c49_i7] : !hw.inout<uarray<128xi32>>, i7
            %165 = sv.read_inout %164 : !hw.inout<i32>
            %166 = sv.array_index_inout %regs[%c49_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %166, %165 : i32
            %167 = sv.array_index_inout %_RANDOM[%c50_i7] : !hw.inout<uarray<128xi32>>, i7
            %168 = sv.read_inout %167 : !hw.inout<i32>
            %169 = sv.array_index_inout %regs[%c50_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %169, %168 : i32
            %170 = sv.array_index_inout %_RANDOM[%c51_i7] : !hw.inout<uarray<128xi32>>, i7
            %171 = sv.read_inout %170 : !hw.inout<i32>
            %172 = sv.array_index_inout %regs[%c51_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %172, %171 : i32
            %173 = sv.array_index_inout %_RANDOM[%c52_i7] : !hw.inout<uarray<128xi32>>, i7
            %174 = sv.read_inout %173 : !hw.inout<i32>
            %175 = sv.array_index_inout %regs[%c52_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %175, %174 : i32
            %176 = sv.array_index_inout %_RANDOM[%c53_i7] : !hw.inout<uarray<128xi32>>, i7
            %177 = sv.read_inout %176 : !hw.inout<i32>
            %178 = sv.array_index_inout %regs[%c53_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %178, %177 : i32
            %179 = sv.array_index_inout %_RANDOM[%c54_i7] : !hw.inout<uarray<128xi32>>, i7
            %180 = sv.read_inout %179 : !hw.inout<i32>
            %181 = sv.array_index_inout %regs[%c54_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %181, %180 : i32
            %182 = sv.array_index_inout %_RANDOM[%c55_i7] : !hw.inout<uarray<128xi32>>, i7
            %183 = sv.read_inout %182 : !hw.inout<i32>
            %184 = sv.array_index_inout %regs[%c55_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %184, %183 : i32
            %185 = sv.array_index_inout %_RANDOM[%c56_i7] : !hw.inout<uarray<128xi32>>, i7
            %186 = sv.read_inout %185 : !hw.inout<i32>
            %187 = sv.array_index_inout %regs[%c56_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %187, %186 : i32
            %188 = sv.array_index_inout %_RANDOM[%c57_i7] : !hw.inout<uarray<128xi32>>, i7
            %189 = sv.read_inout %188 : !hw.inout<i32>
            %190 = sv.array_index_inout %regs[%c57_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %190, %189 : i32
            %191 = sv.array_index_inout %_RANDOM[%c58_i7] : !hw.inout<uarray<128xi32>>, i7
            %192 = sv.read_inout %191 : !hw.inout<i32>
            %193 = sv.array_index_inout %regs[%c58_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %193, %192 : i32
            %194 = sv.array_index_inout %_RANDOM[%c59_i7] : !hw.inout<uarray<128xi32>>, i7
            %195 = sv.read_inout %194 : !hw.inout<i32>
            %196 = sv.array_index_inout %regs[%c59_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %196, %195 : i32
            %197 = sv.array_index_inout %_RANDOM[%c60_i7] : !hw.inout<uarray<128xi32>>, i7
            %198 = sv.read_inout %197 : !hw.inout<i32>
            %199 = sv.array_index_inout %regs[%c60_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %199, %198 : i32
            %200 = sv.array_index_inout %_RANDOM[%c61_i7] : !hw.inout<uarray<128xi32>>, i7
            %201 = sv.read_inout %200 : !hw.inout<i32>
            %202 = sv.array_index_inout %regs[%c61_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %202, %201 : i32
            %203 = sv.array_index_inout %_RANDOM[%c62_i7] : !hw.inout<uarray<128xi32>>, i7
            %204 = sv.read_inout %203 : !hw.inout<i32>
            %205 = sv.array_index_inout %regs[%c62_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %205, %204 : i32
            %206 = sv.array_index_inout %_RANDOM[%c63_i7] : !hw.inout<uarray<128xi32>>, i7
            %207 = sv.read_inout %206 : !hw.inout<i32>
            %208 = sv.array_index_inout %regs[%c63_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %208, %207 : i32
            %209 = sv.array_index_inout %_RANDOM[%c-64_i7] : !hw.inout<uarray<128xi32>>, i7
            %210 = sv.read_inout %209 : !hw.inout<i32>
            %211 = sv.array_index_inout %regs[%c-64_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %211, %210 : i32
            %212 = sv.array_index_inout %_RANDOM[%c-63_i7] : !hw.inout<uarray<128xi32>>, i7
            %213 = sv.read_inout %212 : !hw.inout<i32>
            %214 = sv.array_index_inout %regs[%c-63_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %214, %213 : i32
            %215 = sv.array_index_inout %_RANDOM[%c-62_i7] : !hw.inout<uarray<128xi32>>, i7
            %216 = sv.read_inout %215 : !hw.inout<i32>
            %217 = sv.array_index_inout %regs[%c-62_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %217, %216 : i32
            %218 = sv.array_index_inout %_RANDOM[%c-61_i7] : !hw.inout<uarray<128xi32>>, i7
            %219 = sv.read_inout %218 : !hw.inout<i32>
            %220 = sv.array_index_inout %regs[%c-61_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %220, %219 : i32
            %221 = sv.array_index_inout %_RANDOM[%c-60_i7] : !hw.inout<uarray<128xi32>>, i7
            %222 = sv.read_inout %221 : !hw.inout<i32>
            %223 = sv.array_index_inout %regs[%c-60_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %223, %222 : i32
            %224 = sv.array_index_inout %_RANDOM[%c-59_i7] : !hw.inout<uarray<128xi32>>, i7
            %225 = sv.read_inout %224 : !hw.inout<i32>
            %226 = sv.array_index_inout %regs[%c-59_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %226, %225 : i32
            %227 = sv.array_index_inout %_RANDOM[%c-58_i7] : !hw.inout<uarray<128xi32>>, i7
            %228 = sv.read_inout %227 : !hw.inout<i32>
            %229 = sv.array_index_inout %regs[%c-58_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %229, %228 : i32
            %230 = sv.array_index_inout %_RANDOM[%c-57_i7] : !hw.inout<uarray<128xi32>>, i7
            %231 = sv.read_inout %230 : !hw.inout<i32>
            %232 = sv.array_index_inout %regs[%c-57_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %232, %231 : i32
            %233 = sv.array_index_inout %_RANDOM[%c-56_i7] : !hw.inout<uarray<128xi32>>, i7
            %234 = sv.read_inout %233 : !hw.inout<i32>
            %235 = sv.array_index_inout %regs[%c-56_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %235, %234 : i32
            %236 = sv.array_index_inout %_RANDOM[%c-55_i7] : !hw.inout<uarray<128xi32>>, i7
            %237 = sv.read_inout %236 : !hw.inout<i32>
            %238 = sv.array_index_inout %regs[%c-55_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %238, %237 : i32
            %239 = sv.array_index_inout %_RANDOM[%c-54_i7] : !hw.inout<uarray<128xi32>>, i7
            %240 = sv.read_inout %239 : !hw.inout<i32>
            %241 = sv.array_index_inout %regs[%c-54_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %241, %240 : i32
            %242 = sv.array_index_inout %_RANDOM[%c-53_i7] : !hw.inout<uarray<128xi32>>, i7
            %243 = sv.read_inout %242 : !hw.inout<i32>
            %244 = sv.array_index_inout %regs[%c-53_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %244, %243 : i32
            %245 = sv.array_index_inout %_RANDOM[%c-52_i7] : !hw.inout<uarray<128xi32>>, i7
            %246 = sv.read_inout %245 : !hw.inout<i32>
            %247 = sv.array_index_inout %regs[%c-52_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %247, %246 : i32
            %248 = sv.array_index_inout %_RANDOM[%c-51_i7] : !hw.inout<uarray<128xi32>>, i7
            %249 = sv.read_inout %248 : !hw.inout<i32>
            %250 = sv.array_index_inout %regs[%c-51_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %250, %249 : i32
            %251 = sv.array_index_inout %_RANDOM[%c-50_i7] : !hw.inout<uarray<128xi32>>, i7
            %252 = sv.read_inout %251 : !hw.inout<i32>
            %253 = sv.array_index_inout %regs[%c-50_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %253, %252 : i32
            %254 = sv.array_index_inout %_RANDOM[%c-49_i7] : !hw.inout<uarray<128xi32>>, i7
            %255 = sv.read_inout %254 : !hw.inout<i32>
            %256 = sv.array_index_inout %regs[%c-49_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %256, %255 : i32
            %257 = sv.array_index_inout %_RANDOM[%c-48_i7] : !hw.inout<uarray<128xi32>>, i7
            %258 = sv.read_inout %257 : !hw.inout<i32>
            %259 = sv.array_index_inout %regs[%c-48_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %259, %258 : i32
            %260 = sv.array_index_inout %_RANDOM[%c-47_i7] : !hw.inout<uarray<128xi32>>, i7
            %261 = sv.read_inout %260 : !hw.inout<i32>
            %262 = sv.array_index_inout %regs[%c-47_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %262, %261 : i32
            %263 = sv.array_index_inout %_RANDOM[%c-46_i7] : !hw.inout<uarray<128xi32>>, i7
            %264 = sv.read_inout %263 : !hw.inout<i32>
            %265 = sv.array_index_inout %regs[%c-46_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %265, %264 : i32
            %266 = sv.array_index_inout %_RANDOM[%c-45_i7] : !hw.inout<uarray<128xi32>>, i7
            %267 = sv.read_inout %266 : !hw.inout<i32>
            %268 = sv.array_index_inout %regs[%c-45_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %268, %267 : i32
            %269 = sv.array_index_inout %_RANDOM[%c-44_i7] : !hw.inout<uarray<128xi32>>, i7
            %270 = sv.read_inout %269 : !hw.inout<i32>
            %271 = sv.array_index_inout %regs[%c-44_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %271, %270 : i32
            %272 = sv.array_index_inout %_RANDOM[%c-43_i7] : !hw.inout<uarray<128xi32>>, i7
            %273 = sv.read_inout %272 : !hw.inout<i32>
            %274 = sv.array_index_inout %regs[%c-43_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %274, %273 : i32
            %275 = sv.array_index_inout %_RANDOM[%c-42_i7] : !hw.inout<uarray<128xi32>>, i7
            %276 = sv.read_inout %275 : !hw.inout<i32>
            %277 = sv.array_index_inout %regs[%c-42_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %277, %276 : i32
            %278 = sv.array_index_inout %_RANDOM[%c-41_i7] : !hw.inout<uarray<128xi32>>, i7
            %279 = sv.read_inout %278 : !hw.inout<i32>
            %280 = sv.array_index_inout %regs[%c-41_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %280, %279 : i32
            %281 = sv.array_index_inout %_RANDOM[%c-40_i7] : !hw.inout<uarray<128xi32>>, i7
            %282 = sv.read_inout %281 : !hw.inout<i32>
            %283 = sv.array_index_inout %regs[%c-40_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %283, %282 : i32
            %284 = sv.array_index_inout %_RANDOM[%c-39_i7] : !hw.inout<uarray<128xi32>>, i7
            %285 = sv.read_inout %284 : !hw.inout<i32>
            %286 = sv.array_index_inout %regs[%c-39_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %286, %285 : i32
            %287 = sv.array_index_inout %_RANDOM[%c-38_i7] : !hw.inout<uarray<128xi32>>, i7
            %288 = sv.read_inout %287 : !hw.inout<i32>
            %289 = sv.array_index_inout %regs[%c-38_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %289, %288 : i32
            %290 = sv.array_index_inout %_RANDOM[%c-37_i7] : !hw.inout<uarray<128xi32>>, i7
            %291 = sv.read_inout %290 : !hw.inout<i32>
            %292 = sv.array_index_inout %regs[%c-37_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %292, %291 : i32
            %293 = sv.array_index_inout %_RANDOM[%c-36_i7] : !hw.inout<uarray<128xi32>>, i7
            %294 = sv.read_inout %293 : !hw.inout<i32>
            %295 = sv.array_index_inout %regs[%c-36_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %295, %294 : i32
            %296 = sv.array_index_inout %_RANDOM[%c-35_i7] : !hw.inout<uarray<128xi32>>, i7
            %297 = sv.read_inout %296 : !hw.inout<i32>
            %298 = sv.array_index_inout %regs[%c-35_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %298, %297 : i32
            %299 = sv.array_index_inout %_RANDOM[%c-34_i7] : !hw.inout<uarray<128xi32>>, i7
            %300 = sv.read_inout %299 : !hw.inout<i32>
            %301 = sv.array_index_inout %regs[%c-34_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %301, %300 : i32
            %302 = sv.array_index_inout %_RANDOM[%c-33_i7] : !hw.inout<uarray<128xi32>>, i7
            %303 = sv.read_inout %302 : !hw.inout<i32>
            %304 = sv.array_index_inout %regs[%c-33_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %304, %303 : i32
            %305 = sv.array_index_inout %_RANDOM[%c-32_i7] : !hw.inout<uarray<128xi32>>, i7
            %306 = sv.read_inout %305 : !hw.inout<i32>
            %307 = sv.array_index_inout %regs[%c-32_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %307, %306 : i32
            %308 = sv.array_index_inout %_RANDOM[%c-31_i7] : !hw.inout<uarray<128xi32>>, i7
            %309 = sv.read_inout %308 : !hw.inout<i32>
            %310 = sv.array_index_inout %regs[%c-31_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %310, %309 : i32
            %311 = sv.array_index_inout %_RANDOM[%c-30_i7] : !hw.inout<uarray<128xi32>>, i7
            %312 = sv.read_inout %311 : !hw.inout<i32>
            %313 = sv.array_index_inout %regs[%c-30_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %313, %312 : i32
            %314 = sv.array_index_inout %_RANDOM[%c-29_i7] : !hw.inout<uarray<128xi32>>, i7
            %315 = sv.read_inout %314 : !hw.inout<i32>
            %316 = sv.array_index_inout %regs[%c-29_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %316, %315 : i32
            %317 = sv.array_index_inout %_RANDOM[%c-28_i7] : !hw.inout<uarray<128xi32>>, i7
            %318 = sv.read_inout %317 : !hw.inout<i32>
            %319 = sv.array_index_inout %regs[%c-28_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %319, %318 : i32
            %320 = sv.array_index_inout %_RANDOM[%c-27_i7] : !hw.inout<uarray<128xi32>>, i7
            %321 = sv.read_inout %320 : !hw.inout<i32>
            %322 = sv.array_index_inout %regs[%c-27_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %322, %321 : i32
            %323 = sv.array_index_inout %_RANDOM[%c-26_i7] : !hw.inout<uarray<128xi32>>, i7
            %324 = sv.read_inout %323 : !hw.inout<i32>
            %325 = sv.array_index_inout %regs[%c-26_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %325, %324 : i32
            %326 = sv.array_index_inout %_RANDOM[%c-25_i7] : !hw.inout<uarray<128xi32>>, i7
            %327 = sv.read_inout %326 : !hw.inout<i32>
            %328 = sv.array_index_inout %regs[%c-25_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %328, %327 : i32
            %329 = sv.array_index_inout %_RANDOM[%c-24_i7] : !hw.inout<uarray<128xi32>>, i7
            %330 = sv.read_inout %329 : !hw.inout<i32>
            %331 = sv.array_index_inout %regs[%c-24_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %331, %330 : i32
            %332 = sv.array_index_inout %_RANDOM[%c-23_i7] : !hw.inout<uarray<128xi32>>, i7
            %333 = sv.read_inout %332 : !hw.inout<i32>
            %334 = sv.array_index_inout %regs[%c-23_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %334, %333 : i32
            %335 = sv.array_index_inout %_RANDOM[%c-22_i7] : !hw.inout<uarray<128xi32>>, i7
            %336 = sv.read_inout %335 : !hw.inout<i32>
            %337 = sv.array_index_inout %regs[%c-22_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %337, %336 : i32
            %338 = sv.array_index_inout %_RANDOM[%c-21_i7] : !hw.inout<uarray<128xi32>>, i7
            %339 = sv.read_inout %338 : !hw.inout<i32>
            %340 = sv.array_index_inout %regs[%c-21_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %340, %339 : i32
            %341 = sv.array_index_inout %_RANDOM[%c-20_i7] : !hw.inout<uarray<128xi32>>, i7
            %342 = sv.read_inout %341 : !hw.inout<i32>
            %343 = sv.array_index_inout %regs[%c-20_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %343, %342 : i32
            %344 = sv.array_index_inout %_RANDOM[%c-19_i7] : !hw.inout<uarray<128xi32>>, i7
            %345 = sv.read_inout %344 : !hw.inout<i32>
            %346 = sv.array_index_inout %regs[%c-19_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %346, %345 : i32
            %347 = sv.array_index_inout %_RANDOM[%c-18_i7] : !hw.inout<uarray<128xi32>>, i7
            %348 = sv.read_inout %347 : !hw.inout<i32>
            %349 = sv.array_index_inout %regs[%c-18_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %349, %348 : i32
            %350 = sv.array_index_inout %_RANDOM[%c-17_i7] : !hw.inout<uarray<128xi32>>, i7
            %351 = sv.read_inout %350 : !hw.inout<i32>
            %352 = sv.array_index_inout %regs[%c-17_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %352, %351 : i32
            %353 = sv.array_index_inout %_RANDOM[%c-16_i7] : !hw.inout<uarray<128xi32>>, i7
            %354 = sv.read_inout %353 : !hw.inout<i32>
            %355 = sv.array_index_inout %regs[%c-16_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %355, %354 : i32
            %356 = sv.array_index_inout %_RANDOM[%c-15_i7] : !hw.inout<uarray<128xi32>>, i7
            %357 = sv.read_inout %356 : !hw.inout<i32>
            %358 = sv.array_index_inout %regs[%c-15_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %358, %357 : i32
            %359 = sv.array_index_inout %_RANDOM[%c-14_i7] : !hw.inout<uarray<128xi32>>, i7
            %360 = sv.read_inout %359 : !hw.inout<i32>
            %361 = sv.array_index_inout %regs[%c-14_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %361, %360 : i32
            %362 = sv.array_index_inout %_RANDOM[%c-13_i7] : !hw.inout<uarray<128xi32>>, i7
            %363 = sv.read_inout %362 : !hw.inout<i32>
            %364 = sv.array_index_inout %regs[%c-13_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %364, %363 : i32
            %365 = sv.array_index_inout %_RANDOM[%c-12_i7] : !hw.inout<uarray<128xi32>>, i7
            %366 = sv.read_inout %365 : !hw.inout<i32>
            %367 = sv.array_index_inout %regs[%c-12_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %367, %366 : i32
            %368 = sv.array_index_inout %_RANDOM[%c-11_i7] : !hw.inout<uarray<128xi32>>, i7
            %369 = sv.read_inout %368 : !hw.inout<i32>
            %370 = sv.array_index_inout %regs[%c-11_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %370, %369 : i32
            %371 = sv.array_index_inout %_RANDOM[%c-10_i7] : !hw.inout<uarray<128xi32>>, i7
            %372 = sv.read_inout %371 : !hw.inout<i32>
            %373 = sv.array_index_inout %regs[%c-10_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %373, %372 : i32
            %374 = sv.array_index_inout %_RANDOM[%c-9_i7] : !hw.inout<uarray<128xi32>>, i7
            %375 = sv.read_inout %374 : !hw.inout<i32>
            %376 = sv.array_index_inout %regs[%c-9_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %376, %375 : i32
            %377 = sv.array_index_inout %_RANDOM[%c-8_i7] : !hw.inout<uarray<128xi32>>, i7
            %378 = sv.read_inout %377 : !hw.inout<i32>
            %379 = sv.array_index_inout %regs[%c-8_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %379, %378 : i32
            %380 = sv.array_index_inout %_RANDOM[%c-7_i7] : !hw.inout<uarray<128xi32>>, i7
            %381 = sv.read_inout %380 : !hw.inout<i32>
            %382 = sv.array_index_inout %regs[%c-7_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %382, %381 : i32
            %383 = sv.array_index_inout %_RANDOM[%c-6_i7] : !hw.inout<uarray<128xi32>>, i7
            %384 = sv.read_inout %383 : !hw.inout<i32>
            %385 = sv.array_index_inout %regs[%c-6_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %385, %384 : i32
            %386 = sv.array_index_inout %_RANDOM[%c-5_i7] : !hw.inout<uarray<128xi32>>, i7
            %387 = sv.read_inout %386 : !hw.inout<i32>
            %388 = sv.array_index_inout %regs[%c-5_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %388, %387 : i32
            %389 = sv.array_index_inout %_RANDOM[%c-4_i7] : !hw.inout<uarray<128xi32>>, i7
            %390 = sv.read_inout %389 : !hw.inout<i32>
            %391 = sv.array_index_inout %regs[%c-4_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %391, %390 : i32
            %392 = sv.array_index_inout %_RANDOM[%c-3_i7] : !hw.inout<uarray<128xi32>>, i7
            %393 = sv.read_inout %392 : !hw.inout<i32>
            %394 = sv.array_index_inout %regs[%c-3_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %394, %393 : i32
            %395 = sv.array_index_inout %_RANDOM[%c-2_i7] : !hw.inout<uarray<128xi32>>, i7
            %396 = sv.read_inout %395 : !hw.inout<i32>
            %397 = sv.array_index_inout %regs[%c-2_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %397, %396 : i32
            %398 = sv.array_index_inout %_RANDOM[%c-1_i7] : !hw.inout<uarray<128xi32>>, i7
            %399 = sv.read_inout %398 : !hw.inout<i32>
            %400 = sv.array_index_inout %regs[%c-1_i7] : !hw.inout<array<128xi32>>, i7
            sv.bpassign %400, %399 : i32
          }
        }
        sv.ifdef  @FIRRTL_AFTER_INITIAL {
          sv.verbatim "`FIRRTL_AFTER_INITIAL"
        }
      }
    }
    hw.output %src1data, %src2data : i32, i32
  }
  hw.module private @TetraNyteCore_Anon(in %io_a : i32, in %io_b : i32, in %io_fn : i5, out io_out : i32) {
    %c1_i5 = hw.constant 1 : i5
    %false = hw.constant false
    %c0_i5 = hw.constant 0 : i5
    %c0_i32 = hw.constant 0 : i32
    %io = sv.wire sym @sym {hw.verilogName = "io"} : !hw.inout<struct<a: i32, b: i32, fn: i5, out: i32>>
    %0 = sv.read_inout %io : !hw.inout<struct<a: i32, b: i32, fn: i5, out: i32>>
    %a = hw.struct_extract %0["a"] : !hw.struct<a: i32, b: i32, fn: i5, out: i32>
    %1 = sv.read_inout %io : !hw.inout<struct<a: i32, b: i32, fn: i5, out: i32>>
    %b = hw.struct_extract %1["b"] : !hw.struct<a: i32, b: i32, fn: i5, out: i32>
    %2 = sv.read_inout %io : !hw.inout<struct<a: i32, b: i32, fn: i5, out: i32>>
    %fn = hw.struct_extract %2["fn"] : !hw.struct<a: i32, b: i32, fn: i5, out: i32>
    %3 = sv.read_inout %io : !hw.inout<struct<a: i32, b: i32, fn: i5, out: i32>>
    %out = hw.struct_extract %3["out"] : !hw.struct<a: i32, b: i32, fn: i5, out: i32>
    %4 = comb.icmp bin eq %fn, %c0_i5 {sv.namehint = "_T"} : i5
    %5 = comb.concat %false, %a : i1, i32
    %6 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<i33>
    sv.assign %6, %5 : i33
    %7 = comb.concat %false, %b : i1, i32
    %8 = sv.wire {hw.verilogName = "_GEN_0"} : !hw.inout<i33>
    sv.assign %8, %7 : i33
    %9 = sv.read_inout %6 : !hw.inout<i33>
    %10 = sv.read_inout %8 : !hw.inout<i33>
    %11 = comb.add bin %9, %10 : i33
    %_io_out_T = sv.wire sym @sym_0 {hw.verilogName = "_io_out_T"} : !hw.inout<i33>
    sv.assign %_io_out_T, %11 : i33
    %12 = sv.read_inout %_io_out_T : !hw.inout<i33>
    %13 = comb.extract %12 from 0 : (i33) -> i32
    %_io_out_T_1 = sv.wire sym @sym_1 {hw.verilogName = "_io_out_T_1"} : !hw.inout<i32>
    sv.assign %_io_out_T_1, %13 : i32
    %14 = comb.icmp bin eq %fn, %c1_i5 {sv.namehint = "_T_1"} : i5
    %15 = sv.read_inout %6 : !hw.inout<i33>
    %16 = sv.read_inout %8 : !hw.inout<i33>
    %17 = comb.sub bin %15, %16 : i33
    %_io_out_T_2 = sv.wire sym @sym_2 {hw.verilogName = "_io_out_T_2"} : !hw.inout<i33>
    sv.assign %_io_out_T_2, %17 : i33
    %18 = sv.read_inout %_io_out_T_2 : !hw.inout<i33>
    %19 = comb.extract %18 from 0 : (i33) -> i32
    %_io_out_T_3 = sv.wire sym @sym_3 {hw.verilogName = "_io_out_T_3"} : !hw.inout<i32>
    sv.assign %_io_out_T_3, %19 : i32
    %20 = sv.read_inout %_io_out_T_3 : !hw.inout<i32>
    %21 = comb.mux bin %14, %20, %c0_i32 : i32
    %22 = sv.read_inout %_io_out_T_1 : !hw.inout<i32>
    %23 = comb.mux bin %4, %22, %21 : i32
    %24 = hw.struct_create (%io_a, %io_b, %io_fn, %23) : !hw.struct<a: i32, b: i32, fn: i5, out: i32>
    sv.assign %io, %24 : !hw.struct<a: i32, b: i32, fn: i5, out: i32>
    hw.output %out : i32
  }
  hw.module private @instrMem_1024x32(in %R0_addr : i10, in %R0_en : i1, in %R0_clk : i1, out R0_data : i32, in %W0_addr : i10, in %W0_en : i1, in %W0_clk : i1, in %W0_data : i32) attributes {comment = "VCS coverage exclude_file"} {
    %Memory = sv.reg {hw.verilogName = "Memory"} : !hw.inout<uarray<1024xi32>> 
    %_R0_en_d0 = sv.reg sym @_R0_en_d0 {hw.verilogName = "_R0_en_d0"} : !hw.inout<i1> 
    %_R0_addr_d0 = sv.reg sym @_R0_addr_d0 {hw.verilogName = "_R0_addr_d0"} : !hw.inout<i10> 
    sv.always posedge %R0_clk {
      sv.passign %_R0_en_d0, %R0_en : i1
      sv.passign %_R0_addr_d0, %R0_addr : i10
    }
    %x_i32 = sv.constantX : i32
    %0 = sv.read_inout %_R0_en_d0 : !hw.inout<i1>
    %1 = sv.read_inout %_R0_addr_d0 : !hw.inout<i10>
    %2 = sv.array_index_inout %Memory[%1] : !hw.inout<uarray<1024xi32>>, i10
    %3 = sv.read_inout %2 : !hw.inout<i32>
    %4 = comb.mux %0, %3, %x_i32 : i32
    sv.always posedge %W0_clk {
      %true = hw.constant true
      %5 = comb.and %W0_en, %true : i1
      sv.if %5 {
        %6 = sv.array_index_inout %Memory[%W0_addr] : !hw.inout<uarray<1024xi32>>, i10
        sv.passign %6, %W0_data : i32
      }
    }
    sv.ifdef  @ENABLE_INITIAL_MEM_ {
      sv.ifdef  @RANDOMIZE_REG_INIT {
        %_RANDOM = sv.reg sym @_RANDOM {hw.verilogName = "_RANDOM"} : !hw.inout<i32> 
      }
      %_RANDOM_MEM = sv.reg {hw.verilogName = "_RANDOM_MEM"} : !hw.inout<i32> 
      sv.initial {
        sv.verbatim "`INIT_RANDOM_PROLOG_"
        sv.ifdef.procedural  @RANDOMIZE_MEM_INIT {
          %c1_i11 = hw.constant 1 : i11
          %c-1024_i11 = hw.constant -1024 : i11
          %c0_i11 = hw.constant 0 : i11
          sv.for %i = %c0_i11 to %c-1024_i11 step %c1_i11 : i11 {
            %RANDOM = sv.macro.ref.expr.se @RANDOM() : () -> i32
            sv.bpassign %_RANDOM_MEM, %RANDOM : i32
            %5 = comb.extract %i from 0 : (i11) -> i10
            %6 = sv.read_inout %_RANDOM_MEM : !hw.inout<i32>
            %7 = sv.array_index_inout %Memory[%5] : !hw.inout<uarray<1024xi32>>, i10
            sv.bpassign %7, %6 : i32
          } {hw.verilogName = "i"}
        }
        sv.ifdef.procedural  @RANDOMIZE_REG_INIT {
          sv.verbatim "{{0}} = {`RANDOM};" {symbols = [#hw.innerNameRef<@instrMem_1024x32::@_RANDOM>]}
          sv.verbatim "{{0}} = {{1}}[0];" {symbols = [#hw.innerNameRef<@instrMem_1024x32::@_R0_en_d0>, #hw.innerNameRef<@instrMem_1024x32::@_RANDOM>]}
          sv.verbatim "{{0}} = {{1}}[10:1];" {symbols = [#hw.innerNameRef<@instrMem_1024x32::@_R0_addr_d0>, #hw.innerNameRef<@instrMem_1024x32::@_RANDOM>]}
        }
      }
    }
    hw.output %4 : i32
  }
  hw.module @TetraNyteCore(in %clock : i1, in %reset : i1, out io_memAddr : i32, out io_memWdata : i32, in %io_memRdata : i32, out io_memWe : i1, in %io_instrWriteEnable : i1, in %io_instrWriteAddr : i10, in %io_instrWriteData : i32, in %io_debug : i1) attributes {emit.fragments = [@RANDOM_INIT_REG_FRAGMENT, @RANDOM_INIT_MEM_FRAGMENT, @RANDOM_INIT_FRAGMENT]} {
    %_alu_io_out = sv.wire {hw.verilogName = "_alu_io_out"} : !hw.inout<i32>
    %_regFile_io_src1data = sv.wire {hw.verilogName = "_regFile_io_src1data"} : !hw.inout<i32>
    %_regFile_io_src2data = sv.wire {hw.verilogName = "_regFile_io_src2data"} : !hw.inout<i32>
    %_instrMem_ext_R0_data = sv.wire {hw.verilogName = "_instrMem_ext_R0_data"} : !hw.inout<i32>
    %true = hw.constant true
    %c35_i7 = hw.constant 35 : i7
    %c3_i7 = hw.constant 3 : i7
    %c51_i7 = hw.constant 51 : i7
    %c4_i33 = hw.constant 4 : i33
    %c1_i3 = hw.constant 1 : i3
    %false = hw.constant false
    %c0_i5 = hw.constant 0 : i5
    %c0_i32 = hw.constant 0 : i32
    %0 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<4xi32>
    %_pcRegs_WIRE = sv.wire sym @sym_3 {hw.verilogName = "_pcRegs_WIRE"} : !hw.inout<array<4xi32>>
    sv.assign %_pcRegs_WIRE, %0 : !hw.array<4xi32>
    %1 = hw.aggregate_constant [0 : i2, false, 0 : i32, 0 : i32, false, false, false, false, false, false, false, false, false, false, 0 : i5, 0 : i32, 0 : i5, 0 : i5, 0 : i5, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %2 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %2, %1 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_ifStage_WIRE = sv.wire sym @sym_5 {hw.verilogName = "_ifStage_WIRE"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %3 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_ifStage_WIRE, %3 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_ifStage_WIRE_1 = sv.wire sym @sym_6 {hw.verilogName = "_ifStage_WIRE_1"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %4 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_ifStage_WIRE_1, %4 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_ifStage_WIRE_2 = sv.wire sym @sym_7 {hw.verilogName = "_ifStage_WIRE_2"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %5 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_ifStage_WIRE_2, %5 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_ifStage_WIRE_3 = sv.wire sym @sym_8 {hw.verilogName = "_ifStage_WIRE_3"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %6 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_ifStage_WIRE_3, %6 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_decStage_WIRE = sv.wire sym @sym_11 {hw.verilogName = "_decStage_WIRE"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %7 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_decStage_WIRE, %7 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_decStage_WIRE_1 = sv.wire sym @sym_12 {hw.verilogName = "_decStage_WIRE_1"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %8 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_decStage_WIRE_1, %8 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_decStage_WIRE_2 = sv.wire sym @sym_13 {hw.verilogName = "_decStage_WIRE_2"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %9 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_decStage_WIRE_2, %9 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_decStage_WIRE_3 = sv.wire sym @sym_14 {hw.verilogName = "_decStage_WIRE_3"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %10 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_decStage_WIRE_3, %10 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_exStage_WIRE = sv.wire sym @sym_17 {hw.verilogName = "_exStage_WIRE"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %11 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_exStage_WIRE, %11 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_exStage_WIRE_1 = sv.wire sym @sym_18 {hw.verilogName = "_exStage_WIRE_1"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %12 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_exStage_WIRE_1, %12 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_exStage_WIRE_2 = sv.wire sym @sym_19 {hw.verilogName = "_exStage_WIRE_2"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %13 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_exStage_WIRE_2, %13 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_exStage_WIRE_3 = sv.wire sym @sym_20 {hw.verilogName = "_exStage_WIRE_3"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %14 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_exStage_WIRE_3, %14 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_memStage_WIRE = sv.wire sym @sym_23 {hw.verilogName = "_memStage_WIRE"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %15 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_memStage_WIRE, %15 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_memStage_WIRE_1 = sv.wire sym @sym_24 {hw.verilogName = "_memStage_WIRE_1"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %16 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_memStage_WIRE_1, %16 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_memStage_WIRE_2 = sv.wire sym @sym_25 {hw.verilogName = "_memStage_WIRE_2"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %17 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_memStage_WIRE_2, %17 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_memStage_WIRE_3 = sv.wire sym @sym_26 {hw.verilogName = "_memStage_WIRE_3"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %18 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_memStage_WIRE_3, %18 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_ifWire_WIRE = sv.wire sym @sym_29 {hw.verilogName = "_ifWire_WIRE"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %19 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_ifWire_WIRE, %19 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_decWire_WIRE = sv.wire sym @sym_36 {hw.verilogName = "_decWire_WIRE"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %20 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_decWire_WIRE, %20 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_exWire_WIRE = sv.wire sym @sym_42 {hw.verilogName = "_exWire_WIRE"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %21 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_exWire_WIRE, %21 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_memWire_WIRE = sv.wire sym @sym_46 {hw.verilogName = "_memWire_WIRE"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %22 = sv.read_inout %2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %_memWire_WIRE, %22 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %io = sv.wire sym @sym {hw.verilogName = "io"} : !hw.inout<struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>>
    %23 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>>
    %memAddr = hw.struct_extract %23["memAddr"] : !hw.struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>
    %24 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>>
    %memWdata = hw.struct_extract %24["memWdata"] : !hw.struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>
    %25 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>>
    %memRdata = hw.struct_extract %25["memRdata"] : !hw.struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>
    %26 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>>
    %memWe = hw.struct_extract %26["memWe"] : !hw.struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>
    %27 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>>
    %instrWriteEnable = hw.struct_extract %27["instrWriteEnable"] : !hw.struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>
    %28 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>>
    %instrWriteAddr = hw.struct_extract %28["instrWriteAddr"] : !hw.struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>
    %29 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>>
    %instrWriteData = hw.struct_extract %29["instrWriteData"] : !hw.struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>
    %currentThread = sv.reg sym @sym_0 {hw.verilogName = "currentThread"} : !hw.inout<i2> 
    %30 = sv.read_inout %currentThread : !hw.inout<i2>
    %31 = comb.concat %false, %30 : i1, i2
    %32 = comb.add bin %31, %c1_i3 : i3
    %_currentThread_T = sv.wire sym @sym_1 {hw.verilogName = "_currentThread_T"} : !hw.inout<i3>
    sv.assign %_currentThread_T, %32 : i3
    %33 = sv.read_inout %_currentThread_T : !hw.inout<i3>
    %34 = comb.extract %33 from 0 : (i3) -> i2
    %_currentThread_T_1 = sv.wire sym @sym_2 {hw.verilogName = "_currentThread_T_1"} : !hw.inout<i2>
    sv.assign %_currentThread_T_1, %34 : i2
    %pcRegs = sv.reg sym @sym_4 {hw.verilogName = "pcRegs"} : !hw.inout<array<4xi32>> 
    %ifStage = sv.reg sym @sym_10 {hw.verilogName = "ifStage"} : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>> 
    %decStage = sv.reg sym @sym_16 {hw.verilogName = "decStage"} : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>> 
    %exStage = sv.reg sym @sym_22 {hw.verilogName = "exStage"} : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>> 
    %memStage = sv.reg sym @sym_28 {hw.verilogName = "memStage"} : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>> 
    %35 = sv.read_inout %pcRegs : !hw.inout<array<4xi32>>
    %36 = sv.read_inout %currentThread : !hw.inout<i2>
    %37 = hw.array_get %35[%36] : !hw.array<4xi32>, i2
    %38 = sv.wire {hw.verilogName = "_GEN_0"} : !hw.inout<i32>
    sv.assign %38, %37 : i32
    %39 = sv.read_inout %38 : !hw.inout<i32>
    %40 = comb.extract %39 from 2 : (i32) -> i30
    %_ifWire_instr_T = sv.wire sym @sym_31 {hw.verilogName = "_ifWire_instr_T"} : !hw.inout<i30>
    sv.assign %_ifWire_instr_T, %40 : i30
    %41 = sv.read_inout %_ifWire_instr_T : !hw.inout<i30>
    %_ifWire_instr_WIRE = sv.wire sym @sym_32 {hw.verilogName = "_ifWire_instr_WIRE"} : !hw.inout<i30>
    sv.assign %_ifWire_instr_WIRE, %41 : i30
    %42 = sv.read_inout %_ifWire_instr_WIRE : !hw.inout<i30>
    %43 = comb.extract %42 from 0 : (i30) -> i10
    %_ifWire_instr_T_1 = sv.wire sym @sym_33 {hw.verilogName = "_ifWire_instr_T_1"} : !hw.inout<i10>
    sv.assign %_ifWire_instr_T_1, %43 : i10
    %44 = sv.read_inout %currentThread : !hw.inout<i2>
    %45 = sv.read_inout %38 : !hw.inout<i32>
    %46 = sv.read_inout %_instrMem_ext_R0_data : !hw.inout<i32>
    %47 = hw.struct_create (%44, %true, %45, %46, %false, %false, %false, %false, %false, %false, %false, %false, %false, %false, %c0_i5, %c0_i32, %c0_i5, %c0_i5, %c0_i5, %c0_i32, %c0_i32, %c0_i32, %c0_i32, %c0_i32, %c0_i32) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %ifWire = sv.wire sym @sym_30 {hw.verilogName = "ifWire"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %ifWire, %47 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %48 = sv.read_inout %38 : !hw.inout<i32>
    %49 = comb.concat %false, %48 : i1, i32
    %50 = comb.add bin %49, %c4_i33 : i33
    %_pcRegs_T = sv.wire sym @sym_34 {hw.verilogName = "_pcRegs_T"} : !hw.inout<i33>
    sv.assign %_pcRegs_T, %50 : i33
    %51 = sv.read_inout %_pcRegs_T : !hw.inout<i33>
    %52 = comb.extract %51 from 0 : (i33) -> i32
    %_pcRegs_T_1 = sv.wire sym @sym_35 {hw.verilogName = "_pcRegs_T_1"} : !hw.inout<i32>
    sv.assign %_pcRegs_T_1, %52 : i32
    %53 = sv.read_inout %decStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
    %54 = sv.read_inout %currentThread : !hw.inout<i2>
    %55 = hw.array_get %53[%54] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
    %56 = sv.wire {hw.verilogName = "_GEN_1"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %56, %55 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %decWire = sv.wire sym @sym_37 {hw.verilogName = "decWire"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %57 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs2 = hw.struct_extract %57["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %58 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs1 = hw.struct_extract %58["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %59 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %instr = hw.struct_extract %59["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %60 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %threadId = hw.struct_extract %60["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %61 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %valid = hw.struct_extract %61["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %62 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %pc = hw.struct_extract %62["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %63 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %instr_0 = hw.struct_extract %63["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %64 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isALU = hw.struct_extract %64["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %65 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isLoad = hw.struct_extract %65["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %66 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isStore = hw.struct_extract %66["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %67 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isBranch = hw.struct_extract %67["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %68 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isJAL = hw.struct_extract %68["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %69 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isJALR = hw.struct_extract %69["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %70 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isLUI = hw.struct_extract %70["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %71 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isAUIPC = hw.struct_extract %71["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %72 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isFence = hw.struct_extract %72["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %73 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isSystem = hw.struct_extract %73["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %74 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %aluOp = hw.struct_extract %74["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %75 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %imm = hw.struct_extract %75["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %76 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memAddr_1 = hw.struct_extract %76["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %77 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memWdata_2 = hw.struct_extract %77["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %78 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memRdata_3 = hw.struct_extract %78["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %79 = sv.read_inout %56 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %aluResult = hw.struct_extract %79["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %80 = comb.extract %instr from 0 : (i32) -> i7
    %opcode = sv.wire sym @sym_38 {hw.verilogName = "opcode"} : !hw.inout<i7>
    sv.assign %opcode, %80 : i7
    %81 = sv.read_inout %opcode : !hw.inout<i7>
    %82 = comb.icmp bin eq %81, %c51_i7 : i7
    %_T = sv.wire {hw.verilogName = "_T"} : !hw.inout<i1>
    sv.assign %_T, %82 : i1
    %83 = sv.read_inout %_T : !hw.inout<i1>
    %84 = comb.or %83, %isALU : i1
    %85 = sv.read_inout %opcode : !hw.inout<i7>
    %86 = comb.icmp bin eq %85, %c3_i7 : i7
    %_T_1 = sv.wire {hw.verilogName = "_T_1"} : !hw.inout<i1>
    sv.assign %_T_1, %86 : i1
    %87 = sv.read_inout %_T : !hw.inout<i1>
    %88 = comb.xor %87, %true : i1
    %89 = sv.read_inout %_T_1 : !hw.inout<i1>
    %90 = comb.and %88, %89 : i1
    %91 = comb.or %90, %isLoad : i1
    %92 = sv.read_inout %opcode : !hw.inout<i7>
    %93 = comb.icmp bin eq %92, %c35_i7 {sv.namehint = "_T_2"} : i7
    %94 = sv.read_inout %_T : !hw.inout<i1>
    %95 = sv.read_inout %_T_1 : !hw.inout<i1>
    %96 = comb.or bin %94, %95 : i1
    %97 = comb.xor %96, %true : i1
    %98 = comb.and %97, %93 : i1
    %99 = comb.or %98, %isStore : i1
    %100 = comb.extract %instr from 15 : (i32) -> i5
    %_decWire_rs1_T = sv.wire sym @sym_39 {hw.verilogName = "_decWire_rs1_T"} : !hw.inout<i5>
    sv.assign %_decWire_rs1_T, %100 : i5
    %101 = comb.extract %instr from 20 : (i32) -> i5
    %_decWire_rs2_T = sv.wire sym @sym_40 {hw.verilogName = "_decWire_rs2_T"} : !hw.inout<i5>
    sv.assign %_decWire_rs2_T, %101 : i5
    %102 = comb.extract %instr from 7 : (i32) -> i5
    %_decWire_rd_T = sv.wire sym @sym_41 {hw.verilogName = "_decWire_rd_T"} : !hw.inout<i5>
    sv.assign %_decWire_rd_T, %102 : i5
    %103 = sv.read_inout %_decWire_rs1_T : !hw.inout<i5>
    %104 = sv.read_inout %_decWire_rs2_T : !hw.inout<i5>
    %105 = sv.read_inout %_decWire_rd_T : !hw.inout<i5>
    %106 = sv.read_inout %_regFile_io_src1data : !hw.inout<i32>
    %107 = sv.read_inout %_regFile_io_src2data : !hw.inout<i32>
    %108 = hw.struct_create (%threadId, %valid, %pc, %instr_0, %84, %91, %99, %isBranch, %isJAL, %isJALR, %isLUI, %isAUIPC, %isFence, %isSystem, %aluOp, %imm, %103, %104, %105, %106, %107, %memAddr_1, %memWdata_2, %memRdata_3, %aluResult) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    sv.assign %decWire, %108 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %109 = sv.read_inout %exStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
    %110 = sv.read_inout %currentThread : !hw.inout<i2>
    %111 = hw.array_get %109[%110] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
    %112 = sv.wire {hw.verilogName = "_GEN_2"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %112, %111 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %exWire = sv.wire sym @sym_43 {hw.verilogName = "exWire"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %113 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %imm_4 = hw.struct_extract %113["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %114 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isStore_5 = hw.struct_extract %114["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %115 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isLoad_6 = hw.struct_extract %115["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %116 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %aluOp_7 = hw.struct_extract %116["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %117 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs2Data = hw.struct_extract %117["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %118 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs1Data = hw.struct_extract %118["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %119 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %threadId_8 = hw.struct_extract %119["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %120 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %valid_9 = hw.struct_extract %120["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %121 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %pc_10 = hw.struct_extract %121["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %122 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %instr_11 = hw.struct_extract %122["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %123 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isALU_12 = hw.struct_extract %123["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %124 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isLoad_13 = hw.struct_extract %124["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %125 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isStore_14 = hw.struct_extract %125["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %126 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isBranch_15 = hw.struct_extract %126["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %127 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isJAL_16 = hw.struct_extract %127["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %128 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isJALR_17 = hw.struct_extract %128["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %129 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isLUI_18 = hw.struct_extract %129["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %130 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isAUIPC_19 = hw.struct_extract %130["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %131 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isFence_20 = hw.struct_extract %131["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %132 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isSystem_21 = hw.struct_extract %132["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %133 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %aluOp_22 = hw.struct_extract %133["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %134 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %imm_23 = hw.struct_extract %134["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %135 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs1_24 = hw.struct_extract %135["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %136 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs2_25 = hw.struct_extract %136["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %137 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rd = hw.struct_extract %137["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %138 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs1Data_26 = hw.struct_extract %138["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %139 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs2Data_27 = hw.struct_extract %139["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %140 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memAddr_28 = hw.struct_extract %140["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %141 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memWdata_29 = hw.struct_extract %141["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %142 = sv.read_inout %112 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memRdata_30 = hw.struct_extract %142["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %143 = comb.or bin %isLoad_6, %isStore_5 : i1
    %_T_3 = sv.wire {hw.verilogName = "_T_3"} : !hw.inout<i1>
    sv.assign %_T_3, %143 : i1
    %144 = comb.concat %false, %rs1Data : i1, i32
    %145 = comb.concat %false, %imm_4 : i1, i32
    %146 = comb.add bin %144, %145 : i33
    %_exWire_memAddr_T = sv.wire sym @sym_44 {hw.verilogName = "_exWire_memAddr_T"} : !hw.inout<i33>
    sv.assign %_exWire_memAddr_T, %146 : i33
    %147 = sv.read_inout %_exWire_memAddr_T : !hw.inout<i33>
    %148 = comb.extract %147 from 0 : (i33) -> i32
    %_exWire_memAddr_T_1 = sv.wire sym @sym_45 {hw.verilogName = "_exWire_memAddr_T_1"} : !hw.inout<i32>
    sv.assign %_exWire_memAddr_T_1, %148 : i32
    %149 = sv.read_inout %_exWire_memAddr_T_1 : !hw.inout<i32>
    %150 = sv.read_inout %_T_3 : !hw.inout<i1>
    %151 = comb.mux bin %150, %149, %memAddr_28 : i32
    %152 = sv.read_inout %_T_3 : !hw.inout<i1>
    %153 = comb.mux bin %152, %rs2Data, %memWdata_29 : i32
    %154 = sv.read_inout %_alu_io_out : !hw.inout<i32>
    %155 = hw.struct_create (%threadId_8, %valid_9, %pc_10, %instr_11, %isALU_12, %isLoad_13, %isStore_14, %isBranch_15, %isJAL_16, %isJALR_17, %isLUI_18, %isAUIPC_19, %isFence_20, %isSystem_21, %aluOp_22, %imm_23, %rs1_24, %rs2_25, %rd, %rs1Data_26, %rs2Data_27, %151, %153, %memRdata_30, %154) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    sv.assign %exWire, %155 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %156 = sv.read_inout %currentThread : !hw.inout<i2>
    %157 = sv.read_inout %memStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
    %158 = hw.array_get %157[%156] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
    %159 = sv.wire {hw.verilogName = "_GEN_3"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    sv.assign %159, %158 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %memWire = sv.wire sym @sym_47 {hw.verilogName = "memWire"} : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %160 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isALU_31 = hw.struct_extract %160["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %161 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rd_32 = hw.struct_extract %161["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %162 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %aluResult_33 = hw.struct_extract %162["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %163 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isLoad_34 = hw.struct_extract %163["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %164 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memRdata_35 = hw.struct_extract %164["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %165 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %valid_36 = hw.struct_extract %165["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %166 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isStore_37 = hw.struct_extract %166["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %167 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memWdata_38 = hw.struct_extract %167["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %168 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memAddr_39 = hw.struct_extract %168["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %169 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %threadId_40 = hw.struct_extract %169["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %170 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %valid_41 = hw.struct_extract %170["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %171 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %pc_42 = hw.struct_extract %171["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %172 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %instr_43 = hw.struct_extract %172["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %173 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isALU_44 = hw.struct_extract %173["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %174 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isLoad_45 = hw.struct_extract %174["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %175 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isStore_46 = hw.struct_extract %175["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %176 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isBranch_47 = hw.struct_extract %176["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %177 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isJAL_48 = hw.struct_extract %177["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %178 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isJALR_49 = hw.struct_extract %178["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %179 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isLUI_50 = hw.struct_extract %179["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %180 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isAUIPC_51 = hw.struct_extract %180["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %181 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isFence_52 = hw.struct_extract %181["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %182 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %isSystem_53 = hw.struct_extract %182["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %183 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %aluOp_54 = hw.struct_extract %183["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %184 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %imm_55 = hw.struct_extract %184["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %185 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs1_56 = hw.struct_extract %185["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %186 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs2_57 = hw.struct_extract %186["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %187 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rd_58 = hw.struct_extract %187["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %188 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs1Data_59 = hw.struct_extract %188["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %189 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %rs2Data_60 = hw.struct_extract %189["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %190 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memAddr_61 = hw.struct_extract %190["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %191 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %memWdata_62 = hw.struct_extract %191["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %192 = sv.read_inout %159 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %aluResult_63 = hw.struct_extract %192["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %193 = comb.and bin %isStore_37, %valid_36 : i1
    %_io_memWe_T = sv.wire sym @sym_48 {hw.verilogName = "_io_memWe_T"} : !hw.inout<i1>
    sv.assign %_io_memWe_T, %193 : i1
    %194 = hw.struct_create (%threadId_40, %valid_41, %pc_42, %instr_43, %isALU_44, %isLoad_45, %isStore_46, %isBranch_47, %isJAL_48, %isJALR_49, %isLUI_50, %isAUIPC_51, %isFence_52, %isSystem_53, %aluOp_54, %imm_55, %rs1_56, %rs2_57, %rd_58, %rs1Data_59, %rs2Data_60, %memAddr_61, %memWdata_62, %memRdata, %aluResult_63) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    sv.assign %memWire, %194 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %195 = comb.mux bin %isLoad_34, %memRdata_35, %aluResult_33 : i32
    %wbData = sv.wire sym @sym_49 {hw.verilogName = "wbData"} : !hw.inout<i32>
    sv.assign %wbData, %195 : i32
    %196 = comb.icmp bin ne %rd_32, %c0_i5 : i5
    %_regFile_io_wen_T = sv.wire sym @sym_50 {hw.verilogName = "_regFile_io_wen_T"} : !hw.inout<i1>
    sv.assign %_regFile_io_wen_T, %196 : i1
    %197 = sv.read_inout %_regFile_io_wen_T : !hw.inout<i1>
    %198 = comb.and bin %valid_36, %197 : i1
    %_regFile_io_wen_T_1 = sv.wire sym @sym_51 {hw.verilogName = "_regFile_io_wen_T_1"} : !hw.inout<i1>
    sv.assign %_regFile_io_wen_T_1, %198 : i1
    %199 = comb.or bin %isLoad_34, %isALU_31 : i1
    %_regFile_io_wen_T_2 = sv.wire sym @sym_52 {hw.verilogName = "_regFile_io_wen_T_2"} : !hw.inout<i1>
    sv.assign %_regFile_io_wen_T_2, %199 : i1
    %200 = sv.read_inout %_regFile_io_wen_T_1 : !hw.inout<i1>
    %201 = sv.read_inout %_regFile_io_wen_T_2 : !hw.inout<i1>
    %202 = comb.and bin %200, %201 : i1
    %_regFile_io_wen_T_3 = sv.wire sym @sym_53 {hw.verilogName = "_regFile_io_wen_T_3"} : !hw.inout<i1>
    sv.assign %_regFile_io_wen_T_3, %202 : i1
    %203 = sv.read_inout %_ifStage_WIRE : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %204 = sv.read_inout %_ifStage_WIRE_1 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %205 = sv.read_inout %_ifStage_WIRE_2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %206 = sv.read_inout %_ifStage_WIRE_3 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %207 = hw.array_create %206, %205, %204, %203 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_ifStage_WIRE_4 = sv.wire sym @sym_9 {hw.verilogName = "_ifStage_WIRE_4"} : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
    sv.assign %_ifStage_WIRE_4, %207 : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %208 = sv.read_inout %_decStage_WIRE : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %209 = sv.read_inout %_decStage_WIRE_1 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %210 = sv.read_inout %_decStage_WIRE_2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %211 = sv.read_inout %_decStage_WIRE_3 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %212 = hw.array_create %211, %210, %209, %208 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_decStage_WIRE_4 = sv.wire sym @sym_15 {hw.verilogName = "_decStage_WIRE_4"} : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
    sv.assign %_decStage_WIRE_4, %212 : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %213 = sv.read_inout %_exStage_WIRE : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %214 = sv.read_inout %_exStage_WIRE_1 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %215 = sv.read_inout %_exStage_WIRE_2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %216 = sv.read_inout %_exStage_WIRE_3 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %217 = hw.array_create %216, %215, %214, %213 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_exStage_WIRE_4 = sv.wire sym @sym_21 {hw.verilogName = "_exStage_WIRE_4"} : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
    sv.assign %_exStage_WIRE_4, %217 : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %218 = sv.read_inout %_memStage_WIRE : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %219 = sv.read_inout %_memStage_WIRE_1 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %220 = sv.read_inout %_memStage_WIRE_2 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %221 = sv.read_inout %_memStage_WIRE_3 : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %222 = hw.array_create %221, %220, %219, %218 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
    %_memStage_WIRE_4 = sv.wire sym @sym_27 {hw.verilogName = "_memStage_WIRE_4"} : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
    sv.assign %_memStage_WIRE_4, %222 : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
    %223 = sv.read_inout %_io_memWe_T : !hw.inout<i1>
    %224 = hw.struct_create (%memAddr_39, %memWdata_38, %io_memRdata, %223, %io_instrWriteEnable, %io_instrWriteAddr, %io_instrWriteData, %io_debug) : !hw.struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>
    sv.assign %io, %224 : !hw.struct<memAddr: i32, memWdata: i32, memRdata: i32, memWe: i1, instrWriteEnable: i1, instrWriteAddr: i10, instrWriteData: i32, debug: i1>
    sv.always posedge %clock {
      sv.if %reset {
        %c0_i2 = hw.constant 0 : i2
        sv.passign %currentThread, %c0_i2 : i2
        %229 = sv.read_inout %_pcRegs_WIRE : !hw.inout<array<4xi32>>
        sv.passign %pcRegs, %229 : !hw.array<4xi32>
        %230 = sv.read_inout %_ifStage_WIRE_4 : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        sv.passign %ifStage, %230 : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %231 = sv.read_inout %_decStage_WIRE_4 : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        sv.passign %decStage, %231 : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %232 = sv.read_inout %_exStage_WIRE_4 : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        sv.passign %exStage, %232 : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %233 = sv.read_inout %_memStage_WIRE_4 : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        sv.passign %memStage, %233 : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
      } else {
        %229 = sv.logic {hw.verilogName = "_GEN_4"} : !hw.inout<i1>
        %230 = sv.logic {hw.verilogName = "_GEN_5"} : !hw.inout<i1>
        %231 = sv.logic {hw.verilogName = "_GEN_6"} : !hw.inout<i1>
        %c0_i2 = hw.constant 0 : i2
        %c1_i2 = hw.constant 1 : i2
        %c-2_i2 = hw.constant -2 : i2
        %c-1_i2 = hw.constant -1 : i2
        %c0_i5_64 = hw.constant 0 : i5
        %c0_i32_65 = hw.constant 0 : i32
        %232 = sv.read_inout %ifStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %233 = hw.array_get %232[%c0_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %234 = sv.read_inout %ifStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %235 = hw.array_get %234[%c1_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %236 = sv.read_inout %ifStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %237 = hw.array_get %236[%c-2_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %238 = sv.read_inout %ifStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %239 = hw.array_get %238[%c-1_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %240 = sv.read_inout %decStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %241 = hw.array_get %240[%c0_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %242 = sv.read_inout %decStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %243 = hw.array_get %242[%c1_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %244 = sv.read_inout %decStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %245 = hw.array_get %244[%c-2_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %246 = sv.read_inout %decStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %247 = hw.array_get %246[%c-1_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %248 = sv.read_inout %exStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %249 = hw.array_get %248[%c0_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %250 = sv.read_inout %exStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %251 = hw.array_get %250[%c1_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %252 = sv.read_inout %exStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %253 = hw.array_get %252[%c-2_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %254 = sv.read_inout %exStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %255 = hw.array_get %254[%c-1_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %256 = sv.read_inout %memStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %257 = hw.array_get %256[%c0_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %258 = sv.read_inout %memStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %259 = hw.array_get %258[%c1_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %260 = sv.read_inout %memStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %261 = hw.array_get %260[%c-2_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %262 = sv.read_inout %memStage : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>
        %263 = hw.array_get %262[%c-1_i2] : !hw.array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>, i2
        %264 = sv.read_inout %currentThread : !hw.inout<i2>
        %265 = comb.icmp bin eq %264, %c0_i2 : i2
        sv.bpassign %229, %265 : i1
        %266 = sv.read_inout %currentThread : !hw.inout<i2>
        %267 = comb.icmp bin eq %266, %c1_i2 : i2
        sv.bpassign %230, %267 : i1
        %268 = sv.read_inout %currentThread : !hw.inout<i2>
        %269 = comb.icmp bin eq %268, %c-2_i2 : i2
        sv.bpassign %231, %269 : i1
        %270 = sv.read_inout %ifWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %threadId_66 = hw.struct_extract %270["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %271 = sv.read_inout %ifWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %pc_67 = hw.struct_extract %271["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %272 = sv.read_inout %ifWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %instr_68 = hw.struct_extract %272["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %273 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %threadId_69 = hw.struct_extract %273["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %274 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %valid_70 = hw.struct_extract %274["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %275 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %pc_71 = hw.struct_extract %275["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %276 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isALU_72 = hw.struct_extract %276["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %277 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isLoad_73 = hw.struct_extract %277["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %278 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isStore_74 = hw.struct_extract %278["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %279 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isBranch_75 = hw.struct_extract %279["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %280 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isJAL_76 = hw.struct_extract %280["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %281 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isJALR_77 = hw.struct_extract %281["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %282 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isLUI_78 = hw.struct_extract %282["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %283 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isAUIPC_79 = hw.struct_extract %283["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %284 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isFence_80 = hw.struct_extract %284["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %285 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isSystem_81 = hw.struct_extract %285["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %286 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %aluOp_82 = hw.struct_extract %286["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %287 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %imm_83 = hw.struct_extract %287["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %288 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rd_84 = hw.struct_extract %288["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %289 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rs1Data_85 = hw.struct_extract %289["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %290 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rs2Data_86 = hw.struct_extract %290["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %291 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %memAddr_87 = hw.struct_extract %291["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %292 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %memWdata_88 = hw.struct_extract %292["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %293 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %memRdata_89 = hw.struct_extract %293["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %294 = sv.read_inout %decWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %aluResult_90 = hw.struct_extract %294["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %295 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %threadId_91 = hw.struct_extract %295["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %296 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %valid_92 = hw.struct_extract %296["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %297 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %pc_93 = hw.struct_extract %297["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %298 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %instr_94 = hw.struct_extract %298["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %299 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isALU_95 = hw.struct_extract %299["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %300 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isBranch_96 = hw.struct_extract %300["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %301 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isJAL_97 = hw.struct_extract %301["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %302 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isJALR_98 = hw.struct_extract %302["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %303 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isLUI_99 = hw.struct_extract %303["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %304 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isAUIPC_100 = hw.struct_extract %304["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %305 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isFence_101 = hw.struct_extract %305["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %306 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isSystem_102 = hw.struct_extract %306["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %307 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rs1_103 = hw.struct_extract %307["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %308 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rs2_104 = hw.struct_extract %308["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %309 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rd_105 = hw.struct_extract %309["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %310 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %memAddr_106 = hw.struct_extract %310["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %311 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %memWdata_107 = hw.struct_extract %311["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %312 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %memRdata_108 = hw.struct_extract %312["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %313 = sv.read_inout %exWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %aluResult_109 = hw.struct_extract %313["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %314 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %threadId_110 = hw.struct_extract %314["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %315 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %pc_111 = hw.struct_extract %315["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %316 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %instr_112 = hw.struct_extract %316["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %317 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isBranch_113 = hw.struct_extract %317["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %318 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isJAL_114 = hw.struct_extract %318["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %319 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isJALR_115 = hw.struct_extract %319["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %320 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isLUI_116 = hw.struct_extract %320["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %321 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isAUIPC_117 = hw.struct_extract %321["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %322 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isFence_118 = hw.struct_extract %322["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %323 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %isSystem_119 = hw.struct_extract %323["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %324 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %aluOp_120 = hw.struct_extract %324["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %325 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %imm_121 = hw.struct_extract %325["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %326 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rs1_122 = hw.struct_extract %326["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %327 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rs2_123 = hw.struct_extract %327["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %328 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rs1Data_124 = hw.struct_extract %328["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %329 = sv.read_inout %memWire : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
        %rs2Data_125 = hw.struct_extract %329["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %330 = sv.read_inout %_currentThread_T_1 : !hw.inout<i2>
        sv.passign %currentThread, %330 : i2
        %331 = sv.read_inout %currentThread : !hw.inout<i2>
        %332 = sv.array_index_inout %pcRegs[%331] : !hw.inout<array<4xi32>>, i2
        %333 = sv.read_inout %_pcRegs_T_1 : !hw.inout<i32>
        sv.passign %332, %333 : i32
        %aluResult_126 = hw.struct_extract %233["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %334 = sv.read_inout %229 : !hw.inout<i1>
        %335 = comb.mux bin %334, %c0_i32_65, %aluResult_126 : i32
        %memRdata_127 = hw.struct_extract %233["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %336 = sv.read_inout %229 : !hw.inout<i1>
        %337 = comb.mux bin %336, %c0_i32_65, %memRdata_127 : i32
        %memWdata_128 = hw.struct_extract %233["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %338 = sv.read_inout %229 : !hw.inout<i1>
        %339 = comb.mux bin %338, %c0_i32_65, %memWdata_128 : i32
        %memAddr_129 = hw.struct_extract %233["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %340 = sv.read_inout %229 : !hw.inout<i1>
        %341 = comb.mux bin %340, %c0_i32_65, %memAddr_129 : i32
        %rs2Data_130 = hw.struct_extract %233["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %342 = sv.read_inout %229 : !hw.inout<i1>
        %343 = comb.mux bin %342, %c0_i32_65, %rs2Data_130 : i32
        %rs1Data_131 = hw.struct_extract %233["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %344 = sv.read_inout %229 : !hw.inout<i1>
        %345 = comb.mux bin %344, %c0_i32_65, %rs1Data_131 : i32
        %rd_132 = hw.struct_extract %233["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %346 = sv.read_inout %229 : !hw.inout<i1>
        %347 = comb.mux bin %346, %c0_i5_64, %rd_132 : i5
        %rs2_133 = hw.struct_extract %233["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %348 = sv.read_inout %229 : !hw.inout<i1>
        %349 = comb.mux bin %348, %c0_i5_64, %rs2_133 : i5
        %rs1_134 = hw.struct_extract %233["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %350 = sv.read_inout %229 : !hw.inout<i1>
        %351 = comb.mux bin %350, %c0_i5_64, %rs1_134 : i5
        %imm_135 = hw.struct_extract %233["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %352 = sv.read_inout %229 : !hw.inout<i1>
        %353 = comb.mux bin %352, %c0_i32_65, %imm_135 : i32
        %aluOp_136 = hw.struct_extract %233["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %354 = sv.read_inout %229 : !hw.inout<i1>
        %355 = comb.mux bin %354, %c0_i5_64, %aluOp_136 : i5
        %true_137 = hw.constant true
        %356 = sv.read_inout %229 : !hw.inout<i1>
        %357 = comb.xor %356, %true_137 : i1
        %isSystem_138 = hw.struct_extract %233["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %358 = comb.and %357, %isSystem_138 : i1
        %true_139 = hw.constant true
        %359 = sv.read_inout %229 : !hw.inout<i1>
        %360 = comb.xor %359, %true_139 : i1
        %isFence_140 = hw.struct_extract %233["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %361 = comb.and %360, %isFence_140 : i1
        %true_141 = hw.constant true
        %362 = sv.read_inout %229 : !hw.inout<i1>
        %363 = comb.xor %362, %true_141 : i1
        %isAUIPC_142 = hw.struct_extract %233["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %364 = comb.and %363, %isAUIPC_142 : i1
        %true_143 = hw.constant true
        %365 = sv.read_inout %229 : !hw.inout<i1>
        %366 = comb.xor %365, %true_143 : i1
        %isLUI_144 = hw.struct_extract %233["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %367 = comb.and %366, %isLUI_144 : i1
        %true_145 = hw.constant true
        %368 = sv.read_inout %229 : !hw.inout<i1>
        %369 = comb.xor %368, %true_145 : i1
        %isJALR_146 = hw.struct_extract %233["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %370 = comb.and %369, %isJALR_146 : i1
        %true_147 = hw.constant true
        %371 = sv.read_inout %229 : !hw.inout<i1>
        %372 = comb.xor %371, %true_147 : i1
        %isJAL_148 = hw.struct_extract %233["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %373 = comb.and %372, %isJAL_148 : i1
        %true_149 = hw.constant true
        %374 = sv.read_inout %229 : !hw.inout<i1>
        %375 = comb.xor %374, %true_149 : i1
        %isBranch_150 = hw.struct_extract %233["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %376 = comb.and %375, %isBranch_150 : i1
        %true_151 = hw.constant true
        %377 = sv.read_inout %229 : !hw.inout<i1>
        %378 = comb.xor %377, %true_151 : i1
        %isStore_152 = hw.struct_extract %233["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %379 = comb.and %378, %isStore_152 : i1
        %true_153 = hw.constant true
        %380 = sv.read_inout %229 : !hw.inout<i1>
        %381 = comb.xor %380, %true_153 : i1
        %isLoad_154 = hw.struct_extract %233["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %382 = comb.and %381, %isLoad_154 : i1
        %true_155 = hw.constant true
        %383 = sv.read_inout %229 : !hw.inout<i1>
        %384 = comb.xor %383, %true_155 : i1
        %isALU_156 = hw.struct_extract %233["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %385 = comb.and %384, %isALU_156 : i1
        %instr_157 = hw.struct_extract %233["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %386 = sv.read_inout %229 : !hw.inout<i1>
        %387 = comb.mux bin %386, %instr_68, %instr_157 : i32
        %pc_158 = hw.struct_extract %233["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %388 = sv.read_inout %229 : !hw.inout<i1>
        %389 = comb.mux bin %388, %pc_67, %pc_158 : i32
        %valid_159 = hw.struct_extract %233["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %390 = sv.read_inout %229 : !hw.inout<i1>
        %391 = comb.or %390, %valid_159 : i1
        %threadId_160 = hw.struct_extract %233["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %392 = sv.read_inout %229 : !hw.inout<i1>
        %393 = comb.mux bin %392, %threadId_66, %threadId_160 : i2
        %394 = hw.struct_create (%393, %391, %389, %387, %385, %382, %379, %376, %373, %370, %367, %364, %361, %358, %355, %353, %351, %349, %347, %345, %343, %341, %339, %337, %335) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %395 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %395, %394 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_161 = hw.struct_extract %235["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %396 = sv.read_inout %230 : !hw.inout<i1>
        %397 = comb.mux bin %396, %c0_i32_65, %aluResult_161 : i32
        %memRdata_162 = hw.struct_extract %235["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %398 = sv.read_inout %230 : !hw.inout<i1>
        %399 = comb.mux bin %398, %c0_i32_65, %memRdata_162 : i32
        %memWdata_163 = hw.struct_extract %235["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %400 = sv.read_inout %230 : !hw.inout<i1>
        %401 = comb.mux bin %400, %c0_i32_65, %memWdata_163 : i32
        %memAddr_164 = hw.struct_extract %235["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %402 = sv.read_inout %230 : !hw.inout<i1>
        %403 = comb.mux bin %402, %c0_i32_65, %memAddr_164 : i32
        %rs2Data_165 = hw.struct_extract %235["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %404 = sv.read_inout %230 : !hw.inout<i1>
        %405 = comb.mux bin %404, %c0_i32_65, %rs2Data_165 : i32
        %rs1Data_166 = hw.struct_extract %235["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %406 = sv.read_inout %230 : !hw.inout<i1>
        %407 = comb.mux bin %406, %c0_i32_65, %rs1Data_166 : i32
        %rd_167 = hw.struct_extract %235["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %408 = sv.read_inout %230 : !hw.inout<i1>
        %409 = comb.mux bin %408, %c0_i5_64, %rd_167 : i5
        %rs2_168 = hw.struct_extract %235["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %410 = sv.read_inout %230 : !hw.inout<i1>
        %411 = comb.mux bin %410, %c0_i5_64, %rs2_168 : i5
        %rs1_169 = hw.struct_extract %235["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %412 = sv.read_inout %230 : !hw.inout<i1>
        %413 = comb.mux bin %412, %c0_i5_64, %rs1_169 : i5
        %imm_170 = hw.struct_extract %235["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %414 = sv.read_inout %230 : !hw.inout<i1>
        %415 = comb.mux bin %414, %c0_i32_65, %imm_170 : i32
        %aluOp_171 = hw.struct_extract %235["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %416 = sv.read_inout %230 : !hw.inout<i1>
        %417 = comb.mux bin %416, %c0_i5_64, %aluOp_171 : i5
        %true_172 = hw.constant true
        %418 = sv.read_inout %230 : !hw.inout<i1>
        %419 = comb.xor %418, %true_172 : i1
        %isSystem_173 = hw.struct_extract %235["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %420 = comb.and %419, %isSystem_173 : i1
        %true_174 = hw.constant true
        %421 = sv.read_inout %230 : !hw.inout<i1>
        %422 = comb.xor %421, %true_174 : i1
        %isFence_175 = hw.struct_extract %235["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %423 = comb.and %422, %isFence_175 : i1
        %true_176 = hw.constant true
        %424 = sv.read_inout %230 : !hw.inout<i1>
        %425 = comb.xor %424, %true_176 : i1
        %isAUIPC_177 = hw.struct_extract %235["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %426 = comb.and %425, %isAUIPC_177 : i1
        %true_178 = hw.constant true
        %427 = sv.read_inout %230 : !hw.inout<i1>
        %428 = comb.xor %427, %true_178 : i1
        %isLUI_179 = hw.struct_extract %235["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %429 = comb.and %428, %isLUI_179 : i1
        %true_180 = hw.constant true
        %430 = sv.read_inout %230 : !hw.inout<i1>
        %431 = comb.xor %430, %true_180 : i1
        %isJALR_181 = hw.struct_extract %235["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %432 = comb.and %431, %isJALR_181 : i1
        %true_182 = hw.constant true
        %433 = sv.read_inout %230 : !hw.inout<i1>
        %434 = comb.xor %433, %true_182 : i1
        %isJAL_183 = hw.struct_extract %235["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %435 = comb.and %434, %isJAL_183 : i1
        %true_184 = hw.constant true
        %436 = sv.read_inout %230 : !hw.inout<i1>
        %437 = comb.xor %436, %true_184 : i1
        %isBranch_185 = hw.struct_extract %235["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %438 = comb.and %437, %isBranch_185 : i1
        %true_186 = hw.constant true
        %439 = sv.read_inout %230 : !hw.inout<i1>
        %440 = comb.xor %439, %true_186 : i1
        %isStore_187 = hw.struct_extract %235["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %441 = comb.and %440, %isStore_187 : i1
        %true_188 = hw.constant true
        %442 = sv.read_inout %230 : !hw.inout<i1>
        %443 = comb.xor %442, %true_188 : i1
        %isLoad_189 = hw.struct_extract %235["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %444 = comb.and %443, %isLoad_189 : i1
        %true_190 = hw.constant true
        %445 = sv.read_inout %230 : !hw.inout<i1>
        %446 = comb.xor %445, %true_190 : i1
        %isALU_191 = hw.struct_extract %235["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %447 = comb.and %446, %isALU_191 : i1
        %instr_192 = hw.struct_extract %235["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %448 = sv.read_inout %230 : !hw.inout<i1>
        %449 = comb.mux bin %448, %instr_68, %instr_192 : i32
        %pc_193 = hw.struct_extract %235["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %450 = sv.read_inout %230 : !hw.inout<i1>
        %451 = comb.mux bin %450, %pc_67, %pc_193 : i32
        %valid_194 = hw.struct_extract %235["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %452 = sv.read_inout %230 : !hw.inout<i1>
        %453 = comb.or %452, %valid_194 : i1
        %threadId_195 = hw.struct_extract %235["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %454 = sv.read_inout %230 : !hw.inout<i1>
        %455 = comb.mux bin %454, %threadId_66, %threadId_195 : i2
        %456 = hw.struct_create (%455, %453, %451, %449, %447, %444, %441, %438, %435, %432, %429, %426, %423, %420, %417, %415, %413, %411, %409, %407, %405, %403, %401, %399, %397) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %457 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %457, %456 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_196 = hw.struct_extract %237["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %458 = sv.read_inout %231 : !hw.inout<i1>
        %459 = comb.mux bin %458, %c0_i32_65, %aluResult_196 : i32
        %memRdata_197 = hw.struct_extract %237["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %460 = sv.read_inout %231 : !hw.inout<i1>
        %461 = comb.mux bin %460, %c0_i32_65, %memRdata_197 : i32
        %memWdata_198 = hw.struct_extract %237["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %462 = sv.read_inout %231 : !hw.inout<i1>
        %463 = comb.mux bin %462, %c0_i32_65, %memWdata_198 : i32
        %memAddr_199 = hw.struct_extract %237["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %464 = sv.read_inout %231 : !hw.inout<i1>
        %465 = comb.mux bin %464, %c0_i32_65, %memAddr_199 : i32
        %rs2Data_200 = hw.struct_extract %237["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %466 = sv.read_inout %231 : !hw.inout<i1>
        %467 = comb.mux bin %466, %c0_i32_65, %rs2Data_200 : i32
        %rs1Data_201 = hw.struct_extract %237["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %468 = sv.read_inout %231 : !hw.inout<i1>
        %469 = comb.mux bin %468, %c0_i32_65, %rs1Data_201 : i32
        %rd_202 = hw.struct_extract %237["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %470 = sv.read_inout %231 : !hw.inout<i1>
        %471 = comb.mux bin %470, %c0_i5_64, %rd_202 : i5
        %rs2_203 = hw.struct_extract %237["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %472 = sv.read_inout %231 : !hw.inout<i1>
        %473 = comb.mux bin %472, %c0_i5_64, %rs2_203 : i5
        %rs1_204 = hw.struct_extract %237["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %474 = sv.read_inout %231 : !hw.inout<i1>
        %475 = comb.mux bin %474, %c0_i5_64, %rs1_204 : i5
        %imm_205 = hw.struct_extract %237["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %476 = sv.read_inout %231 : !hw.inout<i1>
        %477 = comb.mux bin %476, %c0_i32_65, %imm_205 : i32
        %aluOp_206 = hw.struct_extract %237["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %478 = sv.read_inout %231 : !hw.inout<i1>
        %479 = comb.mux bin %478, %c0_i5_64, %aluOp_206 : i5
        %true_207 = hw.constant true
        %480 = sv.read_inout %231 : !hw.inout<i1>
        %481 = comb.xor %480, %true_207 : i1
        %isSystem_208 = hw.struct_extract %237["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %482 = comb.and %481, %isSystem_208 : i1
        %true_209 = hw.constant true
        %483 = sv.read_inout %231 : !hw.inout<i1>
        %484 = comb.xor %483, %true_209 : i1
        %isFence_210 = hw.struct_extract %237["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %485 = comb.and %484, %isFence_210 : i1
        %true_211 = hw.constant true
        %486 = sv.read_inout %231 : !hw.inout<i1>
        %487 = comb.xor %486, %true_211 : i1
        %isAUIPC_212 = hw.struct_extract %237["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %488 = comb.and %487, %isAUIPC_212 : i1
        %true_213 = hw.constant true
        %489 = sv.read_inout %231 : !hw.inout<i1>
        %490 = comb.xor %489, %true_213 : i1
        %isLUI_214 = hw.struct_extract %237["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %491 = comb.and %490, %isLUI_214 : i1
        %true_215 = hw.constant true
        %492 = sv.read_inout %231 : !hw.inout<i1>
        %493 = comb.xor %492, %true_215 : i1
        %isJALR_216 = hw.struct_extract %237["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %494 = comb.and %493, %isJALR_216 : i1
        %true_217 = hw.constant true
        %495 = sv.read_inout %231 : !hw.inout<i1>
        %496 = comb.xor %495, %true_217 : i1
        %isJAL_218 = hw.struct_extract %237["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %497 = comb.and %496, %isJAL_218 : i1
        %true_219 = hw.constant true
        %498 = sv.read_inout %231 : !hw.inout<i1>
        %499 = comb.xor %498, %true_219 : i1
        %isBranch_220 = hw.struct_extract %237["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %500 = comb.and %499, %isBranch_220 : i1
        %true_221 = hw.constant true
        %501 = sv.read_inout %231 : !hw.inout<i1>
        %502 = comb.xor %501, %true_221 : i1
        %isStore_222 = hw.struct_extract %237["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %503 = comb.and %502, %isStore_222 : i1
        %true_223 = hw.constant true
        %504 = sv.read_inout %231 : !hw.inout<i1>
        %505 = comb.xor %504, %true_223 : i1
        %isLoad_224 = hw.struct_extract %237["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %506 = comb.and %505, %isLoad_224 : i1
        %true_225 = hw.constant true
        %507 = sv.read_inout %231 : !hw.inout<i1>
        %508 = comb.xor %507, %true_225 : i1
        %isALU_226 = hw.struct_extract %237["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %509 = comb.and %508, %isALU_226 : i1
        %instr_227 = hw.struct_extract %237["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %510 = sv.read_inout %231 : !hw.inout<i1>
        %511 = comb.mux bin %510, %instr_68, %instr_227 : i32
        %pc_228 = hw.struct_extract %237["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %512 = sv.read_inout %231 : !hw.inout<i1>
        %513 = comb.mux bin %512, %pc_67, %pc_228 : i32
        %valid_229 = hw.struct_extract %237["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %514 = sv.read_inout %231 : !hw.inout<i1>
        %515 = comb.or %514, %valid_229 : i1
        %threadId_230 = hw.struct_extract %237["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %516 = sv.read_inout %231 : !hw.inout<i1>
        %517 = comb.mux bin %516, %threadId_66, %threadId_230 : i2
        %518 = hw.struct_create (%517, %515, %513, %511, %509, %506, %503, %500, %497, %494, %491, %488, %485, %482, %479, %477, %475, %473, %471, %469, %467, %465, %463, %461, %459) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %519 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %519, %518 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %c-1_i2_231 = hw.constant -1 : i2
        %520 = sv.read_inout %currentThread : !hw.inout<i2>
        %521 = comb.icmp bin eq %520, %c-1_i2_231 : i2
        %aluResult_232 = hw.struct_extract %239["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %522 = comb.mux bin %521, %c0_i32_65, %aluResult_232 : i32
        %c-1_i2_233 = hw.constant -1 : i2
        %523 = sv.read_inout %currentThread : !hw.inout<i2>
        %524 = comb.icmp bin eq %523, %c-1_i2_233 : i2
        %memRdata_234 = hw.struct_extract %239["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %525 = comb.mux bin %524, %c0_i32_65, %memRdata_234 : i32
        %c-1_i2_235 = hw.constant -1 : i2
        %526 = sv.read_inout %currentThread : !hw.inout<i2>
        %527 = comb.icmp bin eq %526, %c-1_i2_235 : i2
        %memWdata_236 = hw.struct_extract %239["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %528 = comb.mux bin %527, %c0_i32_65, %memWdata_236 : i32
        %c-1_i2_237 = hw.constant -1 : i2
        %529 = sv.read_inout %currentThread : !hw.inout<i2>
        %530 = comb.icmp bin eq %529, %c-1_i2_237 : i2
        %memAddr_238 = hw.struct_extract %239["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %531 = comb.mux bin %530, %c0_i32_65, %memAddr_238 : i32
        %c-1_i2_239 = hw.constant -1 : i2
        %532 = sv.read_inout %currentThread : !hw.inout<i2>
        %533 = comb.icmp bin eq %532, %c-1_i2_239 : i2
        %rs2Data_240 = hw.struct_extract %239["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %534 = comb.mux bin %533, %c0_i32_65, %rs2Data_240 : i32
        %c-1_i2_241 = hw.constant -1 : i2
        %535 = sv.read_inout %currentThread : !hw.inout<i2>
        %536 = comb.icmp bin eq %535, %c-1_i2_241 : i2
        %rs1Data_242 = hw.struct_extract %239["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %537 = comb.mux bin %536, %c0_i32_65, %rs1Data_242 : i32
        %c-1_i2_243 = hw.constant -1 : i2
        %538 = sv.read_inout %currentThread : !hw.inout<i2>
        %539 = comb.icmp bin eq %538, %c-1_i2_243 : i2
        %rd_244 = hw.struct_extract %239["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %540 = comb.mux bin %539, %c0_i5_64, %rd_244 : i5
        %c-1_i2_245 = hw.constant -1 : i2
        %541 = sv.read_inout %currentThread : !hw.inout<i2>
        %542 = comb.icmp bin eq %541, %c-1_i2_245 : i2
        %rs2_246 = hw.struct_extract %239["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %543 = comb.mux bin %542, %c0_i5_64, %rs2_246 : i5
        %c-1_i2_247 = hw.constant -1 : i2
        %544 = sv.read_inout %currentThread : !hw.inout<i2>
        %545 = comb.icmp bin eq %544, %c-1_i2_247 : i2
        %rs1_248 = hw.struct_extract %239["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %546 = comb.mux bin %545, %c0_i5_64, %rs1_248 : i5
        %c-1_i2_249 = hw.constant -1 : i2
        %547 = sv.read_inout %currentThread : !hw.inout<i2>
        %548 = comb.icmp bin eq %547, %c-1_i2_249 : i2
        %imm_250 = hw.struct_extract %239["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %549 = comb.mux bin %548, %c0_i32_65, %imm_250 : i32
        %c-1_i2_251 = hw.constant -1 : i2
        %550 = sv.read_inout %currentThread : !hw.inout<i2>
        %551 = comb.icmp bin eq %550, %c-1_i2_251 : i2
        %aluOp_252 = hw.struct_extract %239["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %552 = comb.mux bin %551, %c0_i5_64, %aluOp_252 : i5
        %true_253 = hw.constant true
        %c-1_i2_254 = hw.constant -1 : i2
        %553 = sv.read_inout %currentThread : !hw.inout<i2>
        %554 = comb.icmp bin eq %553, %c-1_i2_254 : i2
        %555 = comb.xor %554, %true_253 : i1
        %isSystem_255 = hw.struct_extract %239["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %556 = comb.and %555, %isSystem_255 : i1
        %true_256 = hw.constant true
        %c-1_i2_257 = hw.constant -1 : i2
        %557 = sv.read_inout %currentThread : !hw.inout<i2>
        %558 = comb.icmp bin eq %557, %c-1_i2_257 : i2
        %559 = comb.xor %558, %true_256 : i1
        %isFence_258 = hw.struct_extract %239["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %560 = comb.and %559, %isFence_258 : i1
        %true_259 = hw.constant true
        %c-1_i2_260 = hw.constant -1 : i2
        %561 = sv.read_inout %currentThread : !hw.inout<i2>
        %562 = comb.icmp bin eq %561, %c-1_i2_260 : i2
        %563 = comb.xor %562, %true_259 : i1
        %isAUIPC_261 = hw.struct_extract %239["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %564 = comb.and %563, %isAUIPC_261 : i1
        %true_262 = hw.constant true
        %c-1_i2_263 = hw.constant -1 : i2
        %565 = sv.read_inout %currentThread : !hw.inout<i2>
        %566 = comb.icmp bin eq %565, %c-1_i2_263 : i2
        %567 = comb.xor %566, %true_262 : i1
        %isLUI_264 = hw.struct_extract %239["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %568 = comb.and %567, %isLUI_264 : i1
        %true_265 = hw.constant true
        %c-1_i2_266 = hw.constant -1 : i2
        %569 = sv.read_inout %currentThread : !hw.inout<i2>
        %570 = comb.icmp bin eq %569, %c-1_i2_266 : i2
        %571 = comb.xor %570, %true_265 : i1
        %isJALR_267 = hw.struct_extract %239["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %572 = comb.and %571, %isJALR_267 : i1
        %true_268 = hw.constant true
        %c-1_i2_269 = hw.constant -1 : i2
        %573 = sv.read_inout %currentThread : !hw.inout<i2>
        %574 = comb.icmp bin eq %573, %c-1_i2_269 : i2
        %575 = comb.xor %574, %true_268 : i1
        %isJAL_270 = hw.struct_extract %239["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %576 = comb.and %575, %isJAL_270 : i1
        %true_271 = hw.constant true
        %c-1_i2_272 = hw.constant -1 : i2
        %577 = sv.read_inout %currentThread : !hw.inout<i2>
        %578 = comb.icmp bin eq %577, %c-1_i2_272 : i2
        %579 = comb.xor %578, %true_271 : i1
        %isBranch_273 = hw.struct_extract %239["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %580 = comb.and %579, %isBranch_273 : i1
        %true_274 = hw.constant true
        %c-1_i2_275 = hw.constant -1 : i2
        %581 = sv.read_inout %currentThread : !hw.inout<i2>
        %582 = comb.icmp bin eq %581, %c-1_i2_275 : i2
        %583 = comb.xor %582, %true_274 : i1
        %isStore_276 = hw.struct_extract %239["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %584 = comb.and %583, %isStore_276 : i1
        %true_277 = hw.constant true
        %c-1_i2_278 = hw.constant -1 : i2
        %585 = sv.read_inout %currentThread : !hw.inout<i2>
        %586 = comb.icmp bin eq %585, %c-1_i2_278 : i2
        %587 = comb.xor %586, %true_277 : i1
        %isLoad_279 = hw.struct_extract %239["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %588 = comb.and %587, %isLoad_279 : i1
        %true_280 = hw.constant true
        %c-1_i2_281 = hw.constant -1 : i2
        %589 = sv.read_inout %currentThread : !hw.inout<i2>
        %590 = comb.icmp bin eq %589, %c-1_i2_281 : i2
        %591 = comb.xor %590, %true_280 : i1
        %isALU_282 = hw.struct_extract %239["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %592 = comb.and %591, %isALU_282 : i1
        %c-1_i2_283 = hw.constant -1 : i2
        %593 = sv.read_inout %currentThread : !hw.inout<i2>
        %594 = comb.icmp bin eq %593, %c-1_i2_283 : i2
        %instr_284 = hw.struct_extract %239["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %595 = comb.mux bin %594, %instr_68, %instr_284 : i32
        %c-1_i2_285 = hw.constant -1 : i2
        %596 = sv.read_inout %currentThread : !hw.inout<i2>
        %597 = comb.icmp bin eq %596, %c-1_i2_285 : i2
        %pc_286 = hw.struct_extract %239["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %598 = comb.mux bin %597, %pc_67, %pc_286 : i32
        %c-1_i2_287 = hw.constant -1 : i2
        %599 = sv.read_inout %currentThread : !hw.inout<i2>
        %600 = comb.icmp bin eq %599, %c-1_i2_287 : i2
        %valid_288 = hw.struct_extract %239["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %601 = comb.or %600, %valid_288 : i1
        %c-1_i2_289 = hw.constant -1 : i2
        %602 = sv.read_inout %currentThread : !hw.inout<i2>
        %603 = comb.icmp bin eq %602, %c-1_i2_289 : i2
        %threadId_290 = hw.struct_extract %239["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %604 = comb.mux bin %603, %threadId_66, %threadId_290 : i2
        %605 = hw.struct_create (%604, %601, %598, %595, %592, %588, %584, %580, %576, %572, %568, %564, %560, %556, %552, %549, %546, %543, %540, %537, %534, %531, %528, %525, %522) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %606 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %606, %605 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_291 = hw.struct_extract %241["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %607 = sv.read_inout %229 : !hw.inout<i1>
        %608 = comb.mux bin %607, %aluResult_90, %aluResult_291 : i32
        %memRdata_292 = hw.struct_extract %241["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %609 = sv.read_inout %229 : !hw.inout<i1>
        %610 = comb.mux bin %609, %memRdata_89, %memRdata_292 : i32
        %memWdata_293 = hw.struct_extract %241["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %611 = sv.read_inout %229 : !hw.inout<i1>
        %612 = comb.mux bin %611, %memWdata_88, %memWdata_293 : i32
        %memAddr_294 = hw.struct_extract %241["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %613 = sv.read_inout %229 : !hw.inout<i1>
        %614 = comb.mux bin %613, %memAddr_87, %memAddr_294 : i32
        %rs2Data_295 = hw.struct_extract %241["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %615 = sv.read_inout %229 : !hw.inout<i1>
        %616 = comb.mux bin %615, %rs2Data_86, %rs2Data_295 : i32
        %rs1Data_296 = hw.struct_extract %241["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %617 = sv.read_inout %229 : !hw.inout<i1>
        %618 = comb.mux bin %617, %rs1Data_85, %rs1Data_296 : i32
        %rd_297 = hw.struct_extract %241["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %619 = sv.read_inout %229 : !hw.inout<i1>
        %620 = comb.mux bin %619, %rd_84, %rd_297 : i5
        %rs2_298 = hw.struct_extract %241["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %621 = sv.read_inout %229 : !hw.inout<i1>
        %622 = comb.mux bin %621, %rs2, %rs2_298 : i5
        %rs1_299 = hw.struct_extract %241["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %623 = sv.read_inout %229 : !hw.inout<i1>
        %624 = comb.mux bin %623, %rs1, %rs1_299 : i5
        %imm_300 = hw.struct_extract %241["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %625 = sv.read_inout %229 : !hw.inout<i1>
        %626 = comb.mux bin %625, %imm_83, %imm_300 : i32
        %aluOp_301 = hw.struct_extract %241["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %627 = sv.read_inout %229 : !hw.inout<i1>
        %628 = comb.mux bin %627, %aluOp_82, %aluOp_301 : i5
        %isSystem_302 = hw.struct_extract %241["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %629 = sv.read_inout %229 : !hw.inout<i1>
        %630 = comb.mux bin %629, %isSystem_81, %isSystem_302 : i1
        %isFence_303 = hw.struct_extract %241["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %631 = sv.read_inout %229 : !hw.inout<i1>
        %632 = comb.mux bin %631, %isFence_80, %isFence_303 : i1
        %isAUIPC_304 = hw.struct_extract %241["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %633 = sv.read_inout %229 : !hw.inout<i1>
        %634 = comb.mux bin %633, %isAUIPC_79, %isAUIPC_304 : i1
        %isLUI_305 = hw.struct_extract %241["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %635 = sv.read_inout %229 : !hw.inout<i1>
        %636 = comb.mux bin %635, %isLUI_78, %isLUI_305 : i1
        %isJALR_306 = hw.struct_extract %241["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %637 = sv.read_inout %229 : !hw.inout<i1>
        %638 = comb.mux bin %637, %isJALR_77, %isJALR_306 : i1
        %isJAL_307 = hw.struct_extract %241["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %639 = sv.read_inout %229 : !hw.inout<i1>
        %640 = comb.mux bin %639, %isJAL_76, %isJAL_307 : i1
        %isBranch_308 = hw.struct_extract %241["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %641 = sv.read_inout %229 : !hw.inout<i1>
        %642 = comb.mux bin %641, %isBranch_75, %isBranch_308 : i1
        %isStore_309 = hw.struct_extract %241["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %643 = sv.read_inout %229 : !hw.inout<i1>
        %644 = comb.mux bin %643, %isStore_74, %isStore_309 : i1
        %isLoad_310 = hw.struct_extract %241["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %645 = sv.read_inout %229 : !hw.inout<i1>
        %646 = comb.mux bin %645, %isLoad_73, %isLoad_310 : i1
        %isALU_311 = hw.struct_extract %241["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %647 = sv.read_inout %229 : !hw.inout<i1>
        %648 = comb.mux bin %647, %isALU_72, %isALU_311 : i1
        %instr_312 = hw.struct_extract %241["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %649 = sv.read_inout %229 : !hw.inout<i1>
        %650 = comb.mux bin %649, %instr, %instr_312 : i32
        %pc_313 = hw.struct_extract %241["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %651 = sv.read_inout %229 : !hw.inout<i1>
        %652 = comb.mux bin %651, %pc_71, %pc_313 : i32
        %valid_314 = hw.struct_extract %241["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %653 = sv.read_inout %229 : !hw.inout<i1>
        %654 = comb.mux bin %653, %valid_70, %valid_314 : i1
        %threadId_315 = hw.struct_extract %241["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %655 = sv.read_inout %229 : !hw.inout<i1>
        %656 = comb.mux bin %655, %threadId_69, %threadId_315 : i2
        %657 = hw.struct_create (%656, %654, %652, %650, %648, %646, %644, %642, %640, %638, %636, %634, %632, %630, %628, %626, %624, %622, %620, %618, %616, %614, %612, %610, %608) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %658 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %658, %657 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_316 = hw.struct_extract %243["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %659 = sv.read_inout %230 : !hw.inout<i1>
        %660 = comb.mux bin %659, %aluResult_90, %aluResult_316 : i32
        %memRdata_317 = hw.struct_extract %243["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %661 = sv.read_inout %230 : !hw.inout<i1>
        %662 = comb.mux bin %661, %memRdata_89, %memRdata_317 : i32
        %memWdata_318 = hw.struct_extract %243["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %663 = sv.read_inout %230 : !hw.inout<i1>
        %664 = comb.mux bin %663, %memWdata_88, %memWdata_318 : i32
        %memAddr_319 = hw.struct_extract %243["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %665 = sv.read_inout %230 : !hw.inout<i1>
        %666 = comb.mux bin %665, %memAddr_87, %memAddr_319 : i32
        %rs2Data_320 = hw.struct_extract %243["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %667 = sv.read_inout %230 : !hw.inout<i1>
        %668 = comb.mux bin %667, %rs2Data_86, %rs2Data_320 : i32
        %rs1Data_321 = hw.struct_extract %243["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %669 = sv.read_inout %230 : !hw.inout<i1>
        %670 = comb.mux bin %669, %rs1Data_85, %rs1Data_321 : i32
        %rd_322 = hw.struct_extract %243["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %671 = sv.read_inout %230 : !hw.inout<i1>
        %672 = comb.mux bin %671, %rd_84, %rd_322 : i5
        %rs2_323 = hw.struct_extract %243["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %673 = sv.read_inout %230 : !hw.inout<i1>
        %674 = comb.mux bin %673, %rs2, %rs2_323 : i5
        %rs1_324 = hw.struct_extract %243["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %675 = sv.read_inout %230 : !hw.inout<i1>
        %676 = comb.mux bin %675, %rs1, %rs1_324 : i5
        %imm_325 = hw.struct_extract %243["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %677 = sv.read_inout %230 : !hw.inout<i1>
        %678 = comb.mux bin %677, %imm_83, %imm_325 : i32
        %aluOp_326 = hw.struct_extract %243["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %679 = sv.read_inout %230 : !hw.inout<i1>
        %680 = comb.mux bin %679, %aluOp_82, %aluOp_326 : i5
        %isSystem_327 = hw.struct_extract %243["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %681 = sv.read_inout %230 : !hw.inout<i1>
        %682 = comb.mux bin %681, %isSystem_81, %isSystem_327 : i1
        %isFence_328 = hw.struct_extract %243["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %683 = sv.read_inout %230 : !hw.inout<i1>
        %684 = comb.mux bin %683, %isFence_80, %isFence_328 : i1
        %isAUIPC_329 = hw.struct_extract %243["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %685 = sv.read_inout %230 : !hw.inout<i1>
        %686 = comb.mux bin %685, %isAUIPC_79, %isAUIPC_329 : i1
        %isLUI_330 = hw.struct_extract %243["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %687 = sv.read_inout %230 : !hw.inout<i1>
        %688 = comb.mux bin %687, %isLUI_78, %isLUI_330 : i1
        %isJALR_331 = hw.struct_extract %243["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %689 = sv.read_inout %230 : !hw.inout<i1>
        %690 = comb.mux bin %689, %isJALR_77, %isJALR_331 : i1
        %isJAL_332 = hw.struct_extract %243["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %691 = sv.read_inout %230 : !hw.inout<i1>
        %692 = comb.mux bin %691, %isJAL_76, %isJAL_332 : i1
        %isBranch_333 = hw.struct_extract %243["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %693 = sv.read_inout %230 : !hw.inout<i1>
        %694 = comb.mux bin %693, %isBranch_75, %isBranch_333 : i1
        %isStore_334 = hw.struct_extract %243["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %695 = sv.read_inout %230 : !hw.inout<i1>
        %696 = comb.mux bin %695, %isStore_74, %isStore_334 : i1
        %isLoad_335 = hw.struct_extract %243["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %697 = sv.read_inout %230 : !hw.inout<i1>
        %698 = comb.mux bin %697, %isLoad_73, %isLoad_335 : i1
        %isALU_336 = hw.struct_extract %243["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %699 = sv.read_inout %230 : !hw.inout<i1>
        %700 = comb.mux bin %699, %isALU_72, %isALU_336 : i1
        %instr_337 = hw.struct_extract %243["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %701 = sv.read_inout %230 : !hw.inout<i1>
        %702 = comb.mux bin %701, %instr, %instr_337 : i32
        %pc_338 = hw.struct_extract %243["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %703 = sv.read_inout %230 : !hw.inout<i1>
        %704 = comb.mux bin %703, %pc_71, %pc_338 : i32
        %valid_339 = hw.struct_extract %243["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %705 = sv.read_inout %230 : !hw.inout<i1>
        %706 = comb.mux bin %705, %valid_70, %valid_339 : i1
        %threadId_340 = hw.struct_extract %243["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %707 = sv.read_inout %230 : !hw.inout<i1>
        %708 = comb.mux bin %707, %threadId_69, %threadId_340 : i2
        %709 = hw.struct_create (%708, %706, %704, %702, %700, %698, %696, %694, %692, %690, %688, %686, %684, %682, %680, %678, %676, %674, %672, %670, %668, %666, %664, %662, %660) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %710 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %710, %709 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_341 = hw.struct_extract %245["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %711 = sv.read_inout %231 : !hw.inout<i1>
        %712 = comb.mux bin %711, %aluResult_90, %aluResult_341 : i32
        %memRdata_342 = hw.struct_extract %245["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %713 = sv.read_inout %231 : !hw.inout<i1>
        %714 = comb.mux bin %713, %memRdata_89, %memRdata_342 : i32
        %memWdata_343 = hw.struct_extract %245["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %715 = sv.read_inout %231 : !hw.inout<i1>
        %716 = comb.mux bin %715, %memWdata_88, %memWdata_343 : i32
        %memAddr_344 = hw.struct_extract %245["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %717 = sv.read_inout %231 : !hw.inout<i1>
        %718 = comb.mux bin %717, %memAddr_87, %memAddr_344 : i32
        %rs2Data_345 = hw.struct_extract %245["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %719 = sv.read_inout %231 : !hw.inout<i1>
        %720 = comb.mux bin %719, %rs2Data_86, %rs2Data_345 : i32
        %rs1Data_346 = hw.struct_extract %245["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %721 = sv.read_inout %231 : !hw.inout<i1>
        %722 = comb.mux bin %721, %rs1Data_85, %rs1Data_346 : i32
        %rd_347 = hw.struct_extract %245["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %723 = sv.read_inout %231 : !hw.inout<i1>
        %724 = comb.mux bin %723, %rd_84, %rd_347 : i5
        %rs2_348 = hw.struct_extract %245["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %725 = sv.read_inout %231 : !hw.inout<i1>
        %726 = comb.mux bin %725, %rs2, %rs2_348 : i5
        %rs1_349 = hw.struct_extract %245["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %727 = sv.read_inout %231 : !hw.inout<i1>
        %728 = comb.mux bin %727, %rs1, %rs1_349 : i5
        %imm_350 = hw.struct_extract %245["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %729 = sv.read_inout %231 : !hw.inout<i1>
        %730 = comb.mux bin %729, %imm_83, %imm_350 : i32
        %aluOp_351 = hw.struct_extract %245["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %731 = sv.read_inout %231 : !hw.inout<i1>
        %732 = comb.mux bin %731, %aluOp_82, %aluOp_351 : i5
        %isSystem_352 = hw.struct_extract %245["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %733 = sv.read_inout %231 : !hw.inout<i1>
        %734 = comb.mux bin %733, %isSystem_81, %isSystem_352 : i1
        %isFence_353 = hw.struct_extract %245["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %735 = sv.read_inout %231 : !hw.inout<i1>
        %736 = comb.mux bin %735, %isFence_80, %isFence_353 : i1
        %isAUIPC_354 = hw.struct_extract %245["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %737 = sv.read_inout %231 : !hw.inout<i1>
        %738 = comb.mux bin %737, %isAUIPC_79, %isAUIPC_354 : i1
        %isLUI_355 = hw.struct_extract %245["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %739 = sv.read_inout %231 : !hw.inout<i1>
        %740 = comb.mux bin %739, %isLUI_78, %isLUI_355 : i1
        %isJALR_356 = hw.struct_extract %245["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %741 = sv.read_inout %231 : !hw.inout<i1>
        %742 = comb.mux bin %741, %isJALR_77, %isJALR_356 : i1
        %isJAL_357 = hw.struct_extract %245["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %743 = sv.read_inout %231 : !hw.inout<i1>
        %744 = comb.mux bin %743, %isJAL_76, %isJAL_357 : i1
        %isBranch_358 = hw.struct_extract %245["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %745 = sv.read_inout %231 : !hw.inout<i1>
        %746 = comb.mux bin %745, %isBranch_75, %isBranch_358 : i1
        %isStore_359 = hw.struct_extract %245["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %747 = sv.read_inout %231 : !hw.inout<i1>
        %748 = comb.mux bin %747, %isStore_74, %isStore_359 : i1
        %isLoad_360 = hw.struct_extract %245["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %749 = sv.read_inout %231 : !hw.inout<i1>
        %750 = comb.mux bin %749, %isLoad_73, %isLoad_360 : i1
        %isALU_361 = hw.struct_extract %245["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %751 = sv.read_inout %231 : !hw.inout<i1>
        %752 = comb.mux bin %751, %isALU_72, %isALU_361 : i1
        %instr_362 = hw.struct_extract %245["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %753 = sv.read_inout %231 : !hw.inout<i1>
        %754 = comb.mux bin %753, %instr, %instr_362 : i32
        %pc_363 = hw.struct_extract %245["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %755 = sv.read_inout %231 : !hw.inout<i1>
        %756 = comb.mux bin %755, %pc_71, %pc_363 : i32
        %valid_364 = hw.struct_extract %245["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %757 = sv.read_inout %231 : !hw.inout<i1>
        %758 = comb.mux bin %757, %valid_70, %valid_364 : i1
        %threadId_365 = hw.struct_extract %245["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %759 = sv.read_inout %231 : !hw.inout<i1>
        %760 = comb.mux bin %759, %threadId_69, %threadId_365 : i2
        %761 = hw.struct_create (%760, %758, %756, %754, %752, %750, %748, %746, %744, %742, %740, %738, %736, %734, %732, %730, %728, %726, %724, %722, %720, %718, %716, %714, %712) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %762 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %762, %761 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %c-1_i2_366 = hw.constant -1 : i2
        %763 = sv.read_inout %currentThread : !hw.inout<i2>
        %764 = comb.icmp bin eq %763, %c-1_i2_366 : i2
        %aluResult_367 = hw.struct_extract %247["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %765 = comb.mux bin %764, %aluResult_90, %aluResult_367 : i32
        %c-1_i2_368 = hw.constant -1 : i2
        %766 = sv.read_inout %currentThread : !hw.inout<i2>
        %767 = comb.icmp bin eq %766, %c-1_i2_368 : i2
        %memRdata_369 = hw.struct_extract %247["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %768 = comb.mux bin %767, %memRdata_89, %memRdata_369 : i32
        %c-1_i2_370 = hw.constant -1 : i2
        %769 = sv.read_inout %currentThread : !hw.inout<i2>
        %770 = comb.icmp bin eq %769, %c-1_i2_370 : i2
        %memWdata_371 = hw.struct_extract %247["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %771 = comb.mux bin %770, %memWdata_88, %memWdata_371 : i32
        %c-1_i2_372 = hw.constant -1 : i2
        %772 = sv.read_inout %currentThread : !hw.inout<i2>
        %773 = comb.icmp bin eq %772, %c-1_i2_372 : i2
        %memAddr_373 = hw.struct_extract %247["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %774 = comb.mux bin %773, %memAddr_87, %memAddr_373 : i32
        %c-1_i2_374 = hw.constant -1 : i2
        %775 = sv.read_inout %currentThread : !hw.inout<i2>
        %776 = comb.icmp bin eq %775, %c-1_i2_374 : i2
        %rs2Data_375 = hw.struct_extract %247["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %777 = comb.mux bin %776, %rs2Data_86, %rs2Data_375 : i32
        %c-1_i2_376 = hw.constant -1 : i2
        %778 = sv.read_inout %currentThread : !hw.inout<i2>
        %779 = comb.icmp bin eq %778, %c-1_i2_376 : i2
        %rs1Data_377 = hw.struct_extract %247["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %780 = comb.mux bin %779, %rs1Data_85, %rs1Data_377 : i32
        %c-1_i2_378 = hw.constant -1 : i2
        %781 = sv.read_inout %currentThread : !hw.inout<i2>
        %782 = comb.icmp bin eq %781, %c-1_i2_378 : i2
        %rd_379 = hw.struct_extract %247["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %783 = comb.mux bin %782, %rd_84, %rd_379 : i5
        %c-1_i2_380 = hw.constant -1 : i2
        %784 = sv.read_inout %currentThread : !hw.inout<i2>
        %785 = comb.icmp bin eq %784, %c-1_i2_380 : i2
        %rs2_381 = hw.struct_extract %247["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %786 = comb.mux bin %785, %rs2, %rs2_381 : i5
        %c-1_i2_382 = hw.constant -1 : i2
        %787 = sv.read_inout %currentThread : !hw.inout<i2>
        %788 = comb.icmp bin eq %787, %c-1_i2_382 : i2
        %rs1_383 = hw.struct_extract %247["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %789 = comb.mux bin %788, %rs1, %rs1_383 : i5
        %c-1_i2_384 = hw.constant -1 : i2
        %790 = sv.read_inout %currentThread : !hw.inout<i2>
        %791 = comb.icmp bin eq %790, %c-1_i2_384 : i2
        %imm_385 = hw.struct_extract %247["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %792 = comb.mux bin %791, %imm_83, %imm_385 : i32
        %c-1_i2_386 = hw.constant -1 : i2
        %793 = sv.read_inout %currentThread : !hw.inout<i2>
        %794 = comb.icmp bin eq %793, %c-1_i2_386 : i2
        %aluOp_387 = hw.struct_extract %247["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %795 = comb.mux bin %794, %aluOp_82, %aluOp_387 : i5
        %c-1_i2_388 = hw.constant -1 : i2
        %796 = sv.read_inout %currentThread : !hw.inout<i2>
        %797 = comb.icmp bin eq %796, %c-1_i2_388 : i2
        %isSystem_389 = hw.struct_extract %247["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %798 = comb.mux bin %797, %isSystem_81, %isSystem_389 : i1
        %c-1_i2_390 = hw.constant -1 : i2
        %799 = sv.read_inout %currentThread : !hw.inout<i2>
        %800 = comb.icmp bin eq %799, %c-1_i2_390 : i2
        %isFence_391 = hw.struct_extract %247["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %801 = comb.mux bin %800, %isFence_80, %isFence_391 : i1
        %c-1_i2_392 = hw.constant -1 : i2
        %802 = sv.read_inout %currentThread : !hw.inout<i2>
        %803 = comb.icmp bin eq %802, %c-1_i2_392 : i2
        %isAUIPC_393 = hw.struct_extract %247["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %804 = comb.mux bin %803, %isAUIPC_79, %isAUIPC_393 : i1
        %c-1_i2_394 = hw.constant -1 : i2
        %805 = sv.read_inout %currentThread : !hw.inout<i2>
        %806 = comb.icmp bin eq %805, %c-1_i2_394 : i2
        %isLUI_395 = hw.struct_extract %247["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %807 = comb.mux bin %806, %isLUI_78, %isLUI_395 : i1
        %c-1_i2_396 = hw.constant -1 : i2
        %808 = sv.read_inout %currentThread : !hw.inout<i2>
        %809 = comb.icmp bin eq %808, %c-1_i2_396 : i2
        %isJALR_397 = hw.struct_extract %247["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %810 = comb.mux bin %809, %isJALR_77, %isJALR_397 : i1
        %c-1_i2_398 = hw.constant -1 : i2
        %811 = sv.read_inout %currentThread : !hw.inout<i2>
        %812 = comb.icmp bin eq %811, %c-1_i2_398 : i2
        %isJAL_399 = hw.struct_extract %247["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %813 = comb.mux bin %812, %isJAL_76, %isJAL_399 : i1
        %c-1_i2_400 = hw.constant -1 : i2
        %814 = sv.read_inout %currentThread : !hw.inout<i2>
        %815 = comb.icmp bin eq %814, %c-1_i2_400 : i2
        %isBranch_401 = hw.struct_extract %247["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %816 = comb.mux bin %815, %isBranch_75, %isBranch_401 : i1
        %c-1_i2_402 = hw.constant -1 : i2
        %817 = sv.read_inout %currentThread : !hw.inout<i2>
        %818 = comb.icmp bin eq %817, %c-1_i2_402 : i2
        %isStore_403 = hw.struct_extract %247["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %819 = comb.mux bin %818, %isStore_74, %isStore_403 : i1
        %c-1_i2_404 = hw.constant -1 : i2
        %820 = sv.read_inout %currentThread : !hw.inout<i2>
        %821 = comb.icmp bin eq %820, %c-1_i2_404 : i2
        %isLoad_405 = hw.struct_extract %247["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %822 = comb.mux bin %821, %isLoad_73, %isLoad_405 : i1
        %c-1_i2_406 = hw.constant -1 : i2
        %823 = sv.read_inout %currentThread : !hw.inout<i2>
        %824 = comb.icmp bin eq %823, %c-1_i2_406 : i2
        %isALU_407 = hw.struct_extract %247["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %825 = comb.mux bin %824, %isALU_72, %isALU_407 : i1
        %c-1_i2_408 = hw.constant -1 : i2
        %826 = sv.read_inout %currentThread : !hw.inout<i2>
        %827 = comb.icmp bin eq %826, %c-1_i2_408 : i2
        %instr_409 = hw.struct_extract %247["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %828 = comb.mux bin %827, %instr, %instr_409 : i32
        %c-1_i2_410 = hw.constant -1 : i2
        %829 = sv.read_inout %currentThread : !hw.inout<i2>
        %830 = comb.icmp bin eq %829, %c-1_i2_410 : i2
        %pc_411 = hw.struct_extract %247["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %831 = comb.mux bin %830, %pc_71, %pc_411 : i32
        %c-1_i2_412 = hw.constant -1 : i2
        %832 = sv.read_inout %currentThread : !hw.inout<i2>
        %833 = comb.icmp bin eq %832, %c-1_i2_412 : i2
        %valid_413 = hw.struct_extract %247["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %834 = comb.mux bin %833, %valid_70, %valid_413 : i1
        %c-1_i2_414 = hw.constant -1 : i2
        %835 = sv.read_inout %currentThread : !hw.inout<i2>
        %836 = comb.icmp bin eq %835, %c-1_i2_414 : i2
        %threadId_415 = hw.struct_extract %247["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %837 = comb.mux bin %836, %threadId_69, %threadId_415 : i2
        %838 = hw.struct_create (%837, %834, %831, %828, %825, %822, %819, %816, %813, %810, %807, %804, %801, %798, %795, %792, %789, %786, %783, %780, %777, %774, %771, %768, %765) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %839 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %839, %838 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_416 = hw.struct_extract %249["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %840 = sv.read_inout %229 : !hw.inout<i1>
        %841 = comb.mux bin %840, %aluResult_109, %aluResult_416 : i32
        %memRdata_417 = hw.struct_extract %249["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %842 = sv.read_inout %229 : !hw.inout<i1>
        %843 = comb.mux bin %842, %memRdata_108, %memRdata_417 : i32
        %memWdata_418 = hw.struct_extract %249["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %844 = sv.read_inout %229 : !hw.inout<i1>
        %845 = comb.mux bin %844, %memWdata_107, %memWdata_418 : i32
        %memAddr_419 = hw.struct_extract %249["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %846 = sv.read_inout %229 : !hw.inout<i1>
        %847 = comb.mux bin %846, %memAddr_106, %memAddr_419 : i32
        %rs2Data_420 = hw.struct_extract %249["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %848 = sv.read_inout %229 : !hw.inout<i1>
        %849 = comb.mux bin %848, %rs2Data, %rs2Data_420 : i32
        %rs1Data_421 = hw.struct_extract %249["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %850 = sv.read_inout %229 : !hw.inout<i1>
        %851 = comb.mux bin %850, %rs1Data, %rs1Data_421 : i32
        %rd_422 = hw.struct_extract %249["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %852 = sv.read_inout %229 : !hw.inout<i1>
        %853 = comb.mux bin %852, %rd_105, %rd_422 : i5
        %rs2_423 = hw.struct_extract %249["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %854 = sv.read_inout %229 : !hw.inout<i1>
        %855 = comb.mux bin %854, %rs2_104, %rs2_423 : i5
        %rs1_424 = hw.struct_extract %249["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %856 = sv.read_inout %229 : !hw.inout<i1>
        %857 = comb.mux bin %856, %rs1_103, %rs1_424 : i5
        %imm_425 = hw.struct_extract %249["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %858 = sv.read_inout %229 : !hw.inout<i1>
        %859 = comb.mux bin %858, %imm_4, %imm_425 : i32
        %aluOp_426 = hw.struct_extract %249["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %860 = sv.read_inout %229 : !hw.inout<i1>
        %861 = comb.mux bin %860, %aluOp_7, %aluOp_426 : i5
        %isSystem_427 = hw.struct_extract %249["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %862 = sv.read_inout %229 : !hw.inout<i1>
        %863 = comb.mux bin %862, %isSystem_102, %isSystem_427 : i1
        %isFence_428 = hw.struct_extract %249["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %864 = sv.read_inout %229 : !hw.inout<i1>
        %865 = comb.mux bin %864, %isFence_101, %isFence_428 : i1
        %isAUIPC_429 = hw.struct_extract %249["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %866 = sv.read_inout %229 : !hw.inout<i1>
        %867 = comb.mux bin %866, %isAUIPC_100, %isAUIPC_429 : i1
        %isLUI_430 = hw.struct_extract %249["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %868 = sv.read_inout %229 : !hw.inout<i1>
        %869 = comb.mux bin %868, %isLUI_99, %isLUI_430 : i1
        %isJALR_431 = hw.struct_extract %249["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %870 = sv.read_inout %229 : !hw.inout<i1>
        %871 = comb.mux bin %870, %isJALR_98, %isJALR_431 : i1
        %isJAL_432 = hw.struct_extract %249["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %872 = sv.read_inout %229 : !hw.inout<i1>
        %873 = comb.mux bin %872, %isJAL_97, %isJAL_432 : i1
        %isBranch_433 = hw.struct_extract %249["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %874 = sv.read_inout %229 : !hw.inout<i1>
        %875 = comb.mux bin %874, %isBranch_96, %isBranch_433 : i1
        %isStore_434 = hw.struct_extract %249["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %876 = sv.read_inout %229 : !hw.inout<i1>
        %877 = comb.mux bin %876, %isStore_5, %isStore_434 : i1
        %isLoad_435 = hw.struct_extract %249["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %878 = sv.read_inout %229 : !hw.inout<i1>
        %879 = comb.mux bin %878, %isLoad_6, %isLoad_435 : i1
        %isALU_436 = hw.struct_extract %249["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %880 = sv.read_inout %229 : !hw.inout<i1>
        %881 = comb.mux bin %880, %isALU_95, %isALU_436 : i1
        %instr_437 = hw.struct_extract %249["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %882 = sv.read_inout %229 : !hw.inout<i1>
        %883 = comb.mux bin %882, %instr_94, %instr_437 : i32
        %pc_438 = hw.struct_extract %249["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %884 = sv.read_inout %229 : !hw.inout<i1>
        %885 = comb.mux bin %884, %pc_93, %pc_438 : i32
        %valid_439 = hw.struct_extract %249["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %886 = sv.read_inout %229 : !hw.inout<i1>
        %887 = comb.mux bin %886, %valid_92, %valid_439 : i1
        %threadId_440 = hw.struct_extract %249["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %888 = sv.read_inout %229 : !hw.inout<i1>
        %889 = comb.mux bin %888, %threadId_91, %threadId_440 : i2
        %890 = hw.struct_create (%889, %887, %885, %883, %881, %879, %877, %875, %873, %871, %869, %867, %865, %863, %861, %859, %857, %855, %853, %851, %849, %847, %845, %843, %841) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %891 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %891, %890 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_441 = hw.struct_extract %251["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %892 = sv.read_inout %230 : !hw.inout<i1>
        %893 = comb.mux bin %892, %aluResult_109, %aluResult_441 : i32
        %memRdata_442 = hw.struct_extract %251["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %894 = sv.read_inout %230 : !hw.inout<i1>
        %895 = comb.mux bin %894, %memRdata_108, %memRdata_442 : i32
        %memWdata_443 = hw.struct_extract %251["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %896 = sv.read_inout %230 : !hw.inout<i1>
        %897 = comb.mux bin %896, %memWdata_107, %memWdata_443 : i32
        %memAddr_444 = hw.struct_extract %251["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %898 = sv.read_inout %230 : !hw.inout<i1>
        %899 = comb.mux bin %898, %memAddr_106, %memAddr_444 : i32
        %rs2Data_445 = hw.struct_extract %251["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %900 = sv.read_inout %230 : !hw.inout<i1>
        %901 = comb.mux bin %900, %rs2Data, %rs2Data_445 : i32
        %rs1Data_446 = hw.struct_extract %251["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %902 = sv.read_inout %230 : !hw.inout<i1>
        %903 = comb.mux bin %902, %rs1Data, %rs1Data_446 : i32
        %rd_447 = hw.struct_extract %251["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %904 = sv.read_inout %230 : !hw.inout<i1>
        %905 = comb.mux bin %904, %rd_105, %rd_447 : i5
        %rs2_448 = hw.struct_extract %251["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %906 = sv.read_inout %230 : !hw.inout<i1>
        %907 = comb.mux bin %906, %rs2_104, %rs2_448 : i5
        %rs1_449 = hw.struct_extract %251["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %908 = sv.read_inout %230 : !hw.inout<i1>
        %909 = comb.mux bin %908, %rs1_103, %rs1_449 : i5
        %imm_450 = hw.struct_extract %251["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %910 = sv.read_inout %230 : !hw.inout<i1>
        %911 = comb.mux bin %910, %imm_4, %imm_450 : i32
        %aluOp_451 = hw.struct_extract %251["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %912 = sv.read_inout %230 : !hw.inout<i1>
        %913 = comb.mux bin %912, %aluOp_7, %aluOp_451 : i5
        %isSystem_452 = hw.struct_extract %251["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %914 = sv.read_inout %230 : !hw.inout<i1>
        %915 = comb.mux bin %914, %isSystem_102, %isSystem_452 : i1
        %isFence_453 = hw.struct_extract %251["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %916 = sv.read_inout %230 : !hw.inout<i1>
        %917 = comb.mux bin %916, %isFence_101, %isFence_453 : i1
        %isAUIPC_454 = hw.struct_extract %251["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %918 = sv.read_inout %230 : !hw.inout<i1>
        %919 = comb.mux bin %918, %isAUIPC_100, %isAUIPC_454 : i1
        %isLUI_455 = hw.struct_extract %251["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %920 = sv.read_inout %230 : !hw.inout<i1>
        %921 = comb.mux bin %920, %isLUI_99, %isLUI_455 : i1
        %isJALR_456 = hw.struct_extract %251["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %922 = sv.read_inout %230 : !hw.inout<i1>
        %923 = comb.mux bin %922, %isJALR_98, %isJALR_456 : i1
        %isJAL_457 = hw.struct_extract %251["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %924 = sv.read_inout %230 : !hw.inout<i1>
        %925 = comb.mux bin %924, %isJAL_97, %isJAL_457 : i1
        %isBranch_458 = hw.struct_extract %251["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %926 = sv.read_inout %230 : !hw.inout<i1>
        %927 = comb.mux bin %926, %isBranch_96, %isBranch_458 : i1
        %isStore_459 = hw.struct_extract %251["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %928 = sv.read_inout %230 : !hw.inout<i1>
        %929 = comb.mux bin %928, %isStore_5, %isStore_459 : i1
        %isLoad_460 = hw.struct_extract %251["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %930 = sv.read_inout %230 : !hw.inout<i1>
        %931 = comb.mux bin %930, %isLoad_6, %isLoad_460 : i1
        %isALU_461 = hw.struct_extract %251["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %932 = sv.read_inout %230 : !hw.inout<i1>
        %933 = comb.mux bin %932, %isALU_95, %isALU_461 : i1
        %instr_462 = hw.struct_extract %251["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %934 = sv.read_inout %230 : !hw.inout<i1>
        %935 = comb.mux bin %934, %instr_94, %instr_462 : i32
        %pc_463 = hw.struct_extract %251["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %936 = sv.read_inout %230 : !hw.inout<i1>
        %937 = comb.mux bin %936, %pc_93, %pc_463 : i32
        %valid_464 = hw.struct_extract %251["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %938 = sv.read_inout %230 : !hw.inout<i1>
        %939 = comb.mux bin %938, %valid_92, %valid_464 : i1
        %threadId_465 = hw.struct_extract %251["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %940 = sv.read_inout %230 : !hw.inout<i1>
        %941 = comb.mux bin %940, %threadId_91, %threadId_465 : i2
        %942 = hw.struct_create (%941, %939, %937, %935, %933, %931, %929, %927, %925, %923, %921, %919, %917, %915, %913, %911, %909, %907, %905, %903, %901, %899, %897, %895, %893) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %943 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %943, %942 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_466 = hw.struct_extract %253["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %944 = sv.read_inout %231 : !hw.inout<i1>
        %945 = comb.mux bin %944, %aluResult_109, %aluResult_466 : i32
        %memRdata_467 = hw.struct_extract %253["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %946 = sv.read_inout %231 : !hw.inout<i1>
        %947 = comb.mux bin %946, %memRdata_108, %memRdata_467 : i32
        %memWdata_468 = hw.struct_extract %253["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %948 = sv.read_inout %231 : !hw.inout<i1>
        %949 = comb.mux bin %948, %memWdata_107, %memWdata_468 : i32
        %memAddr_469 = hw.struct_extract %253["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %950 = sv.read_inout %231 : !hw.inout<i1>
        %951 = comb.mux bin %950, %memAddr_106, %memAddr_469 : i32
        %rs2Data_470 = hw.struct_extract %253["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %952 = sv.read_inout %231 : !hw.inout<i1>
        %953 = comb.mux bin %952, %rs2Data, %rs2Data_470 : i32
        %rs1Data_471 = hw.struct_extract %253["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %954 = sv.read_inout %231 : !hw.inout<i1>
        %955 = comb.mux bin %954, %rs1Data, %rs1Data_471 : i32
        %rd_472 = hw.struct_extract %253["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %956 = sv.read_inout %231 : !hw.inout<i1>
        %957 = comb.mux bin %956, %rd_105, %rd_472 : i5
        %rs2_473 = hw.struct_extract %253["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %958 = sv.read_inout %231 : !hw.inout<i1>
        %959 = comb.mux bin %958, %rs2_104, %rs2_473 : i5
        %rs1_474 = hw.struct_extract %253["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %960 = sv.read_inout %231 : !hw.inout<i1>
        %961 = comb.mux bin %960, %rs1_103, %rs1_474 : i5
        %imm_475 = hw.struct_extract %253["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %962 = sv.read_inout %231 : !hw.inout<i1>
        %963 = comb.mux bin %962, %imm_4, %imm_475 : i32
        %aluOp_476 = hw.struct_extract %253["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %964 = sv.read_inout %231 : !hw.inout<i1>
        %965 = comb.mux bin %964, %aluOp_7, %aluOp_476 : i5
        %isSystem_477 = hw.struct_extract %253["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %966 = sv.read_inout %231 : !hw.inout<i1>
        %967 = comb.mux bin %966, %isSystem_102, %isSystem_477 : i1
        %isFence_478 = hw.struct_extract %253["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %968 = sv.read_inout %231 : !hw.inout<i1>
        %969 = comb.mux bin %968, %isFence_101, %isFence_478 : i1
        %isAUIPC_479 = hw.struct_extract %253["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %970 = sv.read_inout %231 : !hw.inout<i1>
        %971 = comb.mux bin %970, %isAUIPC_100, %isAUIPC_479 : i1
        %isLUI_480 = hw.struct_extract %253["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %972 = sv.read_inout %231 : !hw.inout<i1>
        %973 = comb.mux bin %972, %isLUI_99, %isLUI_480 : i1
        %isJALR_481 = hw.struct_extract %253["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %974 = sv.read_inout %231 : !hw.inout<i1>
        %975 = comb.mux bin %974, %isJALR_98, %isJALR_481 : i1
        %isJAL_482 = hw.struct_extract %253["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %976 = sv.read_inout %231 : !hw.inout<i1>
        %977 = comb.mux bin %976, %isJAL_97, %isJAL_482 : i1
        %isBranch_483 = hw.struct_extract %253["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %978 = sv.read_inout %231 : !hw.inout<i1>
        %979 = comb.mux bin %978, %isBranch_96, %isBranch_483 : i1
        %isStore_484 = hw.struct_extract %253["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %980 = sv.read_inout %231 : !hw.inout<i1>
        %981 = comb.mux bin %980, %isStore_5, %isStore_484 : i1
        %isLoad_485 = hw.struct_extract %253["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %982 = sv.read_inout %231 : !hw.inout<i1>
        %983 = comb.mux bin %982, %isLoad_6, %isLoad_485 : i1
        %isALU_486 = hw.struct_extract %253["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %984 = sv.read_inout %231 : !hw.inout<i1>
        %985 = comb.mux bin %984, %isALU_95, %isALU_486 : i1
        %instr_487 = hw.struct_extract %253["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %986 = sv.read_inout %231 : !hw.inout<i1>
        %987 = comb.mux bin %986, %instr_94, %instr_487 : i32
        %pc_488 = hw.struct_extract %253["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %988 = sv.read_inout %231 : !hw.inout<i1>
        %989 = comb.mux bin %988, %pc_93, %pc_488 : i32
        %valid_489 = hw.struct_extract %253["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %990 = sv.read_inout %231 : !hw.inout<i1>
        %991 = comb.mux bin %990, %valid_92, %valid_489 : i1
        %threadId_490 = hw.struct_extract %253["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %992 = sv.read_inout %231 : !hw.inout<i1>
        %993 = comb.mux bin %992, %threadId_91, %threadId_490 : i2
        %994 = hw.struct_create (%993, %991, %989, %987, %985, %983, %981, %979, %977, %975, %973, %971, %969, %967, %965, %963, %961, %959, %957, %955, %953, %951, %949, %947, %945) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %995 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %995, %994 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %c-1_i2_491 = hw.constant -1 : i2
        %996 = sv.read_inout %currentThread : !hw.inout<i2>
        %997 = comb.icmp bin eq %996, %c-1_i2_491 : i2
        %aluResult_492 = hw.struct_extract %255["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %998 = comb.mux bin %997, %aluResult_109, %aluResult_492 : i32
        %c-1_i2_493 = hw.constant -1 : i2
        %999 = sv.read_inout %currentThread : !hw.inout<i2>
        %1000 = comb.icmp bin eq %999, %c-1_i2_493 : i2
        %memRdata_494 = hw.struct_extract %255["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1001 = comb.mux bin %1000, %memRdata_108, %memRdata_494 : i32
        %c-1_i2_495 = hw.constant -1 : i2
        %1002 = sv.read_inout %currentThread : !hw.inout<i2>
        %1003 = comb.icmp bin eq %1002, %c-1_i2_495 : i2
        %memWdata_496 = hw.struct_extract %255["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1004 = comb.mux bin %1003, %memWdata_107, %memWdata_496 : i32
        %c-1_i2_497 = hw.constant -1 : i2
        %1005 = sv.read_inout %currentThread : !hw.inout<i2>
        %1006 = comb.icmp bin eq %1005, %c-1_i2_497 : i2
        %memAddr_498 = hw.struct_extract %255["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1007 = comb.mux bin %1006, %memAddr_106, %memAddr_498 : i32
        %c-1_i2_499 = hw.constant -1 : i2
        %1008 = sv.read_inout %currentThread : !hw.inout<i2>
        %1009 = comb.icmp bin eq %1008, %c-1_i2_499 : i2
        %rs2Data_500 = hw.struct_extract %255["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1010 = comb.mux bin %1009, %rs2Data, %rs2Data_500 : i32
        %c-1_i2_501 = hw.constant -1 : i2
        %1011 = sv.read_inout %currentThread : !hw.inout<i2>
        %1012 = comb.icmp bin eq %1011, %c-1_i2_501 : i2
        %rs1Data_502 = hw.struct_extract %255["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1013 = comb.mux bin %1012, %rs1Data, %rs1Data_502 : i32
        %c-1_i2_503 = hw.constant -1 : i2
        %1014 = sv.read_inout %currentThread : !hw.inout<i2>
        %1015 = comb.icmp bin eq %1014, %c-1_i2_503 : i2
        %rd_504 = hw.struct_extract %255["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1016 = comb.mux bin %1015, %rd_105, %rd_504 : i5
        %c-1_i2_505 = hw.constant -1 : i2
        %1017 = sv.read_inout %currentThread : !hw.inout<i2>
        %1018 = comb.icmp bin eq %1017, %c-1_i2_505 : i2
        %rs2_506 = hw.struct_extract %255["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1019 = comb.mux bin %1018, %rs2_104, %rs2_506 : i5
        %c-1_i2_507 = hw.constant -1 : i2
        %1020 = sv.read_inout %currentThread : !hw.inout<i2>
        %1021 = comb.icmp bin eq %1020, %c-1_i2_507 : i2
        %rs1_508 = hw.struct_extract %255["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1022 = comb.mux bin %1021, %rs1_103, %rs1_508 : i5
        %c-1_i2_509 = hw.constant -1 : i2
        %1023 = sv.read_inout %currentThread : !hw.inout<i2>
        %1024 = comb.icmp bin eq %1023, %c-1_i2_509 : i2
        %imm_510 = hw.struct_extract %255["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1025 = comb.mux bin %1024, %imm_4, %imm_510 : i32
        %c-1_i2_511 = hw.constant -1 : i2
        %1026 = sv.read_inout %currentThread : !hw.inout<i2>
        %1027 = comb.icmp bin eq %1026, %c-1_i2_511 : i2
        %aluOp_512 = hw.struct_extract %255["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1028 = comb.mux bin %1027, %aluOp_7, %aluOp_512 : i5
        %c-1_i2_513 = hw.constant -1 : i2
        %1029 = sv.read_inout %currentThread : !hw.inout<i2>
        %1030 = comb.icmp bin eq %1029, %c-1_i2_513 : i2
        %isSystem_514 = hw.struct_extract %255["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1031 = comb.mux bin %1030, %isSystem_102, %isSystem_514 : i1
        %c-1_i2_515 = hw.constant -1 : i2
        %1032 = sv.read_inout %currentThread : !hw.inout<i2>
        %1033 = comb.icmp bin eq %1032, %c-1_i2_515 : i2
        %isFence_516 = hw.struct_extract %255["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1034 = comb.mux bin %1033, %isFence_101, %isFence_516 : i1
        %c-1_i2_517 = hw.constant -1 : i2
        %1035 = sv.read_inout %currentThread : !hw.inout<i2>
        %1036 = comb.icmp bin eq %1035, %c-1_i2_517 : i2
        %isAUIPC_518 = hw.struct_extract %255["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1037 = comb.mux bin %1036, %isAUIPC_100, %isAUIPC_518 : i1
        %c-1_i2_519 = hw.constant -1 : i2
        %1038 = sv.read_inout %currentThread : !hw.inout<i2>
        %1039 = comb.icmp bin eq %1038, %c-1_i2_519 : i2
        %isLUI_520 = hw.struct_extract %255["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1040 = comb.mux bin %1039, %isLUI_99, %isLUI_520 : i1
        %c-1_i2_521 = hw.constant -1 : i2
        %1041 = sv.read_inout %currentThread : !hw.inout<i2>
        %1042 = comb.icmp bin eq %1041, %c-1_i2_521 : i2
        %isJALR_522 = hw.struct_extract %255["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1043 = comb.mux bin %1042, %isJALR_98, %isJALR_522 : i1
        %c-1_i2_523 = hw.constant -1 : i2
        %1044 = sv.read_inout %currentThread : !hw.inout<i2>
        %1045 = comb.icmp bin eq %1044, %c-1_i2_523 : i2
        %isJAL_524 = hw.struct_extract %255["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1046 = comb.mux bin %1045, %isJAL_97, %isJAL_524 : i1
        %c-1_i2_525 = hw.constant -1 : i2
        %1047 = sv.read_inout %currentThread : !hw.inout<i2>
        %1048 = comb.icmp bin eq %1047, %c-1_i2_525 : i2
        %isBranch_526 = hw.struct_extract %255["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1049 = comb.mux bin %1048, %isBranch_96, %isBranch_526 : i1
        %c-1_i2_527 = hw.constant -1 : i2
        %1050 = sv.read_inout %currentThread : !hw.inout<i2>
        %1051 = comb.icmp bin eq %1050, %c-1_i2_527 : i2
        %isStore_528 = hw.struct_extract %255["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1052 = comb.mux bin %1051, %isStore_5, %isStore_528 : i1
        %c-1_i2_529 = hw.constant -1 : i2
        %1053 = sv.read_inout %currentThread : !hw.inout<i2>
        %1054 = comb.icmp bin eq %1053, %c-1_i2_529 : i2
        %isLoad_530 = hw.struct_extract %255["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1055 = comb.mux bin %1054, %isLoad_6, %isLoad_530 : i1
        %c-1_i2_531 = hw.constant -1 : i2
        %1056 = sv.read_inout %currentThread : !hw.inout<i2>
        %1057 = comb.icmp bin eq %1056, %c-1_i2_531 : i2
        %isALU_532 = hw.struct_extract %255["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1058 = comb.mux bin %1057, %isALU_95, %isALU_532 : i1
        %c-1_i2_533 = hw.constant -1 : i2
        %1059 = sv.read_inout %currentThread : !hw.inout<i2>
        %1060 = comb.icmp bin eq %1059, %c-1_i2_533 : i2
        %instr_534 = hw.struct_extract %255["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1061 = comb.mux bin %1060, %instr_94, %instr_534 : i32
        %c-1_i2_535 = hw.constant -1 : i2
        %1062 = sv.read_inout %currentThread : !hw.inout<i2>
        %1063 = comb.icmp bin eq %1062, %c-1_i2_535 : i2
        %pc_536 = hw.struct_extract %255["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1064 = comb.mux bin %1063, %pc_93, %pc_536 : i32
        %c-1_i2_537 = hw.constant -1 : i2
        %1065 = sv.read_inout %currentThread : !hw.inout<i2>
        %1066 = comb.icmp bin eq %1065, %c-1_i2_537 : i2
        %valid_538 = hw.struct_extract %255["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1067 = comb.mux bin %1066, %valid_92, %valid_538 : i1
        %c-1_i2_539 = hw.constant -1 : i2
        %1068 = sv.read_inout %currentThread : !hw.inout<i2>
        %1069 = comb.icmp bin eq %1068, %c-1_i2_539 : i2
        %threadId_540 = hw.struct_extract %255["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1070 = comb.mux bin %1069, %threadId_91, %threadId_540 : i2
        %1071 = hw.struct_create (%1070, %1067, %1064, %1061, %1058, %1055, %1052, %1049, %1046, %1043, %1040, %1037, %1034, %1031, %1028, %1025, %1022, %1019, %1016, %1013, %1010, %1007, %1004, %1001, %998) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1072 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %1072, %1071 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_541 = hw.struct_extract %257["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1073 = sv.read_inout %229 : !hw.inout<i1>
        %1074 = comb.mux bin %1073, %aluResult_33, %aluResult_541 : i32
        %memRdata_542 = hw.struct_extract %257["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1075 = sv.read_inout %229 : !hw.inout<i1>
        %1076 = comb.mux bin %1075, %memRdata_35, %memRdata_542 : i32
        %memWdata_543 = hw.struct_extract %257["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1077 = sv.read_inout %229 : !hw.inout<i1>
        %1078 = comb.mux bin %1077, %memWdata_38, %memWdata_543 : i32
        %memAddr_544 = hw.struct_extract %257["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1079 = sv.read_inout %229 : !hw.inout<i1>
        %1080 = comb.mux bin %1079, %memAddr_39, %memAddr_544 : i32
        %rs2Data_545 = hw.struct_extract %257["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1081 = sv.read_inout %229 : !hw.inout<i1>
        %1082 = comb.mux bin %1081, %rs2Data_125, %rs2Data_545 : i32
        %rs1Data_546 = hw.struct_extract %257["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1083 = sv.read_inout %229 : !hw.inout<i1>
        %1084 = comb.mux bin %1083, %rs1Data_124, %rs1Data_546 : i32
        %rd_547 = hw.struct_extract %257["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1085 = sv.read_inout %229 : !hw.inout<i1>
        %1086 = comb.mux bin %1085, %rd_32, %rd_547 : i5
        %rs2_548 = hw.struct_extract %257["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1087 = sv.read_inout %229 : !hw.inout<i1>
        %1088 = comb.mux bin %1087, %rs2_123, %rs2_548 : i5
        %rs1_549 = hw.struct_extract %257["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1089 = sv.read_inout %229 : !hw.inout<i1>
        %1090 = comb.mux bin %1089, %rs1_122, %rs1_549 : i5
        %imm_550 = hw.struct_extract %257["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1091 = sv.read_inout %229 : !hw.inout<i1>
        %1092 = comb.mux bin %1091, %imm_121, %imm_550 : i32
        %aluOp_551 = hw.struct_extract %257["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1093 = sv.read_inout %229 : !hw.inout<i1>
        %1094 = comb.mux bin %1093, %aluOp_120, %aluOp_551 : i5
        %isSystem_552 = hw.struct_extract %257["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1095 = sv.read_inout %229 : !hw.inout<i1>
        %1096 = comb.mux bin %1095, %isSystem_119, %isSystem_552 : i1
        %isFence_553 = hw.struct_extract %257["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1097 = sv.read_inout %229 : !hw.inout<i1>
        %1098 = comb.mux bin %1097, %isFence_118, %isFence_553 : i1
        %isAUIPC_554 = hw.struct_extract %257["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1099 = sv.read_inout %229 : !hw.inout<i1>
        %1100 = comb.mux bin %1099, %isAUIPC_117, %isAUIPC_554 : i1
        %isLUI_555 = hw.struct_extract %257["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1101 = sv.read_inout %229 : !hw.inout<i1>
        %1102 = comb.mux bin %1101, %isLUI_116, %isLUI_555 : i1
        %isJALR_556 = hw.struct_extract %257["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1103 = sv.read_inout %229 : !hw.inout<i1>
        %1104 = comb.mux bin %1103, %isJALR_115, %isJALR_556 : i1
        %isJAL_557 = hw.struct_extract %257["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1105 = sv.read_inout %229 : !hw.inout<i1>
        %1106 = comb.mux bin %1105, %isJAL_114, %isJAL_557 : i1
        %isBranch_558 = hw.struct_extract %257["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1107 = sv.read_inout %229 : !hw.inout<i1>
        %1108 = comb.mux bin %1107, %isBranch_113, %isBranch_558 : i1
        %isStore_559 = hw.struct_extract %257["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1109 = sv.read_inout %229 : !hw.inout<i1>
        %1110 = comb.mux bin %1109, %isStore_37, %isStore_559 : i1
        %isLoad_560 = hw.struct_extract %257["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1111 = sv.read_inout %229 : !hw.inout<i1>
        %1112 = comb.mux bin %1111, %isLoad_34, %isLoad_560 : i1
        %isALU_561 = hw.struct_extract %257["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1113 = sv.read_inout %229 : !hw.inout<i1>
        %1114 = comb.mux bin %1113, %isALU_31, %isALU_561 : i1
        %instr_562 = hw.struct_extract %257["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1115 = sv.read_inout %229 : !hw.inout<i1>
        %1116 = comb.mux bin %1115, %instr_112, %instr_562 : i32
        %pc_563 = hw.struct_extract %257["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1117 = sv.read_inout %229 : !hw.inout<i1>
        %1118 = comb.mux bin %1117, %pc_111, %pc_563 : i32
        %valid_564 = hw.struct_extract %257["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1119 = sv.read_inout %229 : !hw.inout<i1>
        %1120 = comb.mux bin %1119, %valid_36, %valid_564 : i1
        %threadId_565 = hw.struct_extract %257["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1121 = sv.read_inout %229 : !hw.inout<i1>
        %1122 = comb.mux bin %1121, %threadId_110, %threadId_565 : i2
        %1123 = hw.struct_create (%1122, %1120, %1118, %1116, %1114, %1112, %1110, %1108, %1106, %1104, %1102, %1100, %1098, %1096, %1094, %1092, %1090, %1088, %1086, %1084, %1082, %1080, %1078, %1076, %1074) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1124 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %1124, %1123 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_566 = hw.struct_extract %259["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1125 = sv.read_inout %230 : !hw.inout<i1>
        %1126 = comb.mux bin %1125, %aluResult_33, %aluResult_566 : i32
        %memRdata_567 = hw.struct_extract %259["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1127 = sv.read_inout %230 : !hw.inout<i1>
        %1128 = comb.mux bin %1127, %memRdata_35, %memRdata_567 : i32
        %memWdata_568 = hw.struct_extract %259["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1129 = sv.read_inout %230 : !hw.inout<i1>
        %1130 = comb.mux bin %1129, %memWdata_38, %memWdata_568 : i32
        %memAddr_569 = hw.struct_extract %259["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1131 = sv.read_inout %230 : !hw.inout<i1>
        %1132 = comb.mux bin %1131, %memAddr_39, %memAddr_569 : i32
        %rs2Data_570 = hw.struct_extract %259["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1133 = sv.read_inout %230 : !hw.inout<i1>
        %1134 = comb.mux bin %1133, %rs2Data_125, %rs2Data_570 : i32
        %rs1Data_571 = hw.struct_extract %259["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1135 = sv.read_inout %230 : !hw.inout<i1>
        %1136 = comb.mux bin %1135, %rs1Data_124, %rs1Data_571 : i32
        %rd_572 = hw.struct_extract %259["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1137 = sv.read_inout %230 : !hw.inout<i1>
        %1138 = comb.mux bin %1137, %rd_32, %rd_572 : i5
        %rs2_573 = hw.struct_extract %259["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1139 = sv.read_inout %230 : !hw.inout<i1>
        %1140 = comb.mux bin %1139, %rs2_123, %rs2_573 : i5
        %rs1_574 = hw.struct_extract %259["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1141 = sv.read_inout %230 : !hw.inout<i1>
        %1142 = comb.mux bin %1141, %rs1_122, %rs1_574 : i5
        %imm_575 = hw.struct_extract %259["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1143 = sv.read_inout %230 : !hw.inout<i1>
        %1144 = comb.mux bin %1143, %imm_121, %imm_575 : i32
        %aluOp_576 = hw.struct_extract %259["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1145 = sv.read_inout %230 : !hw.inout<i1>
        %1146 = comb.mux bin %1145, %aluOp_120, %aluOp_576 : i5
        %isSystem_577 = hw.struct_extract %259["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1147 = sv.read_inout %230 : !hw.inout<i1>
        %1148 = comb.mux bin %1147, %isSystem_119, %isSystem_577 : i1
        %isFence_578 = hw.struct_extract %259["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1149 = sv.read_inout %230 : !hw.inout<i1>
        %1150 = comb.mux bin %1149, %isFence_118, %isFence_578 : i1
        %isAUIPC_579 = hw.struct_extract %259["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1151 = sv.read_inout %230 : !hw.inout<i1>
        %1152 = comb.mux bin %1151, %isAUIPC_117, %isAUIPC_579 : i1
        %isLUI_580 = hw.struct_extract %259["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1153 = sv.read_inout %230 : !hw.inout<i1>
        %1154 = comb.mux bin %1153, %isLUI_116, %isLUI_580 : i1
        %isJALR_581 = hw.struct_extract %259["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1155 = sv.read_inout %230 : !hw.inout<i1>
        %1156 = comb.mux bin %1155, %isJALR_115, %isJALR_581 : i1
        %isJAL_582 = hw.struct_extract %259["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1157 = sv.read_inout %230 : !hw.inout<i1>
        %1158 = comb.mux bin %1157, %isJAL_114, %isJAL_582 : i1
        %isBranch_583 = hw.struct_extract %259["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1159 = sv.read_inout %230 : !hw.inout<i1>
        %1160 = comb.mux bin %1159, %isBranch_113, %isBranch_583 : i1
        %isStore_584 = hw.struct_extract %259["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1161 = sv.read_inout %230 : !hw.inout<i1>
        %1162 = comb.mux bin %1161, %isStore_37, %isStore_584 : i1
        %isLoad_585 = hw.struct_extract %259["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1163 = sv.read_inout %230 : !hw.inout<i1>
        %1164 = comb.mux bin %1163, %isLoad_34, %isLoad_585 : i1
        %isALU_586 = hw.struct_extract %259["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1165 = sv.read_inout %230 : !hw.inout<i1>
        %1166 = comb.mux bin %1165, %isALU_31, %isALU_586 : i1
        %instr_587 = hw.struct_extract %259["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1167 = sv.read_inout %230 : !hw.inout<i1>
        %1168 = comb.mux bin %1167, %instr_112, %instr_587 : i32
        %pc_588 = hw.struct_extract %259["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1169 = sv.read_inout %230 : !hw.inout<i1>
        %1170 = comb.mux bin %1169, %pc_111, %pc_588 : i32
        %valid_589 = hw.struct_extract %259["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1171 = sv.read_inout %230 : !hw.inout<i1>
        %1172 = comb.mux bin %1171, %valid_36, %valid_589 : i1
        %threadId_590 = hw.struct_extract %259["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1173 = sv.read_inout %230 : !hw.inout<i1>
        %1174 = comb.mux bin %1173, %threadId_110, %threadId_590 : i2
        %1175 = hw.struct_create (%1174, %1172, %1170, %1168, %1166, %1164, %1162, %1160, %1158, %1156, %1154, %1152, %1150, %1148, %1146, %1144, %1142, %1140, %1138, %1136, %1134, %1132, %1130, %1128, %1126) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1176 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %1176, %1175 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %aluResult_591 = hw.struct_extract %261["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1177 = sv.read_inout %231 : !hw.inout<i1>
        %1178 = comb.mux bin %1177, %aluResult_33, %aluResult_591 : i32
        %memRdata_592 = hw.struct_extract %261["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1179 = sv.read_inout %231 : !hw.inout<i1>
        %1180 = comb.mux bin %1179, %memRdata_35, %memRdata_592 : i32
        %memWdata_593 = hw.struct_extract %261["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1181 = sv.read_inout %231 : !hw.inout<i1>
        %1182 = comb.mux bin %1181, %memWdata_38, %memWdata_593 : i32
        %memAddr_594 = hw.struct_extract %261["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1183 = sv.read_inout %231 : !hw.inout<i1>
        %1184 = comb.mux bin %1183, %memAddr_39, %memAddr_594 : i32
        %rs2Data_595 = hw.struct_extract %261["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1185 = sv.read_inout %231 : !hw.inout<i1>
        %1186 = comb.mux bin %1185, %rs2Data_125, %rs2Data_595 : i32
        %rs1Data_596 = hw.struct_extract %261["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1187 = sv.read_inout %231 : !hw.inout<i1>
        %1188 = comb.mux bin %1187, %rs1Data_124, %rs1Data_596 : i32
        %rd_597 = hw.struct_extract %261["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1189 = sv.read_inout %231 : !hw.inout<i1>
        %1190 = comb.mux bin %1189, %rd_32, %rd_597 : i5
        %rs2_598 = hw.struct_extract %261["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1191 = sv.read_inout %231 : !hw.inout<i1>
        %1192 = comb.mux bin %1191, %rs2_123, %rs2_598 : i5
        %rs1_599 = hw.struct_extract %261["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1193 = sv.read_inout %231 : !hw.inout<i1>
        %1194 = comb.mux bin %1193, %rs1_122, %rs1_599 : i5
        %imm_600 = hw.struct_extract %261["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1195 = sv.read_inout %231 : !hw.inout<i1>
        %1196 = comb.mux bin %1195, %imm_121, %imm_600 : i32
        %aluOp_601 = hw.struct_extract %261["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1197 = sv.read_inout %231 : !hw.inout<i1>
        %1198 = comb.mux bin %1197, %aluOp_120, %aluOp_601 : i5
        %isSystem_602 = hw.struct_extract %261["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1199 = sv.read_inout %231 : !hw.inout<i1>
        %1200 = comb.mux bin %1199, %isSystem_119, %isSystem_602 : i1
        %isFence_603 = hw.struct_extract %261["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1201 = sv.read_inout %231 : !hw.inout<i1>
        %1202 = comb.mux bin %1201, %isFence_118, %isFence_603 : i1
        %isAUIPC_604 = hw.struct_extract %261["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1203 = sv.read_inout %231 : !hw.inout<i1>
        %1204 = comb.mux bin %1203, %isAUIPC_117, %isAUIPC_604 : i1
        %isLUI_605 = hw.struct_extract %261["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1205 = sv.read_inout %231 : !hw.inout<i1>
        %1206 = comb.mux bin %1205, %isLUI_116, %isLUI_605 : i1
        %isJALR_606 = hw.struct_extract %261["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1207 = sv.read_inout %231 : !hw.inout<i1>
        %1208 = comb.mux bin %1207, %isJALR_115, %isJALR_606 : i1
        %isJAL_607 = hw.struct_extract %261["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1209 = sv.read_inout %231 : !hw.inout<i1>
        %1210 = comb.mux bin %1209, %isJAL_114, %isJAL_607 : i1
        %isBranch_608 = hw.struct_extract %261["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1211 = sv.read_inout %231 : !hw.inout<i1>
        %1212 = comb.mux bin %1211, %isBranch_113, %isBranch_608 : i1
        %isStore_609 = hw.struct_extract %261["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1213 = sv.read_inout %231 : !hw.inout<i1>
        %1214 = comb.mux bin %1213, %isStore_37, %isStore_609 : i1
        %isLoad_610 = hw.struct_extract %261["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1215 = sv.read_inout %231 : !hw.inout<i1>
        %1216 = comb.mux bin %1215, %isLoad_34, %isLoad_610 : i1
        %isALU_611 = hw.struct_extract %261["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1217 = sv.read_inout %231 : !hw.inout<i1>
        %1218 = comb.mux bin %1217, %isALU_31, %isALU_611 : i1
        %instr_612 = hw.struct_extract %261["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1219 = sv.read_inout %231 : !hw.inout<i1>
        %1220 = comb.mux bin %1219, %instr_112, %instr_612 : i32
        %pc_613 = hw.struct_extract %261["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1221 = sv.read_inout %231 : !hw.inout<i1>
        %1222 = comb.mux bin %1221, %pc_111, %pc_613 : i32
        %valid_614 = hw.struct_extract %261["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1223 = sv.read_inout %231 : !hw.inout<i1>
        %1224 = comb.mux bin %1223, %valid_36, %valid_614 : i1
        %threadId_615 = hw.struct_extract %261["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1225 = sv.read_inout %231 : !hw.inout<i1>
        %1226 = comb.mux bin %1225, %threadId_110, %threadId_615 : i2
        %1227 = hw.struct_create (%1226, %1224, %1222, %1220, %1218, %1216, %1214, %1212, %1210, %1208, %1206, %1204, %1202, %1200, %1198, %1196, %1194, %1192, %1190, %1188, %1186, %1184, %1182, %1180, %1178) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1228 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %1228, %1227 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %c-1_i2_616 = hw.constant -1 : i2
        %1229 = sv.read_inout %currentThread : !hw.inout<i2>
        %1230 = comb.icmp bin eq %1229, %c-1_i2_616 : i2
        %aluResult_617 = hw.struct_extract %263["aluResult"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1231 = comb.mux bin %1230, %aluResult_33, %aluResult_617 : i32
        %c-1_i2_618 = hw.constant -1 : i2
        %1232 = sv.read_inout %currentThread : !hw.inout<i2>
        %1233 = comb.icmp bin eq %1232, %c-1_i2_618 : i2
        %memRdata_619 = hw.struct_extract %263["memRdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1234 = comb.mux bin %1233, %memRdata_35, %memRdata_619 : i32
        %c-1_i2_620 = hw.constant -1 : i2
        %1235 = sv.read_inout %currentThread : !hw.inout<i2>
        %1236 = comb.icmp bin eq %1235, %c-1_i2_620 : i2
        %memWdata_621 = hw.struct_extract %263["memWdata"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1237 = comb.mux bin %1236, %memWdata_38, %memWdata_621 : i32
        %c-1_i2_622 = hw.constant -1 : i2
        %1238 = sv.read_inout %currentThread : !hw.inout<i2>
        %1239 = comb.icmp bin eq %1238, %c-1_i2_622 : i2
        %memAddr_623 = hw.struct_extract %263["memAddr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1240 = comb.mux bin %1239, %memAddr_39, %memAddr_623 : i32
        %c-1_i2_624 = hw.constant -1 : i2
        %1241 = sv.read_inout %currentThread : !hw.inout<i2>
        %1242 = comb.icmp bin eq %1241, %c-1_i2_624 : i2
        %rs2Data_625 = hw.struct_extract %263["rs2Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1243 = comb.mux bin %1242, %rs2Data_125, %rs2Data_625 : i32
        %c-1_i2_626 = hw.constant -1 : i2
        %1244 = sv.read_inout %currentThread : !hw.inout<i2>
        %1245 = comb.icmp bin eq %1244, %c-1_i2_626 : i2
        %rs1Data_627 = hw.struct_extract %263["rs1Data"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1246 = comb.mux bin %1245, %rs1Data_124, %rs1Data_627 : i32
        %c-1_i2_628 = hw.constant -1 : i2
        %1247 = sv.read_inout %currentThread : !hw.inout<i2>
        %1248 = comb.icmp bin eq %1247, %c-1_i2_628 : i2
        %rd_629 = hw.struct_extract %263["rd"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1249 = comb.mux bin %1248, %rd_32, %rd_629 : i5
        %c-1_i2_630 = hw.constant -1 : i2
        %1250 = sv.read_inout %currentThread : !hw.inout<i2>
        %1251 = comb.icmp bin eq %1250, %c-1_i2_630 : i2
        %rs2_631 = hw.struct_extract %263["rs2"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1252 = comb.mux bin %1251, %rs2_123, %rs2_631 : i5
        %c-1_i2_632 = hw.constant -1 : i2
        %1253 = sv.read_inout %currentThread : !hw.inout<i2>
        %1254 = comb.icmp bin eq %1253, %c-1_i2_632 : i2
        %rs1_633 = hw.struct_extract %263["rs1"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1255 = comb.mux bin %1254, %rs1_122, %rs1_633 : i5
        %c-1_i2_634 = hw.constant -1 : i2
        %1256 = sv.read_inout %currentThread : !hw.inout<i2>
        %1257 = comb.icmp bin eq %1256, %c-1_i2_634 : i2
        %imm_635 = hw.struct_extract %263["imm"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1258 = comb.mux bin %1257, %imm_121, %imm_635 : i32
        %c-1_i2_636 = hw.constant -1 : i2
        %1259 = sv.read_inout %currentThread : !hw.inout<i2>
        %1260 = comb.icmp bin eq %1259, %c-1_i2_636 : i2
        %aluOp_637 = hw.struct_extract %263["aluOp"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1261 = comb.mux bin %1260, %aluOp_120, %aluOp_637 : i5
        %c-1_i2_638 = hw.constant -1 : i2
        %1262 = sv.read_inout %currentThread : !hw.inout<i2>
        %1263 = comb.icmp bin eq %1262, %c-1_i2_638 : i2
        %isSystem_639 = hw.struct_extract %263["isSystem"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1264 = comb.mux bin %1263, %isSystem_119, %isSystem_639 : i1
        %c-1_i2_640 = hw.constant -1 : i2
        %1265 = sv.read_inout %currentThread : !hw.inout<i2>
        %1266 = comb.icmp bin eq %1265, %c-1_i2_640 : i2
        %isFence_641 = hw.struct_extract %263["isFence"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1267 = comb.mux bin %1266, %isFence_118, %isFence_641 : i1
        %c-1_i2_642 = hw.constant -1 : i2
        %1268 = sv.read_inout %currentThread : !hw.inout<i2>
        %1269 = comb.icmp bin eq %1268, %c-1_i2_642 : i2
        %isAUIPC_643 = hw.struct_extract %263["isAUIPC"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1270 = comb.mux bin %1269, %isAUIPC_117, %isAUIPC_643 : i1
        %c-1_i2_644 = hw.constant -1 : i2
        %1271 = sv.read_inout %currentThread : !hw.inout<i2>
        %1272 = comb.icmp bin eq %1271, %c-1_i2_644 : i2
        %isLUI_645 = hw.struct_extract %263["isLUI"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1273 = comb.mux bin %1272, %isLUI_116, %isLUI_645 : i1
        %c-1_i2_646 = hw.constant -1 : i2
        %1274 = sv.read_inout %currentThread : !hw.inout<i2>
        %1275 = comb.icmp bin eq %1274, %c-1_i2_646 : i2
        %isJALR_647 = hw.struct_extract %263["isJALR"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1276 = comb.mux bin %1275, %isJALR_115, %isJALR_647 : i1
        %c-1_i2_648 = hw.constant -1 : i2
        %1277 = sv.read_inout %currentThread : !hw.inout<i2>
        %1278 = comb.icmp bin eq %1277, %c-1_i2_648 : i2
        %isJAL_649 = hw.struct_extract %263["isJAL"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1279 = comb.mux bin %1278, %isJAL_114, %isJAL_649 : i1
        %c-1_i2_650 = hw.constant -1 : i2
        %1280 = sv.read_inout %currentThread : !hw.inout<i2>
        %1281 = comb.icmp bin eq %1280, %c-1_i2_650 : i2
        %isBranch_651 = hw.struct_extract %263["isBranch"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1282 = comb.mux bin %1281, %isBranch_113, %isBranch_651 : i1
        %c-1_i2_652 = hw.constant -1 : i2
        %1283 = sv.read_inout %currentThread : !hw.inout<i2>
        %1284 = comb.icmp bin eq %1283, %c-1_i2_652 : i2
        %isStore_653 = hw.struct_extract %263["isStore"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1285 = comb.mux bin %1284, %isStore_37, %isStore_653 : i1
        %c-1_i2_654 = hw.constant -1 : i2
        %1286 = sv.read_inout %currentThread : !hw.inout<i2>
        %1287 = comb.icmp bin eq %1286, %c-1_i2_654 : i2
        %isLoad_655 = hw.struct_extract %263["isLoad"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1288 = comb.mux bin %1287, %isLoad_34, %isLoad_655 : i1
        %c-1_i2_656 = hw.constant -1 : i2
        %1289 = sv.read_inout %currentThread : !hw.inout<i2>
        %1290 = comb.icmp bin eq %1289, %c-1_i2_656 : i2
        %isALU_657 = hw.struct_extract %263["isALU"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1291 = comb.mux bin %1290, %isALU_31, %isALU_657 : i1
        %c-1_i2_658 = hw.constant -1 : i2
        %1292 = sv.read_inout %currentThread : !hw.inout<i2>
        %1293 = comb.icmp bin eq %1292, %c-1_i2_658 : i2
        %instr_659 = hw.struct_extract %263["instr"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1294 = comb.mux bin %1293, %instr_112, %instr_659 : i32
        %c-1_i2_660 = hw.constant -1 : i2
        %1295 = sv.read_inout %currentThread : !hw.inout<i2>
        %1296 = comb.icmp bin eq %1295, %c-1_i2_660 : i2
        %pc_661 = hw.struct_extract %263["pc"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1297 = comb.mux bin %1296, %pc_111, %pc_661 : i32
        %c-1_i2_662 = hw.constant -1 : i2
        %1298 = sv.read_inout %currentThread : !hw.inout<i2>
        %1299 = comb.icmp bin eq %1298, %c-1_i2_662 : i2
        %valid_663 = hw.struct_extract %263["valid"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1300 = comb.mux bin %1299, %valid_36, %valid_663 : i1
        %c-1_i2_664 = hw.constant -1 : i2
        %1301 = sv.read_inout %currentThread : !hw.inout<i2>
        %1302 = comb.icmp bin eq %1301, %c-1_i2_664 : i2
        %threadId_665 = hw.struct_extract %263["threadId"] : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1303 = comb.mux bin %1302, %threadId_110, %threadId_665 : i2
        %1304 = hw.struct_create (%1303, %1300, %1297, %1294, %1291, %1288, %1285, %1282, %1279, %1276, %1273, %1270, %1267, %1264, %1261, %1258, %1255, %1252, %1249, %1246, %1243, %1240, %1237, %1234, %1231) : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
        %1305 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
        sv.passign %1305, %1304 : !hw.struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>
      }
    }
    sv.ifdef  @ENABLE_INITIAL_REG_ {
      sv.ordered {
        sv.ifdef  @FIRRTL_BEFORE_INITIAL {
          sv.verbatim "`FIRRTL_BEFORE_INITIAL"
        }
        sv.initial {
          %_RANDOM = sv.logic {hw.verilogName = "_RANDOM"} : !hw.inout<uarray<165xi32>>
          sv.ifdef.procedural  @INIT_RANDOM_PROLOG_ {
            sv.verbatim "`INIT_RANDOM_PROLOG_"
          }
          sv.ifdef.procedural  @RANDOMIZE_REG_INIT {
            %c-92_i8 = hw.constant -92 : i8
            %c-93_i8 = hw.constant -93 : i8
            %c-94_i8 = hw.constant -94 : i8
            %c-95_i8 = hw.constant -95 : i8
            %c-96_i8 = hw.constant -96 : i8
            %c-97_i8 = hw.constant -97 : i8
            %c-98_i8 = hw.constant -98 : i8
            %c-99_i8 = hw.constant -99 : i8
            %c-100_i8 = hw.constant -100 : i8
            %c-101_i8 = hw.constant -101 : i8
            %c-102_i8 = hw.constant -102 : i8
            %c-103_i8 = hw.constant -103 : i8
            %c-104_i8 = hw.constant -104 : i8
            %c-105_i8 = hw.constant -105 : i8
            %c-106_i8 = hw.constant -106 : i8
            %c-107_i8 = hw.constant -107 : i8
            %c-108_i8 = hw.constant -108 : i8
            %c-109_i8 = hw.constant -109 : i8
            %c-110_i8 = hw.constant -110 : i8
            %c-111_i8 = hw.constant -111 : i8
            %c-112_i8 = hw.constant -112 : i8
            %c-113_i8 = hw.constant -113 : i8
            %c-114_i8 = hw.constant -114 : i8
            %c-115_i8 = hw.constant -115 : i8
            %c-116_i8 = hw.constant -116 : i8
            %c-117_i8 = hw.constant -117 : i8
            %c-118_i8 = hw.constant -118 : i8
            %c-119_i8 = hw.constant -119 : i8
            %c-120_i8 = hw.constant -120 : i8
            %c-121_i8 = hw.constant -121 : i8
            %c-122_i8 = hw.constant -122 : i8
            %c-123_i8 = hw.constant -123 : i8
            %c-124_i8 = hw.constant -124 : i8
            %c-125_i8 = hw.constant -125 : i8
            %c-126_i8 = hw.constant -126 : i8
            %c-127_i8 = hw.constant -127 : i8
            %c-128_i8 = hw.constant -128 : i8
            %c127_i8 = hw.constant 127 : i8
            %c126_i8 = hw.constant 126 : i8
            %c125_i8 = hw.constant 125 : i8
            %c124_i8 = hw.constant 124 : i8
            %c123_i8 = hw.constant 123 : i8
            %c122_i8 = hw.constant 122 : i8
            %c121_i8 = hw.constant 121 : i8
            %c120_i8 = hw.constant 120 : i8
            %c119_i8 = hw.constant 119 : i8
            %c118_i8 = hw.constant 118 : i8
            %c117_i8 = hw.constant 117 : i8
            %c116_i8 = hw.constant 116 : i8
            %c115_i8 = hw.constant 115 : i8
            %c114_i8 = hw.constant 114 : i8
            %c113_i8 = hw.constant 113 : i8
            %c112_i8 = hw.constant 112 : i8
            %c111_i8 = hw.constant 111 : i8
            %c110_i8 = hw.constant 110 : i8
            %c109_i8 = hw.constant 109 : i8
            %c108_i8 = hw.constant 108 : i8
            %c107_i8 = hw.constant 107 : i8
            %c106_i8 = hw.constant 106 : i8
            %c105_i8 = hw.constant 105 : i8
            %c104_i8 = hw.constant 104 : i8
            %c103_i8 = hw.constant 103 : i8
            %c102_i8 = hw.constant 102 : i8
            %c101_i8 = hw.constant 101 : i8
            %c100_i8 = hw.constant 100 : i8
            %c99_i8 = hw.constant 99 : i8
            %c98_i8 = hw.constant 98 : i8
            %c97_i8 = hw.constant 97 : i8
            %c96_i8 = hw.constant 96 : i8
            %c95_i8 = hw.constant 95 : i8
            %c94_i8 = hw.constant 94 : i8
            %c93_i8 = hw.constant 93 : i8
            %c92_i8 = hw.constant 92 : i8
            %c91_i8 = hw.constant 91 : i8
            %c90_i8 = hw.constant 90 : i8
            %c89_i8 = hw.constant 89 : i8
            %c88_i8 = hw.constant 88 : i8
            %c87_i8 = hw.constant 87 : i8
            %c86_i8 = hw.constant 86 : i8
            %c85_i8 = hw.constant 85 : i8
            %c84_i8 = hw.constant 84 : i8
            %c83_i8 = hw.constant 83 : i8
            %c82_i8 = hw.constant 82 : i8
            %c81_i8 = hw.constant 81 : i8
            %c80_i8 = hw.constant 80 : i8
            %c79_i8 = hw.constant 79 : i8
            %c78_i8 = hw.constant 78 : i8
            %c77_i8 = hw.constant 77 : i8
            %c76_i8 = hw.constant 76 : i8
            %c75_i8 = hw.constant 75 : i8
            %c74_i8 = hw.constant 74 : i8
            %c73_i8 = hw.constant 73 : i8
            %c72_i8 = hw.constant 72 : i8
            %c71_i8 = hw.constant 71 : i8
            %c70_i8 = hw.constant 70 : i8
            %c69_i8 = hw.constant 69 : i8
            %c68_i8 = hw.constant 68 : i8
            %c67_i8 = hw.constant 67 : i8
            %c66_i8 = hw.constant 66 : i8
            %c65_i8 = hw.constant 65 : i8
            %c64_i8 = hw.constant 64 : i8
            %c63_i8 = hw.constant 63 : i8
            %c62_i8 = hw.constant 62 : i8
            %c61_i8 = hw.constant 61 : i8
            %c60_i8 = hw.constant 60 : i8
            %c59_i8 = hw.constant 59 : i8
            %c58_i8 = hw.constant 58 : i8
            %c57_i8 = hw.constant 57 : i8
            %c56_i8 = hw.constant 56 : i8
            %c55_i8 = hw.constant 55 : i8
            %c54_i8 = hw.constant 54 : i8
            %c53_i8 = hw.constant 53 : i8
            %c52_i8 = hw.constant 52 : i8
            %c51_i8 = hw.constant 51 : i8
            %c50_i8 = hw.constant 50 : i8
            %c49_i8 = hw.constant 49 : i8
            %c48_i8 = hw.constant 48 : i8
            %c47_i8 = hw.constant 47 : i8
            %c46_i8 = hw.constant 46 : i8
            %c45_i8 = hw.constant 45 : i8
            %c44_i8 = hw.constant 44 : i8
            %c43_i8 = hw.constant 43 : i8
            %c42_i8 = hw.constant 42 : i8
            %c41_i8 = hw.constant 41 : i8
            %c40_i8 = hw.constant 40 : i8
            %c39_i8 = hw.constant 39 : i8
            %c38_i8 = hw.constant 38 : i8
            %c37_i8 = hw.constant 37 : i8
            %c36_i8 = hw.constant 36 : i8
            %c35_i8 = hw.constant 35 : i8
            %c34_i8 = hw.constant 34 : i8
            %c33_i8 = hw.constant 33 : i8
            %c32_i8 = hw.constant 32 : i8
            %c31_i8 = hw.constant 31 : i8
            %c30_i8 = hw.constant 30 : i8
            %c29_i8 = hw.constant 29 : i8
            %c28_i8 = hw.constant 28 : i8
            %c27_i8 = hw.constant 27 : i8
            %c26_i8 = hw.constant 26 : i8
            %c25_i8 = hw.constant 25 : i8
            %c24_i8 = hw.constant 24 : i8
            %c23_i8 = hw.constant 23 : i8
            %c22_i8 = hw.constant 22 : i8
            %c21_i8 = hw.constant 21 : i8
            %c20_i8 = hw.constant 20 : i8
            %c19_i8 = hw.constant 19 : i8
            %c18_i8 = hw.constant 18 : i8
            %c17_i8 = hw.constant 17 : i8
            %c16_i8 = hw.constant 16 : i8
            %c15_i8 = hw.constant 15 : i8
            %c14_i8 = hw.constant 14 : i8
            %c13_i8 = hw.constant 13 : i8
            %c12_i8 = hw.constant 12 : i8
            %c11_i8 = hw.constant 11 : i8
            %c10_i8 = hw.constant 10 : i8
            %c9_i8 = hw.constant 9 : i8
            %c8_i8 = hw.constant 8 : i8
            %c7_i8 = hw.constant 7 : i8
            %c6_i8 = hw.constant 6 : i8
            %c5_i8 = hw.constant 5 : i8
            %c4_i8 = hw.constant 4 : i8
            %c3_i8 = hw.constant 3 : i8
            %c2_i8 = hw.constant 2 : i8
            %c1_i8 = hw.constant 1 : i8
            %c-91_i8 = hw.constant -91 : i8
            %c0_i8 = hw.constant 0 : i8
            %c0_i2 = hw.constant 0 : i2
            %c1_i2 = hw.constant 1 : i2
            %c-2_i2 = hw.constant -2 : i2
            %c-1_i2 = hw.constant -1 : i2
            sv.for %i = %c0_i8 to %c-91_i8 step %c1_i8 : i8 {
              %RANDOM = sv.macro.ref.expr.se @RANDOM() : () -> i32
              %2887 = sv.array_index_inout %_RANDOM[%i] : !hw.inout<uarray<165xi32>>, i8
              sv.bpassign %2887, %RANDOM : i32
            } {hw.verilogName = "i"}
            %229 = sv.array_index_inout %_RANDOM[%c0_i8] : !hw.inout<uarray<165xi32>>, i8
            %230 = sv.read_inout %229 : !hw.inout<i32>
            %231 = comb.extract %230 from 0 : (i32) -> i2
            sv.bpassign %currentThread, %231 : i2
            %232 = sv.array_index_inout %_RANDOM[%c0_i8] : !hw.inout<uarray<165xi32>>, i8
            %233 = sv.read_inout %232 : !hw.inout<i32>
            %234 = comb.extract %233 from 2 : (i32) -> i30
            %235 = sv.array_index_inout %_RANDOM[%c4_i8] : !hw.inout<uarray<165xi32>>, i8
            %236 = sv.read_inout %235 : !hw.inout<i32>
            %237 = comb.extract %236 from 0 : (i32) -> i2
            %238 = sv.array_index_inout %_RANDOM[%c1_i8] : !hw.inout<uarray<165xi32>>, i8
            %239 = sv.read_inout %238 : !hw.inout<i32>
            %240 = comb.extract %239 from 30 : (i32) -> i2
            %241 = comb.concat %234, %240 : i30, i2
            %242 = sv.array_index_inout %pcRegs[%c0_i2] : !hw.inout<array<4xi32>>, i2
            sv.bpassign %242, %241 : i32
            %243 = sv.array_index_inout %_RANDOM[%c2_i8] : !hw.inout<uarray<165xi32>>, i8
            %244 = sv.read_inout %243 : !hw.inout<i32>
            %245 = comb.extract %244 from 30 : (i32) -> i2
            %246 = sv.array_index_inout %_RANDOM[%c1_i8] : !hw.inout<uarray<165xi32>>, i8
            %247 = sv.read_inout %246 : !hw.inout<i32>
            %248 = comb.extract %247 from 0 : (i32) -> i30
            %249 = comb.concat %248, %245 : i30, i2
            %250 = sv.array_index_inout %pcRegs[%c1_i2] : !hw.inout<array<4xi32>>, i2
            sv.bpassign %250, %249 : i32
            %251 = sv.array_index_inout %_RANDOM[%c3_i8] : !hw.inout<uarray<165xi32>>, i8
            %252 = sv.read_inout %251 : !hw.inout<i32>
            %253 = comb.extract %252 from 30 : (i32) -> i2
            %254 = sv.array_index_inout %_RANDOM[%c2_i8] : !hw.inout<uarray<165xi32>>, i8
            %255 = sv.read_inout %254 : !hw.inout<i32>
            %256 = comb.extract %255 from 0 : (i32) -> i30
            %257 = comb.concat %256, %253 : i30, i2
            %258 = sv.array_index_inout %pcRegs[%c-2_i2] : !hw.inout<array<4xi32>>, i2
            sv.bpassign %258, %257 : i32
            %259 = sv.array_index_inout %_RANDOM[%c3_i8] : !hw.inout<uarray<165xi32>>, i8
            %260 = sv.read_inout %259 : !hw.inout<i32>
            %261 = comb.extract %260 from 0 : (i32) -> i30
            %262 = comb.concat %261, %237 : i30, i2
            %263 = sv.array_index_inout %pcRegs[%c-1_i2] : !hw.inout<array<4xi32>>, i2
            sv.bpassign %263, %262 : i32
            %264 = sv.array_index_inout %_RANDOM[%c44_i8] : !hw.inout<uarray<165xi32>>, i8
            %265 = sv.read_inout %264 : !hw.inout<i32>
            %266 = comb.extract %265 from 0 : (i32) -> i6
            %267 = sv.array_index_inout %_RANDOM[%c4_i8] : !hw.inout<uarray<165xi32>>, i8
            %268 = sv.read_inout %267 : !hw.inout<i32>
            %269 = comb.extract %268 from 30 : (i32) -> i2
            %270 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %271 = sv.struct_field_inout %270["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %271, %269 : i2
            %272 = sv.array_index_inout %_RANDOM[%c4_i8] : !hw.inout<uarray<165xi32>>, i8
            %273 = sv.read_inout %272 : !hw.inout<i32>
            %274 = comb.extract %273 from 29 : (i32) -> i1
            %275 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %276 = sv.struct_field_inout %275["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %276, %274 : i1
            %277 = sv.array_index_inout %_RANDOM[%c5_i8] : !hw.inout<uarray<165xi32>>, i8
            %278 = sv.read_inout %277 : !hw.inout<i32>
            %279 = comb.extract %278 from 27 : (i32) -> i5
            %280 = sv.array_index_inout %_RANDOM[%c4_i8] : !hw.inout<uarray<165xi32>>, i8
            %281 = sv.read_inout %280 : !hw.inout<i32>
            %282 = comb.extract %281 from 2 : (i32) -> i27
            %283 = comb.concat %282, %279 : i27, i5
            %284 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %285 = sv.struct_field_inout %284["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %285, %283 : i32
            %286 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %287 = sv.read_inout %286 : !hw.inout<i32>
            %288 = comb.extract %287 from 27 : (i32) -> i5
            %289 = sv.array_index_inout %_RANDOM[%c5_i8] : !hw.inout<uarray<165xi32>>, i8
            %290 = sv.read_inout %289 : !hw.inout<i32>
            %291 = comb.extract %290 from 0 : (i32) -> i27
            %292 = comb.concat %291, %288 : i27, i5
            %293 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %294 = sv.struct_field_inout %293["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %294, %292 : i32
            %295 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %296 = sv.read_inout %295 : !hw.inout<i32>
            %297 = comb.extract %296 from 26 : (i32) -> i1
            %298 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %299 = sv.struct_field_inout %298["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %299, %297 : i1
            %300 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %301 = sv.read_inout %300 : !hw.inout<i32>
            %302 = comb.extract %301 from 25 : (i32) -> i1
            %303 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %304 = sv.struct_field_inout %303["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %304, %302 : i1
            %305 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %306 = sv.read_inout %305 : !hw.inout<i32>
            %307 = comb.extract %306 from 24 : (i32) -> i1
            %308 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %309 = sv.struct_field_inout %308["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %309, %307 : i1
            %310 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %311 = sv.read_inout %310 : !hw.inout<i32>
            %312 = comb.extract %311 from 23 : (i32) -> i1
            %313 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %314 = sv.struct_field_inout %313["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %314, %312 : i1
            %315 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %316 = sv.read_inout %315 : !hw.inout<i32>
            %317 = comb.extract %316 from 22 : (i32) -> i1
            %318 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %319 = sv.struct_field_inout %318["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %319, %317 : i1
            %320 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %321 = sv.read_inout %320 : !hw.inout<i32>
            %322 = comb.extract %321 from 21 : (i32) -> i1
            %323 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %324 = sv.struct_field_inout %323["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %324, %322 : i1
            %325 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %326 = sv.read_inout %325 : !hw.inout<i32>
            %327 = comb.extract %326 from 20 : (i32) -> i1
            %328 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %329 = sv.struct_field_inout %328["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %329, %327 : i1
            %330 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %331 = sv.read_inout %330 : !hw.inout<i32>
            %332 = comb.extract %331 from 19 : (i32) -> i1
            %333 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %334 = sv.struct_field_inout %333["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %334, %332 : i1
            %335 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %336 = sv.read_inout %335 : !hw.inout<i32>
            %337 = comb.extract %336 from 18 : (i32) -> i1
            %338 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %339 = sv.struct_field_inout %338["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %339, %337 : i1
            %340 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %341 = sv.read_inout %340 : !hw.inout<i32>
            %342 = comb.extract %341 from 17 : (i32) -> i1
            %343 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %344 = sv.struct_field_inout %343["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %344, %342 : i1
            %345 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %346 = sv.read_inout %345 : !hw.inout<i32>
            %347 = comb.extract %346 from 12 : (i32) -> i5
            %348 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %349 = sv.struct_field_inout %348["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %349, %347 : i5
            %350 = sv.array_index_inout %_RANDOM[%c7_i8] : !hw.inout<uarray<165xi32>>, i8
            %351 = sv.read_inout %350 : !hw.inout<i32>
            %352 = comb.extract %351 from 12 : (i32) -> i20
            %353 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %354 = sv.read_inout %353 : !hw.inout<i32>
            %355 = comb.extract %354 from 0 : (i32) -> i12
            %356 = comb.concat %355, %352 : i12, i20
            %357 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %358 = sv.struct_field_inout %357["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %358, %356 : i32
            %359 = sv.array_index_inout %_RANDOM[%c7_i8] : !hw.inout<uarray<165xi32>>, i8
            %360 = sv.read_inout %359 : !hw.inout<i32>
            %361 = comb.extract %360 from 7 : (i32) -> i5
            %362 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %363 = sv.struct_field_inout %362["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %363, %361 : i5
            %364 = sv.array_index_inout %_RANDOM[%c7_i8] : !hw.inout<uarray<165xi32>>, i8
            %365 = sv.read_inout %364 : !hw.inout<i32>
            %366 = comb.extract %365 from 2 : (i32) -> i5
            %367 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %368 = sv.struct_field_inout %367["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %368, %366 : i5
            %369 = sv.array_index_inout %_RANDOM[%c8_i8] : !hw.inout<uarray<165xi32>>, i8
            %370 = sv.read_inout %369 : !hw.inout<i32>
            %371 = comb.extract %370 from 29 : (i32) -> i3
            %372 = sv.array_index_inout %_RANDOM[%c7_i8] : !hw.inout<uarray<165xi32>>, i8
            %373 = sv.read_inout %372 : !hw.inout<i32>
            %374 = comb.extract %373 from 0 : (i32) -> i2
            %375 = comb.concat %374, %371 : i2, i3
            %376 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %377 = sv.struct_field_inout %376["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %377, %375 : i5
            %378 = sv.array_index_inout %_RANDOM[%c9_i8] : !hw.inout<uarray<165xi32>>, i8
            %379 = sv.read_inout %378 : !hw.inout<i32>
            %380 = comb.extract %379 from 29 : (i32) -> i3
            %381 = sv.array_index_inout %_RANDOM[%c8_i8] : !hw.inout<uarray<165xi32>>, i8
            %382 = sv.read_inout %381 : !hw.inout<i32>
            %383 = comb.extract %382 from 0 : (i32) -> i29
            %384 = comb.concat %383, %380 : i29, i3
            %385 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %386 = sv.struct_field_inout %385["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %386, %384 : i32
            %387 = sv.array_index_inout %_RANDOM[%c10_i8] : !hw.inout<uarray<165xi32>>, i8
            %388 = sv.read_inout %387 : !hw.inout<i32>
            %389 = comb.extract %388 from 29 : (i32) -> i3
            %390 = sv.array_index_inout %_RANDOM[%c9_i8] : !hw.inout<uarray<165xi32>>, i8
            %391 = sv.read_inout %390 : !hw.inout<i32>
            %392 = comb.extract %391 from 0 : (i32) -> i29
            %393 = comb.concat %392, %389 : i29, i3
            %394 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %395 = sv.struct_field_inout %394["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %395, %393 : i32
            %396 = sv.array_index_inout %_RANDOM[%c11_i8] : !hw.inout<uarray<165xi32>>, i8
            %397 = sv.read_inout %396 : !hw.inout<i32>
            %398 = comb.extract %397 from 29 : (i32) -> i3
            %399 = sv.array_index_inout %_RANDOM[%c10_i8] : !hw.inout<uarray<165xi32>>, i8
            %400 = sv.read_inout %399 : !hw.inout<i32>
            %401 = comb.extract %400 from 0 : (i32) -> i29
            %402 = comb.concat %401, %398 : i29, i3
            %403 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %404 = sv.struct_field_inout %403["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %404, %402 : i32
            %405 = sv.array_index_inout %_RANDOM[%c12_i8] : !hw.inout<uarray<165xi32>>, i8
            %406 = sv.read_inout %405 : !hw.inout<i32>
            %407 = comb.extract %406 from 29 : (i32) -> i3
            %408 = sv.array_index_inout %_RANDOM[%c11_i8] : !hw.inout<uarray<165xi32>>, i8
            %409 = sv.read_inout %408 : !hw.inout<i32>
            %410 = comb.extract %409 from 0 : (i32) -> i29
            %411 = comb.concat %410, %407 : i29, i3
            %412 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %413 = sv.struct_field_inout %412["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %413, %411 : i32
            %414 = sv.array_index_inout %_RANDOM[%c13_i8] : !hw.inout<uarray<165xi32>>, i8
            %415 = sv.read_inout %414 : !hw.inout<i32>
            %416 = comb.extract %415 from 29 : (i32) -> i3
            %417 = sv.array_index_inout %_RANDOM[%c12_i8] : !hw.inout<uarray<165xi32>>, i8
            %418 = sv.read_inout %417 : !hw.inout<i32>
            %419 = comb.extract %418 from 0 : (i32) -> i29
            %420 = comb.concat %419, %416 : i29, i3
            %421 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %422 = sv.struct_field_inout %421["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %422, %420 : i32
            %423 = sv.array_index_inout %_RANDOM[%c14_i8] : !hw.inout<uarray<165xi32>>, i8
            %424 = sv.read_inout %423 : !hw.inout<i32>
            %425 = comb.extract %424 from 29 : (i32) -> i3
            %426 = sv.array_index_inout %_RANDOM[%c13_i8] : !hw.inout<uarray<165xi32>>, i8
            %427 = sv.read_inout %426 : !hw.inout<i32>
            %428 = comb.extract %427 from 0 : (i32) -> i29
            %429 = comb.concat %428, %425 : i29, i3
            %430 = sv.array_index_inout %ifStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %431 = sv.struct_field_inout %430["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %431, %429 : i32
            %432 = sv.array_index_inout %_RANDOM[%c14_i8] : !hw.inout<uarray<165xi32>>, i8
            %433 = sv.read_inout %432 : !hw.inout<i32>
            %434 = comb.extract %433 from 27 : (i32) -> i2
            %435 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %436 = sv.struct_field_inout %435["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %436, %434 : i2
            %437 = sv.array_index_inout %_RANDOM[%c14_i8] : !hw.inout<uarray<165xi32>>, i8
            %438 = sv.read_inout %437 : !hw.inout<i32>
            %439 = comb.extract %438 from 26 : (i32) -> i1
            %440 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %441 = sv.struct_field_inout %440["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %441, %439 : i1
            %442 = sv.array_index_inout %_RANDOM[%c15_i8] : !hw.inout<uarray<165xi32>>, i8
            %443 = sv.read_inout %442 : !hw.inout<i32>
            %444 = comb.extract %443 from 26 : (i32) -> i6
            %445 = sv.array_index_inout %_RANDOM[%c14_i8] : !hw.inout<uarray<165xi32>>, i8
            %446 = sv.read_inout %445 : !hw.inout<i32>
            %447 = comb.extract %446 from 0 : (i32) -> i26
            %448 = comb.concat %447, %444 : i26, i6
            %449 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %450 = sv.struct_field_inout %449["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %450, %448 : i32
            %451 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %452 = sv.read_inout %451 : !hw.inout<i32>
            %453 = comb.extract %452 from 26 : (i32) -> i6
            %454 = sv.array_index_inout %_RANDOM[%c15_i8] : !hw.inout<uarray<165xi32>>, i8
            %455 = sv.read_inout %454 : !hw.inout<i32>
            %456 = comb.extract %455 from 0 : (i32) -> i26
            %457 = comb.concat %456, %453 : i26, i6
            %458 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %459 = sv.struct_field_inout %458["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %459, %457 : i32
            %460 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %461 = sv.read_inout %460 : !hw.inout<i32>
            %462 = comb.extract %461 from 25 : (i32) -> i1
            %463 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %464 = sv.struct_field_inout %463["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %464, %462 : i1
            %465 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %466 = sv.read_inout %465 : !hw.inout<i32>
            %467 = comb.extract %466 from 24 : (i32) -> i1
            %468 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %469 = sv.struct_field_inout %468["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %469, %467 : i1
            %470 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %471 = sv.read_inout %470 : !hw.inout<i32>
            %472 = comb.extract %471 from 23 : (i32) -> i1
            %473 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %474 = sv.struct_field_inout %473["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %474, %472 : i1
            %475 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %476 = sv.read_inout %475 : !hw.inout<i32>
            %477 = comb.extract %476 from 22 : (i32) -> i1
            %478 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %479 = sv.struct_field_inout %478["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %479, %477 : i1
            %480 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %481 = sv.read_inout %480 : !hw.inout<i32>
            %482 = comb.extract %481 from 21 : (i32) -> i1
            %483 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %484 = sv.struct_field_inout %483["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %484, %482 : i1
            %485 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %486 = sv.read_inout %485 : !hw.inout<i32>
            %487 = comb.extract %486 from 20 : (i32) -> i1
            %488 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %489 = sv.struct_field_inout %488["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %489, %487 : i1
            %490 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %491 = sv.read_inout %490 : !hw.inout<i32>
            %492 = comb.extract %491 from 19 : (i32) -> i1
            %493 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %494 = sv.struct_field_inout %493["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %494, %492 : i1
            %495 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %496 = sv.read_inout %495 : !hw.inout<i32>
            %497 = comb.extract %496 from 18 : (i32) -> i1
            %498 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %499 = sv.struct_field_inout %498["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %499, %497 : i1
            %500 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %501 = sv.read_inout %500 : !hw.inout<i32>
            %502 = comb.extract %501 from 17 : (i32) -> i1
            %503 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %504 = sv.struct_field_inout %503["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %504, %502 : i1
            %505 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %506 = sv.read_inout %505 : !hw.inout<i32>
            %507 = comb.extract %506 from 16 : (i32) -> i1
            %508 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %509 = sv.struct_field_inout %508["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %509, %507 : i1
            %510 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %511 = sv.read_inout %510 : !hw.inout<i32>
            %512 = comb.extract %511 from 11 : (i32) -> i5
            %513 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %514 = sv.struct_field_inout %513["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %514, %512 : i5
            %515 = sv.array_index_inout %_RANDOM[%c17_i8] : !hw.inout<uarray<165xi32>>, i8
            %516 = sv.read_inout %515 : !hw.inout<i32>
            %517 = comb.extract %516 from 11 : (i32) -> i21
            %518 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %519 = sv.read_inout %518 : !hw.inout<i32>
            %520 = comb.extract %519 from 0 : (i32) -> i11
            %521 = comb.concat %520, %517 : i11, i21
            %522 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %523 = sv.struct_field_inout %522["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %523, %521 : i32
            %524 = sv.array_index_inout %_RANDOM[%c17_i8] : !hw.inout<uarray<165xi32>>, i8
            %525 = sv.read_inout %524 : !hw.inout<i32>
            %526 = comb.extract %525 from 6 : (i32) -> i5
            %527 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %528 = sv.struct_field_inout %527["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %528, %526 : i5
            %529 = sv.array_index_inout %_RANDOM[%c17_i8] : !hw.inout<uarray<165xi32>>, i8
            %530 = sv.read_inout %529 : !hw.inout<i32>
            %531 = comb.extract %530 from 1 : (i32) -> i5
            %532 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %533 = sv.struct_field_inout %532["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %533, %531 : i5
            %534 = sv.array_index_inout %_RANDOM[%c18_i8] : !hw.inout<uarray<165xi32>>, i8
            %535 = sv.read_inout %534 : !hw.inout<i32>
            %536 = comb.extract %535 from 28 : (i32) -> i4
            %537 = sv.array_index_inout %_RANDOM[%c17_i8] : !hw.inout<uarray<165xi32>>, i8
            %538 = sv.read_inout %537 : !hw.inout<i32>
            %539 = comb.extract %538 from 0 : (i32) -> i1
            %540 = comb.concat %539, %536 : i1, i4
            %541 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %542 = sv.struct_field_inout %541["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %542, %540 : i5
            %543 = sv.array_index_inout %_RANDOM[%c19_i8] : !hw.inout<uarray<165xi32>>, i8
            %544 = sv.read_inout %543 : !hw.inout<i32>
            %545 = comb.extract %544 from 28 : (i32) -> i4
            %546 = sv.array_index_inout %_RANDOM[%c18_i8] : !hw.inout<uarray<165xi32>>, i8
            %547 = sv.read_inout %546 : !hw.inout<i32>
            %548 = comb.extract %547 from 0 : (i32) -> i28
            %549 = comb.concat %548, %545 : i28, i4
            %550 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %551 = sv.struct_field_inout %550["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %551, %549 : i32
            %552 = sv.array_index_inout %_RANDOM[%c20_i8] : !hw.inout<uarray<165xi32>>, i8
            %553 = sv.read_inout %552 : !hw.inout<i32>
            %554 = comb.extract %553 from 28 : (i32) -> i4
            %555 = sv.array_index_inout %_RANDOM[%c19_i8] : !hw.inout<uarray<165xi32>>, i8
            %556 = sv.read_inout %555 : !hw.inout<i32>
            %557 = comb.extract %556 from 0 : (i32) -> i28
            %558 = comb.concat %557, %554 : i28, i4
            %559 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %560 = sv.struct_field_inout %559["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %560, %558 : i32
            %561 = sv.array_index_inout %_RANDOM[%c21_i8] : !hw.inout<uarray<165xi32>>, i8
            %562 = sv.read_inout %561 : !hw.inout<i32>
            %563 = comb.extract %562 from 28 : (i32) -> i4
            %564 = sv.array_index_inout %_RANDOM[%c20_i8] : !hw.inout<uarray<165xi32>>, i8
            %565 = sv.read_inout %564 : !hw.inout<i32>
            %566 = comb.extract %565 from 0 : (i32) -> i28
            %567 = comb.concat %566, %563 : i28, i4
            %568 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %569 = sv.struct_field_inout %568["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %569, %567 : i32
            %570 = sv.array_index_inout %_RANDOM[%c22_i8] : !hw.inout<uarray<165xi32>>, i8
            %571 = sv.read_inout %570 : !hw.inout<i32>
            %572 = comb.extract %571 from 28 : (i32) -> i4
            %573 = sv.array_index_inout %_RANDOM[%c21_i8] : !hw.inout<uarray<165xi32>>, i8
            %574 = sv.read_inout %573 : !hw.inout<i32>
            %575 = comb.extract %574 from 0 : (i32) -> i28
            %576 = comb.concat %575, %572 : i28, i4
            %577 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %578 = sv.struct_field_inout %577["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %578, %576 : i32
            %579 = sv.array_index_inout %_RANDOM[%c23_i8] : !hw.inout<uarray<165xi32>>, i8
            %580 = sv.read_inout %579 : !hw.inout<i32>
            %581 = comb.extract %580 from 28 : (i32) -> i4
            %582 = sv.array_index_inout %_RANDOM[%c22_i8] : !hw.inout<uarray<165xi32>>, i8
            %583 = sv.read_inout %582 : !hw.inout<i32>
            %584 = comb.extract %583 from 0 : (i32) -> i28
            %585 = comb.concat %584, %581 : i28, i4
            %586 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %587 = sv.struct_field_inout %586["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %587, %585 : i32
            %588 = sv.array_index_inout %_RANDOM[%c24_i8] : !hw.inout<uarray<165xi32>>, i8
            %589 = sv.read_inout %588 : !hw.inout<i32>
            %590 = comb.extract %589 from 28 : (i32) -> i4
            %591 = sv.array_index_inout %_RANDOM[%c23_i8] : !hw.inout<uarray<165xi32>>, i8
            %592 = sv.read_inout %591 : !hw.inout<i32>
            %593 = comb.extract %592 from 0 : (i32) -> i28
            %594 = comb.concat %593, %590 : i28, i4
            %595 = sv.array_index_inout %ifStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %596 = sv.struct_field_inout %595["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %596, %594 : i32
            %597 = sv.array_index_inout %_RANDOM[%c24_i8] : !hw.inout<uarray<165xi32>>, i8
            %598 = sv.read_inout %597 : !hw.inout<i32>
            %599 = comb.extract %598 from 26 : (i32) -> i2
            %600 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %601 = sv.struct_field_inout %600["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %601, %599 : i2
            %602 = sv.array_index_inout %_RANDOM[%c24_i8] : !hw.inout<uarray<165xi32>>, i8
            %603 = sv.read_inout %602 : !hw.inout<i32>
            %604 = comb.extract %603 from 25 : (i32) -> i1
            %605 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %606 = sv.struct_field_inout %605["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %606, %604 : i1
            %607 = sv.array_index_inout %_RANDOM[%c25_i8] : !hw.inout<uarray<165xi32>>, i8
            %608 = sv.read_inout %607 : !hw.inout<i32>
            %609 = comb.extract %608 from 25 : (i32) -> i7
            %610 = sv.array_index_inout %_RANDOM[%c24_i8] : !hw.inout<uarray<165xi32>>, i8
            %611 = sv.read_inout %610 : !hw.inout<i32>
            %612 = comb.extract %611 from 0 : (i32) -> i25
            %613 = comb.concat %612, %609 : i25, i7
            %614 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %615 = sv.struct_field_inout %614["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %615, %613 : i32
            %616 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %617 = sv.read_inout %616 : !hw.inout<i32>
            %618 = comb.extract %617 from 25 : (i32) -> i7
            %619 = sv.array_index_inout %_RANDOM[%c25_i8] : !hw.inout<uarray<165xi32>>, i8
            %620 = sv.read_inout %619 : !hw.inout<i32>
            %621 = comb.extract %620 from 0 : (i32) -> i25
            %622 = comb.concat %621, %618 : i25, i7
            %623 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %624 = sv.struct_field_inout %623["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %624, %622 : i32
            %625 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %626 = sv.read_inout %625 : !hw.inout<i32>
            %627 = comb.extract %626 from 24 : (i32) -> i1
            %628 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %629 = sv.struct_field_inout %628["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %629, %627 : i1
            %630 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %631 = sv.read_inout %630 : !hw.inout<i32>
            %632 = comb.extract %631 from 23 : (i32) -> i1
            %633 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %634 = sv.struct_field_inout %633["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %634, %632 : i1
            %635 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %636 = sv.read_inout %635 : !hw.inout<i32>
            %637 = comb.extract %636 from 22 : (i32) -> i1
            %638 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %639 = sv.struct_field_inout %638["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %639, %637 : i1
            %640 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %641 = sv.read_inout %640 : !hw.inout<i32>
            %642 = comb.extract %641 from 21 : (i32) -> i1
            %643 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %644 = sv.struct_field_inout %643["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %644, %642 : i1
            %645 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %646 = sv.read_inout %645 : !hw.inout<i32>
            %647 = comb.extract %646 from 20 : (i32) -> i1
            %648 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %649 = sv.struct_field_inout %648["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %649, %647 : i1
            %650 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %651 = sv.read_inout %650 : !hw.inout<i32>
            %652 = comb.extract %651 from 19 : (i32) -> i1
            %653 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %654 = sv.struct_field_inout %653["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %654, %652 : i1
            %655 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %656 = sv.read_inout %655 : !hw.inout<i32>
            %657 = comb.extract %656 from 18 : (i32) -> i1
            %658 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %659 = sv.struct_field_inout %658["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %659, %657 : i1
            %660 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %661 = sv.read_inout %660 : !hw.inout<i32>
            %662 = comb.extract %661 from 17 : (i32) -> i1
            %663 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %664 = sv.struct_field_inout %663["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %664, %662 : i1
            %665 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %666 = sv.read_inout %665 : !hw.inout<i32>
            %667 = comb.extract %666 from 16 : (i32) -> i1
            %668 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %669 = sv.struct_field_inout %668["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %669, %667 : i1
            %670 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %671 = sv.read_inout %670 : !hw.inout<i32>
            %672 = comb.extract %671 from 15 : (i32) -> i1
            %673 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %674 = sv.struct_field_inout %673["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %674, %672 : i1
            %675 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %676 = sv.read_inout %675 : !hw.inout<i32>
            %677 = comb.extract %676 from 10 : (i32) -> i5
            %678 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %679 = sv.struct_field_inout %678["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %679, %677 : i5
            %680 = sv.array_index_inout %_RANDOM[%c27_i8] : !hw.inout<uarray<165xi32>>, i8
            %681 = sv.read_inout %680 : !hw.inout<i32>
            %682 = comb.extract %681 from 10 : (i32) -> i22
            %683 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %684 = sv.read_inout %683 : !hw.inout<i32>
            %685 = comb.extract %684 from 0 : (i32) -> i10
            %686 = comb.concat %685, %682 : i10, i22
            %687 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %688 = sv.struct_field_inout %687["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %688, %686 : i32
            %689 = sv.array_index_inout %_RANDOM[%c27_i8] : !hw.inout<uarray<165xi32>>, i8
            %690 = sv.read_inout %689 : !hw.inout<i32>
            %691 = comb.extract %690 from 5 : (i32) -> i5
            %692 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %693 = sv.struct_field_inout %692["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %693, %691 : i5
            %694 = sv.array_index_inout %_RANDOM[%c27_i8] : !hw.inout<uarray<165xi32>>, i8
            %695 = sv.read_inout %694 : !hw.inout<i32>
            %696 = comb.extract %695 from 0 : (i32) -> i5
            %697 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %698 = sv.struct_field_inout %697["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %698, %696 : i5
            %699 = sv.array_index_inout %_RANDOM[%c28_i8] : !hw.inout<uarray<165xi32>>, i8
            %700 = sv.read_inout %699 : !hw.inout<i32>
            %701 = comb.extract %700 from 27 : (i32) -> i5
            %702 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %703 = sv.struct_field_inout %702["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %703, %701 : i5
            %704 = sv.array_index_inout %_RANDOM[%c29_i8] : !hw.inout<uarray<165xi32>>, i8
            %705 = sv.read_inout %704 : !hw.inout<i32>
            %706 = comb.extract %705 from 27 : (i32) -> i5
            %707 = sv.array_index_inout %_RANDOM[%c28_i8] : !hw.inout<uarray<165xi32>>, i8
            %708 = sv.read_inout %707 : !hw.inout<i32>
            %709 = comb.extract %708 from 0 : (i32) -> i27
            %710 = comb.concat %709, %706 : i27, i5
            %711 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %712 = sv.struct_field_inout %711["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %712, %710 : i32
            %713 = sv.array_index_inout %_RANDOM[%c30_i8] : !hw.inout<uarray<165xi32>>, i8
            %714 = sv.read_inout %713 : !hw.inout<i32>
            %715 = comb.extract %714 from 27 : (i32) -> i5
            %716 = sv.array_index_inout %_RANDOM[%c29_i8] : !hw.inout<uarray<165xi32>>, i8
            %717 = sv.read_inout %716 : !hw.inout<i32>
            %718 = comb.extract %717 from 0 : (i32) -> i27
            %719 = comb.concat %718, %715 : i27, i5
            %720 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %721 = sv.struct_field_inout %720["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %721, %719 : i32
            %722 = sv.array_index_inout %_RANDOM[%c31_i8] : !hw.inout<uarray<165xi32>>, i8
            %723 = sv.read_inout %722 : !hw.inout<i32>
            %724 = comb.extract %723 from 27 : (i32) -> i5
            %725 = sv.array_index_inout %_RANDOM[%c30_i8] : !hw.inout<uarray<165xi32>>, i8
            %726 = sv.read_inout %725 : !hw.inout<i32>
            %727 = comb.extract %726 from 0 : (i32) -> i27
            %728 = comb.concat %727, %724 : i27, i5
            %729 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %730 = sv.struct_field_inout %729["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %730, %728 : i32
            %731 = sv.array_index_inout %_RANDOM[%c32_i8] : !hw.inout<uarray<165xi32>>, i8
            %732 = sv.read_inout %731 : !hw.inout<i32>
            %733 = comb.extract %732 from 27 : (i32) -> i5
            %734 = sv.array_index_inout %_RANDOM[%c31_i8] : !hw.inout<uarray<165xi32>>, i8
            %735 = sv.read_inout %734 : !hw.inout<i32>
            %736 = comb.extract %735 from 0 : (i32) -> i27
            %737 = comb.concat %736, %733 : i27, i5
            %738 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %739 = sv.struct_field_inout %738["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %739, %737 : i32
            %740 = sv.array_index_inout %_RANDOM[%c33_i8] : !hw.inout<uarray<165xi32>>, i8
            %741 = sv.read_inout %740 : !hw.inout<i32>
            %742 = comb.extract %741 from 27 : (i32) -> i5
            %743 = sv.array_index_inout %_RANDOM[%c32_i8] : !hw.inout<uarray<165xi32>>, i8
            %744 = sv.read_inout %743 : !hw.inout<i32>
            %745 = comb.extract %744 from 0 : (i32) -> i27
            %746 = comb.concat %745, %742 : i27, i5
            %747 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %748 = sv.struct_field_inout %747["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %748, %746 : i32
            %749 = sv.array_index_inout %_RANDOM[%c34_i8] : !hw.inout<uarray<165xi32>>, i8
            %750 = sv.read_inout %749 : !hw.inout<i32>
            %751 = comb.extract %750 from 27 : (i32) -> i5
            %752 = sv.array_index_inout %_RANDOM[%c33_i8] : !hw.inout<uarray<165xi32>>, i8
            %753 = sv.read_inout %752 : !hw.inout<i32>
            %754 = comb.extract %753 from 0 : (i32) -> i27
            %755 = comb.concat %754, %751 : i27, i5
            %756 = sv.array_index_inout %ifStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %757 = sv.struct_field_inout %756["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %757, %755 : i32
            %758 = sv.array_index_inout %_RANDOM[%c34_i8] : !hw.inout<uarray<165xi32>>, i8
            %759 = sv.read_inout %758 : !hw.inout<i32>
            %760 = comb.extract %759 from 25 : (i32) -> i2
            %761 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %762 = sv.struct_field_inout %761["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %762, %760 : i2
            %763 = sv.array_index_inout %_RANDOM[%c34_i8] : !hw.inout<uarray<165xi32>>, i8
            %764 = sv.read_inout %763 : !hw.inout<i32>
            %765 = comb.extract %764 from 24 : (i32) -> i1
            %766 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %767 = sv.struct_field_inout %766["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %767, %765 : i1
            %768 = sv.array_index_inout %_RANDOM[%c35_i8] : !hw.inout<uarray<165xi32>>, i8
            %769 = sv.read_inout %768 : !hw.inout<i32>
            %770 = comb.extract %769 from 24 : (i32) -> i8
            %771 = sv.array_index_inout %_RANDOM[%c34_i8] : !hw.inout<uarray<165xi32>>, i8
            %772 = sv.read_inout %771 : !hw.inout<i32>
            %773 = comb.extract %772 from 0 : (i32) -> i24
            %774 = comb.concat %773, %770 : i24, i8
            %775 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %776 = sv.struct_field_inout %775["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %776, %774 : i32
            %777 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %778 = sv.read_inout %777 : !hw.inout<i32>
            %779 = comb.extract %778 from 24 : (i32) -> i8
            %780 = sv.array_index_inout %_RANDOM[%c35_i8] : !hw.inout<uarray<165xi32>>, i8
            %781 = sv.read_inout %780 : !hw.inout<i32>
            %782 = comb.extract %781 from 0 : (i32) -> i24
            %783 = comb.concat %782, %779 : i24, i8
            %784 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %785 = sv.struct_field_inout %784["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %785, %783 : i32
            %786 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %787 = sv.read_inout %786 : !hw.inout<i32>
            %788 = comb.extract %787 from 23 : (i32) -> i1
            %789 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %790 = sv.struct_field_inout %789["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %790, %788 : i1
            %791 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %792 = sv.read_inout %791 : !hw.inout<i32>
            %793 = comb.extract %792 from 22 : (i32) -> i1
            %794 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %795 = sv.struct_field_inout %794["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %795, %793 : i1
            %796 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %797 = sv.read_inout %796 : !hw.inout<i32>
            %798 = comb.extract %797 from 21 : (i32) -> i1
            %799 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %800 = sv.struct_field_inout %799["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %800, %798 : i1
            %801 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %802 = sv.read_inout %801 : !hw.inout<i32>
            %803 = comb.extract %802 from 20 : (i32) -> i1
            %804 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %805 = sv.struct_field_inout %804["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %805, %803 : i1
            %806 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %807 = sv.read_inout %806 : !hw.inout<i32>
            %808 = comb.extract %807 from 19 : (i32) -> i1
            %809 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %810 = sv.struct_field_inout %809["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %810, %808 : i1
            %811 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %812 = sv.read_inout %811 : !hw.inout<i32>
            %813 = comb.extract %812 from 18 : (i32) -> i1
            %814 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %815 = sv.struct_field_inout %814["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %815, %813 : i1
            %816 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %817 = sv.read_inout %816 : !hw.inout<i32>
            %818 = comb.extract %817 from 17 : (i32) -> i1
            %819 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %820 = sv.struct_field_inout %819["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %820, %818 : i1
            %821 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %822 = sv.read_inout %821 : !hw.inout<i32>
            %823 = comb.extract %822 from 16 : (i32) -> i1
            %824 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %825 = sv.struct_field_inout %824["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %825, %823 : i1
            %826 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %827 = sv.read_inout %826 : !hw.inout<i32>
            %828 = comb.extract %827 from 15 : (i32) -> i1
            %829 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %830 = sv.struct_field_inout %829["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %830, %828 : i1
            %831 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %832 = sv.read_inout %831 : !hw.inout<i32>
            %833 = comb.extract %832 from 14 : (i32) -> i1
            %834 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %835 = sv.struct_field_inout %834["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %835, %833 : i1
            %836 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %837 = sv.read_inout %836 : !hw.inout<i32>
            %838 = comb.extract %837 from 9 : (i32) -> i5
            %839 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %840 = sv.struct_field_inout %839["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %840, %838 : i5
            %841 = sv.array_index_inout %_RANDOM[%c37_i8] : !hw.inout<uarray<165xi32>>, i8
            %842 = sv.read_inout %841 : !hw.inout<i32>
            %843 = comb.extract %842 from 9 : (i32) -> i23
            %844 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %845 = sv.read_inout %844 : !hw.inout<i32>
            %846 = comb.extract %845 from 0 : (i32) -> i9
            %847 = comb.concat %846, %843 : i9, i23
            %848 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %849 = sv.struct_field_inout %848["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %849, %847 : i32
            %850 = sv.array_index_inout %_RANDOM[%c37_i8] : !hw.inout<uarray<165xi32>>, i8
            %851 = sv.read_inout %850 : !hw.inout<i32>
            %852 = comb.extract %851 from 4 : (i32) -> i5
            %853 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %854 = sv.struct_field_inout %853["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %854, %852 : i5
            %855 = sv.array_index_inout %_RANDOM[%c38_i8] : !hw.inout<uarray<165xi32>>, i8
            %856 = sv.read_inout %855 : !hw.inout<i32>
            %857 = comb.extract %856 from 31 : (i32) -> i1
            %858 = sv.array_index_inout %_RANDOM[%c37_i8] : !hw.inout<uarray<165xi32>>, i8
            %859 = sv.read_inout %858 : !hw.inout<i32>
            %860 = comb.extract %859 from 0 : (i32) -> i4
            %861 = comb.concat %860, %857 : i4, i1
            %862 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %863 = sv.struct_field_inout %862["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %863, %861 : i5
            %864 = sv.array_index_inout %_RANDOM[%c38_i8] : !hw.inout<uarray<165xi32>>, i8
            %865 = sv.read_inout %864 : !hw.inout<i32>
            %866 = comb.extract %865 from 26 : (i32) -> i5
            %867 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %868 = sv.struct_field_inout %867["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %868, %866 : i5
            %869 = sv.array_index_inout %_RANDOM[%c39_i8] : !hw.inout<uarray<165xi32>>, i8
            %870 = sv.read_inout %869 : !hw.inout<i32>
            %871 = comb.extract %870 from 26 : (i32) -> i6
            %872 = sv.array_index_inout %_RANDOM[%c38_i8] : !hw.inout<uarray<165xi32>>, i8
            %873 = sv.read_inout %872 : !hw.inout<i32>
            %874 = comb.extract %873 from 0 : (i32) -> i26
            %875 = comb.concat %874, %871 : i26, i6
            %876 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %877 = sv.struct_field_inout %876["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %877, %875 : i32
            %878 = sv.array_index_inout %_RANDOM[%c40_i8] : !hw.inout<uarray<165xi32>>, i8
            %879 = sv.read_inout %878 : !hw.inout<i32>
            %880 = comb.extract %879 from 26 : (i32) -> i6
            %881 = sv.array_index_inout %_RANDOM[%c39_i8] : !hw.inout<uarray<165xi32>>, i8
            %882 = sv.read_inout %881 : !hw.inout<i32>
            %883 = comb.extract %882 from 0 : (i32) -> i26
            %884 = comb.concat %883, %880 : i26, i6
            %885 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %886 = sv.struct_field_inout %885["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %886, %884 : i32
            %887 = sv.array_index_inout %_RANDOM[%c41_i8] : !hw.inout<uarray<165xi32>>, i8
            %888 = sv.read_inout %887 : !hw.inout<i32>
            %889 = comb.extract %888 from 26 : (i32) -> i6
            %890 = sv.array_index_inout %_RANDOM[%c40_i8] : !hw.inout<uarray<165xi32>>, i8
            %891 = sv.read_inout %890 : !hw.inout<i32>
            %892 = comb.extract %891 from 0 : (i32) -> i26
            %893 = comb.concat %892, %889 : i26, i6
            %894 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %895 = sv.struct_field_inout %894["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %895, %893 : i32
            %896 = sv.array_index_inout %_RANDOM[%c42_i8] : !hw.inout<uarray<165xi32>>, i8
            %897 = sv.read_inout %896 : !hw.inout<i32>
            %898 = comb.extract %897 from 26 : (i32) -> i6
            %899 = sv.array_index_inout %_RANDOM[%c41_i8] : !hw.inout<uarray<165xi32>>, i8
            %900 = sv.read_inout %899 : !hw.inout<i32>
            %901 = comb.extract %900 from 0 : (i32) -> i26
            %902 = comb.concat %901, %898 : i26, i6
            %903 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %904 = sv.struct_field_inout %903["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %904, %902 : i32
            %905 = sv.array_index_inout %_RANDOM[%c43_i8] : !hw.inout<uarray<165xi32>>, i8
            %906 = sv.read_inout %905 : !hw.inout<i32>
            %907 = comb.extract %906 from 26 : (i32) -> i6
            %908 = sv.array_index_inout %_RANDOM[%c42_i8] : !hw.inout<uarray<165xi32>>, i8
            %909 = sv.read_inout %908 : !hw.inout<i32>
            %910 = comb.extract %909 from 0 : (i32) -> i26
            %911 = comb.concat %910, %907 : i26, i6
            %912 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %913 = sv.struct_field_inout %912["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %913, %911 : i32
            %914 = sv.array_index_inout %_RANDOM[%c43_i8] : !hw.inout<uarray<165xi32>>, i8
            %915 = sv.read_inout %914 : !hw.inout<i32>
            %916 = comb.extract %915 from 0 : (i32) -> i26
            %917 = comb.concat %916, %266 : i26, i6
            %918 = sv.array_index_inout %ifStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %919 = sv.struct_field_inout %918["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %919, %917 : i32
            %920 = sv.array_index_inout %_RANDOM[%c84_i8] : !hw.inout<uarray<165xi32>>, i8
            %921 = sv.read_inout %920 : !hw.inout<i32>
            %922 = comb.extract %921 from 0 : (i32) -> i10
            %923 = sv.array_index_inout %_RANDOM[%c44_i8] : !hw.inout<uarray<165xi32>>, i8
            %924 = sv.read_inout %923 : !hw.inout<i32>
            %925 = comb.extract %924 from 30 : (i32) -> i2
            %926 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %927 = sv.struct_field_inout %926["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %927, %925 : i2
            %928 = sv.array_index_inout %_RANDOM[%c44_i8] : !hw.inout<uarray<165xi32>>, i8
            %929 = sv.read_inout %928 : !hw.inout<i32>
            %930 = comb.extract %929 from 29 : (i32) -> i1
            %931 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %932 = sv.struct_field_inout %931["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %932, %930 : i1
            %933 = sv.array_index_inout %_RANDOM[%c45_i8] : !hw.inout<uarray<165xi32>>, i8
            %934 = sv.read_inout %933 : !hw.inout<i32>
            %935 = comb.extract %934 from 23 : (i32) -> i9
            %936 = sv.array_index_inout %_RANDOM[%c44_i8] : !hw.inout<uarray<165xi32>>, i8
            %937 = sv.read_inout %936 : !hw.inout<i32>
            %938 = comb.extract %937 from 6 : (i32) -> i23
            %939 = comb.concat %938, %935 : i23, i9
            %940 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %941 = sv.struct_field_inout %940["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %941, %939 : i32
            %942 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %943 = sv.read_inout %942 : !hw.inout<i32>
            %944 = comb.extract %943 from 23 : (i32) -> i9
            %945 = sv.array_index_inout %_RANDOM[%c45_i8] : !hw.inout<uarray<165xi32>>, i8
            %946 = sv.read_inout %945 : !hw.inout<i32>
            %947 = comb.extract %946 from 0 : (i32) -> i23
            %948 = comb.concat %947, %944 : i23, i9
            %949 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %950 = sv.struct_field_inout %949["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %950, %948 : i32
            %951 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %952 = sv.read_inout %951 : !hw.inout<i32>
            %953 = comb.extract %952 from 22 : (i32) -> i1
            %954 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %955 = sv.struct_field_inout %954["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %955, %953 : i1
            %956 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %957 = sv.read_inout %956 : !hw.inout<i32>
            %958 = comb.extract %957 from 21 : (i32) -> i1
            %959 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %960 = sv.struct_field_inout %959["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %960, %958 : i1
            %961 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %962 = sv.read_inout %961 : !hw.inout<i32>
            %963 = comb.extract %962 from 20 : (i32) -> i1
            %964 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %965 = sv.struct_field_inout %964["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %965, %963 : i1
            %966 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %967 = sv.read_inout %966 : !hw.inout<i32>
            %968 = comb.extract %967 from 19 : (i32) -> i1
            %969 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %970 = sv.struct_field_inout %969["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %970, %968 : i1
            %971 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %972 = sv.read_inout %971 : !hw.inout<i32>
            %973 = comb.extract %972 from 18 : (i32) -> i1
            %974 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %975 = sv.struct_field_inout %974["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %975, %973 : i1
            %976 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %977 = sv.read_inout %976 : !hw.inout<i32>
            %978 = comb.extract %977 from 17 : (i32) -> i1
            %979 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %980 = sv.struct_field_inout %979["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %980, %978 : i1
            %981 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %982 = sv.read_inout %981 : !hw.inout<i32>
            %983 = comb.extract %982 from 16 : (i32) -> i1
            %984 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %985 = sv.struct_field_inout %984["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %985, %983 : i1
            %986 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %987 = sv.read_inout %986 : !hw.inout<i32>
            %988 = comb.extract %987 from 15 : (i32) -> i1
            %989 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %990 = sv.struct_field_inout %989["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %990, %988 : i1
            %991 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %992 = sv.read_inout %991 : !hw.inout<i32>
            %993 = comb.extract %992 from 14 : (i32) -> i1
            %994 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %995 = sv.struct_field_inout %994["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %995, %993 : i1
            %996 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %997 = sv.read_inout %996 : !hw.inout<i32>
            %998 = comb.extract %997 from 13 : (i32) -> i1
            %999 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1000 = sv.struct_field_inout %999["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1000, %998 : i1
            %1001 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %1002 = sv.read_inout %1001 : !hw.inout<i32>
            %1003 = comb.extract %1002 from 8 : (i32) -> i5
            %1004 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1005 = sv.struct_field_inout %1004["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1005, %1003 : i5
            %1006 = sv.array_index_inout %_RANDOM[%c47_i8] : !hw.inout<uarray<165xi32>>, i8
            %1007 = sv.read_inout %1006 : !hw.inout<i32>
            %1008 = comb.extract %1007 from 8 : (i32) -> i24
            %1009 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %1010 = sv.read_inout %1009 : !hw.inout<i32>
            %1011 = comb.extract %1010 from 0 : (i32) -> i8
            %1012 = comb.concat %1011, %1008 : i8, i24
            %1013 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1014 = sv.struct_field_inout %1013["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1014, %1012 : i32
            %1015 = sv.array_index_inout %_RANDOM[%c47_i8] : !hw.inout<uarray<165xi32>>, i8
            %1016 = sv.read_inout %1015 : !hw.inout<i32>
            %1017 = comb.extract %1016 from 3 : (i32) -> i5
            %1018 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1019 = sv.struct_field_inout %1018["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1019, %1017 : i5
            %1020 = sv.array_index_inout %_RANDOM[%c48_i8] : !hw.inout<uarray<165xi32>>, i8
            %1021 = sv.read_inout %1020 : !hw.inout<i32>
            %1022 = comb.extract %1021 from 30 : (i32) -> i2
            %1023 = sv.array_index_inout %_RANDOM[%c47_i8] : !hw.inout<uarray<165xi32>>, i8
            %1024 = sv.read_inout %1023 : !hw.inout<i32>
            %1025 = comb.extract %1024 from 0 : (i32) -> i3
            %1026 = comb.concat %1025, %1022 : i3, i2
            %1027 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1028 = sv.struct_field_inout %1027["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1028, %1026 : i5
            %1029 = sv.array_index_inout %_RANDOM[%c48_i8] : !hw.inout<uarray<165xi32>>, i8
            %1030 = sv.read_inout %1029 : !hw.inout<i32>
            %1031 = comb.extract %1030 from 25 : (i32) -> i5
            %1032 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1033 = sv.struct_field_inout %1032["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1033, %1031 : i5
            %1034 = sv.array_index_inout %_RANDOM[%c49_i8] : !hw.inout<uarray<165xi32>>, i8
            %1035 = sv.read_inout %1034 : !hw.inout<i32>
            %1036 = comb.extract %1035 from 25 : (i32) -> i7
            %1037 = sv.array_index_inout %_RANDOM[%c48_i8] : !hw.inout<uarray<165xi32>>, i8
            %1038 = sv.read_inout %1037 : !hw.inout<i32>
            %1039 = comb.extract %1038 from 0 : (i32) -> i25
            %1040 = comb.concat %1039, %1036 : i25, i7
            %1041 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1042 = sv.struct_field_inout %1041["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1042, %1040 : i32
            %1043 = sv.array_index_inout %_RANDOM[%c50_i8] : !hw.inout<uarray<165xi32>>, i8
            %1044 = sv.read_inout %1043 : !hw.inout<i32>
            %1045 = comb.extract %1044 from 25 : (i32) -> i7
            %1046 = sv.array_index_inout %_RANDOM[%c49_i8] : !hw.inout<uarray<165xi32>>, i8
            %1047 = sv.read_inout %1046 : !hw.inout<i32>
            %1048 = comb.extract %1047 from 0 : (i32) -> i25
            %1049 = comb.concat %1048, %1045 : i25, i7
            %1050 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1051 = sv.struct_field_inout %1050["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1051, %1049 : i32
            %1052 = sv.array_index_inout %_RANDOM[%c51_i8] : !hw.inout<uarray<165xi32>>, i8
            %1053 = sv.read_inout %1052 : !hw.inout<i32>
            %1054 = comb.extract %1053 from 25 : (i32) -> i7
            %1055 = sv.array_index_inout %_RANDOM[%c50_i8] : !hw.inout<uarray<165xi32>>, i8
            %1056 = sv.read_inout %1055 : !hw.inout<i32>
            %1057 = comb.extract %1056 from 0 : (i32) -> i25
            %1058 = comb.concat %1057, %1054 : i25, i7
            %1059 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1060 = sv.struct_field_inout %1059["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1060, %1058 : i32
            %1061 = sv.array_index_inout %_RANDOM[%c52_i8] : !hw.inout<uarray<165xi32>>, i8
            %1062 = sv.read_inout %1061 : !hw.inout<i32>
            %1063 = comb.extract %1062 from 25 : (i32) -> i7
            %1064 = sv.array_index_inout %_RANDOM[%c51_i8] : !hw.inout<uarray<165xi32>>, i8
            %1065 = sv.read_inout %1064 : !hw.inout<i32>
            %1066 = comb.extract %1065 from 0 : (i32) -> i25
            %1067 = comb.concat %1066, %1063 : i25, i7
            %1068 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1069 = sv.struct_field_inout %1068["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1069, %1067 : i32
            %1070 = sv.array_index_inout %_RANDOM[%c53_i8] : !hw.inout<uarray<165xi32>>, i8
            %1071 = sv.read_inout %1070 : !hw.inout<i32>
            %1072 = comb.extract %1071 from 25 : (i32) -> i7
            %1073 = sv.array_index_inout %_RANDOM[%c52_i8] : !hw.inout<uarray<165xi32>>, i8
            %1074 = sv.read_inout %1073 : !hw.inout<i32>
            %1075 = comb.extract %1074 from 0 : (i32) -> i25
            %1076 = comb.concat %1075, %1072 : i25, i7
            %1077 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1078 = sv.struct_field_inout %1077["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1078, %1076 : i32
            %1079 = sv.array_index_inout %_RANDOM[%c54_i8] : !hw.inout<uarray<165xi32>>, i8
            %1080 = sv.read_inout %1079 : !hw.inout<i32>
            %1081 = comb.extract %1080 from 25 : (i32) -> i7
            %1082 = sv.array_index_inout %_RANDOM[%c53_i8] : !hw.inout<uarray<165xi32>>, i8
            %1083 = sv.read_inout %1082 : !hw.inout<i32>
            %1084 = comb.extract %1083 from 0 : (i32) -> i25
            %1085 = comb.concat %1084, %1081 : i25, i7
            %1086 = sv.array_index_inout %decStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1087 = sv.struct_field_inout %1086["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1087, %1085 : i32
            %1088 = sv.array_index_inout %_RANDOM[%c54_i8] : !hw.inout<uarray<165xi32>>, i8
            %1089 = sv.read_inout %1088 : !hw.inout<i32>
            %1090 = comb.extract %1089 from 23 : (i32) -> i2
            %1091 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1092 = sv.struct_field_inout %1091["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1092, %1090 : i2
            %1093 = sv.array_index_inout %_RANDOM[%c54_i8] : !hw.inout<uarray<165xi32>>, i8
            %1094 = sv.read_inout %1093 : !hw.inout<i32>
            %1095 = comb.extract %1094 from 22 : (i32) -> i1
            %1096 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1097 = sv.struct_field_inout %1096["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1097, %1095 : i1
            %1098 = sv.array_index_inout %_RANDOM[%c55_i8] : !hw.inout<uarray<165xi32>>, i8
            %1099 = sv.read_inout %1098 : !hw.inout<i32>
            %1100 = comb.extract %1099 from 22 : (i32) -> i10
            %1101 = sv.array_index_inout %_RANDOM[%c54_i8] : !hw.inout<uarray<165xi32>>, i8
            %1102 = sv.read_inout %1101 : !hw.inout<i32>
            %1103 = comb.extract %1102 from 0 : (i32) -> i22
            %1104 = comb.concat %1103, %1100 : i22, i10
            %1105 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1106 = sv.struct_field_inout %1105["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1106, %1104 : i32
            %1107 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1108 = sv.read_inout %1107 : !hw.inout<i32>
            %1109 = comb.extract %1108 from 22 : (i32) -> i10
            %1110 = sv.array_index_inout %_RANDOM[%c55_i8] : !hw.inout<uarray<165xi32>>, i8
            %1111 = sv.read_inout %1110 : !hw.inout<i32>
            %1112 = comb.extract %1111 from 0 : (i32) -> i22
            %1113 = comb.concat %1112, %1109 : i22, i10
            %1114 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1115 = sv.struct_field_inout %1114["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1115, %1113 : i32
            %1116 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1117 = sv.read_inout %1116 : !hw.inout<i32>
            %1118 = comb.extract %1117 from 21 : (i32) -> i1
            %1119 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1120 = sv.struct_field_inout %1119["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1120, %1118 : i1
            %1121 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1122 = sv.read_inout %1121 : !hw.inout<i32>
            %1123 = comb.extract %1122 from 20 : (i32) -> i1
            %1124 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1125 = sv.struct_field_inout %1124["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1125, %1123 : i1
            %1126 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1127 = sv.read_inout %1126 : !hw.inout<i32>
            %1128 = comb.extract %1127 from 19 : (i32) -> i1
            %1129 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1130 = sv.struct_field_inout %1129["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1130, %1128 : i1
            %1131 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1132 = sv.read_inout %1131 : !hw.inout<i32>
            %1133 = comb.extract %1132 from 18 : (i32) -> i1
            %1134 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1135 = sv.struct_field_inout %1134["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1135, %1133 : i1
            %1136 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1137 = sv.read_inout %1136 : !hw.inout<i32>
            %1138 = comb.extract %1137 from 17 : (i32) -> i1
            %1139 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1140 = sv.struct_field_inout %1139["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1140, %1138 : i1
            %1141 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1142 = sv.read_inout %1141 : !hw.inout<i32>
            %1143 = comb.extract %1142 from 16 : (i32) -> i1
            %1144 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1145 = sv.struct_field_inout %1144["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1145, %1143 : i1
            %1146 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1147 = sv.read_inout %1146 : !hw.inout<i32>
            %1148 = comb.extract %1147 from 15 : (i32) -> i1
            %1149 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1150 = sv.struct_field_inout %1149["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1150, %1148 : i1
            %1151 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1152 = sv.read_inout %1151 : !hw.inout<i32>
            %1153 = comb.extract %1152 from 14 : (i32) -> i1
            %1154 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1155 = sv.struct_field_inout %1154["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1155, %1153 : i1
            %1156 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1157 = sv.read_inout %1156 : !hw.inout<i32>
            %1158 = comb.extract %1157 from 13 : (i32) -> i1
            %1159 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1160 = sv.struct_field_inout %1159["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1160, %1158 : i1
            %1161 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1162 = sv.read_inout %1161 : !hw.inout<i32>
            %1163 = comb.extract %1162 from 12 : (i32) -> i1
            %1164 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1165 = sv.struct_field_inout %1164["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1165, %1163 : i1
            %1166 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1167 = sv.read_inout %1166 : !hw.inout<i32>
            %1168 = comb.extract %1167 from 7 : (i32) -> i5
            %1169 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1170 = sv.struct_field_inout %1169["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1170, %1168 : i5
            %1171 = sv.array_index_inout %_RANDOM[%c57_i8] : !hw.inout<uarray<165xi32>>, i8
            %1172 = sv.read_inout %1171 : !hw.inout<i32>
            %1173 = comb.extract %1172 from 7 : (i32) -> i25
            %1174 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1175 = sv.read_inout %1174 : !hw.inout<i32>
            %1176 = comb.extract %1175 from 0 : (i32) -> i7
            %1177 = comb.concat %1176, %1173 : i7, i25
            %1178 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1179 = sv.struct_field_inout %1178["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1179, %1177 : i32
            %1180 = sv.array_index_inout %_RANDOM[%c57_i8] : !hw.inout<uarray<165xi32>>, i8
            %1181 = sv.read_inout %1180 : !hw.inout<i32>
            %1182 = comb.extract %1181 from 2 : (i32) -> i5
            %1183 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1184 = sv.struct_field_inout %1183["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1184, %1182 : i5
            %1185 = sv.array_index_inout %_RANDOM[%c58_i8] : !hw.inout<uarray<165xi32>>, i8
            %1186 = sv.read_inout %1185 : !hw.inout<i32>
            %1187 = comb.extract %1186 from 29 : (i32) -> i3
            %1188 = sv.array_index_inout %_RANDOM[%c57_i8] : !hw.inout<uarray<165xi32>>, i8
            %1189 = sv.read_inout %1188 : !hw.inout<i32>
            %1190 = comb.extract %1189 from 0 : (i32) -> i2
            %1191 = comb.concat %1190, %1187 : i2, i3
            %1192 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1193 = sv.struct_field_inout %1192["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1193, %1191 : i5
            %1194 = sv.array_index_inout %_RANDOM[%c58_i8] : !hw.inout<uarray<165xi32>>, i8
            %1195 = sv.read_inout %1194 : !hw.inout<i32>
            %1196 = comb.extract %1195 from 24 : (i32) -> i5
            %1197 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1198 = sv.struct_field_inout %1197["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1198, %1196 : i5
            %1199 = sv.array_index_inout %_RANDOM[%c59_i8] : !hw.inout<uarray<165xi32>>, i8
            %1200 = sv.read_inout %1199 : !hw.inout<i32>
            %1201 = comb.extract %1200 from 24 : (i32) -> i8
            %1202 = sv.array_index_inout %_RANDOM[%c58_i8] : !hw.inout<uarray<165xi32>>, i8
            %1203 = sv.read_inout %1202 : !hw.inout<i32>
            %1204 = comb.extract %1203 from 0 : (i32) -> i24
            %1205 = comb.concat %1204, %1201 : i24, i8
            %1206 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1207 = sv.struct_field_inout %1206["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1207, %1205 : i32
            %1208 = sv.array_index_inout %_RANDOM[%c60_i8] : !hw.inout<uarray<165xi32>>, i8
            %1209 = sv.read_inout %1208 : !hw.inout<i32>
            %1210 = comb.extract %1209 from 24 : (i32) -> i8
            %1211 = sv.array_index_inout %_RANDOM[%c59_i8] : !hw.inout<uarray<165xi32>>, i8
            %1212 = sv.read_inout %1211 : !hw.inout<i32>
            %1213 = comb.extract %1212 from 0 : (i32) -> i24
            %1214 = comb.concat %1213, %1210 : i24, i8
            %1215 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1216 = sv.struct_field_inout %1215["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1216, %1214 : i32
            %1217 = sv.array_index_inout %_RANDOM[%c61_i8] : !hw.inout<uarray<165xi32>>, i8
            %1218 = sv.read_inout %1217 : !hw.inout<i32>
            %1219 = comb.extract %1218 from 24 : (i32) -> i8
            %1220 = sv.array_index_inout %_RANDOM[%c60_i8] : !hw.inout<uarray<165xi32>>, i8
            %1221 = sv.read_inout %1220 : !hw.inout<i32>
            %1222 = comb.extract %1221 from 0 : (i32) -> i24
            %1223 = comb.concat %1222, %1219 : i24, i8
            %1224 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1225 = sv.struct_field_inout %1224["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1225, %1223 : i32
            %1226 = sv.array_index_inout %_RANDOM[%c62_i8] : !hw.inout<uarray<165xi32>>, i8
            %1227 = sv.read_inout %1226 : !hw.inout<i32>
            %1228 = comb.extract %1227 from 24 : (i32) -> i8
            %1229 = sv.array_index_inout %_RANDOM[%c61_i8] : !hw.inout<uarray<165xi32>>, i8
            %1230 = sv.read_inout %1229 : !hw.inout<i32>
            %1231 = comb.extract %1230 from 0 : (i32) -> i24
            %1232 = comb.concat %1231, %1228 : i24, i8
            %1233 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1234 = sv.struct_field_inout %1233["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1234, %1232 : i32
            %1235 = sv.array_index_inout %_RANDOM[%c63_i8] : !hw.inout<uarray<165xi32>>, i8
            %1236 = sv.read_inout %1235 : !hw.inout<i32>
            %1237 = comb.extract %1236 from 24 : (i32) -> i8
            %1238 = sv.array_index_inout %_RANDOM[%c62_i8] : !hw.inout<uarray<165xi32>>, i8
            %1239 = sv.read_inout %1238 : !hw.inout<i32>
            %1240 = comb.extract %1239 from 0 : (i32) -> i24
            %1241 = comb.concat %1240, %1237 : i24, i8
            %1242 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1243 = sv.struct_field_inout %1242["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1243, %1241 : i32
            %1244 = sv.array_index_inout %_RANDOM[%c64_i8] : !hw.inout<uarray<165xi32>>, i8
            %1245 = sv.read_inout %1244 : !hw.inout<i32>
            %1246 = comb.extract %1245 from 24 : (i32) -> i8
            %1247 = sv.array_index_inout %_RANDOM[%c63_i8] : !hw.inout<uarray<165xi32>>, i8
            %1248 = sv.read_inout %1247 : !hw.inout<i32>
            %1249 = comb.extract %1248 from 0 : (i32) -> i24
            %1250 = comb.concat %1249, %1246 : i24, i8
            %1251 = sv.array_index_inout %decStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1252 = sv.struct_field_inout %1251["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1252, %1250 : i32
            %1253 = sv.array_index_inout %_RANDOM[%c64_i8] : !hw.inout<uarray<165xi32>>, i8
            %1254 = sv.read_inout %1253 : !hw.inout<i32>
            %1255 = comb.extract %1254 from 22 : (i32) -> i2
            %1256 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1257 = sv.struct_field_inout %1256["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1257, %1255 : i2
            %1258 = sv.array_index_inout %_RANDOM[%c64_i8] : !hw.inout<uarray<165xi32>>, i8
            %1259 = sv.read_inout %1258 : !hw.inout<i32>
            %1260 = comb.extract %1259 from 21 : (i32) -> i1
            %1261 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1262 = sv.struct_field_inout %1261["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1262, %1260 : i1
            %1263 = sv.array_index_inout %_RANDOM[%c65_i8] : !hw.inout<uarray<165xi32>>, i8
            %1264 = sv.read_inout %1263 : !hw.inout<i32>
            %1265 = comb.extract %1264 from 21 : (i32) -> i11
            %1266 = sv.array_index_inout %_RANDOM[%c64_i8] : !hw.inout<uarray<165xi32>>, i8
            %1267 = sv.read_inout %1266 : !hw.inout<i32>
            %1268 = comb.extract %1267 from 0 : (i32) -> i21
            %1269 = comb.concat %1268, %1265 : i21, i11
            %1270 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1271 = sv.struct_field_inout %1270["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1271, %1269 : i32
            %1272 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1273 = sv.read_inout %1272 : !hw.inout<i32>
            %1274 = comb.extract %1273 from 21 : (i32) -> i11
            %1275 = sv.array_index_inout %_RANDOM[%c65_i8] : !hw.inout<uarray<165xi32>>, i8
            %1276 = sv.read_inout %1275 : !hw.inout<i32>
            %1277 = comb.extract %1276 from 0 : (i32) -> i21
            %1278 = comb.concat %1277, %1274 : i21, i11
            %1279 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1280 = sv.struct_field_inout %1279["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1280, %1278 : i32
            %1281 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1282 = sv.read_inout %1281 : !hw.inout<i32>
            %1283 = comb.extract %1282 from 20 : (i32) -> i1
            %1284 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1285 = sv.struct_field_inout %1284["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1285, %1283 : i1
            %1286 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1287 = sv.read_inout %1286 : !hw.inout<i32>
            %1288 = comb.extract %1287 from 19 : (i32) -> i1
            %1289 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1290 = sv.struct_field_inout %1289["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1290, %1288 : i1
            %1291 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1292 = sv.read_inout %1291 : !hw.inout<i32>
            %1293 = comb.extract %1292 from 18 : (i32) -> i1
            %1294 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1295 = sv.struct_field_inout %1294["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1295, %1293 : i1
            %1296 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1297 = sv.read_inout %1296 : !hw.inout<i32>
            %1298 = comb.extract %1297 from 17 : (i32) -> i1
            %1299 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1300 = sv.struct_field_inout %1299["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1300, %1298 : i1
            %1301 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1302 = sv.read_inout %1301 : !hw.inout<i32>
            %1303 = comb.extract %1302 from 16 : (i32) -> i1
            %1304 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1305 = sv.struct_field_inout %1304["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1305, %1303 : i1
            %1306 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1307 = sv.read_inout %1306 : !hw.inout<i32>
            %1308 = comb.extract %1307 from 15 : (i32) -> i1
            %1309 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1310 = sv.struct_field_inout %1309["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1310, %1308 : i1
            %1311 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1312 = sv.read_inout %1311 : !hw.inout<i32>
            %1313 = comb.extract %1312 from 14 : (i32) -> i1
            %1314 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1315 = sv.struct_field_inout %1314["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1315, %1313 : i1
            %1316 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1317 = sv.read_inout %1316 : !hw.inout<i32>
            %1318 = comb.extract %1317 from 13 : (i32) -> i1
            %1319 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1320 = sv.struct_field_inout %1319["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1320, %1318 : i1
            %1321 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1322 = sv.read_inout %1321 : !hw.inout<i32>
            %1323 = comb.extract %1322 from 12 : (i32) -> i1
            %1324 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1325 = sv.struct_field_inout %1324["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1325, %1323 : i1
            %1326 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1327 = sv.read_inout %1326 : !hw.inout<i32>
            %1328 = comb.extract %1327 from 11 : (i32) -> i1
            %1329 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1330 = sv.struct_field_inout %1329["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1330, %1328 : i1
            %1331 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1332 = sv.read_inout %1331 : !hw.inout<i32>
            %1333 = comb.extract %1332 from 6 : (i32) -> i5
            %1334 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1335 = sv.struct_field_inout %1334["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1335, %1333 : i5
            %1336 = sv.array_index_inout %_RANDOM[%c67_i8] : !hw.inout<uarray<165xi32>>, i8
            %1337 = sv.read_inout %1336 : !hw.inout<i32>
            %1338 = comb.extract %1337 from 6 : (i32) -> i26
            %1339 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1340 = sv.read_inout %1339 : !hw.inout<i32>
            %1341 = comb.extract %1340 from 0 : (i32) -> i6
            %1342 = comb.concat %1341, %1338 : i6, i26
            %1343 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1344 = sv.struct_field_inout %1343["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1344, %1342 : i32
            %1345 = sv.array_index_inout %_RANDOM[%c67_i8] : !hw.inout<uarray<165xi32>>, i8
            %1346 = sv.read_inout %1345 : !hw.inout<i32>
            %1347 = comb.extract %1346 from 1 : (i32) -> i5
            %1348 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1349 = sv.struct_field_inout %1348["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1349, %1347 : i5
            %1350 = sv.array_index_inout %_RANDOM[%c68_i8] : !hw.inout<uarray<165xi32>>, i8
            %1351 = sv.read_inout %1350 : !hw.inout<i32>
            %1352 = comb.extract %1351 from 28 : (i32) -> i4
            %1353 = sv.array_index_inout %_RANDOM[%c67_i8] : !hw.inout<uarray<165xi32>>, i8
            %1354 = sv.read_inout %1353 : !hw.inout<i32>
            %1355 = comb.extract %1354 from 0 : (i32) -> i1
            %1356 = comb.concat %1355, %1352 : i1, i4
            %1357 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1358 = sv.struct_field_inout %1357["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1358, %1356 : i5
            %1359 = sv.array_index_inout %_RANDOM[%c68_i8] : !hw.inout<uarray<165xi32>>, i8
            %1360 = sv.read_inout %1359 : !hw.inout<i32>
            %1361 = comb.extract %1360 from 23 : (i32) -> i5
            %1362 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1363 = sv.struct_field_inout %1362["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1363, %1361 : i5
            %1364 = sv.array_index_inout %_RANDOM[%c69_i8] : !hw.inout<uarray<165xi32>>, i8
            %1365 = sv.read_inout %1364 : !hw.inout<i32>
            %1366 = comb.extract %1365 from 23 : (i32) -> i9
            %1367 = sv.array_index_inout %_RANDOM[%c68_i8] : !hw.inout<uarray<165xi32>>, i8
            %1368 = sv.read_inout %1367 : !hw.inout<i32>
            %1369 = comb.extract %1368 from 0 : (i32) -> i23
            %1370 = comb.concat %1369, %1366 : i23, i9
            %1371 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1372 = sv.struct_field_inout %1371["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1372, %1370 : i32
            %1373 = sv.array_index_inout %_RANDOM[%c70_i8] : !hw.inout<uarray<165xi32>>, i8
            %1374 = sv.read_inout %1373 : !hw.inout<i32>
            %1375 = comb.extract %1374 from 23 : (i32) -> i9
            %1376 = sv.array_index_inout %_RANDOM[%c69_i8] : !hw.inout<uarray<165xi32>>, i8
            %1377 = sv.read_inout %1376 : !hw.inout<i32>
            %1378 = comb.extract %1377 from 0 : (i32) -> i23
            %1379 = comb.concat %1378, %1375 : i23, i9
            %1380 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1381 = sv.struct_field_inout %1380["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1381, %1379 : i32
            %1382 = sv.array_index_inout %_RANDOM[%c71_i8] : !hw.inout<uarray<165xi32>>, i8
            %1383 = sv.read_inout %1382 : !hw.inout<i32>
            %1384 = comb.extract %1383 from 23 : (i32) -> i9
            %1385 = sv.array_index_inout %_RANDOM[%c70_i8] : !hw.inout<uarray<165xi32>>, i8
            %1386 = sv.read_inout %1385 : !hw.inout<i32>
            %1387 = comb.extract %1386 from 0 : (i32) -> i23
            %1388 = comb.concat %1387, %1384 : i23, i9
            %1389 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1390 = sv.struct_field_inout %1389["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1390, %1388 : i32
            %1391 = sv.array_index_inout %_RANDOM[%c72_i8] : !hw.inout<uarray<165xi32>>, i8
            %1392 = sv.read_inout %1391 : !hw.inout<i32>
            %1393 = comb.extract %1392 from 23 : (i32) -> i9
            %1394 = sv.array_index_inout %_RANDOM[%c71_i8] : !hw.inout<uarray<165xi32>>, i8
            %1395 = sv.read_inout %1394 : !hw.inout<i32>
            %1396 = comb.extract %1395 from 0 : (i32) -> i23
            %1397 = comb.concat %1396, %1393 : i23, i9
            %1398 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1399 = sv.struct_field_inout %1398["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1399, %1397 : i32
            %1400 = sv.array_index_inout %_RANDOM[%c73_i8] : !hw.inout<uarray<165xi32>>, i8
            %1401 = sv.read_inout %1400 : !hw.inout<i32>
            %1402 = comb.extract %1401 from 23 : (i32) -> i9
            %1403 = sv.array_index_inout %_RANDOM[%c72_i8] : !hw.inout<uarray<165xi32>>, i8
            %1404 = sv.read_inout %1403 : !hw.inout<i32>
            %1405 = comb.extract %1404 from 0 : (i32) -> i23
            %1406 = comb.concat %1405, %1402 : i23, i9
            %1407 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1408 = sv.struct_field_inout %1407["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1408, %1406 : i32
            %1409 = sv.array_index_inout %_RANDOM[%c74_i8] : !hw.inout<uarray<165xi32>>, i8
            %1410 = sv.read_inout %1409 : !hw.inout<i32>
            %1411 = comb.extract %1410 from 23 : (i32) -> i9
            %1412 = sv.array_index_inout %_RANDOM[%c73_i8] : !hw.inout<uarray<165xi32>>, i8
            %1413 = sv.read_inout %1412 : !hw.inout<i32>
            %1414 = comb.extract %1413 from 0 : (i32) -> i23
            %1415 = comb.concat %1414, %1411 : i23, i9
            %1416 = sv.array_index_inout %decStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1417 = sv.struct_field_inout %1416["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1417, %1415 : i32
            %1418 = sv.array_index_inout %_RANDOM[%c74_i8] : !hw.inout<uarray<165xi32>>, i8
            %1419 = sv.read_inout %1418 : !hw.inout<i32>
            %1420 = comb.extract %1419 from 21 : (i32) -> i2
            %1421 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1422 = sv.struct_field_inout %1421["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1422, %1420 : i2
            %1423 = sv.array_index_inout %_RANDOM[%c74_i8] : !hw.inout<uarray<165xi32>>, i8
            %1424 = sv.read_inout %1423 : !hw.inout<i32>
            %1425 = comb.extract %1424 from 20 : (i32) -> i1
            %1426 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1427 = sv.struct_field_inout %1426["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1427, %1425 : i1
            %1428 = sv.array_index_inout %_RANDOM[%c75_i8] : !hw.inout<uarray<165xi32>>, i8
            %1429 = sv.read_inout %1428 : !hw.inout<i32>
            %1430 = comb.extract %1429 from 20 : (i32) -> i12
            %1431 = sv.array_index_inout %_RANDOM[%c74_i8] : !hw.inout<uarray<165xi32>>, i8
            %1432 = sv.read_inout %1431 : !hw.inout<i32>
            %1433 = comb.extract %1432 from 0 : (i32) -> i20
            %1434 = comb.concat %1433, %1430 : i20, i12
            %1435 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1436 = sv.struct_field_inout %1435["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1436, %1434 : i32
            %1437 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1438 = sv.read_inout %1437 : !hw.inout<i32>
            %1439 = comb.extract %1438 from 20 : (i32) -> i12
            %1440 = sv.array_index_inout %_RANDOM[%c75_i8] : !hw.inout<uarray<165xi32>>, i8
            %1441 = sv.read_inout %1440 : !hw.inout<i32>
            %1442 = comb.extract %1441 from 0 : (i32) -> i20
            %1443 = comb.concat %1442, %1439 : i20, i12
            %1444 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1445 = sv.struct_field_inout %1444["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1445, %1443 : i32
            %1446 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1447 = sv.read_inout %1446 : !hw.inout<i32>
            %1448 = comb.extract %1447 from 19 : (i32) -> i1
            %1449 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1450 = sv.struct_field_inout %1449["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1450, %1448 : i1
            %1451 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1452 = sv.read_inout %1451 : !hw.inout<i32>
            %1453 = comb.extract %1452 from 18 : (i32) -> i1
            %1454 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1455 = sv.struct_field_inout %1454["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1455, %1453 : i1
            %1456 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1457 = sv.read_inout %1456 : !hw.inout<i32>
            %1458 = comb.extract %1457 from 17 : (i32) -> i1
            %1459 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1460 = sv.struct_field_inout %1459["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1460, %1458 : i1
            %1461 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1462 = sv.read_inout %1461 : !hw.inout<i32>
            %1463 = comb.extract %1462 from 16 : (i32) -> i1
            %1464 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1465 = sv.struct_field_inout %1464["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1465, %1463 : i1
            %1466 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1467 = sv.read_inout %1466 : !hw.inout<i32>
            %1468 = comb.extract %1467 from 15 : (i32) -> i1
            %1469 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1470 = sv.struct_field_inout %1469["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1470, %1468 : i1
            %1471 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1472 = sv.read_inout %1471 : !hw.inout<i32>
            %1473 = comb.extract %1472 from 14 : (i32) -> i1
            %1474 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1475 = sv.struct_field_inout %1474["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1475, %1473 : i1
            %1476 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1477 = sv.read_inout %1476 : !hw.inout<i32>
            %1478 = comb.extract %1477 from 13 : (i32) -> i1
            %1479 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1480 = sv.struct_field_inout %1479["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1480, %1478 : i1
            %1481 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1482 = sv.read_inout %1481 : !hw.inout<i32>
            %1483 = comb.extract %1482 from 12 : (i32) -> i1
            %1484 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1485 = sv.struct_field_inout %1484["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1485, %1483 : i1
            %1486 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1487 = sv.read_inout %1486 : !hw.inout<i32>
            %1488 = comb.extract %1487 from 11 : (i32) -> i1
            %1489 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1490 = sv.struct_field_inout %1489["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1490, %1488 : i1
            %1491 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1492 = sv.read_inout %1491 : !hw.inout<i32>
            %1493 = comb.extract %1492 from 10 : (i32) -> i1
            %1494 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1495 = sv.struct_field_inout %1494["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1495, %1493 : i1
            %1496 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1497 = sv.read_inout %1496 : !hw.inout<i32>
            %1498 = comb.extract %1497 from 5 : (i32) -> i5
            %1499 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1500 = sv.struct_field_inout %1499["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1500, %1498 : i5
            %1501 = sv.array_index_inout %_RANDOM[%c77_i8] : !hw.inout<uarray<165xi32>>, i8
            %1502 = sv.read_inout %1501 : !hw.inout<i32>
            %1503 = comb.extract %1502 from 5 : (i32) -> i27
            %1504 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1505 = sv.read_inout %1504 : !hw.inout<i32>
            %1506 = comb.extract %1505 from 0 : (i32) -> i5
            %1507 = comb.concat %1506, %1503 : i5, i27
            %1508 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1509 = sv.struct_field_inout %1508["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1509, %1507 : i32
            %1510 = sv.array_index_inout %_RANDOM[%c77_i8] : !hw.inout<uarray<165xi32>>, i8
            %1511 = sv.read_inout %1510 : !hw.inout<i32>
            %1512 = comb.extract %1511 from 0 : (i32) -> i5
            %1513 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1514 = sv.struct_field_inout %1513["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1514, %1512 : i5
            %1515 = sv.array_index_inout %_RANDOM[%c78_i8] : !hw.inout<uarray<165xi32>>, i8
            %1516 = sv.read_inout %1515 : !hw.inout<i32>
            %1517 = comb.extract %1516 from 27 : (i32) -> i5
            %1518 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1519 = sv.struct_field_inout %1518["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1519, %1517 : i5
            %1520 = sv.array_index_inout %_RANDOM[%c78_i8] : !hw.inout<uarray<165xi32>>, i8
            %1521 = sv.read_inout %1520 : !hw.inout<i32>
            %1522 = comb.extract %1521 from 22 : (i32) -> i5
            %1523 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1524 = sv.struct_field_inout %1523["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1524, %1522 : i5
            %1525 = sv.array_index_inout %_RANDOM[%c79_i8] : !hw.inout<uarray<165xi32>>, i8
            %1526 = sv.read_inout %1525 : !hw.inout<i32>
            %1527 = comb.extract %1526 from 22 : (i32) -> i10
            %1528 = sv.array_index_inout %_RANDOM[%c78_i8] : !hw.inout<uarray<165xi32>>, i8
            %1529 = sv.read_inout %1528 : !hw.inout<i32>
            %1530 = comb.extract %1529 from 0 : (i32) -> i22
            %1531 = comb.concat %1530, %1527 : i22, i10
            %1532 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1533 = sv.struct_field_inout %1532["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1533, %1531 : i32
            %1534 = sv.array_index_inout %_RANDOM[%c80_i8] : !hw.inout<uarray<165xi32>>, i8
            %1535 = sv.read_inout %1534 : !hw.inout<i32>
            %1536 = comb.extract %1535 from 22 : (i32) -> i10
            %1537 = sv.array_index_inout %_RANDOM[%c79_i8] : !hw.inout<uarray<165xi32>>, i8
            %1538 = sv.read_inout %1537 : !hw.inout<i32>
            %1539 = comb.extract %1538 from 0 : (i32) -> i22
            %1540 = comb.concat %1539, %1536 : i22, i10
            %1541 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1542 = sv.struct_field_inout %1541["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1542, %1540 : i32
            %1543 = sv.array_index_inout %_RANDOM[%c81_i8] : !hw.inout<uarray<165xi32>>, i8
            %1544 = sv.read_inout %1543 : !hw.inout<i32>
            %1545 = comb.extract %1544 from 22 : (i32) -> i10
            %1546 = sv.array_index_inout %_RANDOM[%c80_i8] : !hw.inout<uarray<165xi32>>, i8
            %1547 = sv.read_inout %1546 : !hw.inout<i32>
            %1548 = comb.extract %1547 from 0 : (i32) -> i22
            %1549 = comb.concat %1548, %1545 : i22, i10
            %1550 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1551 = sv.struct_field_inout %1550["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1551, %1549 : i32
            %1552 = sv.array_index_inout %_RANDOM[%c82_i8] : !hw.inout<uarray<165xi32>>, i8
            %1553 = sv.read_inout %1552 : !hw.inout<i32>
            %1554 = comb.extract %1553 from 22 : (i32) -> i10
            %1555 = sv.array_index_inout %_RANDOM[%c81_i8] : !hw.inout<uarray<165xi32>>, i8
            %1556 = sv.read_inout %1555 : !hw.inout<i32>
            %1557 = comb.extract %1556 from 0 : (i32) -> i22
            %1558 = comb.concat %1557, %1554 : i22, i10
            %1559 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1560 = sv.struct_field_inout %1559["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1560, %1558 : i32
            %1561 = sv.array_index_inout %_RANDOM[%c83_i8] : !hw.inout<uarray<165xi32>>, i8
            %1562 = sv.read_inout %1561 : !hw.inout<i32>
            %1563 = comb.extract %1562 from 22 : (i32) -> i10
            %1564 = sv.array_index_inout %_RANDOM[%c82_i8] : !hw.inout<uarray<165xi32>>, i8
            %1565 = sv.read_inout %1564 : !hw.inout<i32>
            %1566 = comb.extract %1565 from 0 : (i32) -> i22
            %1567 = comb.concat %1566, %1563 : i22, i10
            %1568 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1569 = sv.struct_field_inout %1568["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1569, %1567 : i32
            %1570 = sv.array_index_inout %_RANDOM[%c83_i8] : !hw.inout<uarray<165xi32>>, i8
            %1571 = sv.read_inout %1570 : !hw.inout<i32>
            %1572 = comb.extract %1571 from 0 : (i32) -> i22
            %1573 = comb.concat %1572, %922 : i22, i10
            %1574 = sv.array_index_inout %decStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1575 = sv.struct_field_inout %1574["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1575, %1573 : i32
            %1576 = sv.array_index_inout %_RANDOM[%c124_i8] : !hw.inout<uarray<165xi32>>, i8
            %1577 = sv.read_inout %1576 : !hw.inout<i32>
            %1578 = comb.extract %1577 from 0 : (i32) -> i14
            %1579 = sv.array_index_inout %_RANDOM[%c84_i8] : !hw.inout<uarray<165xi32>>, i8
            %1580 = sv.read_inout %1579 : !hw.inout<i32>
            %1581 = comb.extract %1580 from 30 : (i32) -> i2
            %1582 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1583 = sv.struct_field_inout %1582["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1583, %1581 : i2
            %1584 = sv.array_index_inout %_RANDOM[%c84_i8] : !hw.inout<uarray<165xi32>>, i8
            %1585 = sv.read_inout %1584 : !hw.inout<i32>
            %1586 = comb.extract %1585 from 29 : (i32) -> i1
            %1587 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1588 = sv.struct_field_inout %1587["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1588, %1586 : i1
            %1589 = sv.array_index_inout %_RANDOM[%c85_i8] : !hw.inout<uarray<165xi32>>, i8
            %1590 = sv.read_inout %1589 : !hw.inout<i32>
            %1591 = comb.extract %1590 from 19 : (i32) -> i13
            %1592 = sv.array_index_inout %_RANDOM[%c84_i8] : !hw.inout<uarray<165xi32>>, i8
            %1593 = sv.read_inout %1592 : !hw.inout<i32>
            %1594 = comb.extract %1593 from 10 : (i32) -> i19
            %1595 = comb.concat %1594, %1591 : i19, i13
            %1596 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1597 = sv.struct_field_inout %1596["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1597, %1595 : i32
            %1598 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1599 = sv.read_inout %1598 : !hw.inout<i32>
            %1600 = comb.extract %1599 from 19 : (i32) -> i13
            %1601 = sv.array_index_inout %_RANDOM[%c85_i8] : !hw.inout<uarray<165xi32>>, i8
            %1602 = sv.read_inout %1601 : !hw.inout<i32>
            %1603 = comb.extract %1602 from 0 : (i32) -> i19
            %1604 = comb.concat %1603, %1600 : i19, i13
            %1605 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1606 = sv.struct_field_inout %1605["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1606, %1604 : i32
            %1607 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1608 = sv.read_inout %1607 : !hw.inout<i32>
            %1609 = comb.extract %1608 from 18 : (i32) -> i1
            %1610 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1611 = sv.struct_field_inout %1610["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1611, %1609 : i1
            %1612 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1613 = sv.read_inout %1612 : !hw.inout<i32>
            %1614 = comb.extract %1613 from 17 : (i32) -> i1
            %1615 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1616 = sv.struct_field_inout %1615["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1616, %1614 : i1
            %1617 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1618 = sv.read_inout %1617 : !hw.inout<i32>
            %1619 = comb.extract %1618 from 16 : (i32) -> i1
            %1620 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1621 = sv.struct_field_inout %1620["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1621, %1619 : i1
            %1622 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1623 = sv.read_inout %1622 : !hw.inout<i32>
            %1624 = comb.extract %1623 from 15 : (i32) -> i1
            %1625 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1626 = sv.struct_field_inout %1625["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1626, %1624 : i1
            %1627 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1628 = sv.read_inout %1627 : !hw.inout<i32>
            %1629 = comb.extract %1628 from 14 : (i32) -> i1
            %1630 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1631 = sv.struct_field_inout %1630["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1631, %1629 : i1
            %1632 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1633 = sv.read_inout %1632 : !hw.inout<i32>
            %1634 = comb.extract %1633 from 13 : (i32) -> i1
            %1635 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1636 = sv.struct_field_inout %1635["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1636, %1634 : i1
            %1637 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1638 = sv.read_inout %1637 : !hw.inout<i32>
            %1639 = comb.extract %1638 from 12 : (i32) -> i1
            %1640 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1641 = sv.struct_field_inout %1640["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1641, %1639 : i1
            %1642 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1643 = sv.read_inout %1642 : !hw.inout<i32>
            %1644 = comb.extract %1643 from 11 : (i32) -> i1
            %1645 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1646 = sv.struct_field_inout %1645["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1646, %1644 : i1
            %1647 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1648 = sv.read_inout %1647 : !hw.inout<i32>
            %1649 = comb.extract %1648 from 10 : (i32) -> i1
            %1650 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1651 = sv.struct_field_inout %1650["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1651, %1649 : i1
            %1652 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1653 = sv.read_inout %1652 : !hw.inout<i32>
            %1654 = comb.extract %1653 from 9 : (i32) -> i1
            %1655 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1656 = sv.struct_field_inout %1655["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1656, %1654 : i1
            %1657 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1658 = sv.read_inout %1657 : !hw.inout<i32>
            %1659 = comb.extract %1658 from 4 : (i32) -> i5
            %1660 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1661 = sv.struct_field_inout %1660["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1661, %1659 : i5
            %1662 = sv.array_index_inout %_RANDOM[%c87_i8] : !hw.inout<uarray<165xi32>>, i8
            %1663 = sv.read_inout %1662 : !hw.inout<i32>
            %1664 = comb.extract %1663 from 4 : (i32) -> i28
            %1665 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1666 = sv.read_inout %1665 : !hw.inout<i32>
            %1667 = comb.extract %1666 from 0 : (i32) -> i4
            %1668 = comb.concat %1667, %1664 : i4, i28
            %1669 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1670 = sv.struct_field_inout %1669["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1670, %1668 : i32
            %1671 = sv.array_index_inout %_RANDOM[%c88_i8] : !hw.inout<uarray<165xi32>>, i8
            %1672 = sv.read_inout %1671 : !hw.inout<i32>
            %1673 = comb.extract %1672 from 31 : (i32) -> i1
            %1674 = sv.array_index_inout %_RANDOM[%c87_i8] : !hw.inout<uarray<165xi32>>, i8
            %1675 = sv.read_inout %1674 : !hw.inout<i32>
            %1676 = comb.extract %1675 from 0 : (i32) -> i4
            %1677 = comb.concat %1676, %1673 : i4, i1
            %1678 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1679 = sv.struct_field_inout %1678["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1679, %1677 : i5
            %1680 = sv.array_index_inout %_RANDOM[%c88_i8] : !hw.inout<uarray<165xi32>>, i8
            %1681 = sv.read_inout %1680 : !hw.inout<i32>
            %1682 = comb.extract %1681 from 26 : (i32) -> i5
            %1683 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1684 = sv.struct_field_inout %1683["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1684, %1682 : i5
            %1685 = sv.array_index_inout %_RANDOM[%c88_i8] : !hw.inout<uarray<165xi32>>, i8
            %1686 = sv.read_inout %1685 : !hw.inout<i32>
            %1687 = comb.extract %1686 from 21 : (i32) -> i5
            %1688 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1689 = sv.struct_field_inout %1688["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1689, %1687 : i5
            %1690 = sv.array_index_inout %_RANDOM[%c89_i8] : !hw.inout<uarray<165xi32>>, i8
            %1691 = sv.read_inout %1690 : !hw.inout<i32>
            %1692 = comb.extract %1691 from 21 : (i32) -> i11
            %1693 = sv.array_index_inout %_RANDOM[%c88_i8] : !hw.inout<uarray<165xi32>>, i8
            %1694 = sv.read_inout %1693 : !hw.inout<i32>
            %1695 = comb.extract %1694 from 0 : (i32) -> i21
            %1696 = comb.concat %1695, %1692 : i21, i11
            %1697 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1698 = sv.struct_field_inout %1697["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1698, %1696 : i32
            %1699 = sv.array_index_inout %_RANDOM[%c90_i8] : !hw.inout<uarray<165xi32>>, i8
            %1700 = sv.read_inout %1699 : !hw.inout<i32>
            %1701 = comb.extract %1700 from 21 : (i32) -> i11
            %1702 = sv.array_index_inout %_RANDOM[%c89_i8] : !hw.inout<uarray<165xi32>>, i8
            %1703 = sv.read_inout %1702 : !hw.inout<i32>
            %1704 = comb.extract %1703 from 0 : (i32) -> i21
            %1705 = comb.concat %1704, %1701 : i21, i11
            %1706 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1707 = sv.struct_field_inout %1706["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1707, %1705 : i32
            %1708 = sv.array_index_inout %_RANDOM[%c91_i8] : !hw.inout<uarray<165xi32>>, i8
            %1709 = sv.read_inout %1708 : !hw.inout<i32>
            %1710 = comb.extract %1709 from 21 : (i32) -> i11
            %1711 = sv.array_index_inout %_RANDOM[%c90_i8] : !hw.inout<uarray<165xi32>>, i8
            %1712 = sv.read_inout %1711 : !hw.inout<i32>
            %1713 = comb.extract %1712 from 0 : (i32) -> i21
            %1714 = comb.concat %1713, %1710 : i21, i11
            %1715 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1716 = sv.struct_field_inout %1715["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1716, %1714 : i32
            %1717 = sv.array_index_inout %_RANDOM[%c92_i8] : !hw.inout<uarray<165xi32>>, i8
            %1718 = sv.read_inout %1717 : !hw.inout<i32>
            %1719 = comb.extract %1718 from 21 : (i32) -> i11
            %1720 = sv.array_index_inout %_RANDOM[%c91_i8] : !hw.inout<uarray<165xi32>>, i8
            %1721 = sv.read_inout %1720 : !hw.inout<i32>
            %1722 = comb.extract %1721 from 0 : (i32) -> i21
            %1723 = comb.concat %1722, %1719 : i21, i11
            %1724 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1725 = sv.struct_field_inout %1724["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1725, %1723 : i32
            %1726 = sv.array_index_inout %_RANDOM[%c93_i8] : !hw.inout<uarray<165xi32>>, i8
            %1727 = sv.read_inout %1726 : !hw.inout<i32>
            %1728 = comb.extract %1727 from 21 : (i32) -> i11
            %1729 = sv.array_index_inout %_RANDOM[%c92_i8] : !hw.inout<uarray<165xi32>>, i8
            %1730 = sv.read_inout %1729 : !hw.inout<i32>
            %1731 = comb.extract %1730 from 0 : (i32) -> i21
            %1732 = comb.concat %1731, %1728 : i21, i11
            %1733 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1734 = sv.struct_field_inout %1733["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1734, %1732 : i32
            %1735 = sv.array_index_inout %_RANDOM[%c94_i8] : !hw.inout<uarray<165xi32>>, i8
            %1736 = sv.read_inout %1735 : !hw.inout<i32>
            %1737 = comb.extract %1736 from 21 : (i32) -> i11
            %1738 = sv.array_index_inout %_RANDOM[%c93_i8] : !hw.inout<uarray<165xi32>>, i8
            %1739 = sv.read_inout %1738 : !hw.inout<i32>
            %1740 = comb.extract %1739 from 0 : (i32) -> i21
            %1741 = comb.concat %1740, %1737 : i21, i11
            %1742 = sv.array_index_inout %exStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1743 = sv.struct_field_inout %1742["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1743, %1741 : i32
            %1744 = sv.array_index_inout %_RANDOM[%c94_i8] : !hw.inout<uarray<165xi32>>, i8
            %1745 = sv.read_inout %1744 : !hw.inout<i32>
            %1746 = comb.extract %1745 from 19 : (i32) -> i2
            %1747 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1748 = sv.struct_field_inout %1747["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1748, %1746 : i2
            %1749 = sv.array_index_inout %_RANDOM[%c94_i8] : !hw.inout<uarray<165xi32>>, i8
            %1750 = sv.read_inout %1749 : !hw.inout<i32>
            %1751 = comb.extract %1750 from 18 : (i32) -> i1
            %1752 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1753 = sv.struct_field_inout %1752["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1753, %1751 : i1
            %1754 = sv.array_index_inout %_RANDOM[%c95_i8] : !hw.inout<uarray<165xi32>>, i8
            %1755 = sv.read_inout %1754 : !hw.inout<i32>
            %1756 = comb.extract %1755 from 18 : (i32) -> i14
            %1757 = sv.array_index_inout %_RANDOM[%c94_i8] : !hw.inout<uarray<165xi32>>, i8
            %1758 = sv.read_inout %1757 : !hw.inout<i32>
            %1759 = comb.extract %1758 from 0 : (i32) -> i18
            %1760 = comb.concat %1759, %1756 : i18, i14
            %1761 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1762 = sv.struct_field_inout %1761["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1762, %1760 : i32
            %1763 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1764 = sv.read_inout %1763 : !hw.inout<i32>
            %1765 = comb.extract %1764 from 18 : (i32) -> i14
            %1766 = sv.array_index_inout %_RANDOM[%c95_i8] : !hw.inout<uarray<165xi32>>, i8
            %1767 = sv.read_inout %1766 : !hw.inout<i32>
            %1768 = comb.extract %1767 from 0 : (i32) -> i18
            %1769 = comb.concat %1768, %1765 : i18, i14
            %1770 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1771 = sv.struct_field_inout %1770["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1771, %1769 : i32
            %1772 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1773 = sv.read_inout %1772 : !hw.inout<i32>
            %1774 = comb.extract %1773 from 17 : (i32) -> i1
            %1775 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1776 = sv.struct_field_inout %1775["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1776, %1774 : i1
            %1777 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1778 = sv.read_inout %1777 : !hw.inout<i32>
            %1779 = comb.extract %1778 from 16 : (i32) -> i1
            %1780 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1781 = sv.struct_field_inout %1780["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1781, %1779 : i1
            %1782 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1783 = sv.read_inout %1782 : !hw.inout<i32>
            %1784 = comb.extract %1783 from 15 : (i32) -> i1
            %1785 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1786 = sv.struct_field_inout %1785["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1786, %1784 : i1
            %1787 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1788 = sv.read_inout %1787 : !hw.inout<i32>
            %1789 = comb.extract %1788 from 14 : (i32) -> i1
            %1790 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1791 = sv.struct_field_inout %1790["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1791, %1789 : i1
            %1792 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1793 = sv.read_inout %1792 : !hw.inout<i32>
            %1794 = comb.extract %1793 from 13 : (i32) -> i1
            %1795 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1796 = sv.struct_field_inout %1795["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1796, %1794 : i1
            %1797 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1798 = sv.read_inout %1797 : !hw.inout<i32>
            %1799 = comb.extract %1798 from 12 : (i32) -> i1
            %1800 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1801 = sv.struct_field_inout %1800["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1801, %1799 : i1
            %1802 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1803 = sv.read_inout %1802 : !hw.inout<i32>
            %1804 = comb.extract %1803 from 11 : (i32) -> i1
            %1805 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1806 = sv.struct_field_inout %1805["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1806, %1804 : i1
            %1807 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1808 = sv.read_inout %1807 : !hw.inout<i32>
            %1809 = comb.extract %1808 from 10 : (i32) -> i1
            %1810 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1811 = sv.struct_field_inout %1810["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1811, %1809 : i1
            %1812 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1813 = sv.read_inout %1812 : !hw.inout<i32>
            %1814 = comb.extract %1813 from 9 : (i32) -> i1
            %1815 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1816 = sv.struct_field_inout %1815["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1816, %1814 : i1
            %1817 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1818 = sv.read_inout %1817 : !hw.inout<i32>
            %1819 = comb.extract %1818 from 8 : (i32) -> i1
            %1820 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1821 = sv.struct_field_inout %1820["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1821, %1819 : i1
            %1822 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1823 = sv.read_inout %1822 : !hw.inout<i32>
            %1824 = comb.extract %1823 from 3 : (i32) -> i5
            %1825 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1826 = sv.struct_field_inout %1825["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1826, %1824 : i5
            %1827 = sv.array_index_inout %_RANDOM[%c97_i8] : !hw.inout<uarray<165xi32>>, i8
            %1828 = sv.read_inout %1827 : !hw.inout<i32>
            %1829 = comb.extract %1828 from 3 : (i32) -> i29
            %1830 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1831 = sv.read_inout %1830 : !hw.inout<i32>
            %1832 = comb.extract %1831 from 0 : (i32) -> i3
            %1833 = comb.concat %1832, %1829 : i3, i29
            %1834 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1835 = sv.struct_field_inout %1834["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1835, %1833 : i32
            %1836 = sv.array_index_inout %_RANDOM[%c98_i8] : !hw.inout<uarray<165xi32>>, i8
            %1837 = sv.read_inout %1836 : !hw.inout<i32>
            %1838 = comb.extract %1837 from 30 : (i32) -> i2
            %1839 = sv.array_index_inout %_RANDOM[%c97_i8] : !hw.inout<uarray<165xi32>>, i8
            %1840 = sv.read_inout %1839 : !hw.inout<i32>
            %1841 = comb.extract %1840 from 0 : (i32) -> i3
            %1842 = comb.concat %1841, %1838 : i3, i2
            %1843 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1844 = sv.struct_field_inout %1843["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1844, %1842 : i5
            %1845 = sv.array_index_inout %_RANDOM[%c98_i8] : !hw.inout<uarray<165xi32>>, i8
            %1846 = sv.read_inout %1845 : !hw.inout<i32>
            %1847 = comb.extract %1846 from 25 : (i32) -> i5
            %1848 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1849 = sv.struct_field_inout %1848["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1849, %1847 : i5
            %1850 = sv.array_index_inout %_RANDOM[%c98_i8] : !hw.inout<uarray<165xi32>>, i8
            %1851 = sv.read_inout %1850 : !hw.inout<i32>
            %1852 = comb.extract %1851 from 20 : (i32) -> i5
            %1853 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1854 = sv.struct_field_inout %1853["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1854, %1852 : i5
            %1855 = sv.array_index_inout %_RANDOM[%c99_i8] : !hw.inout<uarray<165xi32>>, i8
            %1856 = sv.read_inout %1855 : !hw.inout<i32>
            %1857 = comb.extract %1856 from 20 : (i32) -> i12
            %1858 = sv.array_index_inout %_RANDOM[%c98_i8] : !hw.inout<uarray<165xi32>>, i8
            %1859 = sv.read_inout %1858 : !hw.inout<i32>
            %1860 = comb.extract %1859 from 0 : (i32) -> i20
            %1861 = comb.concat %1860, %1857 : i20, i12
            %1862 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1863 = sv.struct_field_inout %1862["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1863, %1861 : i32
            %1864 = sv.array_index_inout %_RANDOM[%c100_i8] : !hw.inout<uarray<165xi32>>, i8
            %1865 = sv.read_inout %1864 : !hw.inout<i32>
            %1866 = comb.extract %1865 from 20 : (i32) -> i12
            %1867 = sv.array_index_inout %_RANDOM[%c99_i8] : !hw.inout<uarray<165xi32>>, i8
            %1868 = sv.read_inout %1867 : !hw.inout<i32>
            %1869 = comb.extract %1868 from 0 : (i32) -> i20
            %1870 = comb.concat %1869, %1866 : i20, i12
            %1871 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1872 = sv.struct_field_inout %1871["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1872, %1870 : i32
            %1873 = sv.array_index_inout %_RANDOM[%c101_i8] : !hw.inout<uarray<165xi32>>, i8
            %1874 = sv.read_inout %1873 : !hw.inout<i32>
            %1875 = comb.extract %1874 from 20 : (i32) -> i12
            %1876 = sv.array_index_inout %_RANDOM[%c100_i8] : !hw.inout<uarray<165xi32>>, i8
            %1877 = sv.read_inout %1876 : !hw.inout<i32>
            %1878 = comb.extract %1877 from 0 : (i32) -> i20
            %1879 = comb.concat %1878, %1875 : i20, i12
            %1880 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1881 = sv.struct_field_inout %1880["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1881, %1879 : i32
            %1882 = sv.array_index_inout %_RANDOM[%c102_i8] : !hw.inout<uarray<165xi32>>, i8
            %1883 = sv.read_inout %1882 : !hw.inout<i32>
            %1884 = comb.extract %1883 from 20 : (i32) -> i12
            %1885 = sv.array_index_inout %_RANDOM[%c101_i8] : !hw.inout<uarray<165xi32>>, i8
            %1886 = sv.read_inout %1885 : !hw.inout<i32>
            %1887 = comb.extract %1886 from 0 : (i32) -> i20
            %1888 = comb.concat %1887, %1884 : i20, i12
            %1889 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1890 = sv.struct_field_inout %1889["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1890, %1888 : i32
            %1891 = sv.array_index_inout %_RANDOM[%c103_i8] : !hw.inout<uarray<165xi32>>, i8
            %1892 = sv.read_inout %1891 : !hw.inout<i32>
            %1893 = comb.extract %1892 from 20 : (i32) -> i12
            %1894 = sv.array_index_inout %_RANDOM[%c102_i8] : !hw.inout<uarray<165xi32>>, i8
            %1895 = sv.read_inout %1894 : !hw.inout<i32>
            %1896 = comb.extract %1895 from 0 : (i32) -> i20
            %1897 = comb.concat %1896, %1893 : i20, i12
            %1898 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1899 = sv.struct_field_inout %1898["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1899, %1897 : i32
            %1900 = sv.array_index_inout %_RANDOM[%c104_i8] : !hw.inout<uarray<165xi32>>, i8
            %1901 = sv.read_inout %1900 : !hw.inout<i32>
            %1902 = comb.extract %1901 from 20 : (i32) -> i12
            %1903 = sv.array_index_inout %_RANDOM[%c103_i8] : !hw.inout<uarray<165xi32>>, i8
            %1904 = sv.read_inout %1903 : !hw.inout<i32>
            %1905 = comb.extract %1904 from 0 : (i32) -> i20
            %1906 = comb.concat %1905, %1902 : i20, i12
            %1907 = sv.array_index_inout %exStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1908 = sv.struct_field_inout %1907["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1908, %1906 : i32
            %1909 = sv.array_index_inout %_RANDOM[%c104_i8] : !hw.inout<uarray<165xi32>>, i8
            %1910 = sv.read_inout %1909 : !hw.inout<i32>
            %1911 = comb.extract %1910 from 18 : (i32) -> i2
            %1912 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1913 = sv.struct_field_inout %1912["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1913, %1911 : i2
            %1914 = sv.array_index_inout %_RANDOM[%c104_i8] : !hw.inout<uarray<165xi32>>, i8
            %1915 = sv.read_inout %1914 : !hw.inout<i32>
            %1916 = comb.extract %1915 from 17 : (i32) -> i1
            %1917 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1918 = sv.struct_field_inout %1917["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1918, %1916 : i1
            %1919 = sv.array_index_inout %_RANDOM[%c105_i8] : !hw.inout<uarray<165xi32>>, i8
            %1920 = sv.read_inout %1919 : !hw.inout<i32>
            %1921 = comb.extract %1920 from 17 : (i32) -> i15
            %1922 = sv.array_index_inout %_RANDOM[%c104_i8] : !hw.inout<uarray<165xi32>>, i8
            %1923 = sv.read_inout %1922 : !hw.inout<i32>
            %1924 = comb.extract %1923 from 0 : (i32) -> i17
            %1925 = comb.concat %1924, %1921 : i17, i15
            %1926 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1927 = sv.struct_field_inout %1926["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1927, %1925 : i32
            %1928 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1929 = sv.read_inout %1928 : !hw.inout<i32>
            %1930 = comb.extract %1929 from 17 : (i32) -> i15
            %1931 = sv.array_index_inout %_RANDOM[%c105_i8] : !hw.inout<uarray<165xi32>>, i8
            %1932 = sv.read_inout %1931 : !hw.inout<i32>
            %1933 = comb.extract %1932 from 0 : (i32) -> i17
            %1934 = comb.concat %1933, %1930 : i17, i15
            %1935 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1936 = sv.struct_field_inout %1935["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1936, %1934 : i32
            %1937 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1938 = sv.read_inout %1937 : !hw.inout<i32>
            %1939 = comb.extract %1938 from 16 : (i32) -> i1
            %1940 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1941 = sv.struct_field_inout %1940["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1941, %1939 : i1
            %1942 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1943 = sv.read_inout %1942 : !hw.inout<i32>
            %1944 = comb.extract %1943 from 15 : (i32) -> i1
            %1945 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1946 = sv.struct_field_inout %1945["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1946, %1944 : i1
            %1947 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1948 = sv.read_inout %1947 : !hw.inout<i32>
            %1949 = comb.extract %1948 from 14 : (i32) -> i1
            %1950 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1951 = sv.struct_field_inout %1950["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1951, %1949 : i1
            %1952 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1953 = sv.read_inout %1952 : !hw.inout<i32>
            %1954 = comb.extract %1953 from 13 : (i32) -> i1
            %1955 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1956 = sv.struct_field_inout %1955["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1956, %1954 : i1
            %1957 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1958 = sv.read_inout %1957 : !hw.inout<i32>
            %1959 = comb.extract %1958 from 12 : (i32) -> i1
            %1960 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1961 = sv.struct_field_inout %1960["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1961, %1959 : i1
            %1962 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1963 = sv.read_inout %1962 : !hw.inout<i32>
            %1964 = comb.extract %1963 from 11 : (i32) -> i1
            %1965 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1966 = sv.struct_field_inout %1965["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1966, %1964 : i1
            %1967 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1968 = sv.read_inout %1967 : !hw.inout<i32>
            %1969 = comb.extract %1968 from 10 : (i32) -> i1
            %1970 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1971 = sv.struct_field_inout %1970["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1971, %1969 : i1
            %1972 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1973 = sv.read_inout %1972 : !hw.inout<i32>
            %1974 = comb.extract %1973 from 9 : (i32) -> i1
            %1975 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1976 = sv.struct_field_inout %1975["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1976, %1974 : i1
            %1977 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1978 = sv.read_inout %1977 : !hw.inout<i32>
            %1979 = comb.extract %1978 from 8 : (i32) -> i1
            %1980 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1981 = sv.struct_field_inout %1980["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1981, %1979 : i1
            %1982 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1983 = sv.read_inout %1982 : !hw.inout<i32>
            %1984 = comb.extract %1983 from 7 : (i32) -> i1
            %1985 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1986 = sv.struct_field_inout %1985["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1986, %1984 : i1
            %1987 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1988 = sv.read_inout %1987 : !hw.inout<i32>
            %1989 = comb.extract %1988 from 2 : (i32) -> i5
            %1990 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %1991 = sv.struct_field_inout %1990["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %1991, %1989 : i5
            %1992 = sv.array_index_inout %_RANDOM[%c107_i8] : !hw.inout<uarray<165xi32>>, i8
            %1993 = sv.read_inout %1992 : !hw.inout<i32>
            %1994 = comb.extract %1993 from 2 : (i32) -> i30
            %1995 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1996 = sv.read_inout %1995 : !hw.inout<i32>
            %1997 = comb.extract %1996 from 0 : (i32) -> i2
            %1998 = comb.concat %1997, %1994 : i2, i30
            %1999 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2000 = sv.struct_field_inout %1999["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2000, %1998 : i32
            %2001 = sv.array_index_inout %_RANDOM[%c108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2002 = sv.read_inout %2001 : !hw.inout<i32>
            %2003 = comb.extract %2002 from 29 : (i32) -> i3
            %2004 = sv.array_index_inout %_RANDOM[%c107_i8] : !hw.inout<uarray<165xi32>>, i8
            %2005 = sv.read_inout %2004 : !hw.inout<i32>
            %2006 = comb.extract %2005 from 0 : (i32) -> i2
            %2007 = comb.concat %2006, %2003 : i2, i3
            %2008 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2009 = sv.struct_field_inout %2008["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2009, %2007 : i5
            %2010 = sv.array_index_inout %_RANDOM[%c108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2011 = sv.read_inout %2010 : !hw.inout<i32>
            %2012 = comb.extract %2011 from 24 : (i32) -> i5
            %2013 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2014 = sv.struct_field_inout %2013["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2014, %2012 : i5
            %2015 = sv.array_index_inout %_RANDOM[%c108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2016 = sv.read_inout %2015 : !hw.inout<i32>
            %2017 = comb.extract %2016 from 19 : (i32) -> i5
            %2018 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2019 = sv.struct_field_inout %2018["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2019, %2017 : i5
            %2020 = sv.array_index_inout %_RANDOM[%c109_i8] : !hw.inout<uarray<165xi32>>, i8
            %2021 = sv.read_inout %2020 : !hw.inout<i32>
            %2022 = comb.extract %2021 from 19 : (i32) -> i13
            %2023 = sv.array_index_inout %_RANDOM[%c108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2024 = sv.read_inout %2023 : !hw.inout<i32>
            %2025 = comb.extract %2024 from 0 : (i32) -> i19
            %2026 = comb.concat %2025, %2022 : i19, i13
            %2027 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2028 = sv.struct_field_inout %2027["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2028, %2026 : i32
            %2029 = sv.array_index_inout %_RANDOM[%c110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2030 = sv.read_inout %2029 : !hw.inout<i32>
            %2031 = comb.extract %2030 from 19 : (i32) -> i13
            %2032 = sv.array_index_inout %_RANDOM[%c109_i8] : !hw.inout<uarray<165xi32>>, i8
            %2033 = sv.read_inout %2032 : !hw.inout<i32>
            %2034 = comb.extract %2033 from 0 : (i32) -> i19
            %2035 = comb.concat %2034, %2031 : i19, i13
            %2036 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2037 = sv.struct_field_inout %2036["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2037, %2035 : i32
            %2038 = sv.array_index_inout %_RANDOM[%c111_i8] : !hw.inout<uarray<165xi32>>, i8
            %2039 = sv.read_inout %2038 : !hw.inout<i32>
            %2040 = comb.extract %2039 from 19 : (i32) -> i13
            %2041 = sv.array_index_inout %_RANDOM[%c110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2042 = sv.read_inout %2041 : !hw.inout<i32>
            %2043 = comb.extract %2042 from 0 : (i32) -> i19
            %2044 = comb.concat %2043, %2040 : i19, i13
            %2045 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2046 = sv.struct_field_inout %2045["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2046, %2044 : i32
            %2047 = sv.array_index_inout %_RANDOM[%c112_i8] : !hw.inout<uarray<165xi32>>, i8
            %2048 = sv.read_inout %2047 : !hw.inout<i32>
            %2049 = comb.extract %2048 from 19 : (i32) -> i13
            %2050 = sv.array_index_inout %_RANDOM[%c111_i8] : !hw.inout<uarray<165xi32>>, i8
            %2051 = sv.read_inout %2050 : !hw.inout<i32>
            %2052 = comb.extract %2051 from 0 : (i32) -> i19
            %2053 = comb.concat %2052, %2049 : i19, i13
            %2054 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2055 = sv.struct_field_inout %2054["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2055, %2053 : i32
            %2056 = sv.array_index_inout %_RANDOM[%c113_i8] : !hw.inout<uarray<165xi32>>, i8
            %2057 = sv.read_inout %2056 : !hw.inout<i32>
            %2058 = comb.extract %2057 from 19 : (i32) -> i13
            %2059 = sv.array_index_inout %_RANDOM[%c112_i8] : !hw.inout<uarray<165xi32>>, i8
            %2060 = sv.read_inout %2059 : !hw.inout<i32>
            %2061 = comb.extract %2060 from 0 : (i32) -> i19
            %2062 = comb.concat %2061, %2058 : i19, i13
            %2063 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2064 = sv.struct_field_inout %2063["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2064, %2062 : i32
            %2065 = sv.array_index_inout %_RANDOM[%c114_i8] : !hw.inout<uarray<165xi32>>, i8
            %2066 = sv.read_inout %2065 : !hw.inout<i32>
            %2067 = comb.extract %2066 from 19 : (i32) -> i13
            %2068 = sv.array_index_inout %_RANDOM[%c113_i8] : !hw.inout<uarray<165xi32>>, i8
            %2069 = sv.read_inout %2068 : !hw.inout<i32>
            %2070 = comb.extract %2069 from 0 : (i32) -> i19
            %2071 = comb.concat %2070, %2067 : i19, i13
            %2072 = sv.array_index_inout %exStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2073 = sv.struct_field_inout %2072["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2073, %2071 : i32
            %2074 = sv.array_index_inout %_RANDOM[%c114_i8] : !hw.inout<uarray<165xi32>>, i8
            %2075 = sv.read_inout %2074 : !hw.inout<i32>
            %2076 = comb.extract %2075 from 17 : (i32) -> i2
            %2077 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2078 = sv.struct_field_inout %2077["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2078, %2076 : i2
            %2079 = sv.array_index_inout %_RANDOM[%c114_i8] : !hw.inout<uarray<165xi32>>, i8
            %2080 = sv.read_inout %2079 : !hw.inout<i32>
            %2081 = comb.extract %2080 from 16 : (i32) -> i1
            %2082 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2083 = sv.struct_field_inout %2082["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2083, %2081 : i1
            %2084 = sv.array_index_inout %_RANDOM[%c115_i8] : !hw.inout<uarray<165xi32>>, i8
            %2085 = sv.read_inout %2084 : !hw.inout<i32>
            %2086 = comb.extract %2085 from 16 : (i32) -> i16
            %2087 = sv.array_index_inout %_RANDOM[%c114_i8] : !hw.inout<uarray<165xi32>>, i8
            %2088 = sv.read_inout %2087 : !hw.inout<i32>
            %2089 = comb.extract %2088 from 0 : (i32) -> i16
            %2090 = comb.concat %2089, %2086 : i16, i16
            %2091 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2092 = sv.struct_field_inout %2091["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2092, %2090 : i32
            %2093 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2094 = sv.read_inout %2093 : !hw.inout<i32>
            %2095 = comb.extract %2094 from 16 : (i32) -> i16
            %2096 = sv.array_index_inout %_RANDOM[%c115_i8] : !hw.inout<uarray<165xi32>>, i8
            %2097 = sv.read_inout %2096 : !hw.inout<i32>
            %2098 = comb.extract %2097 from 0 : (i32) -> i16
            %2099 = comb.concat %2098, %2095 : i16, i16
            %2100 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2101 = sv.struct_field_inout %2100["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2101, %2099 : i32
            %2102 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2103 = sv.read_inout %2102 : !hw.inout<i32>
            %2104 = comb.extract %2103 from 15 : (i32) -> i1
            %2105 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2106 = sv.struct_field_inout %2105["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2106, %2104 : i1
            %2107 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2108 = sv.read_inout %2107 : !hw.inout<i32>
            %2109 = comb.extract %2108 from 14 : (i32) -> i1
            %2110 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2111 = sv.struct_field_inout %2110["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2111, %2109 : i1
            %2112 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2113 = sv.read_inout %2112 : !hw.inout<i32>
            %2114 = comb.extract %2113 from 13 : (i32) -> i1
            %2115 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2116 = sv.struct_field_inout %2115["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2116, %2114 : i1
            %2117 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2118 = sv.read_inout %2117 : !hw.inout<i32>
            %2119 = comb.extract %2118 from 12 : (i32) -> i1
            %2120 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2121 = sv.struct_field_inout %2120["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2121, %2119 : i1
            %2122 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2123 = sv.read_inout %2122 : !hw.inout<i32>
            %2124 = comb.extract %2123 from 11 : (i32) -> i1
            %2125 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2126 = sv.struct_field_inout %2125["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2126, %2124 : i1
            %2127 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2128 = sv.read_inout %2127 : !hw.inout<i32>
            %2129 = comb.extract %2128 from 10 : (i32) -> i1
            %2130 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2131 = sv.struct_field_inout %2130["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2131, %2129 : i1
            %2132 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2133 = sv.read_inout %2132 : !hw.inout<i32>
            %2134 = comb.extract %2133 from 9 : (i32) -> i1
            %2135 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2136 = sv.struct_field_inout %2135["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2136, %2134 : i1
            %2137 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2138 = sv.read_inout %2137 : !hw.inout<i32>
            %2139 = comb.extract %2138 from 8 : (i32) -> i1
            %2140 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2141 = sv.struct_field_inout %2140["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2141, %2139 : i1
            %2142 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2143 = sv.read_inout %2142 : !hw.inout<i32>
            %2144 = comb.extract %2143 from 7 : (i32) -> i1
            %2145 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2146 = sv.struct_field_inout %2145["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2146, %2144 : i1
            %2147 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2148 = sv.read_inout %2147 : !hw.inout<i32>
            %2149 = comb.extract %2148 from 6 : (i32) -> i1
            %2150 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2151 = sv.struct_field_inout %2150["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2151, %2149 : i1
            %2152 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2153 = sv.read_inout %2152 : !hw.inout<i32>
            %2154 = comb.extract %2153 from 1 : (i32) -> i5
            %2155 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2156 = sv.struct_field_inout %2155["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2156, %2154 : i5
            %2157 = sv.array_index_inout %_RANDOM[%c117_i8] : !hw.inout<uarray<165xi32>>, i8
            %2158 = sv.read_inout %2157 : !hw.inout<i32>
            %2159 = comb.extract %2158 from 1 : (i32) -> i31
            %2160 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2161 = sv.read_inout %2160 : !hw.inout<i32>
            %2162 = comb.extract %2161 from 0 : (i32) -> i1
            %2163 = comb.concat %2162, %2159 : i1, i31
            %2164 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2165 = sv.struct_field_inout %2164["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2165, %2163 : i32
            %2166 = sv.array_index_inout %_RANDOM[%c118_i8] : !hw.inout<uarray<165xi32>>, i8
            %2167 = sv.read_inout %2166 : !hw.inout<i32>
            %2168 = comb.extract %2167 from 28 : (i32) -> i4
            %2169 = sv.array_index_inout %_RANDOM[%c117_i8] : !hw.inout<uarray<165xi32>>, i8
            %2170 = sv.read_inout %2169 : !hw.inout<i32>
            %2171 = comb.extract %2170 from 0 : (i32) -> i1
            %2172 = comb.concat %2171, %2168 : i1, i4
            %2173 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2174 = sv.struct_field_inout %2173["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2174, %2172 : i5
            %2175 = sv.array_index_inout %_RANDOM[%c118_i8] : !hw.inout<uarray<165xi32>>, i8
            %2176 = sv.read_inout %2175 : !hw.inout<i32>
            %2177 = comb.extract %2176 from 23 : (i32) -> i5
            %2178 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2179 = sv.struct_field_inout %2178["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2179, %2177 : i5
            %2180 = sv.array_index_inout %_RANDOM[%c118_i8] : !hw.inout<uarray<165xi32>>, i8
            %2181 = sv.read_inout %2180 : !hw.inout<i32>
            %2182 = comb.extract %2181 from 18 : (i32) -> i5
            %2183 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2184 = sv.struct_field_inout %2183["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2184, %2182 : i5
            %2185 = sv.array_index_inout %_RANDOM[%c119_i8] : !hw.inout<uarray<165xi32>>, i8
            %2186 = sv.read_inout %2185 : !hw.inout<i32>
            %2187 = comb.extract %2186 from 18 : (i32) -> i14
            %2188 = sv.array_index_inout %_RANDOM[%c118_i8] : !hw.inout<uarray<165xi32>>, i8
            %2189 = sv.read_inout %2188 : !hw.inout<i32>
            %2190 = comb.extract %2189 from 0 : (i32) -> i18
            %2191 = comb.concat %2190, %2187 : i18, i14
            %2192 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2193 = sv.struct_field_inout %2192["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2193, %2191 : i32
            %2194 = sv.array_index_inout %_RANDOM[%c120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2195 = sv.read_inout %2194 : !hw.inout<i32>
            %2196 = comb.extract %2195 from 18 : (i32) -> i14
            %2197 = sv.array_index_inout %_RANDOM[%c119_i8] : !hw.inout<uarray<165xi32>>, i8
            %2198 = sv.read_inout %2197 : !hw.inout<i32>
            %2199 = comb.extract %2198 from 0 : (i32) -> i18
            %2200 = comb.concat %2199, %2196 : i18, i14
            %2201 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2202 = sv.struct_field_inout %2201["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2202, %2200 : i32
            %2203 = sv.array_index_inout %_RANDOM[%c121_i8] : !hw.inout<uarray<165xi32>>, i8
            %2204 = sv.read_inout %2203 : !hw.inout<i32>
            %2205 = comb.extract %2204 from 18 : (i32) -> i14
            %2206 = sv.array_index_inout %_RANDOM[%c120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2207 = sv.read_inout %2206 : !hw.inout<i32>
            %2208 = comb.extract %2207 from 0 : (i32) -> i18
            %2209 = comb.concat %2208, %2205 : i18, i14
            %2210 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2211 = sv.struct_field_inout %2210["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2211, %2209 : i32
            %2212 = sv.array_index_inout %_RANDOM[%c122_i8] : !hw.inout<uarray<165xi32>>, i8
            %2213 = sv.read_inout %2212 : !hw.inout<i32>
            %2214 = comb.extract %2213 from 18 : (i32) -> i14
            %2215 = sv.array_index_inout %_RANDOM[%c121_i8] : !hw.inout<uarray<165xi32>>, i8
            %2216 = sv.read_inout %2215 : !hw.inout<i32>
            %2217 = comb.extract %2216 from 0 : (i32) -> i18
            %2218 = comb.concat %2217, %2214 : i18, i14
            %2219 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2220 = sv.struct_field_inout %2219["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2220, %2218 : i32
            %2221 = sv.array_index_inout %_RANDOM[%c123_i8] : !hw.inout<uarray<165xi32>>, i8
            %2222 = sv.read_inout %2221 : !hw.inout<i32>
            %2223 = comb.extract %2222 from 18 : (i32) -> i14
            %2224 = sv.array_index_inout %_RANDOM[%c122_i8] : !hw.inout<uarray<165xi32>>, i8
            %2225 = sv.read_inout %2224 : !hw.inout<i32>
            %2226 = comb.extract %2225 from 0 : (i32) -> i18
            %2227 = comb.concat %2226, %2223 : i18, i14
            %2228 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2229 = sv.struct_field_inout %2228["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2229, %2227 : i32
            %2230 = sv.array_index_inout %_RANDOM[%c123_i8] : !hw.inout<uarray<165xi32>>, i8
            %2231 = sv.read_inout %2230 : !hw.inout<i32>
            %2232 = comb.extract %2231 from 0 : (i32) -> i18
            %2233 = comb.concat %2232, %1578 : i18, i14
            %2234 = sv.array_index_inout %exStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2235 = sv.struct_field_inout %2234["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2235, %2233 : i32
            %2236 = sv.array_index_inout %_RANDOM[%c-92_i8] : !hw.inout<uarray<165xi32>>, i8
            %2237 = sv.read_inout %2236 : !hw.inout<i32>
            %2238 = comb.extract %2237 from 0 : (i32) -> i18
            %2239 = sv.array_index_inout %_RANDOM[%c124_i8] : !hw.inout<uarray<165xi32>>, i8
            %2240 = sv.read_inout %2239 : !hw.inout<i32>
            %2241 = comb.extract %2240 from 30 : (i32) -> i2
            %2242 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2243 = sv.struct_field_inout %2242["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2243, %2241 : i2
            %2244 = sv.array_index_inout %_RANDOM[%c124_i8] : !hw.inout<uarray<165xi32>>, i8
            %2245 = sv.read_inout %2244 : !hw.inout<i32>
            %2246 = comb.extract %2245 from 29 : (i32) -> i1
            %2247 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2248 = sv.struct_field_inout %2247["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2248, %2246 : i1
            %2249 = sv.array_index_inout %_RANDOM[%c125_i8] : !hw.inout<uarray<165xi32>>, i8
            %2250 = sv.read_inout %2249 : !hw.inout<i32>
            %2251 = comb.extract %2250 from 15 : (i32) -> i17
            %2252 = sv.array_index_inout %_RANDOM[%c124_i8] : !hw.inout<uarray<165xi32>>, i8
            %2253 = sv.read_inout %2252 : !hw.inout<i32>
            %2254 = comb.extract %2253 from 14 : (i32) -> i15
            %2255 = comb.concat %2254, %2251 : i15, i17
            %2256 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2257 = sv.struct_field_inout %2256["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2257, %2255 : i32
            %2258 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2259 = sv.read_inout %2258 : !hw.inout<i32>
            %2260 = comb.extract %2259 from 15 : (i32) -> i17
            %2261 = sv.array_index_inout %_RANDOM[%c125_i8] : !hw.inout<uarray<165xi32>>, i8
            %2262 = sv.read_inout %2261 : !hw.inout<i32>
            %2263 = comb.extract %2262 from 0 : (i32) -> i15
            %2264 = comb.concat %2263, %2260 : i15, i17
            %2265 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2266 = sv.struct_field_inout %2265["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2266, %2264 : i32
            %2267 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2268 = sv.read_inout %2267 : !hw.inout<i32>
            %2269 = comb.extract %2268 from 14 : (i32) -> i1
            %2270 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2271 = sv.struct_field_inout %2270["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2271, %2269 : i1
            %2272 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2273 = sv.read_inout %2272 : !hw.inout<i32>
            %2274 = comb.extract %2273 from 13 : (i32) -> i1
            %2275 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2276 = sv.struct_field_inout %2275["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2276, %2274 : i1
            %2277 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2278 = sv.read_inout %2277 : !hw.inout<i32>
            %2279 = comb.extract %2278 from 12 : (i32) -> i1
            %2280 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2281 = sv.struct_field_inout %2280["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2281, %2279 : i1
            %2282 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2283 = sv.read_inout %2282 : !hw.inout<i32>
            %2284 = comb.extract %2283 from 11 : (i32) -> i1
            %2285 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2286 = sv.struct_field_inout %2285["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2286, %2284 : i1
            %2287 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2288 = sv.read_inout %2287 : !hw.inout<i32>
            %2289 = comb.extract %2288 from 10 : (i32) -> i1
            %2290 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2291 = sv.struct_field_inout %2290["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2291, %2289 : i1
            %2292 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2293 = sv.read_inout %2292 : !hw.inout<i32>
            %2294 = comb.extract %2293 from 9 : (i32) -> i1
            %2295 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2296 = sv.struct_field_inout %2295["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2296, %2294 : i1
            %2297 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2298 = sv.read_inout %2297 : !hw.inout<i32>
            %2299 = comb.extract %2298 from 8 : (i32) -> i1
            %2300 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2301 = sv.struct_field_inout %2300["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2301, %2299 : i1
            %2302 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2303 = sv.read_inout %2302 : !hw.inout<i32>
            %2304 = comb.extract %2303 from 7 : (i32) -> i1
            %2305 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2306 = sv.struct_field_inout %2305["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2306, %2304 : i1
            %2307 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2308 = sv.read_inout %2307 : !hw.inout<i32>
            %2309 = comb.extract %2308 from 6 : (i32) -> i1
            %2310 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2311 = sv.struct_field_inout %2310["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2311, %2309 : i1
            %2312 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2313 = sv.read_inout %2312 : !hw.inout<i32>
            %2314 = comb.extract %2313 from 5 : (i32) -> i1
            %2315 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2316 = sv.struct_field_inout %2315["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2316, %2314 : i1
            %2317 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2318 = sv.read_inout %2317 : !hw.inout<i32>
            %2319 = comb.extract %2318 from 0 : (i32) -> i5
            %2320 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2321 = sv.struct_field_inout %2320["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2321, %2319 : i5
            %2322 = sv.array_index_inout %_RANDOM[%c127_i8] : !hw.inout<uarray<165xi32>>, i8
            %2323 = sv.read_inout %2322 : !hw.inout<i32>
            %2324 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2325 = sv.struct_field_inout %2324["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2325, %2323 : i32
            %2326 = sv.array_index_inout %_RANDOM[%c-128_i8] : !hw.inout<uarray<165xi32>>, i8
            %2327 = sv.read_inout %2326 : !hw.inout<i32>
            %2328 = comb.extract %2327 from 27 : (i32) -> i5
            %2329 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2330 = sv.struct_field_inout %2329["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2330, %2328 : i5
            %2331 = sv.array_index_inout %_RANDOM[%c-128_i8] : !hw.inout<uarray<165xi32>>, i8
            %2332 = sv.read_inout %2331 : !hw.inout<i32>
            %2333 = comb.extract %2332 from 22 : (i32) -> i5
            %2334 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2335 = sv.struct_field_inout %2334["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2335, %2333 : i5
            %2336 = sv.array_index_inout %_RANDOM[%c-128_i8] : !hw.inout<uarray<165xi32>>, i8
            %2337 = sv.read_inout %2336 : !hw.inout<i32>
            %2338 = comb.extract %2337 from 17 : (i32) -> i5
            %2339 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2340 = sv.struct_field_inout %2339["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2340, %2338 : i5
            %2341 = sv.array_index_inout %_RANDOM[%c-127_i8] : !hw.inout<uarray<165xi32>>, i8
            %2342 = sv.read_inout %2341 : !hw.inout<i32>
            %2343 = comb.extract %2342 from 17 : (i32) -> i15
            %2344 = sv.array_index_inout %_RANDOM[%c-128_i8] : !hw.inout<uarray<165xi32>>, i8
            %2345 = sv.read_inout %2344 : !hw.inout<i32>
            %2346 = comb.extract %2345 from 0 : (i32) -> i17
            %2347 = comb.concat %2346, %2343 : i17, i15
            %2348 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2349 = sv.struct_field_inout %2348["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2349, %2347 : i32
            %2350 = sv.array_index_inout %_RANDOM[%c-126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2351 = sv.read_inout %2350 : !hw.inout<i32>
            %2352 = comb.extract %2351 from 17 : (i32) -> i15
            %2353 = sv.array_index_inout %_RANDOM[%c-127_i8] : !hw.inout<uarray<165xi32>>, i8
            %2354 = sv.read_inout %2353 : !hw.inout<i32>
            %2355 = comb.extract %2354 from 0 : (i32) -> i17
            %2356 = comb.concat %2355, %2352 : i17, i15
            %2357 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2358 = sv.struct_field_inout %2357["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2358, %2356 : i32
            %2359 = sv.array_index_inout %_RANDOM[%c-125_i8] : !hw.inout<uarray<165xi32>>, i8
            %2360 = sv.read_inout %2359 : !hw.inout<i32>
            %2361 = comb.extract %2360 from 17 : (i32) -> i15
            %2362 = sv.array_index_inout %_RANDOM[%c-126_i8] : !hw.inout<uarray<165xi32>>, i8
            %2363 = sv.read_inout %2362 : !hw.inout<i32>
            %2364 = comb.extract %2363 from 0 : (i32) -> i17
            %2365 = comb.concat %2364, %2361 : i17, i15
            %2366 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2367 = sv.struct_field_inout %2366["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2367, %2365 : i32
            %2368 = sv.array_index_inout %_RANDOM[%c-124_i8] : !hw.inout<uarray<165xi32>>, i8
            %2369 = sv.read_inout %2368 : !hw.inout<i32>
            %2370 = comb.extract %2369 from 17 : (i32) -> i15
            %2371 = sv.array_index_inout %_RANDOM[%c-125_i8] : !hw.inout<uarray<165xi32>>, i8
            %2372 = sv.read_inout %2371 : !hw.inout<i32>
            %2373 = comb.extract %2372 from 0 : (i32) -> i17
            %2374 = comb.concat %2373, %2370 : i17, i15
            %2375 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2376 = sv.struct_field_inout %2375["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2376, %2374 : i32
            %2377 = sv.array_index_inout %_RANDOM[%c-123_i8] : !hw.inout<uarray<165xi32>>, i8
            %2378 = sv.read_inout %2377 : !hw.inout<i32>
            %2379 = comb.extract %2378 from 17 : (i32) -> i15
            %2380 = sv.array_index_inout %_RANDOM[%c-124_i8] : !hw.inout<uarray<165xi32>>, i8
            %2381 = sv.read_inout %2380 : !hw.inout<i32>
            %2382 = comb.extract %2381 from 0 : (i32) -> i17
            %2383 = comb.concat %2382, %2379 : i17, i15
            %2384 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2385 = sv.struct_field_inout %2384["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2385, %2383 : i32
            %2386 = sv.array_index_inout %_RANDOM[%c-122_i8] : !hw.inout<uarray<165xi32>>, i8
            %2387 = sv.read_inout %2386 : !hw.inout<i32>
            %2388 = comb.extract %2387 from 17 : (i32) -> i15
            %2389 = sv.array_index_inout %_RANDOM[%c-123_i8] : !hw.inout<uarray<165xi32>>, i8
            %2390 = sv.read_inout %2389 : !hw.inout<i32>
            %2391 = comb.extract %2390 from 0 : (i32) -> i17
            %2392 = comb.concat %2391, %2388 : i17, i15
            %2393 = sv.array_index_inout %memStage[%c0_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2394 = sv.struct_field_inout %2393["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2394, %2392 : i32
            %2395 = sv.array_index_inout %_RANDOM[%c-122_i8] : !hw.inout<uarray<165xi32>>, i8
            %2396 = sv.read_inout %2395 : !hw.inout<i32>
            %2397 = comb.extract %2396 from 15 : (i32) -> i2
            %2398 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2399 = sv.struct_field_inout %2398["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2399, %2397 : i2
            %2400 = sv.array_index_inout %_RANDOM[%c-122_i8] : !hw.inout<uarray<165xi32>>, i8
            %2401 = sv.read_inout %2400 : !hw.inout<i32>
            %2402 = comb.extract %2401 from 14 : (i32) -> i1
            %2403 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2404 = sv.struct_field_inout %2403["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2404, %2402 : i1
            %2405 = sv.array_index_inout %_RANDOM[%c-121_i8] : !hw.inout<uarray<165xi32>>, i8
            %2406 = sv.read_inout %2405 : !hw.inout<i32>
            %2407 = comb.extract %2406 from 14 : (i32) -> i18
            %2408 = sv.array_index_inout %_RANDOM[%c-122_i8] : !hw.inout<uarray<165xi32>>, i8
            %2409 = sv.read_inout %2408 : !hw.inout<i32>
            %2410 = comb.extract %2409 from 0 : (i32) -> i14
            %2411 = comb.concat %2410, %2407 : i14, i18
            %2412 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2413 = sv.struct_field_inout %2412["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2413, %2411 : i32
            %2414 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2415 = sv.read_inout %2414 : !hw.inout<i32>
            %2416 = comb.extract %2415 from 14 : (i32) -> i18
            %2417 = sv.array_index_inout %_RANDOM[%c-121_i8] : !hw.inout<uarray<165xi32>>, i8
            %2418 = sv.read_inout %2417 : !hw.inout<i32>
            %2419 = comb.extract %2418 from 0 : (i32) -> i14
            %2420 = comb.concat %2419, %2416 : i14, i18
            %2421 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2422 = sv.struct_field_inout %2421["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2422, %2420 : i32
            %2423 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2424 = sv.read_inout %2423 : !hw.inout<i32>
            %2425 = comb.extract %2424 from 13 : (i32) -> i1
            %2426 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2427 = sv.struct_field_inout %2426["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2427, %2425 : i1
            %2428 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2429 = sv.read_inout %2428 : !hw.inout<i32>
            %2430 = comb.extract %2429 from 12 : (i32) -> i1
            %2431 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2432 = sv.struct_field_inout %2431["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2432, %2430 : i1
            %2433 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2434 = sv.read_inout %2433 : !hw.inout<i32>
            %2435 = comb.extract %2434 from 11 : (i32) -> i1
            %2436 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2437 = sv.struct_field_inout %2436["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2437, %2435 : i1
            %2438 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2439 = sv.read_inout %2438 : !hw.inout<i32>
            %2440 = comb.extract %2439 from 10 : (i32) -> i1
            %2441 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2442 = sv.struct_field_inout %2441["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2442, %2440 : i1
            %2443 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2444 = sv.read_inout %2443 : !hw.inout<i32>
            %2445 = comb.extract %2444 from 9 : (i32) -> i1
            %2446 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2447 = sv.struct_field_inout %2446["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2447, %2445 : i1
            %2448 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2449 = sv.read_inout %2448 : !hw.inout<i32>
            %2450 = comb.extract %2449 from 8 : (i32) -> i1
            %2451 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2452 = sv.struct_field_inout %2451["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2452, %2450 : i1
            %2453 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2454 = sv.read_inout %2453 : !hw.inout<i32>
            %2455 = comb.extract %2454 from 7 : (i32) -> i1
            %2456 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2457 = sv.struct_field_inout %2456["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2457, %2455 : i1
            %2458 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2459 = sv.read_inout %2458 : !hw.inout<i32>
            %2460 = comb.extract %2459 from 6 : (i32) -> i1
            %2461 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2462 = sv.struct_field_inout %2461["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2462, %2460 : i1
            %2463 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2464 = sv.read_inout %2463 : !hw.inout<i32>
            %2465 = comb.extract %2464 from 5 : (i32) -> i1
            %2466 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2467 = sv.struct_field_inout %2466["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2467, %2465 : i1
            %2468 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2469 = sv.read_inout %2468 : !hw.inout<i32>
            %2470 = comb.extract %2469 from 4 : (i32) -> i1
            %2471 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2472 = sv.struct_field_inout %2471["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2472, %2470 : i1
            %2473 = sv.array_index_inout %_RANDOM[%c-119_i8] : !hw.inout<uarray<165xi32>>, i8
            %2474 = sv.read_inout %2473 : !hw.inout<i32>
            %2475 = comb.extract %2474 from 31 : (i32) -> i1
            %2476 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %2477 = sv.read_inout %2476 : !hw.inout<i32>
            %2478 = comb.extract %2477 from 0 : (i32) -> i4
            %2479 = comb.concat %2478, %2475 : i4, i1
            %2480 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2481 = sv.struct_field_inout %2480["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2481, %2479 : i5
            %2482 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %2483 = sv.read_inout %2482 : !hw.inout<i32>
            %2484 = comb.extract %2483 from 31 : (i32) -> i1
            %2485 = sv.array_index_inout %_RANDOM[%c-119_i8] : !hw.inout<uarray<165xi32>>, i8
            %2486 = sv.read_inout %2485 : !hw.inout<i32>
            %2487 = comb.extract %2486 from 0 : (i32) -> i31
            %2488 = comb.concat %2487, %2484 : i31, i1
            %2489 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2490 = sv.struct_field_inout %2489["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2490, %2488 : i32
            %2491 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %2492 = sv.read_inout %2491 : !hw.inout<i32>
            %2493 = comb.extract %2492 from 26 : (i32) -> i5
            %2494 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2495 = sv.struct_field_inout %2494["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2495, %2493 : i5
            %2496 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %2497 = sv.read_inout %2496 : !hw.inout<i32>
            %2498 = comb.extract %2497 from 21 : (i32) -> i5
            %2499 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2500 = sv.struct_field_inout %2499["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2500, %2498 : i5
            %2501 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %2502 = sv.read_inout %2501 : !hw.inout<i32>
            %2503 = comb.extract %2502 from 16 : (i32) -> i5
            %2504 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2505 = sv.struct_field_inout %2504["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2505, %2503 : i5
            %2506 = sv.array_index_inout %_RANDOM[%c-117_i8] : !hw.inout<uarray<165xi32>>, i8
            %2507 = sv.read_inout %2506 : !hw.inout<i32>
            %2508 = comb.extract %2507 from 16 : (i32) -> i16
            %2509 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %2510 = sv.read_inout %2509 : !hw.inout<i32>
            %2511 = comb.extract %2510 from 0 : (i32) -> i16
            %2512 = comb.concat %2511, %2508 : i16, i16
            %2513 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2514 = sv.struct_field_inout %2513["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2514, %2512 : i32
            %2515 = sv.array_index_inout %_RANDOM[%c-116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2516 = sv.read_inout %2515 : !hw.inout<i32>
            %2517 = comb.extract %2516 from 16 : (i32) -> i16
            %2518 = sv.array_index_inout %_RANDOM[%c-117_i8] : !hw.inout<uarray<165xi32>>, i8
            %2519 = sv.read_inout %2518 : !hw.inout<i32>
            %2520 = comb.extract %2519 from 0 : (i32) -> i16
            %2521 = comb.concat %2520, %2517 : i16, i16
            %2522 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2523 = sv.struct_field_inout %2522["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2523, %2521 : i32
            %2524 = sv.array_index_inout %_RANDOM[%c-115_i8] : !hw.inout<uarray<165xi32>>, i8
            %2525 = sv.read_inout %2524 : !hw.inout<i32>
            %2526 = comb.extract %2525 from 16 : (i32) -> i16
            %2527 = sv.array_index_inout %_RANDOM[%c-116_i8] : !hw.inout<uarray<165xi32>>, i8
            %2528 = sv.read_inout %2527 : !hw.inout<i32>
            %2529 = comb.extract %2528 from 0 : (i32) -> i16
            %2530 = comb.concat %2529, %2526 : i16, i16
            %2531 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2532 = sv.struct_field_inout %2531["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2532, %2530 : i32
            %2533 = sv.array_index_inout %_RANDOM[%c-114_i8] : !hw.inout<uarray<165xi32>>, i8
            %2534 = sv.read_inout %2533 : !hw.inout<i32>
            %2535 = comb.extract %2534 from 16 : (i32) -> i16
            %2536 = sv.array_index_inout %_RANDOM[%c-115_i8] : !hw.inout<uarray<165xi32>>, i8
            %2537 = sv.read_inout %2536 : !hw.inout<i32>
            %2538 = comb.extract %2537 from 0 : (i32) -> i16
            %2539 = comb.concat %2538, %2535 : i16, i16
            %2540 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2541 = sv.struct_field_inout %2540["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2541, %2539 : i32
            %2542 = sv.array_index_inout %_RANDOM[%c-113_i8] : !hw.inout<uarray<165xi32>>, i8
            %2543 = sv.read_inout %2542 : !hw.inout<i32>
            %2544 = comb.extract %2543 from 16 : (i32) -> i16
            %2545 = sv.array_index_inout %_RANDOM[%c-114_i8] : !hw.inout<uarray<165xi32>>, i8
            %2546 = sv.read_inout %2545 : !hw.inout<i32>
            %2547 = comb.extract %2546 from 0 : (i32) -> i16
            %2548 = comb.concat %2547, %2544 : i16, i16
            %2549 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2550 = sv.struct_field_inout %2549["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2550, %2548 : i32
            %2551 = sv.array_index_inout %_RANDOM[%c-112_i8] : !hw.inout<uarray<165xi32>>, i8
            %2552 = sv.read_inout %2551 : !hw.inout<i32>
            %2553 = comb.extract %2552 from 16 : (i32) -> i16
            %2554 = sv.array_index_inout %_RANDOM[%c-113_i8] : !hw.inout<uarray<165xi32>>, i8
            %2555 = sv.read_inout %2554 : !hw.inout<i32>
            %2556 = comb.extract %2555 from 0 : (i32) -> i16
            %2557 = comb.concat %2556, %2553 : i16, i16
            %2558 = sv.array_index_inout %memStage[%c1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2559 = sv.struct_field_inout %2558["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2559, %2557 : i32
            %2560 = sv.array_index_inout %_RANDOM[%c-112_i8] : !hw.inout<uarray<165xi32>>, i8
            %2561 = sv.read_inout %2560 : !hw.inout<i32>
            %2562 = comb.extract %2561 from 14 : (i32) -> i2
            %2563 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2564 = sv.struct_field_inout %2563["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2564, %2562 : i2
            %2565 = sv.array_index_inout %_RANDOM[%c-112_i8] : !hw.inout<uarray<165xi32>>, i8
            %2566 = sv.read_inout %2565 : !hw.inout<i32>
            %2567 = comb.extract %2566 from 13 : (i32) -> i1
            %2568 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2569 = sv.struct_field_inout %2568["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2569, %2567 : i1
            %2570 = sv.array_index_inout %_RANDOM[%c-111_i8] : !hw.inout<uarray<165xi32>>, i8
            %2571 = sv.read_inout %2570 : !hw.inout<i32>
            %2572 = comb.extract %2571 from 13 : (i32) -> i19
            %2573 = sv.array_index_inout %_RANDOM[%c-112_i8] : !hw.inout<uarray<165xi32>>, i8
            %2574 = sv.read_inout %2573 : !hw.inout<i32>
            %2575 = comb.extract %2574 from 0 : (i32) -> i13
            %2576 = comb.concat %2575, %2572 : i13, i19
            %2577 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2578 = sv.struct_field_inout %2577["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2578, %2576 : i32
            %2579 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2580 = sv.read_inout %2579 : !hw.inout<i32>
            %2581 = comb.extract %2580 from 13 : (i32) -> i19
            %2582 = sv.array_index_inout %_RANDOM[%c-111_i8] : !hw.inout<uarray<165xi32>>, i8
            %2583 = sv.read_inout %2582 : !hw.inout<i32>
            %2584 = comb.extract %2583 from 0 : (i32) -> i13
            %2585 = comb.concat %2584, %2581 : i13, i19
            %2586 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2587 = sv.struct_field_inout %2586["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2587, %2585 : i32
            %2588 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2589 = sv.read_inout %2588 : !hw.inout<i32>
            %2590 = comb.extract %2589 from 12 : (i32) -> i1
            %2591 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2592 = sv.struct_field_inout %2591["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2592, %2590 : i1
            %2593 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2594 = sv.read_inout %2593 : !hw.inout<i32>
            %2595 = comb.extract %2594 from 11 : (i32) -> i1
            %2596 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2597 = sv.struct_field_inout %2596["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2597, %2595 : i1
            %2598 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2599 = sv.read_inout %2598 : !hw.inout<i32>
            %2600 = comb.extract %2599 from 10 : (i32) -> i1
            %2601 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2602 = sv.struct_field_inout %2601["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2602, %2600 : i1
            %2603 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2604 = sv.read_inout %2603 : !hw.inout<i32>
            %2605 = comb.extract %2604 from 9 : (i32) -> i1
            %2606 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2607 = sv.struct_field_inout %2606["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2607, %2605 : i1
            %2608 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2609 = sv.read_inout %2608 : !hw.inout<i32>
            %2610 = comb.extract %2609 from 8 : (i32) -> i1
            %2611 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2612 = sv.struct_field_inout %2611["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2612, %2610 : i1
            %2613 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2614 = sv.read_inout %2613 : !hw.inout<i32>
            %2615 = comb.extract %2614 from 7 : (i32) -> i1
            %2616 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2617 = sv.struct_field_inout %2616["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2617, %2615 : i1
            %2618 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2619 = sv.read_inout %2618 : !hw.inout<i32>
            %2620 = comb.extract %2619 from 6 : (i32) -> i1
            %2621 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2622 = sv.struct_field_inout %2621["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2622, %2620 : i1
            %2623 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2624 = sv.read_inout %2623 : !hw.inout<i32>
            %2625 = comb.extract %2624 from 5 : (i32) -> i1
            %2626 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2627 = sv.struct_field_inout %2626["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2627, %2625 : i1
            %2628 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2629 = sv.read_inout %2628 : !hw.inout<i32>
            %2630 = comb.extract %2629 from 4 : (i32) -> i1
            %2631 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2632 = sv.struct_field_inout %2631["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2632, %2630 : i1
            %2633 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2634 = sv.read_inout %2633 : !hw.inout<i32>
            %2635 = comb.extract %2634 from 3 : (i32) -> i1
            %2636 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2637 = sv.struct_field_inout %2636["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2637, %2635 : i1
            %2638 = sv.array_index_inout %_RANDOM[%c-109_i8] : !hw.inout<uarray<165xi32>>, i8
            %2639 = sv.read_inout %2638 : !hw.inout<i32>
            %2640 = comb.extract %2639 from 30 : (i32) -> i2
            %2641 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2642 = sv.read_inout %2641 : !hw.inout<i32>
            %2643 = comb.extract %2642 from 0 : (i32) -> i3
            %2644 = comb.concat %2643, %2640 : i3, i2
            %2645 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2646 = sv.struct_field_inout %2645["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2646, %2644 : i5
            %2647 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2648 = sv.read_inout %2647 : !hw.inout<i32>
            %2649 = comb.extract %2648 from 30 : (i32) -> i2
            %2650 = sv.array_index_inout %_RANDOM[%c-109_i8] : !hw.inout<uarray<165xi32>>, i8
            %2651 = sv.read_inout %2650 : !hw.inout<i32>
            %2652 = comb.extract %2651 from 0 : (i32) -> i30
            %2653 = comb.concat %2652, %2649 : i30, i2
            %2654 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2655 = sv.struct_field_inout %2654["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2655, %2653 : i32
            %2656 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2657 = sv.read_inout %2656 : !hw.inout<i32>
            %2658 = comb.extract %2657 from 25 : (i32) -> i5
            %2659 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2660 = sv.struct_field_inout %2659["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2660, %2658 : i5
            %2661 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2662 = sv.read_inout %2661 : !hw.inout<i32>
            %2663 = comb.extract %2662 from 20 : (i32) -> i5
            %2664 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2665 = sv.struct_field_inout %2664["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2665, %2663 : i5
            %2666 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2667 = sv.read_inout %2666 : !hw.inout<i32>
            %2668 = comb.extract %2667 from 15 : (i32) -> i5
            %2669 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2670 = sv.struct_field_inout %2669["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2670, %2668 : i5
            %2671 = sv.array_index_inout %_RANDOM[%c-107_i8] : !hw.inout<uarray<165xi32>>, i8
            %2672 = sv.read_inout %2671 : !hw.inout<i32>
            %2673 = comb.extract %2672 from 15 : (i32) -> i17
            %2674 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2675 = sv.read_inout %2674 : !hw.inout<i32>
            %2676 = comb.extract %2675 from 0 : (i32) -> i15
            %2677 = comb.concat %2676, %2673 : i15, i17
            %2678 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2679 = sv.struct_field_inout %2678["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2679, %2677 : i32
            %2680 = sv.array_index_inout %_RANDOM[%c-106_i8] : !hw.inout<uarray<165xi32>>, i8
            %2681 = sv.read_inout %2680 : !hw.inout<i32>
            %2682 = comb.extract %2681 from 15 : (i32) -> i17
            %2683 = sv.array_index_inout %_RANDOM[%c-107_i8] : !hw.inout<uarray<165xi32>>, i8
            %2684 = sv.read_inout %2683 : !hw.inout<i32>
            %2685 = comb.extract %2684 from 0 : (i32) -> i15
            %2686 = comb.concat %2685, %2682 : i15, i17
            %2687 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2688 = sv.struct_field_inout %2687["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2688, %2686 : i32
            %2689 = sv.array_index_inout %_RANDOM[%c-105_i8] : !hw.inout<uarray<165xi32>>, i8
            %2690 = sv.read_inout %2689 : !hw.inout<i32>
            %2691 = comb.extract %2690 from 15 : (i32) -> i17
            %2692 = sv.array_index_inout %_RANDOM[%c-106_i8] : !hw.inout<uarray<165xi32>>, i8
            %2693 = sv.read_inout %2692 : !hw.inout<i32>
            %2694 = comb.extract %2693 from 0 : (i32) -> i15
            %2695 = comb.concat %2694, %2691 : i15, i17
            %2696 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2697 = sv.struct_field_inout %2696["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2697, %2695 : i32
            %2698 = sv.array_index_inout %_RANDOM[%c-104_i8] : !hw.inout<uarray<165xi32>>, i8
            %2699 = sv.read_inout %2698 : !hw.inout<i32>
            %2700 = comb.extract %2699 from 15 : (i32) -> i17
            %2701 = sv.array_index_inout %_RANDOM[%c-105_i8] : !hw.inout<uarray<165xi32>>, i8
            %2702 = sv.read_inout %2701 : !hw.inout<i32>
            %2703 = comb.extract %2702 from 0 : (i32) -> i15
            %2704 = comb.concat %2703, %2700 : i15, i17
            %2705 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2706 = sv.struct_field_inout %2705["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2706, %2704 : i32
            %2707 = sv.array_index_inout %_RANDOM[%c-103_i8] : !hw.inout<uarray<165xi32>>, i8
            %2708 = sv.read_inout %2707 : !hw.inout<i32>
            %2709 = comb.extract %2708 from 15 : (i32) -> i17
            %2710 = sv.array_index_inout %_RANDOM[%c-104_i8] : !hw.inout<uarray<165xi32>>, i8
            %2711 = sv.read_inout %2710 : !hw.inout<i32>
            %2712 = comb.extract %2711 from 0 : (i32) -> i15
            %2713 = comb.concat %2712, %2709 : i15, i17
            %2714 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2715 = sv.struct_field_inout %2714["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2715, %2713 : i32
            %2716 = sv.array_index_inout %_RANDOM[%c-102_i8] : !hw.inout<uarray<165xi32>>, i8
            %2717 = sv.read_inout %2716 : !hw.inout<i32>
            %2718 = comb.extract %2717 from 15 : (i32) -> i17
            %2719 = sv.array_index_inout %_RANDOM[%c-103_i8] : !hw.inout<uarray<165xi32>>, i8
            %2720 = sv.read_inout %2719 : !hw.inout<i32>
            %2721 = comb.extract %2720 from 0 : (i32) -> i15
            %2722 = comb.concat %2721, %2718 : i15, i17
            %2723 = sv.array_index_inout %memStage[%c-2_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2724 = sv.struct_field_inout %2723["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2724, %2722 : i32
            %2725 = sv.array_index_inout %_RANDOM[%c-102_i8] : !hw.inout<uarray<165xi32>>, i8
            %2726 = sv.read_inout %2725 : !hw.inout<i32>
            %2727 = comb.extract %2726 from 13 : (i32) -> i2
            %2728 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2729 = sv.struct_field_inout %2728["threadId"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2729, %2727 : i2
            %2730 = sv.array_index_inout %_RANDOM[%c-102_i8] : !hw.inout<uarray<165xi32>>, i8
            %2731 = sv.read_inout %2730 : !hw.inout<i32>
            %2732 = comb.extract %2731 from 12 : (i32) -> i1
            %2733 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2734 = sv.struct_field_inout %2733["valid"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2734, %2732 : i1
            %2735 = sv.array_index_inout %_RANDOM[%c-101_i8] : !hw.inout<uarray<165xi32>>, i8
            %2736 = sv.read_inout %2735 : !hw.inout<i32>
            %2737 = comb.extract %2736 from 12 : (i32) -> i20
            %2738 = sv.array_index_inout %_RANDOM[%c-102_i8] : !hw.inout<uarray<165xi32>>, i8
            %2739 = sv.read_inout %2738 : !hw.inout<i32>
            %2740 = comb.extract %2739 from 0 : (i32) -> i12
            %2741 = comb.concat %2740, %2737 : i12, i20
            %2742 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2743 = sv.struct_field_inout %2742["pc"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2743, %2741 : i32
            %2744 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2745 = sv.read_inout %2744 : !hw.inout<i32>
            %2746 = comb.extract %2745 from 12 : (i32) -> i20
            %2747 = sv.array_index_inout %_RANDOM[%c-101_i8] : !hw.inout<uarray<165xi32>>, i8
            %2748 = sv.read_inout %2747 : !hw.inout<i32>
            %2749 = comb.extract %2748 from 0 : (i32) -> i12
            %2750 = comb.concat %2749, %2746 : i12, i20
            %2751 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2752 = sv.struct_field_inout %2751["instr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2752, %2750 : i32
            %2753 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2754 = sv.read_inout %2753 : !hw.inout<i32>
            %2755 = comb.extract %2754 from 11 : (i32) -> i1
            %2756 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2757 = sv.struct_field_inout %2756["isALU"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2757, %2755 : i1
            %2758 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2759 = sv.read_inout %2758 : !hw.inout<i32>
            %2760 = comb.extract %2759 from 10 : (i32) -> i1
            %2761 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2762 = sv.struct_field_inout %2761["isLoad"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2762, %2760 : i1
            %2763 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2764 = sv.read_inout %2763 : !hw.inout<i32>
            %2765 = comb.extract %2764 from 9 : (i32) -> i1
            %2766 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2767 = sv.struct_field_inout %2766["isStore"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2767, %2765 : i1
            %2768 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2769 = sv.read_inout %2768 : !hw.inout<i32>
            %2770 = comb.extract %2769 from 8 : (i32) -> i1
            %2771 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2772 = sv.struct_field_inout %2771["isBranch"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2772, %2770 : i1
            %2773 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2774 = sv.read_inout %2773 : !hw.inout<i32>
            %2775 = comb.extract %2774 from 7 : (i32) -> i1
            %2776 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2777 = sv.struct_field_inout %2776["isJAL"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2777, %2775 : i1
            %2778 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2779 = sv.read_inout %2778 : !hw.inout<i32>
            %2780 = comb.extract %2779 from 6 : (i32) -> i1
            %2781 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2782 = sv.struct_field_inout %2781["isJALR"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2782, %2780 : i1
            %2783 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2784 = sv.read_inout %2783 : !hw.inout<i32>
            %2785 = comb.extract %2784 from 5 : (i32) -> i1
            %2786 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2787 = sv.struct_field_inout %2786["isLUI"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2787, %2785 : i1
            %2788 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2789 = sv.read_inout %2788 : !hw.inout<i32>
            %2790 = comb.extract %2789 from 4 : (i32) -> i1
            %2791 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2792 = sv.struct_field_inout %2791["isAUIPC"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2792, %2790 : i1
            %2793 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2794 = sv.read_inout %2793 : !hw.inout<i32>
            %2795 = comb.extract %2794 from 3 : (i32) -> i1
            %2796 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2797 = sv.struct_field_inout %2796["isFence"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2797, %2795 : i1
            %2798 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2799 = sv.read_inout %2798 : !hw.inout<i32>
            %2800 = comb.extract %2799 from 2 : (i32) -> i1
            %2801 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2802 = sv.struct_field_inout %2801["isSystem"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2802, %2800 : i1
            %2803 = sv.array_index_inout %_RANDOM[%c-99_i8] : !hw.inout<uarray<165xi32>>, i8
            %2804 = sv.read_inout %2803 : !hw.inout<i32>
            %2805 = comb.extract %2804 from 29 : (i32) -> i3
            %2806 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2807 = sv.read_inout %2806 : !hw.inout<i32>
            %2808 = comb.extract %2807 from 0 : (i32) -> i2
            %2809 = comb.concat %2808, %2805 : i2, i3
            %2810 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2811 = sv.struct_field_inout %2810["aluOp"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2811, %2809 : i5
            %2812 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2813 = sv.read_inout %2812 : !hw.inout<i32>
            %2814 = comb.extract %2813 from 29 : (i32) -> i3
            %2815 = sv.array_index_inout %_RANDOM[%c-99_i8] : !hw.inout<uarray<165xi32>>, i8
            %2816 = sv.read_inout %2815 : !hw.inout<i32>
            %2817 = comb.extract %2816 from 0 : (i32) -> i29
            %2818 = comb.concat %2817, %2814 : i29, i3
            %2819 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2820 = sv.struct_field_inout %2819["imm"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2820, %2818 : i32
            %2821 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2822 = sv.read_inout %2821 : !hw.inout<i32>
            %2823 = comb.extract %2822 from 24 : (i32) -> i5
            %2824 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2825 = sv.struct_field_inout %2824["rs1"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2825, %2823 : i5
            %2826 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2827 = sv.read_inout %2826 : !hw.inout<i32>
            %2828 = comb.extract %2827 from 19 : (i32) -> i5
            %2829 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2830 = sv.struct_field_inout %2829["rs2"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2830, %2828 : i5
            %2831 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2832 = sv.read_inout %2831 : !hw.inout<i32>
            %2833 = comb.extract %2832 from 14 : (i32) -> i5
            %2834 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2835 = sv.struct_field_inout %2834["rd"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2835, %2833 : i5
            %2836 = sv.array_index_inout %_RANDOM[%c-97_i8] : !hw.inout<uarray<165xi32>>, i8
            %2837 = sv.read_inout %2836 : !hw.inout<i32>
            %2838 = comb.extract %2837 from 14 : (i32) -> i18
            %2839 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2840 = sv.read_inout %2839 : !hw.inout<i32>
            %2841 = comb.extract %2840 from 0 : (i32) -> i14
            %2842 = comb.concat %2841, %2838 : i14, i18
            %2843 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2844 = sv.struct_field_inout %2843["rs1Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2844, %2842 : i32
            %2845 = sv.array_index_inout %_RANDOM[%c-96_i8] : !hw.inout<uarray<165xi32>>, i8
            %2846 = sv.read_inout %2845 : !hw.inout<i32>
            %2847 = comb.extract %2846 from 14 : (i32) -> i18
            %2848 = sv.array_index_inout %_RANDOM[%c-97_i8] : !hw.inout<uarray<165xi32>>, i8
            %2849 = sv.read_inout %2848 : !hw.inout<i32>
            %2850 = comb.extract %2849 from 0 : (i32) -> i14
            %2851 = comb.concat %2850, %2847 : i14, i18
            %2852 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2853 = sv.struct_field_inout %2852["rs2Data"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2853, %2851 : i32
            %2854 = sv.array_index_inout %_RANDOM[%c-95_i8] : !hw.inout<uarray<165xi32>>, i8
            %2855 = sv.read_inout %2854 : !hw.inout<i32>
            %2856 = comb.extract %2855 from 14 : (i32) -> i18
            %2857 = sv.array_index_inout %_RANDOM[%c-96_i8] : !hw.inout<uarray<165xi32>>, i8
            %2858 = sv.read_inout %2857 : !hw.inout<i32>
            %2859 = comb.extract %2858 from 0 : (i32) -> i14
            %2860 = comb.concat %2859, %2856 : i14, i18
            %2861 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2862 = sv.struct_field_inout %2861["memAddr"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2862, %2860 : i32
            %2863 = sv.array_index_inout %_RANDOM[%c-94_i8] : !hw.inout<uarray<165xi32>>, i8
            %2864 = sv.read_inout %2863 : !hw.inout<i32>
            %2865 = comb.extract %2864 from 14 : (i32) -> i18
            %2866 = sv.array_index_inout %_RANDOM[%c-95_i8] : !hw.inout<uarray<165xi32>>, i8
            %2867 = sv.read_inout %2866 : !hw.inout<i32>
            %2868 = comb.extract %2867 from 0 : (i32) -> i14
            %2869 = comb.concat %2868, %2865 : i14, i18
            %2870 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2871 = sv.struct_field_inout %2870["memWdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2871, %2869 : i32
            %2872 = sv.array_index_inout %_RANDOM[%c-93_i8] : !hw.inout<uarray<165xi32>>, i8
            %2873 = sv.read_inout %2872 : !hw.inout<i32>
            %2874 = comb.extract %2873 from 14 : (i32) -> i18
            %2875 = sv.array_index_inout %_RANDOM[%c-94_i8] : !hw.inout<uarray<165xi32>>, i8
            %2876 = sv.read_inout %2875 : !hw.inout<i32>
            %2877 = comb.extract %2876 from 0 : (i32) -> i14
            %2878 = comb.concat %2877, %2874 : i14, i18
            %2879 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2880 = sv.struct_field_inout %2879["memRdata"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2880, %2878 : i32
            %2881 = sv.array_index_inout %_RANDOM[%c-93_i8] : !hw.inout<uarray<165xi32>>, i8
            %2882 = sv.read_inout %2881 : !hw.inout<i32>
            %2883 = comb.extract %2882 from 0 : (i32) -> i14
            %2884 = comb.concat %2883, %2238 : i14, i18
            %2885 = sv.array_index_inout %memStage[%c-1_i2] : !hw.inout<array<4xstruct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>>, i2
            %2886 = sv.struct_field_inout %2885["aluResult"] : !hw.inout<struct<threadId: i2, valid: i1, pc: i32, instr: i32, isALU: i1, isLoad: i1, isStore: i1, isBranch: i1, isJAL: i1, isJALR: i1, isLUI: i1, isAUIPC: i1, isFence: i1, isSystem: i1, aluOp: i5, imm: i32, rs1: i5, rs2: i5, rd: i5, rs1Data: i32, rs2Data: i32, memAddr: i32, memWdata: i32, memRdata: i32, aluResult: i32>>
            sv.bpassign %2886, %2884 : i32
          }
        }
        sv.ifdef  @FIRRTL_AFTER_INITIAL {
          sv.verbatim "`FIRRTL_AFTER_INITIAL"
        }
      }
    }
    %225 = sv.read_inout %_ifWire_instr_T_1 : !hw.inout<i10>
    %instrMem_ext.R0_data = hw.instance "instrMem_ext" @instrMem_1024x32(R0_addr: %225: i10, R0_en: %true: i1, R0_clk: %clock: i1, W0_addr: %instrWriteAddr: i10, W0_en: %instrWriteEnable: i1, W0_clk: %clock: i1, W0_data: %instrWriteData: i32) -> (R0_data: i32) {hw.verilogName = "instrMem_ext"}
    sv.assign %_instrMem_ext_R0_data, %instrMem_ext.R0_data : i32
    %226 = sv.read_inout %wbData : !hw.inout<i32>
    %227 = sv.read_inout %_regFile_io_wen_T_3 : !hw.inout<i1>
    %228 = sv.read_inout %currentThread : !hw.inout<i2>
    %regFile.io_src1data, %regFile.io_src2data = hw.instance "regFile" @RegFileMT2R1WVec(clock: %clock: i1, reset: %reset: i1, io_threadID: %228: i2, io_src1: %rs1: i5, io_src2: %rs2: i5, io_dst1: %rd_32: i5, io_wen: %227: i1, io_dst1data: %226: i32) -> (io_src1data: i32, io_src2data: i32) {hw.verilogName = "regFile"}
    sv.assign %_regFile_io_src2data, %regFile.io_src2data : i32
    sv.assign %_regFile_io_src1data, %regFile.io_src1data : i32
    %alu.io_out = hw.instance "alu" @TetraNyteCore_Anon(io_a: %rs1Data: i32, io_b: %rs2Data: i32, io_fn: %aluOp_7: i5) -> (io_out: i32) {hw.verilogName = "alu"}
    sv.assign %_alu_io_out, %alu.io_out : i32
    hw.output %memAddr, %memWdata, %memWe : i32, i32, i1
  }
  om.class @TetraNyteCore_Class(%basepath: !om.frozenbasepath) {
    om.class.fields
  }
}
