module {
  hw.module @ALU32(in %clock : i1, in %reset : i1, in %io_a : i32, in %io_b : i32, out io_result : i32, in %io_opcode : i6) {
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
  om.class @ALU32_Class(%basepath: !om.frozenbasepath) {
    om.class.fields
  }
}
