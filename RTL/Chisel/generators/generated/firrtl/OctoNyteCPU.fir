FIRRTL version 3.3.0
circuit OctoNyteCPU :%[[
  {
    "class":"firrtl.transforms.DedupGroupAnnotation",
    "target":"~OctoNyteCPU|BranchUnit",
    "group":"BranchUnit"
  },
  {
    "class":"firrtl.transforms.DedupGroupAnnotation",
    "target":"~OctoNyteCPU|ALU32",
    "group":"ALU32"
  },
  {
    "class":"firrtl.transforms.DedupGroupAnnotation",
    "target":"~OctoNyteCPU|LoadUnit",
    "group":"LoadUnit"
  },
  {
    "class":"firrtl.transforms.DedupGroupAnnotation",
    "target":"~OctoNyteCPU|StoreUnit",
    "group":"StoreUnit"
  },
  {
    "class":"firrtl.transforms.DedupGroupAnnotation",
    "target":"~OctoNyteCPU|OctoNyteCPU",
    "group":"OctoNyteCPU"
  }
]]
  module BranchUnit : @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 9:7]
    input clock : Clock @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 9:7]
    input reset : Reset @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 9:7]
    output io : { flip rs1 : UInt<32>, flip rs2 : UInt<32>, flip pc : UInt<32>, flip imm : SInt<12>, flip branchOp : UInt<3>, flip valid : UInt<1>, taken : UInt<1>, target : UInt<32>, nextPc : UInt<32>, misaligned : UInt<1>} @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 10:14]

    node _targetAddr_T = asSInt(io.pc) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 27:27]
    node _targetAddr_T_1 = add(_targetAddr_T, io.imm) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 27:34]
    node _targetAddr_T_2 = tail(_targetAddr_T_1, 1) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 27:34]
    node _targetAddr_T_3 = asSInt(_targetAddr_T_2) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 27:34]
    node targetAddr = asUInt(_targetAddr_T_3) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 27:44]
    node _io_target_T = and(targetAddr, UInt<32>(0hfffffffc)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 28:27]
    connect io.target, _io_target_T @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 28:13]
    node _io_misaligned_T = bits(targetAddr, 1, 0) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 31:30]
    node _io_misaligned_T_1 = neq(_io_misaligned_T, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 31:37]
    connect io.misaligned, _io_misaligned_T_1 @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 31:17]
    node _io_taken_T = eq(io.branchOp, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 34:31]
    node _io_taken_T_1 = eq(io.rs1, io.rs2) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 34:47]
    node _io_taken_T_2 = eq(io.branchOp, UInt<1>(0h1)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 35:31]
    node _io_taken_T_3 = neq(io.rs1, io.rs2) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 35:47]
    node _io_taken_T_4 = eq(io.branchOp, UInt<3>(0h4)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 36:31]
    node _io_taken_T_5 = asSInt(io.rs1) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 36:47]
    node _io_taken_T_6 = asSInt(io.rs2) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 36:63]
    node _io_taken_T_7 = lt(_io_taken_T_5, _io_taken_T_6) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 36:54]
    node _io_taken_T_8 = eq(io.branchOp, UInt<3>(0h5)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 37:31]
    node _io_taken_T_9 = asSInt(io.rs1) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 37:47]
    node _io_taken_T_10 = asSInt(io.rs2) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 37:64]
    node _io_taken_T_11 = geq(_io_taken_T_9, _io_taken_T_10) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 37:54]
    node _io_taken_T_12 = eq(io.branchOp, UInt<3>(0h6)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 38:31]
    node _io_taken_T_13 = lt(io.rs1, io.rs2) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 38:47]
    node _io_taken_T_14 = eq(io.branchOp, UInt<3>(0h7)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 39:31]
    node _io_taken_T_15 = geq(io.rs1, io.rs2) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 39:47]
    node _io_taken_T_16 = mux(_io_taken_T_14, _io_taken_T_15, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 39:18]
    node _io_taken_T_17 = mux(_io_taken_T_12, _io_taken_T_13, _io_taken_T_16) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 38:18]
    node _io_taken_T_18 = mux(_io_taken_T_8, _io_taken_T_11, _io_taken_T_17) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 37:18]
    node _io_taken_T_19 = mux(_io_taken_T_4, _io_taken_T_7, _io_taken_T_18) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 36:18]
    node _io_taken_T_20 = mux(_io_taken_T_2, _io_taken_T_3, _io_taken_T_19) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 35:18]
    node _io_taken_T_21 = mux(_io_taken_T, _io_taken_T_1, _io_taken_T_20) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 34:18]
    node _io_taken_T_22 = and(_io_taken_T_21, io.valid) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 40:29]
    node _io_taken_T_23 = eq(io.misaligned, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 40:44]
    node _io_taken_T_24 = and(_io_taken_T_22, _io_taken_T_23) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 40:41]
    connect io.taken, _io_taken_T_24 @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 34:12]
    node _io_nextPc_T = add(io.pc, UInt<3>(0h4)) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 43:47]
    node _io_nextPc_T_1 = tail(_io_nextPc_T, 1) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 43:47]
    node _io_nextPc_T_2 = mux(io.taken, io.target, _io_nextPc_T_1) @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 43:19]
    connect io.nextPc, _io_nextPc_T_2 @[src/main/scala/OctoNyteCore/BranchUnit/BranchUnit.scala 43:13]

  module ALU32 : @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 28:7]
    input clock : Clock @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 28:7]
    input reset : Reset @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 28:7]
    output io : { flip a : UInt<32>, flip b : UInt<32>, result : UInt<32>, flip opcode : UInt<6>} @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 29:14]

    node _result_T = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 45:15]
    node _result_T_1 = eq(_result_T, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 45:22]
    node _result_T_2 = asSInt(io.a) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 45:46]
    node _result_T_3 = asSInt(io.b) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 45:61]
    node _result_T_4 = add(_result_T_2, _result_T_3) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 45:53]
    node _result_T_5 = asUInt(_result_T_4) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 45:69]
    node _result_T_6 = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 46:15]
    node _result_T_7 = eq(_result_T_6, UInt<1>(0h1)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 46:22]
    node _result_T_8 = asSInt(io.a) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 46:46]
    node _result_T_9 = asSInt(io.b) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 46:61]
    node _result_T_10 = sub(_result_T_8, _result_T_9) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 46:53]
    node _result_T_11 = asUInt(_result_T_10) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 46:69]
    node _result_T_12 = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 47:15]
    node _result_T_13 = eq(_result_T_12, UInt<4>(0h8)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 47:22]
    node _result_T_14 = xor(io.a, io.b) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 47:46]
    node _result_T_15 = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 48:15]
    node _result_T_16 = eq(_result_T_15, UInt<4>(0hc)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 48:22]
    node _result_T_17 = or(io.a, io.b) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 48:46]
    node _result_T_18 = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 49:15]
    node _result_T_19 = eq(_result_T_18, UInt<4>(0he)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 49:22]
    node _result_T_20 = and(io.a, io.b) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 49:46]
    node _result_T_21 = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 50:15]
    node _result_T_22 = eq(_result_T_21, UInt<2>(0h2)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 50:22]
    node _result_T_23 = bits(io.b, 5, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 50:53]
    node _result_T_24 = dshl(io.a, _result_T_23) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 50:46]
    node _result_T_25 = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 51:15]
    node _result_T_26 = eq(_result_T_25, UInt<4>(0ha)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 51:22]
    node _result_T_27 = bits(io.b, 5, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 51:53]
    node _result_T_28 = dshr(io.a, _result_T_27) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 51:46]
    node _result_T_29 = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 52:15]
    node _result_T_30 = eq(_result_T_29, UInt<4>(0hb)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 52:22]
    node _result_T_31 = asSInt(io.a) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 52:46]
    node _result_T_32 = bits(io.b, 5, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 52:60]
    node _result_T_33 = dshr(_result_T_31, _result_T_32) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 52:53]
    node _result_T_34 = asUInt(_result_T_33) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 52:68]
    node _result_T_35 = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 53:15]
    node _result_T_36 = eq(_result_T_35, UInt<3>(0h4)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 53:22]
    node _result_T_37 = asSInt(io.a) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 53:49]
    node _result_T_38 = asSInt(io.b) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 53:63]
    node _result_T_39 = lt(_result_T_37, _result_T_38) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 53:56]
    node _result_T_40 = mux(_result_T_39, UInt<1>(0h1), UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 53:43]
    node _result_T_41 = bits(io.opcode, 3, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 54:15]
    node _result_T_42 = eq(_result_T_41, UInt<3>(0h6)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 54:22]
    node _result_T_43 = lt(io.a, io.b) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 54:49]
    node _result_T_44 = mux(_result_T_43, UInt<1>(0h1), UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 54:43]
    node _result_T_45 = mux(_result_T_42, _result_T_44, UInt<32>(0h0)) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _result_T_46 = mux(_result_T_36, _result_T_40, _result_T_45) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _result_T_47 = mux(_result_T_30, _result_T_34, _result_T_46) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _result_T_48 = mux(_result_T_26, _result_T_28, _result_T_47) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _result_T_49 = mux(_result_T_22, _result_T_24, _result_T_48) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _result_T_50 = mux(_result_T_19, _result_T_20, _result_T_49) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _result_T_51 = mux(_result_T_16, _result_T_17, _result_T_50) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _result_T_52 = mux(_result_T_13, _result_T_14, _result_T_51) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _result_T_53 = mux(_result_T_7, _result_T_11, _result_T_52) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node result = mux(_result_T_1, _result_T_5, _result_T_53) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    connect io.result, result @[src/main/scala/OctoNyteCore/ExecutionUnits/ALU32.scala 62:13]

  module LoadUnit : @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 8:7]
    input clock : Clock @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 8:7]
    input reset : Reset @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 8:7]
    output io : { flip addr : UInt<32>, flip dataIn : UInt<32>, flip funct3 : UInt<3>, dataOut : UInt<32>} @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 9:14]

    wire loadWidth : UInt<2> @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 24:23]
    wire isSigned : UInt<1> @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 25:22]
    node _loadWidth_T = eq(io.funct3, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 28:16]
    node _loadWidth_T_1 = eq(io.funct3, UInt<3>(0h4)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 28:36]
    node _loadWidth_T_2 = or(_loadWidth_T, _loadWidth_T_1) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 28:23]
    node _loadWidth_T_3 = eq(io.funct3, UInt<1>(0h1)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 29:16]
    node _loadWidth_T_4 = eq(io.funct3, UInt<3>(0h5)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 29:36]
    node _loadWidth_T_5 = or(_loadWidth_T_3, _loadWidth_T_4) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 29:23]
    node _loadWidth_T_6 = eq(io.funct3, UInt<2>(0h2)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 30:16]
    node _loadWidth_T_7 = mux(_loadWidth_T_6, UInt<2>(0h2), UInt<2>(0h2)) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _loadWidth_T_8 = mux(_loadWidth_T_5, UInt<1>(0h1), _loadWidth_T_7) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _loadWidth_T_9 = mux(_loadWidth_T_2, UInt<1>(0h0), _loadWidth_T_8) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    connect loadWidth, _loadWidth_T_9 @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 27:13]
    node _isSigned_T = eq(io.funct3, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 33:26]
    node _isSigned_T_1 = eq(io.funct3, UInt<1>(0h1)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 33:46]
    node _isSigned_T_2 = or(_isSigned_T, _isSigned_T_1) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 33:33]
    node _isSigned_T_3 = eq(io.funct3, UInt<2>(0h2)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 33:66]
    node _isSigned_T_4 = or(_isSigned_T_2, _isSigned_T_3) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 33:53]
    connect isSigned, _isSigned_T_4 @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 33:12]
    wire extractedData : UInt<32> @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 35:27]
    node _extractedData_T = eq(loadWidth, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 37:16]
    node _extractedData_T_1 = bits(io.dataIn, 7, 0) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 37:38]
    node _extractedData_T_2 = eq(loadWidth, UInt<1>(0h1)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 38:16]
    node _extractedData_T_3 = bits(io.dataIn, 15, 0) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 38:38]
    node _extractedData_T_4 = eq(loadWidth, UInt<2>(0h2)) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 39:16]
    node _extractedData_T_5 = bits(io.dataIn, 31, 0) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 39:38]
    node _extractedData_T_6 = mux(_extractedData_T_4, _extractedData_T_5, io.dataIn) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _extractedData_T_7 = mux(_extractedData_T_2, _extractedData_T_3, _extractedData_T_6) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _extractedData_T_8 = mux(_extractedData_T, _extractedData_T_1, _extractedData_T_7) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    connect extractedData, _extractedData_T_8 @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 36:17]
    node _io_dataOut_T = asSInt(extractedData) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 42:45]
    node _io_dataOut_T_1 = asUInt(_io_dataOut_T) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 42:60]
    node _io_dataOut_T_2 = cvt(extractedData) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 42:82]
    node _io_dataOut_T_3 = asUInt(_io_dataOut_T_2) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 42:95]
    node _io_dataOut_T_4 = mux(isSigned, _io_dataOut_T_1, _io_dataOut_T_3) @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 42:20]
    connect io.dataOut, _io_dataOut_T_4 @[src/main/scala/OctoNyteCore/LoadUnits/LoadUnit.scala 42:14]

  module StoreUnit : @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 6:7]
    input clock : Clock @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 6:7]
    input reset : Reset @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 6:7]
    output io : { flip addr : UInt<32>, flip dataIn : UInt<32>, flip funct3 : UInt<3>, memWrite : UInt<32>} @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 7:14]

    wire dataOut : UInt<32> @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 14:21]
    node _T = eq(io.funct3, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 17:18]
    when _T : @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 17:32]
      node _dataOut_T = bits(io.dataIn, 7, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 18:40]
      node _dataOut_T_1 = cat(UInt<24>(0h0), _dataOut_T) @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 18:19]
      connect dataOut, _dataOut_T_1 @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 18:13]
    else :
      node _T_1 = eq(io.funct3, UInt<1>(0h1)) @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 19:25]
      when _T_1 : @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 19:39]
        node _dataOut_T_2 = bits(io.dataIn, 15, 0) @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 20:40]
        node _dataOut_T_3 = cat(UInt<16>(0h0), _dataOut_T_2) @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 20:19]
        connect dataOut, _dataOut_T_3 @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 20:13]
      else :
        node _T_2 = eq(io.funct3, UInt<2>(0h2)) @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 21:25]
        when _T_2 : @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 21:39]
          connect dataOut, io.dataIn @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 22:13]
        else :
          connect dataOut, UInt<1>(0h0) @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 24:13]
    connect io.memWrite, dataOut @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 27:15]

  module OctoNyteCPU : @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 10:7]
    input clock : Clock @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 10:7]
    input reset : UInt<1> @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 10:7]
    output io : { memAddr : UInt<32>, flip memData : UInt<32>, memWrite : UInt<1>, flip inst : UInt<32>} @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 11:14]

    regreset IF_ID : UInt<32>, clock, reset, UInt<32>(0h0) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 19:22]
    regreset ID_EX : UInt<32>, clock, reset, UInt<32>(0h0) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 20:22]
    regreset EX_MEM : UInt<32>, clock, reset, UInt<32>(0h0) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 21:23]
    regreset MEM_WB : UInt<32>, clock, reset, UInt<32>(0h0) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 22:23]
    regreset pc : UInt<32>, clock, reset, UInt<32>(0h0) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 25:19]
    wire nextPc : UInt<32> @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 26:20]
    cmem regFile : UInt<32> [32] @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 29:20]
    connect IF_ID, io.inst @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 32:9]
    node opcode = bits(IF_ID, 6, 0) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 35:21]
    node rs1 = bits(IF_ID, 19, 15) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 36:18]
    node rs2 = bits(IF_ID, 24, 20) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 37:18]
    node rd = bits(IF_ID, 11, 7) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 38:17]
    node funct3 = bits(IF_ID, 14, 12) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 39:21]
    node funct7 = bits(IF_ID, 31, 25) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 40:21]
    wire imm : UInt<32> @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 41:17]
    wire branchOp : UInt<3> @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 42:22]
    node _imm_T = eq(opcode, UInt<2>(0h3)) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 46:13]
    node _imm_T_1 = bits(IF_ID, 31, 20) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 46:39]
    node _imm_T_2 = eq(opcode, UInt<7>(0h63)) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 47:13]
    node _imm_T_3 = bits(IF_ID, 31, 20) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 47:39]
    node _imm_T_4 = eq(opcode, UInt<5>(0h13)) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 48:13]
    node _imm_T_5 = bits(IF_ID, 31, 20) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 48:39]
    node _imm_T_6 = eq(opcode, UInt<7>(0h6f)) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 49:13]
    node _imm_T_7 = bits(IF_ID, 31, 12) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 49:39]
    node _imm_T_8 = mux(_imm_T_6, _imm_T_7, UInt<1>(0h0)) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _imm_T_9 = mux(_imm_T_4, _imm_T_5, _imm_T_8) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _imm_T_10 = mux(_imm_T_2, _imm_T_3, _imm_T_9) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    node _imm_T_11 = mux(_imm_T, _imm_T_1, _imm_T_10) @[src/main/scala/chisel3/util/Mux.scala 126:16]
    connect imm, _imm_T_11 @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 45:7]
    connect branchOp, funct3 @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 53:12]
    inst branchUnit of BranchUnit @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 56:26]
    connect branchUnit.clock, clock
    connect branchUnit.reset, reset
    infer mport branchUnit_io_rs1_MPORT = regFile[rs1], clock @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 57:31]
    connect branchUnit.io.rs1, branchUnit_io_rs1_MPORT @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 57:21]
    infer mport branchUnit_io_rs2_MPORT = regFile[rs2], clock @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 58:31]
    connect branchUnit.io.rs2, branchUnit_io_rs2_MPORT @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 58:21]
    connect branchUnit.io.pc, pc @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 59:20]
    node _branchUnit_io_imm_T = asSInt(imm) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 60:28]
    connect branchUnit.io.imm, _branchUnit_io_imm_T @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 60:21]
    connect branchUnit.io.branchOp, branchOp @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 61:26]
    connect branchUnit.io.valid, UInt<1>(0h1) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 62:23]
    connect nextPc, branchUnit.io.nextPc @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 63:10]
    inst alu of ALU32 @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 66:19]
    connect alu.clock, clock
    connect alu.reset, reset
    infer mport alu_io_a_MPORT = regFile[rs1], clock @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 67:22]
    connect alu.io.a, alu_io_a_MPORT @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 67:12]
    infer mport alu_io_b_MPORT = regFile[rs2], clock @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 68:22]
    connect alu.io.b, alu_io_b_MPORT @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 68:12]
    node _alu_io_opcode_T = bits(IF_ID, 5, 0) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 69:25]
    connect alu.io.opcode, _alu_io_opcode_T @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 69:17]
    inst loadUnit of LoadUnit @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 72:24]
    connect loadUnit.clock, clock
    connect loadUnit.reset, reset
    inst storeUnit of StoreUnit @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 73:25]
    connect storeUnit.clock, clock
    connect storeUnit.reset, reset
    connect loadUnit.io.addr, alu.io.result @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 75:20]
    connect loadUnit.io.dataIn, io.memData @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 76:22]
    connect loadUnit.io.funct3, funct3 @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 77:22]
    connect storeUnit.io.addr, alu.io.result @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 79:21]
    infer mport storeUnit_io_dataIn_MPORT = regFile[rs2], clock @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 80:33]
    connect storeUnit.io.dataIn, storeUnit_io_dataIn_MPORT @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 80:23]
    connect storeUnit.io.funct3, funct3 @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 81:23]
    node _MEM_WB_T = mux(branchUnit.io.taken, branchUnit.io.target, alu.io.result) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 84:16]
    connect MEM_WB, _MEM_WB_T @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 84:10]
    when branchUnit.io.taken : @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 87:29]
      connect pc, nextPc @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 88:8]
    else :
      node _pc_T = add(pc, UInt<3>(0h4)) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 90:14]
      node _pc_T_1 = tail(_pc_T, 1) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 90:14]
      connect pc, _pc_T_1 @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 90:8]
    node _T = neq(MEM_WB, UInt<1>(0h0)) @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 94:15]
    when _T : @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 94:24]
      infer mport MPORT = regFile[rd], clock @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 95:12]
      connect MPORT, MEM_WB @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 95:17]
    connect io.memAddr, storeUnit.io.addr @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 99:14]
    connect io.memWrite, storeUnit.io.memWrite @[src/main/scala/OctoNyteCore/OctoNyteCPU/OctoNyteCPU.scala 100:15]
