module {
  hw.module @BranchUnit(in %clock : i1, in %reset : i1, in %io_rs1 : i32, in %io_rs2 : i32, in %io_pc : i32, in %io_imm : i12, in %io_branchOp : i3, in %io_valid : i1, out io_taken : i1, out io_target : i32, out io_nextPc : i32, out io_misaligned : i1) {
    %c4_i33 = hw.constant 4 : i33
    %c1_i3 = hw.constant 1 : i3
    %c-1_i3 = hw.constant -1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c0_i2 = hw.constant 0 : i2
    %c-4_i32 = hw.constant -4 : i32
    %false = hw.constant false
    %true = hw.constant true
    %c-4_i3 = hw.constant -4 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-2_i3 = hw.constant -2 : i3
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
    %valid = hw.struct_extract %5["valid"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %6 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %taken = hw.struct_extract %6["taken"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %7 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %target = hw.struct_extract %7["target"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %8 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %nextPc = hw.struct_extract %8["nextPc"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %9 = sv.read_inout %io : !hw.inout<struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>>
    %misaligned = hw.struct_extract %9["misaligned"] : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    %10 = sv.read_inout %_targetAddr_T : !hw.inout<i32>
    %11 = comb.extract %10 from 31 : (i32) -> i1
    %12 = sv.read_inout %_targetAddr_T : !hw.inout<i32>
    %13 = comb.concat %11, %12 : i1, i32
    %14 = comb.extract %imm from 11 : (i12) -> i1
    %15 = comb.replicate %14 : (i1) -> i21
    %16 = comb.concat %15, %imm : i21, i12
    %17 = comb.add bin %13, %16 : i33
    %_targetAddr_T_1 = sv.wire sym @sym_1 {hw.verilogName = "_targetAddr_T_1"} : !hw.inout<i33>
    sv.assign %_targetAddr_T_1, %17 : i33
    %18 = sv.read_inout %_targetAddr_T_1 : !hw.inout<i33>
    %19 = comb.extract %18 from 0 : (i33) -> i32
    %_targetAddr_T_2 = sv.wire sym @sym_2 {hw.verilogName = "_targetAddr_T_2"} : !hw.inout<i32>
    sv.assign %_targetAddr_T_2, %19 : i32
    %20 = sv.read_inout %_targetAddr_T_2 : !hw.inout<i32>
    %_targetAddr_T_3 = sv.wire sym @sym_3 {hw.verilogName = "_targetAddr_T_3"} : !hw.inout<i32>
    sv.assign %_targetAddr_T_3, %20 : i32
    %21 = sv.read_inout %_targetAddr_T_3 : !hw.inout<i32>
    %targetAddr = sv.wire sym @sym_4 {hw.verilogName = "targetAddr"} : !hw.inout<i32>
    sv.assign %targetAddr, %21 : i32
    %22 = sv.read_inout %targetAddr : !hw.inout<i32>
    %23 = comb.and bin %22, %c-4_i32 : i32
    %_io_target_T = sv.wire sym @sym_5 {hw.verilogName = "_io_target_T"} : !hw.inout<i32>
    sv.assign %_io_target_T, %23 : i32
    %24 = sv.read_inout %targetAddr : !hw.inout<i32>
    %25 = comb.extract %24 from 0 : (i32) -> i2
    %_io_misaligned_T = sv.wire sym @sym_6 {hw.verilogName = "_io_misaligned_T"} : !hw.inout<i2>
    sv.assign %_io_misaligned_T, %25 : i2
    %26 = sv.read_inout %_io_misaligned_T : !hw.inout<i2>
    %27 = comb.icmp bin ne %26, %c0_i2 : i2
    %_io_misaligned_T_1 = sv.wire sym @sym_7 {hw.verilogName = "_io_misaligned_T_1"} : !hw.inout<i1>
    sv.assign %_io_misaligned_T_1, %27 : i1
    %28 = comb.icmp bin eq %branchOp, %c0_i3 : i3
    %_io_taken_T = sv.wire sym @sym_8 {hw.verilogName = "_io_taken_T"} : !hw.inout<i1>
    sv.assign %_io_taken_T, %28 : i1
    %29 = comb.icmp bin eq %rs1, %rs2 : i32
    %_io_taken_T_1 = sv.wire sym @sym_9 {hw.verilogName = "_io_taken_T_1"} : !hw.inout<i1>
    sv.assign %_io_taken_T_1, %29 : i1
    %30 = comb.icmp bin eq %branchOp, %c1_i3 : i3
    %_io_taken_T_2 = sv.wire sym @sym_10 {hw.verilogName = "_io_taken_T_2"} : !hw.inout<i1>
    sv.assign %_io_taken_T_2, %30 : i1
    %31 = comb.icmp bin ne %rs1, %rs2 : i32
    %_io_taken_T_3 = sv.wire sym @sym_11 {hw.verilogName = "_io_taken_T_3"} : !hw.inout<i1>
    sv.assign %_io_taken_T_3, %31 : i1
    %32 = comb.icmp bin eq %branchOp, %c-4_i3 : i3
    %_io_taken_T_4 = sv.wire sym @sym_12 {hw.verilogName = "_io_taken_T_4"} : !hw.inout<i1>
    sv.assign %_io_taken_T_4, %32 : i1
    %33 = sv.read_inout %_io_taken_T_5 : !hw.inout<i32>
    %34 = sv.read_inout %_io_taken_T_6 : !hw.inout<i32>
    %35 = comb.icmp bin slt %33, %34 : i32
    %_io_taken_T_7 = sv.wire sym @sym_15 {hw.verilogName = "_io_taken_T_7"} : !hw.inout<i1>
    sv.assign %_io_taken_T_7, %35 : i1
    %36 = comb.icmp bin eq %branchOp, %c-3_i3 : i3
    %_io_taken_T_8 = sv.wire sym @sym_16 {hw.verilogName = "_io_taken_T_8"} : !hw.inout<i1>
    sv.assign %_io_taken_T_8, %36 : i1
    %37 = sv.read_inout %_io_taken_T_9 : !hw.inout<i32>
    %38 = sv.read_inout %_io_taken_T_10 : !hw.inout<i32>
    %39 = comb.icmp bin sge %37, %38 : i32
    %_io_taken_T_11 = sv.wire sym @sym_19 {hw.verilogName = "_io_taken_T_11"} : !hw.inout<i1>
    sv.assign %_io_taken_T_11, %39 : i1
    %40 = comb.icmp bin eq %branchOp, %c-2_i3 : i3
    %_io_taken_T_12 = sv.wire sym @sym_20 {hw.verilogName = "_io_taken_T_12"} : !hw.inout<i1>
    sv.assign %_io_taken_T_12, %40 : i1
    %41 = comb.icmp bin ult %rs1, %rs2 : i32
    %_io_taken_T_13 = sv.wire sym @sym_21 {hw.verilogName = "_io_taken_T_13"} : !hw.inout<i1>
    sv.assign %_io_taken_T_13, %41 : i1
    %42 = comb.icmp bin eq %branchOp, %c-1_i3 : i3
    %_io_taken_T_14 = sv.wire sym @sym_22 {hw.verilogName = "_io_taken_T_14"} : !hw.inout<i1>
    sv.assign %_io_taken_T_14, %42 : i1
    %43 = comb.icmp bin uge %rs1, %rs2 : i32
    %_io_taken_T_15 = sv.wire sym @sym_23 {hw.verilogName = "_io_taken_T_15"} : !hw.inout<i1>
    sv.assign %_io_taken_T_15, %43 : i1
    %44 = sv.read_inout %_io_taken_T_14 : !hw.inout<i1>
    %45 = sv.read_inout %_io_taken_T_15 : !hw.inout<i1>
    %46 = comb.and %44, %45 : i1
    %_io_taken_T_16 = sv.wire sym @sym_24 {hw.verilogName = "_io_taken_T_16"} : !hw.inout<i1>
    sv.assign %_io_taken_T_16, %46 : i1
    %47 = sv.read_inout %_io_taken_T_12 : !hw.inout<i1>
    %48 = sv.read_inout %_io_taken_T_13 : !hw.inout<i1>
    %49 = sv.read_inout %_io_taken_T_16 : !hw.inout<i1>
    %50 = comb.mux bin %47, %48, %49 : i1
    %_io_taken_T_17 = sv.wire sym @sym_25 {hw.verilogName = "_io_taken_T_17"} : !hw.inout<i1>
    sv.assign %_io_taken_T_17, %50 : i1
    %51 = sv.read_inout %_io_taken_T_8 : !hw.inout<i1>
    %52 = sv.read_inout %_io_taken_T_11 : !hw.inout<i1>
    %53 = sv.read_inout %_io_taken_T_17 : !hw.inout<i1>
    %54 = comb.mux bin %51, %52, %53 : i1
    %_io_taken_T_18 = sv.wire sym @sym_26 {hw.verilogName = "_io_taken_T_18"} : !hw.inout<i1>
    sv.assign %_io_taken_T_18, %54 : i1
    %55 = sv.read_inout %_io_taken_T_4 : !hw.inout<i1>
    %56 = sv.read_inout %_io_taken_T_7 : !hw.inout<i1>
    %57 = sv.read_inout %_io_taken_T_18 : !hw.inout<i1>
    %58 = comb.mux bin %55, %56, %57 : i1
    %_io_taken_T_19 = sv.wire sym @sym_27 {hw.verilogName = "_io_taken_T_19"} : !hw.inout<i1>
    sv.assign %_io_taken_T_19, %58 : i1
    %59 = sv.read_inout %_io_taken_T_2 : !hw.inout<i1>
    %60 = sv.read_inout %_io_taken_T_3 : !hw.inout<i1>
    %61 = sv.read_inout %_io_taken_T_19 : !hw.inout<i1>
    %62 = comb.mux bin %59, %60, %61 : i1
    %_io_taken_T_20 = sv.wire sym @sym_28 {hw.verilogName = "_io_taken_T_20"} : !hw.inout<i1>
    sv.assign %_io_taken_T_20, %62 : i1
    %63 = sv.read_inout %_io_taken_T : !hw.inout<i1>
    %64 = sv.read_inout %_io_taken_T_1 : !hw.inout<i1>
    %65 = sv.read_inout %_io_taken_T_20 : !hw.inout<i1>
    %66 = comb.mux bin %63, %64, %65 : i1
    %_io_taken_T_21 = sv.wire sym @sym_29 {hw.verilogName = "_io_taken_T_21"} : !hw.inout<i1>
    sv.assign %_io_taken_T_21, %66 : i1
    %67 = sv.read_inout %_io_taken_T_21 : !hw.inout<i1>
    %68 = comb.and bin %67, %valid : i1
    %_io_taken_T_22 = sv.wire sym @sym_30 {hw.verilogName = "_io_taken_T_22"} : !hw.inout<i1>
    sv.assign %_io_taken_T_22, %68 : i1
    %69 = comb.xor bin %misaligned, %true : i1
    %_io_taken_T_23 = sv.wire sym @sym_31 {hw.verilogName = "_io_taken_T_23"} : !hw.inout<i1>
    sv.assign %_io_taken_T_23, %69 : i1
    %70 = sv.read_inout %_io_taken_T_22 : !hw.inout<i1>
    %71 = sv.read_inout %_io_taken_T_23 : !hw.inout<i1>
    %72 = comb.and bin %70, %71 : i1
    %_io_taken_T_24 = sv.wire sym @sym_32 {hw.verilogName = "_io_taken_T_24"} : !hw.inout<i1>
    sv.assign %_io_taken_T_24, %72 : i1
    %73 = sv.read_inout %_targetAddr_T : !hw.inout<i32>
    %74 = comb.concat %false, %73 : i1, i32
    %75 = comb.add bin %74, %c4_i33 : i33
    %_io_nextPc_T = sv.wire sym @sym_33 {hw.verilogName = "_io_nextPc_T"} : !hw.inout<i33>
    sv.assign %_io_nextPc_T, %75 : i33
    %76 = sv.read_inout %_io_nextPc_T : !hw.inout<i33>
    %77 = comb.extract %76 from 0 : (i33) -> i32
    %_io_nextPc_T_1 = sv.wire sym @sym_34 {hw.verilogName = "_io_nextPc_T_1"} : !hw.inout<i32>
    sv.assign %_io_nextPc_T_1, %77 : i32
    %78 = sv.read_inout %_io_nextPc_T_1 : !hw.inout<i32>
    %79 = comb.mux bin %taken, %target, %78 : i32
    %_io_nextPc_T_2 = sv.wire sym @sym_35 {hw.verilogName = "_io_nextPc_T_2"} : !hw.inout<i32>
    sv.assign %_io_nextPc_T_2, %79 : i32
    %80 = sv.read_inout %_io_target_T : !hw.inout<i32>
    %81 = sv.read_inout %_io_misaligned_T_1 : !hw.inout<i1>
    %82 = sv.read_inout %_io_taken_T_24 : !hw.inout<i1>
    %83 = sv.read_inout %_io_nextPc_T_2 : !hw.inout<i32>
    %84 = hw.struct_create (%io_rs1, %io_rs2, %io_pc, %io_imm, %io_branchOp, %io_valid, %82, %80, %83, %81) : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    sv.assign %io, %84 : !hw.struct<rs1: i32, rs2: i32, pc: i32, imm: i12, branchOp: i3, valid: i1, taken: i1, target: i32, nextPc: i32, misaligned: i1>
    hw.output %taken, %target, %nextPc, %misaligned : i1, i32, i32, i1
  }
  om.class @BranchUnit_Class(%basepath: !om.frozenbasepath) {
    om.class.fields
  }
}
