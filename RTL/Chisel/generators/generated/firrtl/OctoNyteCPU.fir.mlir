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
  hw.module private @BranchUnit(in %io_rs1 : i32, in %io_rs2 : i32, in %io_pc : i32, in %io_imm : i12, in %io_branchOp : i3, out io_taken : i1, out io_target : i32, out io_nextPc : i32, out io_misaligned : i1) {
    %c4_i33 = hw.constant 4 : i33
    %c1_i3 = hw.constant 1 : i3
    %c-1_i3 = hw.constant -1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c0_i2 = hw.constant 0 : i2
    %c-4_i32 = hw.constant -4 : i32
    %false = hw.constant false
    %c-4_i3 = hw.constant -4 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-2_i3 = hw.constant -2 : i3
    %true = hw.constant true
    %io = sv.wire sym @sym {hw.verilogName = "io"} : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %0 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %rs1 = hw.struct_extract %0["rs1"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %_io_taken_T_5 = sv.wire sym @sym_13 {hw.verilogName = "_io_taken_T_5"} : !hw.inout<i32>
    sv.assign %_io_taken_T_5, %rs1 : i32
    %_io_taken_T_9 = sv.wire sym @sym_17 {hw.verilogName = "_io_taken_T_9"} : !hw.inout<i32>
    sv.assign %_io_taken_T_9, %rs1 : i32
    %1 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %rs2 = hw.struct_extract %1["rs2"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %_io_taken_T_6 = sv.wire sym @sym_14 {hw.verilogName = "_io_taken_T_6"} : !hw.inout<i32>
    sv.assign %_io_taken_T_6, %rs2 : i32
    %_io_taken_T_10 = sv.wire sym @sym_18 {hw.verilogName = "_io_taken_T_10"} : !hw.inout<i32>
    sv.assign %_io_taken_T_10, %rs2 : i32
    %2 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %pc = hw.struct_extract %2["pc"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %_targetAddr_T = sv.wire sym @sym_0 {hw.verilogName = "_targetAddr_T"} : !hw.inout<i32>
    sv.assign %_targetAddr_T, %pc : i32
    %3 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %imm = hw.struct_extract %3["imm"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %4 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %branchOp = hw.struct_extract %4["branchOp"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %5 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %taken = hw.struct_extract %5["taken"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %6 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %target = hw.struct_extract %6["target"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %7 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %nextPc = hw.struct_extract %7["nextPc"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %8 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %misaligned = hw.struct_extract %8["misaligned"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %9 = sv.read_inout %_targetAddr_T : !hw.inout<i32>
    %10 = comb.extract %9 from 31 : (i32) -> i1
    %11 = sv.read_inout %_targetAddr_T : !hw.inout<i32>
    %12 = comb.concat %10, %11 : i1, i32
    %13 = comb.extract %imm from 11 : (i12) -> i1
    %14 = comb.replicate %13 : (i1) -> i21
    %15 = comb.concat %14, %imm : i21, i12
    %16 = comb.add bin %12, %15 : i33
    %_targetAddr_T_1 = sv.wire sym @sym_1 {hw.verilogName = "_targetAddr_T_1"} : !hw.inout<i33>
    sv.assign %_targetAddr_T_1, %16 : i33
    %17 = sv.read_inout %_targetAddr_T_1 : !hw.inout<i33>
    %18 = comb.extract %17 from 0 : (i33) -> i32
    %_targetAddr_T_2 = sv.wire sym @sym_2 {hw.verilogName = "_targetAddr_T_2"} : !hw.inout<i32>
    sv.assign %_targetAddr_T_2, %18 : i32
    %19 = sv.read_inout %_targetAddr_T_2 : !hw.inout<i32>
    %_targetAddr_T_3 = sv.wire sym @sym_3 {hw.verilogName = "_targetAddr_T_3"} : !hw.inout<i32>
    sv.assign %_targetAddr_T_3, %19 : i32
    %20 = sv.read_inout %_targetAddr_T_3 : !hw.inout<i32>
    %targetAddr = sv.wire sym @sym_4 {hw.verilogName = "targetAddr"} : !hw.inout<i32>
    sv.assign %targetAddr, %20 : i32
    %21 = sv.read_inout %targetAddr : !hw.inout<i32>
    %22 = comb.and bin %21, %c-4_i32 : i32
    %_io_target_T = sv.wire sym @sym_5 {hw.verilogName = "_io_target_T"} : !hw.inout<i32>
    sv.assign %_io_target_T, %22 : i32
    %23 = sv.read_inout %targetAddr : !hw.inout<i32>
    %24 = comb.extract %23 from 0 : (i32) -> i2
    %_io_misaligned_T = sv.wire sym @sym_6 {hw.verilogName = "_io_misaligned_T"} : !hw.inout<i2>
    sv.assign %_io_misaligned_T, %24 : i2
    %25 = sv.read_inout %_io_misaligned_T : !hw.inout<i2>
    %26 = comb.icmp bin ne %25, %c0_i2 : i2
    %_io_misaligned_T_1 = sv.wire sym @sym_7 {hw.verilogName = "_io_misaligned_T_1"} : !hw.inout<i1>
    sv.assign %_io_misaligned_T_1, %26 : i1
    %27 = comb.icmp bin eq %branchOp, %c0_i3 : i3
    %_io_taken_T = sv.wire sym @sym_8 {hw.verilogName = "_io_taken_T"} : !hw.inout<i1>
    sv.assign %_io_taken_T, %27 : i1
    %28 = comb.icmp bin eq %rs1, %rs2 : i32
    %_io_taken_T_1 = sv.wire sym @sym_9 {hw.verilogName = "_io_taken_T_1"} : !hw.inout<i1>
    sv.assign %_io_taken_T_1, %28 : i1
    %29 = comb.icmp bin eq %branchOp, %c1_i3 : i3
    %_io_taken_T_2 = sv.wire sym @sym_10 {hw.verilogName = "_io_taken_T_2"} : !hw.inout<i1>
    sv.assign %_io_taken_T_2, %29 : i1
    %30 = comb.icmp bin ne %rs1, %rs2 : i32
    %_io_taken_T_3 = sv.wire sym @sym_11 {hw.verilogName = "_io_taken_T_3"} : !hw.inout<i1>
    sv.assign %_io_taken_T_3, %30 : i1
    %31 = comb.icmp bin eq %branchOp, %c-4_i3 : i3
    %_io_taken_T_4 = sv.wire sym @sym_12 {hw.verilogName = "_io_taken_T_4"} : !hw.inout<i1>
    sv.assign %_io_taken_T_4, %31 : i1
    %32 = sv.read_inout %_io_taken_T_5 : !hw.inout<i32>
    %33 = sv.read_inout %_io_taken_T_6 : !hw.inout<i32>
    %34 = comb.icmp bin slt %32, %33 : i32
    %_io_taken_T_7 = sv.wire sym @sym_15 {hw.verilogName = "_io_taken_T_7"} : !hw.inout<i1>
    sv.assign %_io_taken_T_7, %34 : i1
    %35 = comb.icmp bin eq %branchOp, %c-3_i3 : i3
    %_io_taken_T_8 = sv.wire sym @sym_16 {hw.verilogName = "_io_taken_T_8"} : !hw.inout<i1>
    sv.assign %_io_taken_T_8, %35 : i1
    %36 = sv.read_inout %_io_taken_T_9 : !hw.inout<i32>
    %37 = sv.read_inout %_io_taken_T_10 : !hw.inout<i32>
    %38 = comb.icmp bin sge %36, %37 : i32
    %_io_taken_T_11 = sv.wire sym @sym_19 {hw.verilogName = "_io_taken_T_11"} : !hw.inout<i1>
    sv.assign %_io_taken_T_11, %38 : i1
    %39 = comb.icmp bin eq %branchOp, %c-2_i3 : i3
    %_io_taken_T_12 = sv.wire sym @sym_20 {hw.verilogName = "_io_taken_T_12"} : !hw.inout<i1>
    sv.assign %_io_taken_T_12, %39 : i1
    %40 = comb.icmp bin ult %rs1, %rs2 : i32
    %_io_taken_T_13 = sv.wire sym @sym_21 {hw.verilogName = "_io_taken_T_13"} : !hw.inout<i1>
    sv.assign %_io_taken_T_13, %40 : i1
    %41 = comb.icmp bin eq %branchOp, %c-1_i3 : i3
    %_io_taken_T_14 = sv.wire sym @sym_22 {hw.verilogName = "_io_taken_T_14"} : !hw.inout<i1>
    sv.assign %_io_taken_T_14, %41 : i1
    %42 = comb.icmp bin uge %rs1, %rs2 : i32
    %_io_taken_T_15 = sv.wire sym @sym_23 {hw.verilogName = "_io_taken_T_15"} : !hw.inout<i1>
    sv.assign %_io_taken_T_15, %42 : i1
    %43 = sv.read_inout %_io_taken_T_14 : !hw.inout<i1>
    %44 = sv.read_inout %_io_taken_T_15 : !hw.inout<i1>
    %45 = comb.and %43, %44 : i1
    %_io_taken_T_16 = sv.wire sym @sym_24 {hw.verilogName = "_io_taken_T_16"} : !hw.inout<i1>
    sv.assign %_io_taken_T_16, %45 : i1
    %46 = sv.read_inout %_io_taken_T_12 : !hw.inout<i1>
    %47 = sv.read_inout %_io_taken_T_13 : !hw.inout<i1>
    %48 = sv.read_inout %_io_taken_T_16 : !hw.inout<i1>
    %49 = comb.mux bin %46, %47, %48 : i1
    %_io_taken_T_17 = sv.wire sym @sym_25 {hw.verilogName = "_io_taken_T_17"} : !hw.inout<i1>
    sv.assign %_io_taken_T_17, %49 : i1
    %50 = sv.read_inout %_io_taken_T_8 : !hw.inout<i1>
    %51 = sv.read_inout %_io_taken_T_11 : !hw.inout<i1>
    %52 = sv.read_inout %_io_taken_T_17 : !hw.inout<i1>
    %53 = comb.mux bin %50, %51, %52 : i1
    %_io_taken_T_18 = sv.wire sym @sym_26 {hw.verilogName = "_io_taken_T_18"} : !hw.inout<i1>
    sv.assign %_io_taken_T_18, %53 : i1
    %54 = sv.read_inout %_io_taken_T_4 : !hw.inout<i1>
    %55 = sv.read_inout %_io_taken_T_7 : !hw.inout<i1>
    %56 = sv.read_inout %_io_taken_T_18 : !hw.inout<i1>
    %57 = comb.mux bin %54, %55, %56 : i1
    %_io_taken_T_19 = sv.wire sym @sym_27 {hw.verilogName = "_io_taken_T_19"} : !hw.inout<i1>
    sv.assign %_io_taken_T_19, %57 : i1
    %58 = sv.read_inout %_io_taken_T_2 : !hw.inout<i1>
    %59 = sv.read_inout %_io_taken_T_3 : !hw.inout<i1>
    %60 = sv.read_inout %_io_taken_T_19 : !hw.inout<i1>
    %61 = comb.mux bin %58, %59, %60 : i1
    %_io_taken_T_20 = sv.wire sym @sym_28 {hw.verilogName = "_io_taken_T_20"} : !hw.inout<i1>
    sv.assign %_io_taken_T_20, %61 : i1
    %62 = sv.read_inout %_io_taken_T : !hw.inout<i1>
    %63 = sv.read_inout %_io_taken_T_1 : !hw.inout<i1>
    %64 = sv.read_inout %_io_taken_T_20 : !hw.inout<i1>
    %65 = comb.mux bin %62, %63, %64 : i1
    %_io_taken_T_21 = sv.wire sym @sym_29 {hw.verilogName = "_io_taken_T_21"} : !hw.inout<i1>
    sv.assign %_io_taken_T_21, %65 : i1
    %66 = sv.read_inout %_io_taken_T_21 : !hw.inout<i1>
    %_io_taken_T_22 = sv.wire sym @sym_30 {hw.verilogName = "_io_taken_T_22"} : !hw.inout<i1>
    sv.assign %_io_taken_T_22, %66 : i1
    %67 = comb.xor bin %misaligned, %true : i1
    %_io_taken_T_23 = sv.wire sym @sym_31 {hw.verilogName = "_io_taken_T_23"} : !hw.inout<i1>
    sv.assign %_io_taken_T_23, %67 : i1
    %68 = sv.read_inout %_io_taken_T_22 : !hw.inout<i1>
    %69 = sv.read_inout %_io_taken_T_23 : !hw.inout<i1>
    %70 = comb.and bin %68, %69 : i1
    %_io_taken_T_24 = sv.wire sym @sym_32 {hw.verilogName = "_io_taken_T_24"} : !hw.inout<i1>
    sv.assign %_io_taken_T_24, %70 : i1
    %71 = sv.read_inout %_targetAddr_T : !hw.inout<i32>
    %72 = comb.concat %false, %71 : i1, i32
    %73 = comb.add bin %72, %c4_i33 : i33
    %_io_nextPc_T = sv.wire sym @sym_33 {hw.verilogName = "_io_nextPc_T"} : !hw.inout<i33>
    sv.assign %_io_nextPc_T, %73 : i33
    %74 = sv.read_inout %_io_nextPc_T : !hw.inout<i33>
    %75 = comb.extract %74 from 0 : (i33) -> i32
    %_io_nextPc_T_1 = sv.wire sym @sym_34 {hw.verilogName = "_io_nextPc_T_1"} : !hw.inout<i32>
    sv.assign %_io_nextPc_T_1, %75 : i32
    %76 = sv.read_inout %_io_nextPc_T_1 : !hw.inout<i32>
    %77 = comb.mux bin %taken, %target, %76 : i32
    %_io_nextPc_T_2 = sv.wire sym @sym_35 {hw.verilogName = "_io_nextPc_T_2"} : !hw.inout<i32>
    sv.assign %_io_nextPc_T_2, %77 : i32
    %78 = sv.read_inout %_io_target_T : !hw.inout<i32>
    %79 = sv.read_inout %_io_misaligned_T_1 : !hw.inout<i1>
    %80 = sv.read_inout %_io_taken_T_24 : !hw.inout<i1>
    %81 = sv.read_inout %_io_nextPc_T_2 : !hw.inout<i32>
    %82 = hw.struct_create (%io_rs1, %io_rs2, %io_pc, %io_imm, %io_branchOp, %true, %80, %78, %81, %79) : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    sv.assign %io, %82 : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    hw.output %taken, %target, %nextPc, %misaligned : i1, i32, i32, i1
  }
  hw.module private @ALU32(in %io_a : i32, in %io_b : i32, out io_result : i32, in %io_opcode : i6) {
    %c6_i4 = hw.constant 6 : i4
    %c4_i4 = hw.constant 4 : i4
    %c2_i4 = hw.constant 2 : i4
    %c1_i4 = hw.constant 1 : i4
    %c0_i62 = hw.constant 0 : i62
    %c0_i31 = hw.constant 0 : i31
    %c0_i26 = hw.constant 0 : i26
    %c0_i89 = hw.constant 0 : i89
    %c0_i63 = hw.constant 0 : i63
    %c0_i4 = hw.constant 0 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c-4_i4 = hw.constant -4 : i4
    %c-2_i4 = hw.constant -2 : i4
    %c-6_i4 = hw.constant -6 : i4
    %c-5_i4 = hw.constant -5 : i4
    %c0_i32 = hw.constant 0 : i32
    %io = sv.wire sym @sym {hw.verilogName = "io"} : !hw.inout<struct<a: i32, b: i32, result: i32, opcode: i6>>
    %0 = sv.read_inout %io : !hw.inout<struct<a: i32, b: i32, result: i32, opcode: i6>>
    %a = hw.struct_extract %0["a"] : !hw.struct<a: i32, b: i32, result: i32, opcode: i6>
    %_result_T_2 = sv.wire sym @sym_2 {hw.verilogName = "_result_T_2"} : !hw.inout<i32>
    sv.assign %_result_T_2, %a : i32
    %_result_T_8 = sv.wire sym @sym_8 {hw.verilogName = "_result_T_8"} : !hw.inout<i32>
    sv.assign %_result_T_8, %a : i32
    %_result_T_31 = sv.wire sym @sym_31 {hw.verilogName = "_result_T_31"} : !hw.inout<i32>
    sv.assign %_result_T_31, %a : i32
    %_result_T_37 = sv.wire sym @sym_37 {hw.verilogName = "_result_T_37"} : !hw.inout<i32>
    sv.assign %_result_T_37, %a : i32
    %1 = sv.read_inout %io : !hw.inout<struct<a: i32, b: i32, result: i32, opcode: i6>>
    %b = hw.struct_extract %1["b"] : !hw.struct<a: i32, b: i32, result: i32, opcode: i6>
    %_result_T_3 = sv.wire sym @sym_3 {hw.verilogName = "_result_T_3"} : !hw.inout<i32>
    sv.assign %_result_T_3, %b : i32
    %_result_T_9 = sv.wire sym @sym_9 {hw.verilogName = "_result_T_9"} : !hw.inout<i32>
    sv.assign %_result_T_9, %b : i32
    %_result_T_38 = sv.wire sym @sym_38 {hw.verilogName = "_result_T_38"} : !hw.inout<i32>
    sv.assign %_result_T_38, %b : i32
    %2 = sv.read_inout %io : !hw.inout<struct<a: i32, b: i32, result: i32, opcode: i6>>
    %result = hw.struct_extract %2["result"] : !hw.struct<a: i32, b: i32, result: i32, opcode: i6>
    %3 = sv.read_inout %io : !hw.inout<struct<a: i32, b: i32, result: i32, opcode: i6>>
    %opcode = hw.struct_extract %3["opcode"] : !hw.struct<a: i32, b: i32, result: i32, opcode: i6>
    %4 = comb.extract %opcode from 0 : (i6) -> i4
    %_result_T = sv.wire sym @sym_0 {hw.verilogName = "_result_T"} : !hw.inout<i4>
    sv.assign %_result_T, %4 : i4
    %_result_T_6 = sv.wire sym @sym_6 {hw.verilogName = "_result_T_6"} : !hw.inout<i4>
    sv.assign %_result_T_6, %4 : i4
    %_result_T_12 = sv.wire sym @sym_12 {hw.verilogName = "_result_T_12"} : !hw.inout<i4>
    sv.assign %_result_T_12, %4 : i4
    %_result_T_15 = sv.wire sym @sym_15 {hw.verilogName = "_result_T_15"} : !hw.inout<i4>
    sv.assign %_result_T_15, %4 : i4
    %_result_T_18 = sv.wire sym @sym_18 {hw.verilogName = "_result_T_18"} : !hw.inout<i4>
    sv.assign %_result_T_18, %4 : i4
    %_result_T_21 = sv.wire sym @sym_21 {hw.verilogName = "_result_T_21"} : !hw.inout<i4>
    sv.assign %_result_T_21, %4 : i4
    %_result_T_25 = sv.wire sym @sym_25 {hw.verilogName = "_result_T_25"} : !hw.inout<i4>
    sv.assign %_result_T_25, %4 : i4
    %_result_T_29 = sv.wire sym @sym_29 {hw.verilogName = "_result_T_29"} : !hw.inout<i4>
    sv.assign %_result_T_29, %4 : i4
    %_result_T_35 = sv.wire sym @sym_35 {hw.verilogName = "_result_T_35"} : !hw.inout<i4>
    sv.assign %_result_T_35, %4 : i4
    %_result_T_41 = sv.wire sym @sym_41 {hw.verilogName = "_result_T_41"} : !hw.inout<i4>
    sv.assign %_result_T_41, %4 : i4
    %5 = sv.read_inout %_result_T : !hw.inout<i4>
    %6 = comb.icmp bin eq %5, %c0_i4 : i4
    %_result_T_1 = sv.wire sym @sym_1 {hw.verilogName = "_result_T_1"} : !hw.inout<i1>
    sv.assign %_result_T_1, %6 : i1
    %7 = sv.read_inout %_result_T_2 : !hw.inout<i32>
    %8 = comb.extract %7 from 31 : (i32) -> i1
    %9 = sv.read_inout %_result_T_2 : !hw.inout<i32>
    %10 = comb.concat %8, %9 : i1, i32
    %11 = sv.read_inout %_result_T_3 : !hw.inout<i32>
    %12 = comb.extract %11 from 31 : (i32) -> i1
    %13 = sv.read_inout %_result_T_3 : !hw.inout<i32>
    %14 = comb.concat %12, %13 : i1, i32
    %15 = comb.add bin %10, %14 : i33
    %_result_T_4 = sv.wire sym @sym_4 {hw.verilogName = "_result_T_4"} : !hw.inout<i33>
    sv.assign %_result_T_4, %15 : i33
    %16 = sv.read_inout %_result_T_4 : !hw.inout<i33>
    %_result_T_5 = sv.wire sym @sym_5 {hw.verilogName = "_result_T_5"} : !hw.inout<i33>
    sv.assign %_result_T_5, %16 : i33
    %17 = sv.read_inout %_result_T_6 : !hw.inout<i4>
    %18 = comb.icmp bin eq %17, %c1_i4 : i4
    %_result_T_7 = sv.wire sym @sym_7 {hw.verilogName = "_result_T_7"} : !hw.inout<i1>
    sv.assign %_result_T_7, %18 : i1
    %19 = sv.read_inout %_result_T_8 : !hw.inout<i32>
    %20 = comb.extract %19 from 31 : (i32) -> i1
    %21 = sv.read_inout %_result_T_8 : !hw.inout<i32>
    %22 = comb.concat %20, %21 : i1, i32
    %23 = sv.read_inout %_result_T_9 : !hw.inout<i32>
    %24 = comb.extract %23 from 31 : (i32) -> i1
    %25 = sv.read_inout %_result_T_9 : !hw.inout<i32>
    %26 = comb.concat %24, %25 : i1, i32
    %27 = comb.sub bin %22, %26 : i33
    %_result_T_10 = sv.wire sym @sym_10 {hw.verilogName = "_result_T_10"} : !hw.inout<i33>
    sv.assign %_result_T_10, %27 : i33
    %28 = sv.read_inout %_result_T_10 : !hw.inout<i33>
    %_result_T_11 = sv.wire sym @sym_11 {hw.verilogName = "_result_T_11"} : !hw.inout<i33>
    sv.assign %_result_T_11, %28 : i33
    %29 = sv.read_inout %_result_T_12 : !hw.inout<i4>
    %30 = comb.icmp bin eq %29, %c-8_i4 : i4
    %_result_T_13 = sv.wire sym @sym_13 {hw.verilogName = "_result_T_13"} : !hw.inout<i1>
    sv.assign %_result_T_13, %30 : i1
    %31 = comb.xor bin %a, %b : i32
    %_result_T_14 = sv.wire sym @sym_14 {hw.verilogName = "_result_T_14"} : !hw.inout<i32>
    sv.assign %_result_T_14, %31 : i32
    %32 = sv.read_inout %_result_T_15 : !hw.inout<i4>
    %33 = comb.icmp bin eq %32, %c-4_i4 : i4
    %_result_T_16 = sv.wire sym @sym_16 {hw.verilogName = "_result_T_16"} : !hw.inout<i1>
    sv.assign %_result_T_16, %33 : i1
    %34 = comb.or bin %a, %b : i32
    %_result_T_17 = sv.wire sym @sym_17 {hw.verilogName = "_result_T_17"} : !hw.inout<i32>
    sv.assign %_result_T_17, %34 : i32
    %35 = sv.read_inout %_result_T_18 : !hw.inout<i4>
    %36 = comb.icmp bin eq %35, %c-2_i4 : i4
    %_result_T_19 = sv.wire sym @sym_19 {hw.verilogName = "_result_T_19"} : !hw.inout<i1>
    sv.assign %_result_T_19, %36 : i1
    %37 = comb.and bin %a, %b : i32
    %_result_T_20 = sv.wire sym @sym_20 {hw.verilogName = "_result_T_20"} : !hw.inout<i32>
    sv.assign %_result_T_20, %37 : i32
    %38 = sv.read_inout %_result_T_21 : !hw.inout<i4>
    %39 = comb.icmp bin eq %38, %c2_i4 : i4
    %_result_T_22 = sv.wire sym @sym_22 {hw.verilogName = "_result_T_22"} : !hw.inout<i1>
    sv.assign %_result_T_22, %39 : i1
    %40 = comb.extract %b from 0 : (i32) -> i6
    %_result_T_23 = sv.wire sym @sym_23 {hw.verilogName = "_result_T_23"} : !hw.inout<i6>
    sv.assign %_result_T_23, %40 : i6
    %_result_T_27 = sv.wire sym @sym_27 {hw.verilogName = "_result_T_27"} : !hw.inout<i6>
    sv.assign %_result_T_27, %40 : i6
    %_result_T_32 = sv.wire sym @sym_32 {hw.verilogName = "_result_T_32"} : !hw.inout<i6>
    sv.assign %_result_T_32, %40 : i6
    %41 = comb.concat %c0_i63, %a : i63, i32
    %42 = sv.read_inout %_result_T_23 : !hw.inout<i6>
    %43 = comb.concat %c0_i89, %42 : i89, i6
    %44 = comb.shl bin %41, %43 : i95
    %_result_T_24 = sv.wire sym @sym_24 {hw.verilogName = "_result_T_24"} : !hw.inout<i95>
    sv.assign %_result_T_24, %44 : i95
    %45 = sv.read_inout %_result_T_25 : !hw.inout<i4>
    %46 = comb.icmp bin eq %45, %c-6_i4 : i4
    %_result_T_26 = sv.wire sym @sym_26 {hw.verilogName = "_result_T_26"} : !hw.inout<i1>
    sv.assign %_result_T_26, %46 : i1
    %47 = sv.read_inout %_result_T_27 : !hw.inout<i6>
    %48 = comb.concat %c0_i26, %47 : i26, i6
    %49 = comb.shru bin %a, %48 : i32
    %_result_T_28 = sv.wire sym @sym_28 {hw.verilogName = "_result_T_28"} : !hw.inout<i32>
    sv.assign %_result_T_28, %49 : i32
    %50 = sv.read_inout %_result_T_29 : !hw.inout<i4>
    %51 = comb.icmp bin eq %50, %c-5_i4 : i4
    %_result_T_30 = sv.wire sym @sym_30 {hw.verilogName = "_result_T_30"} : !hw.inout<i1>
    sv.assign %_result_T_30, %51 : i1
    %52 = sv.read_inout %_result_T_32 : !hw.inout<i6>
    %53 = comb.concat %c0_i26, %52 : i26, i6
    %54 = sv.read_inout %_result_T_31 : !hw.inout<i32>
    %55 = comb.shrs bin %54, %53 : i32
    %_result_T_33 = sv.wire sym @sym_33 {hw.verilogName = "_result_T_33"} : !hw.inout<i32>
    sv.assign %_result_T_33, %55 : i32
    %56 = sv.read_inout %_result_T_33 : !hw.inout<i32>
    %_result_T_34 = sv.wire sym @sym_34 {hw.verilogName = "_result_T_34"} : !hw.inout<i32>
    sv.assign %_result_T_34, %56 : i32
    %57 = sv.read_inout %_result_T_35 : !hw.inout<i4>
    %58 = comb.icmp bin eq %57, %c4_i4 : i4
    %_result_T_36 = sv.wire sym @sym_36 {hw.verilogName = "_result_T_36"} : !hw.inout<i1>
    sv.assign %_result_T_36, %58 : i1
    %59 = sv.read_inout %_result_T_37 : !hw.inout<i32>
    %60 = sv.read_inout %_result_T_38 : !hw.inout<i32>
    %61 = comb.icmp bin slt %59, %60 : i32
    %_result_T_39 = sv.wire sym @sym_39 {hw.verilogName = "_result_T_39"} : !hw.inout<i1>
    sv.assign %_result_T_39, %61 : i1
    %62 = sv.read_inout %_result_T_39 : !hw.inout<i1>
    %_result_T_40 = sv.wire sym @sym_40 {hw.verilogName = "_result_T_40"} : !hw.inout<i1>
    sv.assign %_result_T_40, %62 : i1
    %63 = sv.read_inout %_result_T_41 : !hw.inout<i4>
    %64 = comb.icmp bin eq %63, %c6_i4 : i4
    %_result_T_42 = sv.wire sym @sym_42 {hw.verilogName = "_result_T_42"} : !hw.inout<i1>
    sv.assign %_result_T_42, %64 : i1
    %65 = comb.icmp bin ult %a, %b : i32
    %_result_T_43 = sv.wire sym @sym_43 {hw.verilogName = "_result_T_43"} : !hw.inout<i1>
    sv.assign %_result_T_43, %65 : i1
    %66 = sv.read_inout %_result_T_43 : !hw.inout<i1>
    %_result_T_44 = sv.wire sym @sym_44 {hw.verilogName = "_result_T_44"} : !hw.inout<i1>
    sv.assign %_result_T_44, %66 : i1
    %67 = sv.read_inout %_result_T_44 : !hw.inout<i1>
    %68 = comb.concat %c0_i31, %67 : i31, i1
    %69 = sv.read_inout %_result_T_42 : !hw.inout<i1>
    %70 = comb.mux bin %69, %68, %c0_i32 : i32
    %_result_T_45 = sv.wire sym @sym_45 {hw.verilogName = "_result_T_45"} : !hw.inout<i32>
    sv.assign %_result_T_45, %70 : i32
    %71 = sv.read_inout %_result_T_40 : !hw.inout<i1>
    %72 = comb.concat %c0_i31, %71 : i31, i1
    %73 = sv.read_inout %_result_T_36 : !hw.inout<i1>
    %74 = sv.read_inout %_result_T_45 : !hw.inout<i32>
    %75 = comb.mux bin %73, %72, %74 : i32
    %_result_T_46 = sv.wire sym @sym_46 {hw.verilogName = "_result_T_46"} : !hw.inout<i32>
    sv.assign %_result_T_46, %75 : i32
    %76 = sv.read_inout %_result_T_30 : !hw.inout<i1>
    %77 = sv.read_inout %_result_T_34 : !hw.inout<i32>
    %78 = sv.read_inout %_result_T_46 : !hw.inout<i32>
    %79 = comb.mux bin %76, %77, %78 : i32
    %_result_T_47 = sv.wire sym @sym_47 {hw.verilogName = "_result_T_47"} : !hw.inout<i32>
    sv.assign %_result_T_47, %79 : i32
    %80 = sv.read_inout %_result_T_26 : !hw.inout<i1>
    %81 = sv.read_inout %_result_T_28 : !hw.inout<i32>
    %82 = sv.read_inout %_result_T_47 : !hw.inout<i32>
    %83 = comb.mux bin %80, %81, %82 : i32
    %_result_T_48 = sv.wire sym @sym_48 {hw.verilogName = "_result_T_48"} : !hw.inout<i32>
    sv.assign %_result_T_48, %83 : i32
    %84 = sv.read_inout %_result_T_48 : !hw.inout<i32>
    %85 = comb.concat %c0_i63, %84 : i63, i32
    %86 = sv.read_inout %_result_T_22 : !hw.inout<i1>
    %87 = sv.read_inout %_result_T_24 : !hw.inout<i95>
    %88 = comb.mux bin %86, %87, %85 : i95
    %_result_T_49 = sv.wire sym @sym_49 {hw.verilogName = "_result_T_49"} : !hw.inout<i95>
    sv.assign %_result_T_49, %88 : i95
    %89 = sv.read_inout %_result_T_20 : !hw.inout<i32>
    %90 = comb.concat %c0_i63, %89 : i63, i32
    %91 = sv.read_inout %_result_T_19 : !hw.inout<i1>
    %92 = sv.read_inout %_result_T_49 : !hw.inout<i95>
    %93 = comb.mux bin %91, %90, %92 : i95
    %_result_T_50 = sv.wire sym @sym_50 {hw.verilogName = "_result_T_50"} : !hw.inout<i95>
    sv.assign %_result_T_50, %93 : i95
    %94 = sv.read_inout %_result_T_17 : !hw.inout<i32>
    %95 = comb.concat %c0_i63, %94 : i63, i32
    %96 = sv.read_inout %_result_T_16 : !hw.inout<i1>
    %97 = sv.read_inout %_result_T_50 : !hw.inout<i95>
    %98 = comb.mux bin %96, %95, %97 : i95
    %_result_T_51 = sv.wire sym @sym_51 {hw.verilogName = "_result_T_51"} : !hw.inout<i95>
    sv.assign %_result_T_51, %98 : i95
    %99 = sv.read_inout %_result_T_14 : !hw.inout<i32>
    %100 = comb.concat %c0_i63, %99 : i63, i32
    %101 = sv.read_inout %_result_T_13 : !hw.inout<i1>
    %102 = sv.read_inout %_result_T_51 : !hw.inout<i95>
    %103 = comb.mux bin %101, %100, %102 : i95
    %_result_T_52 = sv.wire sym @sym_52 {hw.verilogName = "_result_T_52"} : !hw.inout<i95>
    sv.assign %_result_T_52, %103 : i95
    %104 = sv.read_inout %_result_T_11 : !hw.inout<i33>
    %105 = comb.concat %c0_i62, %104 : i62, i33
    %106 = sv.read_inout %_result_T_7 : !hw.inout<i1>
    %107 = sv.read_inout %_result_T_52 : !hw.inout<i95>
    %108 = comb.mux bin %106, %105, %107 : i95
    %_result_T_53 = sv.wire sym @sym_53 {hw.verilogName = "_result_T_53"} : !hw.inout<i95>
    sv.assign %_result_T_53, %108 : i95
    %109 = sv.read_inout %_result_T_5 : !hw.inout<i33>
    %110 = comb.concat %c0_i62, %109 : i62, i33
    %111 = sv.read_inout %_result_T_1 : !hw.inout<i1>
    %112 = sv.read_inout %_result_T_53 : !hw.inout<i95>
    %113 = comb.mux bin %111, %110, %112 : i95
    %result_0 = sv.wire sym @sym_54 name "result" {hw.verilogName = "result"} : !hw.inout<i95>
    sv.assign %result_0, %113 : i95
    %114 = sv.read_inout %result_0 : !hw.inout<i95>
    %115 = comb.extract %114 from 0 : (i95) -> i32
    %116 = hw.struct_create (%io_a, %io_b, %115, %io_opcode) : !hw.struct<a: i32, b: i32, result: i32, opcode: i6>
    sv.assign %io, %116 : !hw.struct<a: i32, b: i32, result: i32, opcode: i6>
    hw.output %result : i32
  }
  hw.module private @LoadUnit(in %io_addr : i32, in %io_dataIn : i32, in %io_funct3 : i3, out io_dataOut : i32) {
    %extractedData = sv.wire sym @sym_17 {hw.verilogName = "extractedData"} : !hw.inout<i32>
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i24 = hw.constant 0 : i24
    %c0_i16 = hw.constant 0 : i16
    %false = hw.constant false
    %c0_i3 = hw.constant 0 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %c-2_i2 = hw.constant -2 : i2
    %_loadWidth_T_7 = sv.wire sym @sym_9 {hw.verilogName = "_loadWidth_T_7"} : !hw.inout<i2>
    sv.assign %_loadWidth_T_7, %c-2_i2 : i2
    %io = sv.wire sym @sym {hw.verilogName = "io"} : !hw.inout<struct<addr: i32, dataIn: i32, funct3: i3, dataOut: i32>>
    %0 = sv.read_inout %io : !hw.inout<struct<addr: i32, dataIn: i32, funct3: i3, dataOut: i32>>
    %dataIn = hw.struct_extract %0["dataIn"] : !hw.struct<addr: i32, dataIn: i32, funct3: i3, dataOut: i32>
    %_extractedData_T_5 = sv.wire sym @sym_23 {hw.verilogName = "_extractedData_T_5"} : !hw.inout<i32>
    sv.assign %_extractedData_T_5, %dataIn : i32
    %1 = sv.read_inout %io : !hw.inout<struct<addr: i32, dataIn: i32, funct3: i3, dataOut: i32>>
    %funct3 = hw.struct_extract %1["funct3"] : !hw.struct<addr: i32, dataIn: i32, funct3: i3, dataOut: i32>
    %2 = sv.read_inout %io : !hw.inout<struct<addr: i32, dataIn: i32, funct3: i3, dataOut: i32>>
    %dataOut = hw.struct_extract %2["dataOut"] : !hw.struct<addr: i32, dataIn: i32, funct3: i3, dataOut: i32>
    %_loadWidth_T_9 = sv.wire sym @sym_11 {hw.verilogName = "_loadWidth_T_9"} : !hw.inout<i2>
    %_isSigned_T_4 = sv.wire sym @sym_16 {hw.verilogName = "_isSigned_T_4"} : !hw.inout<i1>
    %3 = comb.icmp bin eq %funct3, %c0_i3 : i3
    %4 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<i1>
    sv.assign %4, %3 : i1
    %_loadWidth_T = sv.wire sym @sym_2 {hw.verilogName = "_loadWidth_T"} : !hw.inout<i1>
    %5 = sv.read_inout %4 : !hw.inout<i1>
    sv.assign %_loadWidth_T, %5 : i1
    %_isSigned_T = sv.wire sym @sym_12 {hw.verilogName = "_isSigned_T"} : !hw.inout<i1>
    %6 = sv.read_inout %4 : !hw.inout<i1>
    sv.assign %_isSigned_T, %6 : i1
    %7 = comb.icmp bin eq %funct3, %c-4_i3 : i3
    %_loadWidth_T_1 = sv.wire sym @sym_3 {hw.verilogName = "_loadWidth_T_1"} : !hw.inout<i1>
    sv.assign %_loadWidth_T_1, %7 : i1
    %8 = sv.read_inout %_loadWidth_T : !hw.inout<i1>
    %9 = sv.read_inout %_loadWidth_T_1 : !hw.inout<i1>
    %10 = comb.or bin %8, %9 : i1
    %_loadWidth_T_2 = sv.wire sym @sym_4 {hw.verilogName = "_loadWidth_T_2"} : !hw.inout<i1>
    sv.assign %_loadWidth_T_2, %10 : i1
    %11 = comb.icmp bin eq %funct3, %c1_i3 : i3
    %12 = sv.wire {hw.verilogName = "_GEN_0"} : !hw.inout<i1>
    sv.assign %12, %11 : i1
    %_loadWidth_T_3 = sv.wire sym @sym_5 {hw.verilogName = "_loadWidth_T_3"} : !hw.inout<i1>
    %13 = sv.read_inout %12 : !hw.inout<i1>
    sv.assign %_loadWidth_T_3, %13 : i1
    %_isSigned_T_1 = sv.wire sym @sym_13 {hw.verilogName = "_isSigned_T_1"} : !hw.inout<i1>
    %14 = sv.read_inout %12 : !hw.inout<i1>
    sv.assign %_isSigned_T_1, %14 : i1
    %15 = comb.icmp bin eq %funct3, %c-3_i3 : i3
    %_loadWidth_T_4 = sv.wire sym @sym_6 {hw.verilogName = "_loadWidth_T_4"} : !hw.inout<i1>
    sv.assign %_loadWidth_T_4, %15 : i1
    %16 = sv.read_inout %_loadWidth_T_3 : !hw.inout<i1>
    %17 = sv.read_inout %_loadWidth_T_4 : !hw.inout<i1>
    %18 = comb.or bin %16, %17 : i1
    %_loadWidth_T_5 = sv.wire sym @sym_7 {hw.verilogName = "_loadWidth_T_5"} : !hw.inout<i1>
    sv.assign %_loadWidth_T_5, %18 : i1
    %19 = comb.icmp bin eq %funct3, %c2_i3 : i3
    %20 = sv.wire {hw.verilogName = "_GEN_1"} : !hw.inout<i1>
    sv.assign %20, %19 : i1
    %_loadWidth_T_6 = sv.wire sym @sym_8 {hw.verilogName = "_loadWidth_T_6"} : !hw.inout<i1>
    %21 = sv.read_inout %20 : !hw.inout<i1>
    sv.assign %_loadWidth_T_6, %21 : i1
    %_isSigned_T_3 = sv.wire sym @sym_15 {hw.verilogName = "_isSigned_T_3"} : !hw.inout<i1>
    %22 = sv.read_inout %20 : !hw.inout<i1>
    sv.assign %_isSigned_T_3, %22 : i1
    %23 = sv.read_inout %_loadWidth_T_5 : !hw.inout<i1>
    %24 = comb.mux bin %23, %c1_i2, %c-2_i2 : i2
    %_loadWidth_T_8 = sv.wire sym @sym_10 {hw.verilogName = "_loadWidth_T_8"} : !hw.inout<i2>
    sv.assign %_loadWidth_T_8, %24 : i2
    %25 = sv.read_inout %_loadWidth_T_2 : !hw.inout<i1>
    %26 = sv.read_inout %_loadWidth_T_8 : !hw.inout<i2>
    %27 = comb.mux bin %25, %c0_i2, %26 : i2
    sv.assign %_loadWidth_T_9, %27 : i2
    %28 = sv.read_inout %_loadWidth_T_9 : !hw.inout<i2>
    %loadWidth = sv.wire sym @sym_0 {hw.verilogName = "loadWidth"} : !hw.inout<i2>
    sv.assign %loadWidth, %28 : i2
    %29 = sv.read_inout %_isSigned_T : !hw.inout<i1>
    %30 = sv.read_inout %_isSigned_T_1 : !hw.inout<i1>
    %31 = comb.or bin %29, %30 : i1
    %_isSigned_T_2 = sv.wire sym @sym_14 {hw.verilogName = "_isSigned_T_2"} : !hw.inout<i1>
    sv.assign %_isSigned_T_2, %31 : i1
    %32 = sv.read_inout %_isSigned_T_3 : !hw.inout<i1>
    %33 = sv.read_inout %_isSigned_T_2 : !hw.inout<i1>
    %34 = comb.or bin %33, %32 : i1
    sv.assign %_isSigned_T_4, %34 : i1
    %35 = sv.read_inout %_isSigned_T_4 : !hw.inout<i1>
    %isSigned = sv.wire sym @sym_1 {hw.verilogName = "isSigned"} : !hw.inout<i1>
    sv.assign %isSigned, %35 : i1
    %_extractedData_T_8 = sv.wire sym @sym_26 {hw.verilogName = "_extractedData_T_8"} : !hw.inout<i32>
    %36 = sv.read_inout %extractedData : !hw.inout<i32>
    %_io_dataOut_T = sv.wire sym @sym_27 {hw.verilogName = "_io_dataOut_T"} : !hw.inout<i32>
    sv.assign %_io_dataOut_T, %36 : i32
    %37 = sv.read_inout %loadWidth : !hw.inout<i2>
    %38 = comb.icmp bin eq %37, %c0_i2 : i2
    %_extractedData_T = sv.wire sym @sym_18 {hw.verilogName = "_extractedData_T"} : !hw.inout<i1>
    sv.assign %_extractedData_T, %38 : i1
    %39 = sv.read_inout %_extractedData_T_5 : !hw.inout<i32>
    %40 = comb.extract %39 from 0 : (i32) -> i8
    %_extractedData_T_1 = sv.wire sym @sym_19 {hw.verilogName = "_extractedData_T_1"} : !hw.inout<i8>
    sv.assign %_extractedData_T_1, %40 : i8
    %41 = sv.read_inout %loadWidth : !hw.inout<i2>
    %42 = comb.icmp bin eq %41, %c1_i2 : i2
    %_extractedData_T_2 = sv.wire sym @sym_20 {hw.verilogName = "_extractedData_T_2"} : !hw.inout<i1>
    sv.assign %_extractedData_T_2, %42 : i1
    %43 = sv.read_inout %_extractedData_T_5 : !hw.inout<i32>
    %44 = comb.extract %43 from 0 : (i32) -> i16
    %_extractedData_T_3 = sv.wire sym @sym_21 {hw.verilogName = "_extractedData_T_3"} : !hw.inout<i16>
    sv.assign %_extractedData_T_3, %44 : i16
    %45 = sv.read_inout %loadWidth : !hw.inout<i2>
    %46 = comb.icmp bin eq %45, %c-2_i2 : i2
    %_extractedData_T_4 = sv.wire sym @sym_22 {hw.verilogName = "_extractedData_T_4"} : !hw.inout<i1>
    sv.assign %_extractedData_T_4, %46 : i1
    %47 = sv.read_inout %_extractedData_T_5 : !hw.inout<i32>
    %48 = sv.read_inout %_extractedData_T_4 : !hw.inout<i1>
    %49 = sv.read_inout %_extractedData_T_5 : !hw.inout<i32>
    %50 = comb.mux bin %48, %47, %49 : i32
    %_extractedData_T_6 = sv.wire sym @sym_24 {hw.verilogName = "_extractedData_T_6"} : !hw.inout<i32>
    sv.assign %_extractedData_T_6, %50 : i32
    %51 = sv.read_inout %_extractedData_T_3 : !hw.inout<i16>
    %52 = comb.concat %c0_i16, %51 : i16, i16
    %53 = sv.read_inout %_extractedData_T_2 : !hw.inout<i1>
    %54 = sv.read_inout %_extractedData_T_6 : !hw.inout<i32>
    %55 = comb.mux bin %53, %52, %54 : i32
    %_extractedData_T_7 = sv.wire sym @sym_25 {hw.verilogName = "_extractedData_T_7"} : !hw.inout<i32>
    sv.assign %_extractedData_T_7, %55 : i32
    %56 = sv.read_inout %_extractedData_T_1 : !hw.inout<i8>
    %57 = comb.concat %c0_i24, %56 : i24, i8
    %58 = sv.read_inout %_extractedData_T : !hw.inout<i1>
    %59 = sv.read_inout %_extractedData_T_7 : !hw.inout<i32>
    %60 = comb.mux bin %58, %57, %59 : i32
    sv.assign %_extractedData_T_8, %60 : i32
    %61 = sv.read_inout %_extractedData_T_8 : !hw.inout<i32>
    sv.assign %extractedData, %61 : i32
    %62 = sv.read_inout %_io_dataOut_T : !hw.inout<i32>
    %_io_dataOut_T_1 = sv.wire sym @sym_28 {hw.verilogName = "_io_dataOut_T_1"} : !hw.inout<i32>
    sv.assign %_io_dataOut_T_1, %62 : i32
    %63 = sv.read_inout %extractedData : !hw.inout<i32>
    %64 = comb.concat %false, %63 : i1, i32
    %_io_dataOut_T_2 = sv.wire sym @sym_29 {hw.verilogName = "_io_dataOut_T_2"} : !hw.inout<i33>
    sv.assign %_io_dataOut_T_2, %64 : i33
    %65 = sv.read_inout %_io_dataOut_T_2 : !hw.inout<i33>
    %_io_dataOut_T_3 = sv.wire sym @sym_30 {hw.verilogName = "_io_dataOut_T_3"} : !hw.inout<i33>
    sv.assign %_io_dataOut_T_3, %65 : i33
    %66 = sv.read_inout %_io_dataOut_T_1 : !hw.inout<i32>
    %67 = comb.concat %false, %66 : i1, i32
    %68 = sv.read_inout %isSigned : !hw.inout<i1>
    %69 = sv.read_inout %_io_dataOut_T_3 : !hw.inout<i33>
    %70 = comb.mux bin %68, %67, %69 : i33
    %_io_dataOut_T_4 = sv.wire sym @sym_31 {hw.verilogName = "_io_dataOut_T_4"} : !hw.inout<i33>
    sv.assign %_io_dataOut_T_4, %70 : i33
    %71 = sv.read_inout %_io_dataOut_T_4 : !hw.inout<i33>
    %72 = comb.extract %71 from 0 : (i33) -> i32
    %73 = hw.struct_create (%io_addr, %io_dataIn, %io_funct3, %72) : !hw.struct<addr: i32, dataIn: i32, funct3: i3, dataOut: i32>
    sv.assign %io, %73 : !hw.struct<addr: i32, dataIn: i32, funct3: i3, dataOut: i32>
    hw.output %dataOut : i32
  }
  hw.module private @StoreUnit(in %io_addr : i32, in %io_dataIn : i32, in %io_funct3 : i3, out io_memWrite : i32) {
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c0_i24 = hw.constant 0 : i24
    %c0_i16 = hw.constant 0 : i16
    %c0_i32 = hw.constant 0 : i32
    %io = sv.wire sym @sym {hw.verilogName = "io"} : !hw.inout<struct<addr: i32, dataIn: i32, funct3: i3, memWrite: i32>>
    %0 = sv.read_inout %io : !hw.inout<struct<addr: i32, dataIn: i32, funct3: i3, memWrite: i32>>
    %dataIn = hw.struct_extract %0["dataIn"] : !hw.struct<addr: i32, dataIn: i32, funct3: i3, memWrite: i32>
    %1 = sv.read_inout %io : !hw.inout<struct<addr: i32, dataIn: i32, funct3: i3, memWrite: i32>>
    %funct3 = hw.struct_extract %1["funct3"] : !hw.struct<addr: i32, dataIn: i32, funct3: i3, memWrite: i32>
    %2 = sv.read_inout %io : !hw.inout<struct<addr: i32, dataIn: i32, funct3: i3, memWrite: i32>>
    %memWrite = hw.struct_extract %2["memWrite"] : !hw.struct<addr: i32, dataIn: i32, funct3: i3, memWrite: i32>
    %3 = comb.icmp bin eq %funct3, %c0_i3 {sv.namehint = "_T"} : i3
    %4 = comb.extract %dataIn from 0 : (i32) -> i8
    %_dataOut_T = sv.wire sym @sym_1 {hw.verilogName = "_dataOut_T"} : !hw.inout<i8>
    sv.assign %_dataOut_T, %4 : i8
    %5 = sv.read_inout %_dataOut_T : !hw.inout<i8>
    %6 = comb.concat %c0_i24, %5 : i24, i8
    %_dataOut_T_1 = sv.wire sym @sym_2 {hw.verilogName = "_dataOut_T_1"} : !hw.inout<i32>
    sv.assign %_dataOut_T_1, %6 : i32
    %7 = comb.icmp bin eq %funct3, %c1_i3 {sv.namehint = "_T_1"} : i3
    %8 = comb.extract %dataIn from 0 : (i32) -> i16
    %_dataOut_T_2 = sv.wire sym @sym_3 {hw.verilogName = "_dataOut_T_2"} : !hw.inout<i16>
    sv.assign %_dataOut_T_2, %8 : i16
    %9 = sv.read_inout %_dataOut_T_2 : !hw.inout<i16>
    %10 = comb.concat %c0_i16, %9 : i16, i16
    %_dataOut_T_3 = sv.wire sym @sym_4 {hw.verilogName = "_dataOut_T_3"} : !hw.inout<i32>
    sv.assign %_dataOut_T_3, %10 : i32
    %11 = comb.icmp bin eq %funct3, %c2_i3 {sv.namehint = "_T_2"} : i3
    %12 = comb.mux bin %11, %dataIn, %c0_i32 : i32
    %13 = sv.read_inout %_dataOut_T_3 : !hw.inout<i32>
    %14 = comb.mux bin %7, %13, %12 : i32
    %15 = sv.read_inout %_dataOut_T_1 : !hw.inout<i32>
    %16 = comb.mux bin %3, %15, %14 : i32
    %dataOut = sv.wire sym @sym_0 {hw.verilogName = "dataOut"} : !hw.inout<i32>
    sv.assign %dataOut, %16 : i32
    %17 = sv.read_inout %dataOut : !hw.inout<i32>
    %18 = hw.struct_create (%io_addr, %io_dataIn, %io_funct3, %17) : !hw.struct<addr: i32, dataIn: i32, funct3: i3, memWrite: i32>
    sv.assign %io, %18 : !hw.struct<addr: i32, dataIn: i32, funct3: i3, memWrite: i32>
    hw.output %memWrite : i32
  }
  hw.module private @regFile_32x32(in %R0_addr : i5, in %R0_en : i1, in %R0_clk : i1, out R0_data : i32, in %R1_addr : i5, in %R1_en : i1, in %R1_clk : i1, out R1_data : i32, in %W0_addr : i5, in %W0_en : i1, in %W0_clk : i1, in %W0_data : i32) attributes {comment = "VCS coverage exclude_file", emit.fragments = [@RANDOM_INIT_REG_FRAGMENT, @RANDOM_INIT_MEM_FRAGMENT, @RANDOM_INIT_FRAGMENT]} {
    %Memory = sv.reg {hw.verilogName = "Memory"} : !hw.inout<uarray<32xi32>> 
    %x_i32 = sv.constantX : i32
    %0 = sv.array_index_inout %Memory[%R0_addr] : !hw.inout<uarray<32xi32>>, i5
    %1 = sv.read_inout %0 : !hw.inout<i32>
    %2 = comb.mux %R0_en, %1, %x_i32 : i32
    %3 = sv.array_index_inout %Memory[%R1_addr] : !hw.inout<uarray<32xi32>>, i5
    %4 = sv.read_inout %3 : !hw.inout<i32>
    %5 = comb.mux %R1_en, %4, %x_i32 : i32
    sv.always posedge %W0_clk {
      %true = hw.constant true
      %6 = comb.and %W0_en, %true : i1
      sv.if %6 {
        %7 = sv.array_index_inout %Memory[%W0_addr] : !hw.inout<uarray<32xi32>>, i5
        sv.passign %7, %W0_data : i32
      }
    }
    sv.ifdef  @ENABLE_INITIAL_MEM_ {
      %_RANDOM_MEM = sv.reg {hw.verilogName = "_RANDOM_MEM"} : !hw.inout<i32> 
      sv.initial {
        sv.verbatim "`INIT_RANDOM_PROLOG_"
        sv.ifdef.procedural  @RANDOMIZE_MEM_INIT {
          %c1_i6 = hw.constant 1 : i6
          %c-32_i6 = hw.constant -32 : i6
          %c0_i6 = hw.constant 0 : i6
          sv.for %i = %c0_i6 to %c-32_i6 step %c1_i6 : i6 {
            %RANDOM = sv.macro.ref.expr.se @RANDOM() : () -> i32
            sv.bpassign %_RANDOM_MEM, %RANDOM : i32
            %6 = comb.extract %i from 0 : (i6) -> i5
            %7 = sv.read_inout %_RANDOM_MEM : !hw.inout<i32>
            %8 = sv.array_index_inout %Memory[%6] : !hw.inout<uarray<32xi32>>, i5
            sv.bpassign %8, %7 : i32
          } {hw.verilogName = "i"}
        }
      }
    }
    hw.output %2, %5 : i32, i32
  }
  hw.module @OctoNyteCPU(in %clock : i1, in %reset : i1, out io_memAddr : i32, in %io_memData : i32, out io_memWrite : i1, in %io_inst : i32) attributes {emit.fragments = [@RANDOM_INIT_REG_FRAGMENT, @RANDOM_INIT_FRAGMENT]} {
    %imm = sv.wire sym @sym_10 {hw.verilogName = "imm"} : !hw.inout<i32>
    %_storeUnit_io_memWrite = sv.wire {hw.verilogName = "_storeUnit_io_memWrite"} : !hw.inout<i32>
    %_alu_io_result = sv.wire {hw.verilogName = "_alu_io_result"} : !hw.inout<i32>
    %_branchUnit_io_taken = sv.wire {hw.verilogName = "_branchUnit_io_taken"} : !hw.inout<i1>
    %_branchUnit_io_target = sv.wire {hw.verilogName = "_branchUnit_io_target"} : !hw.inout<i32>
    %_regFile_ext_R0_data = sv.wire {hw.verilogName = "_regFile_ext_R0_data"} : !hw.inout<i32>
    %_regFile_ext_R1_data = sv.wire {hw.verilogName = "_regFile_ext_R1_data"} : !hw.inout<i32>
    %true = hw.constant true
    %c4_i33 = hw.constant 4 : i33
    %c19_i7 = hw.constant 19 : i7
    %c3_i7 = hw.constant 3 : i7
    %false = hw.constant false
    %c0_i12 = hw.constant 0 : i12
    %c0_i8 = hw.constant 0 : i8
    %c0_i32 = hw.constant 0 : i32
    %c-29_i7 = hw.constant -29 : i7
    %c-17_i7 = hw.constant -17 : i7
    %c0_i20 = hw.constant 0 : i20
    %io = sv.wire sym @sym {hw.verilogName = "io"} : !hw.inout<struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>>
    %0 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>>
    %memAddr = hw.struct_extract %0["memAddr"] : !hw.struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>
    %1 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>>
    %memData = hw.struct_extract %1["memData"] : !hw.struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>
    %2 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>>
    %memWrite = hw.struct_extract %2["memWrite"] : !hw.struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>
    %IF_ID = sv.reg sym @sym_0 {hw.verilogName = "IF_ID"} : !hw.inout<i32> 
    %MEM_WB = sv.reg sym @sym_1 {hw.verilogName = "MEM_WB"} : !hw.inout<i32> 
    %pc = sv.reg sym @sym_2 {hw.verilogName = "pc"} : !hw.inout<i32> 
    %3 = sv.read_inout %IF_ID : !hw.inout<i32>
    %4 = comb.extract %3 from 0 : (i32) -> i7
    %opcode = sv.wire sym @sym_4 {hw.verilogName = "opcode"} : !hw.inout<i7>
    sv.assign %opcode, %4 : i7
    %5 = sv.read_inout %IF_ID : !hw.inout<i32>
    %6 = comb.extract %5 from 15 : (i32) -> i5
    %rs1 = sv.wire sym @sym_5 {hw.verilogName = "rs1"} : !hw.inout<i5>
    sv.assign %rs1, %6 : i5
    %7 = sv.read_inout %IF_ID : !hw.inout<i32>
    %8 = comb.extract %7 from 20 : (i32) -> i5
    %rs2 = sv.wire sym @sym_6 {hw.verilogName = "rs2"} : !hw.inout<i5>
    sv.assign %rs2, %8 : i5
    %9 = sv.read_inout %IF_ID : !hw.inout<i32>
    %10 = comb.extract %9 from 7 : (i32) -> i5
    %rd = sv.wire sym @sym_7 {hw.verilogName = "rd"} : !hw.inout<i5>
    sv.assign %rd, %10 : i5
    %11 = sv.read_inout %IF_ID : !hw.inout<i32>
    %12 = comb.extract %11 from 12 : (i32) -> i3
    %funct3 = sv.wire sym @sym_8 {hw.verilogName = "funct3"} : !hw.inout<i3>
    sv.assign %funct3, %12 : i3
    %13 = sv.read_inout %funct3 : !hw.inout<i3>
    %branchOp = sv.wire sym @sym_11 {hw.verilogName = "branchOp"} : !hw.inout<i3>
    sv.assign %branchOp, %13 : i3
    %14 = sv.read_inout %IF_ID : !hw.inout<i32>
    %15 = comb.extract %14 from 25 : (i32) -> i7
    %funct7 = sv.wire sym @sym_9 {hw.verilogName = "funct7"} : !hw.inout<i7>
    sv.assign %funct7, %15 : i7
    %16 = sv.read_inout %imm : !hw.inout<i32>
    %_branchUnit_io_imm_T = sv.wire sym @sym_24 {hw.verilogName = "_branchUnit_io_imm_T"} : !hw.inout<i32>
    sv.assign %_branchUnit_io_imm_T, %16 : i32
    %17 = sv.read_inout %opcode : !hw.inout<i7>
    %18 = comb.icmp bin eq %17, %c3_i7 : i7
    %_imm_T = sv.wire sym @sym_12 {hw.verilogName = "_imm_T"} : !hw.inout<i1>
    sv.assign %_imm_T, %18 : i1
    %19 = sv.read_inout %IF_ID : !hw.inout<i32>
    %20 = comb.extract %19 from 20 : (i32) -> i12
    %_imm_T_1 = sv.wire sym @sym_13 {hw.verilogName = "_imm_T_1"} : !hw.inout<i12>
    sv.assign %_imm_T_1, %20 : i12
    %_imm_T_3 = sv.wire sym @sym_15 {hw.verilogName = "_imm_T_3"} : !hw.inout<i12>
    sv.assign %_imm_T_3, %20 : i12
    %_imm_T_5 = sv.wire sym @sym_17 {hw.verilogName = "_imm_T_5"} : !hw.inout<i12>
    sv.assign %_imm_T_5, %20 : i12
    %21 = sv.read_inout %opcode : !hw.inout<i7>
    %22 = comb.icmp bin eq %21, %c-29_i7 : i7
    %_imm_T_2 = sv.wire sym @sym_14 {hw.verilogName = "_imm_T_2"} : !hw.inout<i1>
    sv.assign %_imm_T_2, %22 : i1
    %23 = sv.read_inout %opcode : !hw.inout<i7>
    %24 = comb.icmp bin eq %23, %c19_i7 : i7
    %_imm_T_4 = sv.wire sym @sym_16 {hw.verilogName = "_imm_T_4"} : !hw.inout<i1>
    sv.assign %_imm_T_4, %24 : i1
    %25 = sv.read_inout %opcode : !hw.inout<i7>
    %26 = comb.icmp bin eq %25, %c-17_i7 : i7
    %_imm_T_6 = sv.wire sym @sym_18 {hw.verilogName = "_imm_T_6"} : !hw.inout<i1>
    sv.assign %_imm_T_6, %26 : i1
    %27 = sv.read_inout %IF_ID : !hw.inout<i32>
    %28 = comb.extract %27 from 12 : (i32) -> i20
    %_imm_T_7 = sv.wire sym @sym_19 {hw.verilogName = "_imm_T_7"} : !hw.inout<i20>
    sv.assign %_imm_T_7, %28 : i20
    %29 = sv.read_inout %_imm_T_6 : !hw.inout<i1>
    %30 = sv.read_inout %_imm_T_7 : !hw.inout<i20>
    %31 = comb.mux bin %29, %30, %c0_i20 : i20
    %_imm_T_8 = sv.wire sym @sym_20 {hw.verilogName = "_imm_T_8"} : !hw.inout<i20>
    sv.assign %_imm_T_8, %31 : i20
    %32 = sv.read_inout %_imm_T_5 : !hw.inout<i12>
    %33 = comb.concat %c0_i8, %32 : i8, i12
    %34 = sv.read_inout %_imm_T_4 : !hw.inout<i1>
    %35 = sv.read_inout %_imm_T_8 : !hw.inout<i20>
    %36 = comb.mux bin %34, %33, %35 : i20
    %_imm_T_9 = sv.wire sym @sym_21 {hw.verilogName = "_imm_T_9"} : !hw.inout<i20>
    sv.assign %_imm_T_9, %36 : i20
    %37 = sv.read_inout %_imm_T_3 : !hw.inout<i12>
    %38 = comb.concat %c0_i8, %37 : i8, i12
    %39 = sv.read_inout %_imm_T_2 : !hw.inout<i1>
    %40 = sv.read_inout %_imm_T_9 : !hw.inout<i20>
    %41 = comb.mux bin %39, %38, %40 : i20
    %_imm_T_10 = sv.wire sym @sym_22 {hw.verilogName = "_imm_T_10"} : !hw.inout<i20>
    sv.assign %_imm_T_10, %41 : i20
    %42 = sv.read_inout %_imm_T_1 : !hw.inout<i12>
    %43 = comb.concat %c0_i8, %42 : i8, i12
    %44 = sv.read_inout %_imm_T : !hw.inout<i1>
    %45 = sv.read_inout %_imm_T_10 : !hw.inout<i20>
    %46 = comb.mux bin %44, %43, %45 : i20
    %_imm_T_11 = sv.wire sym @sym_23 {hw.verilogName = "_imm_T_11"} : !hw.inout<i20>
    sv.assign %_imm_T_11, %46 : i20
    %47 = sv.read_inout %_imm_T_11 : !hw.inout<i20>
    %48 = comb.concat %c0_i12, %47 : i12, i20
    sv.assign %imm, %48 : i32
    %49 = sv.read_inout %_branchUnit_io_imm_T : !hw.inout<i32>
    %50 = comb.extract %49 from 0 : (i32) -> i12
    %51 = sv.read_inout %IF_ID : !hw.inout<i32>
    %52 = comb.extract %51 from 0 : (i32) -> i6
    %_alu_io_opcode_T = sv.wire sym @sym_25 {hw.verilogName = "_alu_io_opcode_T"} : !hw.inout<i6>
    sv.assign %_alu_io_opcode_T, %52 : i6
    %53 = sv.read_inout %_branchUnit_io_taken : !hw.inout<i1>
    %54 = sv.read_inout %_branchUnit_io_target : !hw.inout<i32>
    %55 = sv.read_inout %_alu_io_result : !hw.inout<i32>
    %56 = comb.mux bin %53, %54, %55 : i32
    %_MEM_WB_T = sv.wire sym @sym_26 {hw.verilogName = "_MEM_WB_T"} : !hw.inout<i32>
    sv.assign %_MEM_WB_T, %56 : i32
    %57 = sv.read_inout %pc : !hw.inout<i32>
    %58 = comb.concat %false, %57 : i1, i32
    %59 = comb.add bin %58, %c4_i33 : i33
    %_pc_T = sv.wire sym @sym_27 {hw.verilogName = "_pc_T"} : !hw.inout<i33>
    sv.assign %_pc_T, %59 : i33
    %60 = sv.read_inout %_pc_T : !hw.inout<i33>
    %61 = comb.extract %60 from 0 : (i33) -> i32
    %_pc_T_1 = sv.wire sym @sym_28 {hw.verilogName = "_pc_T_1"} : !hw.inout<i32>
    sv.assign %_pc_T_1, %61 : i32
    %62 = sv.read_inout %MEM_WB : !hw.inout<i32>
    %63 = comb.icmp bin ne %62, %c0_i32 {sv.namehint = "_T"} : i32
    %64 = sv.read_inout %_storeUnit_io_memWrite : !hw.inout<i32>
    %65 = comb.extract %64 from 0 : (i32) -> i1
    %66 = sv.read_inout %_alu_io_result : !hw.inout<i32>
    %67 = hw.struct_create (%66, %io_memData, %65, %io_inst) : !hw.struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>
    sv.assign %io, %67 : !hw.struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>
    %nextPc = sv.wire sym @sym_3 {hw.verilogName = "nextPc"} : !hw.inout<i32>
    sv.always posedge %clock {
      sv.if %reset {
        %c0_i32_0 = hw.constant 0 : i32
        sv.passign %IF_ID, %c0_i32_0 : i32
        sv.passign %MEM_WB, %c0_i32_0 : i32
        sv.passign %pc, %c0_i32_0 : i32
      } else {
        %84 = sv.read_inout %io : !hw.inout<struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>>
        %inst = hw.struct_extract %84["inst"] : !hw.struct<memAddr: i32, memData: i32, memWrite: i1, inst: i32>
        sv.passign %IF_ID, %inst : i32
        %85 = sv.read_inout %_MEM_WB_T : !hw.inout<i32>
        sv.passign %MEM_WB, %85 : i32
        %86 = sv.read_inout %_pc_T_1 : !hw.inout<i32>
        %87 = sv.read_inout %nextPc : !hw.inout<i32>
        %88 = sv.read_inout %_branchUnit_io_taken : !hw.inout<i1>
        %89 = comb.mux bin %88, %87, %86 : i32
        sv.passign %pc, %89 : i32
      }
    }
    sv.ifdef  @ENABLE_INITIAL_REG_ {
      sv.ordered {
        sv.ifdef  @FIRRTL_BEFORE_INITIAL {
          sv.verbatim "`FIRRTL_BEFORE_INITIAL"
        }
        sv.initial {
          %_RANDOM = sv.logic {hw.verilogName = "_RANDOM"} : !hw.inout<uarray<5xi32>>
          sv.ifdef.procedural  @INIT_RANDOM_PROLOG_ {
            sv.verbatim "`INIT_RANDOM_PROLOG_"
          }
          sv.ifdef.procedural  @RANDOMIZE_REG_INIT {
            %c-4_i3 = hw.constant -4 : i3
            %c3_i3 = hw.constant 3 : i3
            %c1_i3 = hw.constant 1 : i3
            %c-3_i3 = hw.constant -3 : i3
            %c0_i3 = hw.constant 0 : i3
            sv.for %i = %c0_i3 to %c-3_i3 step %c1_i3 : i3 {
              %RANDOM = sv.macro.ref.expr.se @RANDOM() : () -> i32
              %90 = sv.array_index_inout %_RANDOM[%i] : !hw.inout<uarray<5xi32>>, i3
              sv.bpassign %90, %RANDOM : i32
            } {hw.verilogName = "i"}
            %84 = sv.array_index_inout %_RANDOM[%c0_i3] : !hw.inout<uarray<5xi32>>, i3
            %85 = sv.read_inout %84 : !hw.inout<i32>
            sv.bpassign %IF_ID, %85 : i32
            %86 = sv.array_index_inout %_RANDOM[%c3_i3] : !hw.inout<uarray<5xi32>>, i3
            %87 = sv.read_inout %86 : !hw.inout<i32>
            sv.bpassign %MEM_WB, %87 : i32
            %88 = sv.array_index_inout %_RANDOM[%c-4_i3] : !hw.inout<uarray<5xi32>>, i3
            %89 = sv.read_inout %88 : !hw.inout<i32>
            sv.bpassign %pc, %89 : i32
          }
        }
        sv.ifdef  @FIRRTL_AFTER_INITIAL {
          sv.verbatim "`FIRRTL_AFTER_INITIAL"
        }
      }
    }
    %68 = sv.read_inout %rs1 : !hw.inout<i5>
    %69 = sv.read_inout %rs2 : !hw.inout<i5>
    %70 = sv.read_inout %rd : !hw.inout<i5>
    %71 = sv.read_inout %MEM_WB : !hw.inout<i32>
    %regFile_ext.R0_data, %regFile_ext.R1_data = hw.instance "regFile_ext" @regFile_32x32(R0_addr: %69: i5, R0_en: %true: i1, R0_clk: %clock: i1, R1_addr: %68: i5, R1_en: %true: i1, R1_clk: %clock: i1, W0_addr: %70: i5, W0_en: %63: i1, W0_clk: %clock: i1, W0_data: %71: i32) -> (R0_data: i32, R1_data: i32) {hw.verilogName = "regFile_ext"}
    sv.assign %_regFile_ext_R1_data, %regFile_ext.R1_data : i32
    sv.assign %_regFile_ext_R0_data, %regFile_ext.R0_data : i32
    %72 = sv.read_inout %pc : !hw.inout<i32>
    %73 = sv.read_inout %branchOp : !hw.inout<i3>
    %74 = sv.read_inout %_regFile_ext_R0_data : !hw.inout<i32>
    %75 = sv.read_inout %_regFile_ext_R1_data : !hw.inout<i32>
    %branchUnit.io_taken, %branchUnit.io_target, %branchUnit.io_nextPc, %branchUnit.io_misaligned = hw.instance "branchUnit" @BranchUnit(io_rs1: %75: i32, io_rs2: %74: i32, io_pc: %72: i32, io_imm: %50: i12, io_branchOp: %73: i3) -> (io_taken: i1, io_target: i32, io_nextPc: i32, io_misaligned: i1) {hw.verilogName = "branchUnit"}
    sv.assign %nextPc, %branchUnit.io_nextPc : i32
    sv.assign %_branchUnit_io_target, %branchUnit.io_target : i32
    sv.assign %_branchUnit_io_taken, %branchUnit.io_taken : i1
    %76 = sv.read_inout %_alu_io_opcode_T : !hw.inout<i6>
    %77 = sv.read_inout %_regFile_ext_R0_data : !hw.inout<i32>
    %78 = sv.read_inout %_regFile_ext_R1_data : !hw.inout<i32>
    %alu.io_result = hw.instance "alu" @ALU32(io_a: %78: i32, io_b: %77: i32, io_opcode: %76: i6) -> (io_result: i32) {hw.verilogName = "alu"}
    sv.assign %_alu_io_result, %alu.io_result : i32
    %79 = sv.read_inout %funct3 : !hw.inout<i3>
    %80 = sv.read_inout %_alu_io_result : !hw.inout<i32>
    %loadUnit.io_dataOut = hw.instance "loadUnit" @LoadUnit(io_addr: %80: i32, io_dataIn: %memData: i32, io_funct3: %79: i3) -> (io_dataOut: i32) {hw.verilogName = "loadUnit"}
    %81 = sv.read_inout %funct3 : !hw.inout<i3>
    %82 = sv.read_inout %_regFile_ext_R0_data : !hw.inout<i32>
    %83 = sv.read_inout %_alu_io_result : !hw.inout<i32>
    %storeUnit.io_memWrite = hw.instance "storeUnit" @StoreUnit(io_addr: %83: i32, io_dataIn: %82: i32, io_funct3: %81: i3) -> (io_memWrite: i32) {hw.verilogName = "storeUnit"}
    sv.assign %_storeUnit_io_memWrite, %storeUnit.io_memWrite : i32
    hw.output %memAddr, %memWrite : i32, i1
  }
  om.class @OctoNyteCPU_Class(%basepath: !om.frozenbasepath) {
    om.class.fields
  }
}
