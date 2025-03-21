module {
  hw.module @ALU32(in %clock : i1, in %reset : i1, in %io_a : i32, in %io_b : i32, out io_result : i32, in %io_opcode : i6) {
    %io_a_0 = sv.wire sym @sym name "io_a" {hw.verilogName = "io_a_0"} : !hw.inout<i32>
    sv.assign %io_a_0, %io_a : i32
    %io_b_1 = sv.wire sym @sym_0 name "io_b" {hw.verilogName = "io_b_0"} : !hw.inout<i32>
    sv.assign %io_b_1, %io_b : i32
    %io_opcode_2 = sv.wire sym @sym_2 name "io_opcode" {hw.verilogName = "io_opcode_0"} : !hw.inout<i6>
    sv.assign %io_opcode_2, %io_opcode : i6
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
    %0 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %_result_T_2 = sv.wire sym @sym_5 {hw.verilogName = "_result_T_2"} : !hw.inout<i32>
    sv.assign %_result_T_2, %0 : i32
    %1 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %_result_T_8 = sv.wire sym @sym_11 {hw.verilogName = "_result_T_8"} : !hw.inout<i32>
    sv.assign %_result_T_8, %1 : i32
    %2 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %_result_T_31 = sv.wire sym @sym_34 {hw.verilogName = "_result_T_31"} : !hw.inout<i32>
    sv.assign %_result_T_31, %2 : i32
    %3 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %_result_T_37 = sv.wire sym @sym_40 {hw.verilogName = "_result_T_37"} : !hw.inout<i32>
    sv.assign %_result_T_37, %3 : i32
    %4 = sv.read_inout %io_b_1 : !hw.inout<i32>
    %_result_T_3 = sv.wire sym @sym_6 {hw.verilogName = "_result_T_3"} : !hw.inout<i32>
    sv.assign %_result_T_3, %4 : i32
    %5 = sv.read_inout %io_b_1 : !hw.inout<i32>
    %_result_T_9 = sv.wire sym @sym_12 {hw.verilogName = "_result_T_9"} : !hw.inout<i32>
    sv.assign %_result_T_9, %5 : i32
    %6 = sv.read_inout %io_b_1 : !hw.inout<i32>
    %_result_T_38 = sv.wire sym @sym_41 {hw.verilogName = "_result_T_38"} : !hw.inout<i32>
    sv.assign %_result_T_38, %6 : i32
    %7 = sv.read_inout %io_opcode_2 : !hw.inout<i6>
    %8 = comb.extract %7 from 0 : (i6) -> i4
    %_result_T = sv.wire sym @sym_3 {hw.verilogName = "_result_T"} : !hw.inout<i4>
    sv.assign %_result_T, %8 : i4
    %_result_T_6 = sv.wire sym @sym_9 {hw.verilogName = "_result_T_6"} : !hw.inout<i4>
    sv.assign %_result_T_6, %8 : i4
    %_result_T_12 = sv.wire sym @sym_15 {hw.verilogName = "_result_T_12"} : !hw.inout<i4>
    sv.assign %_result_T_12, %8 : i4
    %_result_T_15 = sv.wire sym @sym_18 {hw.verilogName = "_result_T_15"} : !hw.inout<i4>
    sv.assign %_result_T_15, %8 : i4
    %_result_T_18 = sv.wire sym @sym_21 {hw.verilogName = "_result_T_18"} : !hw.inout<i4>
    sv.assign %_result_T_18, %8 : i4
    %_result_T_21 = sv.wire sym @sym_24 {hw.verilogName = "_result_T_21"} : !hw.inout<i4>
    sv.assign %_result_T_21, %8 : i4
    %_result_T_25 = sv.wire sym @sym_28 {hw.verilogName = "_result_T_25"} : !hw.inout<i4>
    sv.assign %_result_T_25, %8 : i4
    %_result_T_29 = sv.wire sym @sym_32 {hw.verilogName = "_result_T_29"} : !hw.inout<i4>
    sv.assign %_result_T_29, %8 : i4
    %_result_T_35 = sv.wire sym @sym_38 {hw.verilogName = "_result_T_35"} : !hw.inout<i4>
    sv.assign %_result_T_35, %8 : i4
    %_result_T_41 = sv.wire sym @sym_44 {hw.verilogName = "_result_T_41"} : !hw.inout<i4>
    sv.assign %_result_T_41, %8 : i4
    %9 = sv.read_inout %_result_T : !hw.inout<i4>
    %10 = comb.icmp bin eq %9, %c0_i4 : i4
    %_result_T_1 = sv.wire sym @sym_4 {hw.verilogName = "_result_T_1"} : !hw.inout<i1>
    sv.assign %_result_T_1, %10 : i1
    %11 = sv.read_inout %_result_T_2 : !hw.inout<i32>
    %12 = comb.extract %11 from 31 : (i32) -> i1
    %13 = sv.read_inout %_result_T_2 : !hw.inout<i32>
    %14 = comb.concat %12, %13 : i1, i32
    %15 = sv.read_inout %_result_T_3 : !hw.inout<i32>
    %16 = comb.extract %15 from 31 : (i32) -> i1
    %17 = sv.read_inout %_result_T_3 : !hw.inout<i32>
    %18 = comb.concat %16, %17 : i1, i32
    %19 = comb.add bin %14, %18 : i33
    %_result_T_4 = sv.wire sym @sym_7 {hw.verilogName = "_result_T_4"} : !hw.inout<i33>
    sv.assign %_result_T_4, %19 : i33
    %20 = sv.read_inout %_result_T_4 : !hw.inout<i33>
    %_result_T_5 = sv.wire sym @sym_8 {hw.verilogName = "_result_T_5"} : !hw.inout<i33>
    sv.assign %_result_T_5, %20 : i33
    %21 = sv.read_inout %_result_T_6 : !hw.inout<i4>
    %22 = comb.icmp bin eq %21, %c1_i4 : i4
    %_result_T_7 = sv.wire sym @sym_10 {hw.verilogName = "_result_T_7"} : !hw.inout<i1>
    sv.assign %_result_T_7, %22 : i1
    %23 = sv.read_inout %_result_T_8 : !hw.inout<i32>
    %24 = comb.extract %23 from 31 : (i32) -> i1
    %25 = sv.read_inout %_result_T_8 : !hw.inout<i32>
    %26 = comb.concat %24, %25 : i1, i32
    %27 = sv.read_inout %_result_T_9 : !hw.inout<i32>
    %28 = comb.extract %27 from 31 : (i32) -> i1
    %29 = sv.read_inout %_result_T_9 : !hw.inout<i32>
    %30 = comb.concat %28, %29 : i1, i32
    %31 = comb.sub bin %26, %30 : i33
    %_result_T_10 = sv.wire sym @sym_13 {hw.verilogName = "_result_T_10"} : !hw.inout<i33>
    sv.assign %_result_T_10, %31 : i33
    %32 = sv.read_inout %_result_T_10 : !hw.inout<i33>
    %_result_T_11 = sv.wire sym @sym_14 {hw.verilogName = "_result_T_11"} : !hw.inout<i33>
    sv.assign %_result_T_11, %32 : i33
    %33 = sv.read_inout %_result_T_12 : !hw.inout<i4>
    %34 = comb.icmp bin eq %33, %c-8_i4 : i4
    %_result_T_13 = sv.wire sym @sym_16 {hw.verilogName = "_result_T_13"} : !hw.inout<i1>
    sv.assign %_result_T_13, %34 : i1
    %35 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %36 = sv.read_inout %io_b_1 : !hw.inout<i32>
    %37 = comb.xor bin %35, %36 : i32
    %_result_T_14 = sv.wire sym @sym_17 {hw.verilogName = "_result_T_14"} : !hw.inout<i32>
    sv.assign %_result_T_14, %37 : i32
    %38 = sv.read_inout %_result_T_15 : !hw.inout<i4>
    %39 = comb.icmp bin eq %38, %c-4_i4 : i4
    %_result_T_16 = sv.wire sym @sym_19 {hw.verilogName = "_result_T_16"} : !hw.inout<i1>
    sv.assign %_result_T_16, %39 : i1
    %40 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %41 = sv.read_inout %io_b_1 : !hw.inout<i32>
    %42 = comb.or bin %40, %41 : i32
    %_result_T_17 = sv.wire sym @sym_20 {hw.verilogName = "_result_T_17"} : !hw.inout<i32>
    sv.assign %_result_T_17, %42 : i32
    %43 = sv.read_inout %_result_T_18 : !hw.inout<i4>
    %44 = comb.icmp bin eq %43, %c-2_i4 : i4
    %_result_T_19 = sv.wire sym @sym_22 {hw.verilogName = "_result_T_19"} : !hw.inout<i1>
    sv.assign %_result_T_19, %44 : i1
    %45 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %46 = sv.read_inout %io_b_1 : !hw.inout<i32>
    %47 = comb.and bin %45, %46 : i32
    %_result_T_20 = sv.wire sym @sym_23 {hw.verilogName = "_result_T_20"} : !hw.inout<i32>
    sv.assign %_result_T_20, %47 : i32
    %48 = sv.read_inout %_result_T_21 : !hw.inout<i4>
    %49 = comb.icmp bin eq %48, %c2_i4 : i4
    %_result_T_22 = sv.wire sym @sym_25 {hw.verilogName = "_result_T_22"} : !hw.inout<i1>
    sv.assign %_result_T_22, %49 : i1
    %50 = sv.read_inout %io_b_1 : !hw.inout<i32>
    %51 = comb.extract %50 from 0 : (i32) -> i6
    %_result_T_23 = sv.wire sym @sym_26 {hw.verilogName = "_result_T_23"} : !hw.inout<i6>
    sv.assign %_result_T_23, %51 : i6
    %_result_T_27 = sv.wire sym @sym_30 {hw.verilogName = "_result_T_27"} : !hw.inout<i6>
    sv.assign %_result_T_27, %51 : i6
    %_result_T_32 = sv.wire sym @sym_35 {hw.verilogName = "_result_T_32"} : !hw.inout<i6>
    sv.assign %_result_T_32, %51 : i6
    %52 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %53 = comb.concat %c0_i63, %52 : i63, i32
    %54 = sv.read_inout %_result_T_23 : !hw.inout<i6>
    %55 = comb.concat %c0_i89, %54 : i89, i6
    %56 = comb.shl bin %53, %55 : i95
    %_result_T_24 = sv.wire sym @sym_27 {hw.verilogName = "_result_T_24"} : !hw.inout<i95>
    sv.assign %_result_T_24, %56 : i95
    %57 = sv.read_inout %_result_T_25 : !hw.inout<i4>
    %58 = comb.icmp bin eq %57, %c-6_i4 : i4
    %_result_T_26 = sv.wire sym @sym_29 {hw.verilogName = "_result_T_26"} : !hw.inout<i1>
    sv.assign %_result_T_26, %58 : i1
    %59 = sv.read_inout %_result_T_27 : !hw.inout<i6>
    %60 = comb.concat %c0_i26, %59 : i26, i6
    %61 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %62 = comb.shru bin %61, %60 : i32
    %_result_T_28 = sv.wire sym @sym_31 {hw.verilogName = "_result_T_28"} : !hw.inout<i32>
    sv.assign %_result_T_28, %62 : i32
    %63 = sv.read_inout %_result_T_29 : !hw.inout<i4>
    %64 = comb.icmp bin eq %63, %c-5_i4 : i4
    %_result_T_30 = sv.wire sym @sym_33 {hw.verilogName = "_result_T_30"} : !hw.inout<i1>
    sv.assign %_result_T_30, %64 : i1
    %65 = sv.read_inout %_result_T_32 : !hw.inout<i6>
    %66 = comb.concat %c0_i26, %65 : i26, i6
    %67 = sv.read_inout %_result_T_31 : !hw.inout<i32>
    %68 = comb.shrs bin %67, %66 : i32
    %_result_T_33 = sv.wire sym @sym_36 {hw.verilogName = "_result_T_33"} : !hw.inout<i32>
    sv.assign %_result_T_33, %68 : i32
    %69 = sv.read_inout %_result_T_33 : !hw.inout<i32>
    %_result_T_34 = sv.wire sym @sym_37 {hw.verilogName = "_result_T_34"} : !hw.inout<i32>
    sv.assign %_result_T_34, %69 : i32
    %70 = sv.read_inout %_result_T_35 : !hw.inout<i4>
    %71 = comb.icmp bin eq %70, %c4_i4 : i4
    %_result_T_36 = sv.wire sym @sym_39 {hw.verilogName = "_result_T_36"} : !hw.inout<i1>
    sv.assign %_result_T_36, %71 : i1
    %72 = sv.read_inout %_result_T_37 : !hw.inout<i32>
    %73 = sv.read_inout %_result_T_38 : !hw.inout<i32>
    %74 = comb.icmp bin slt %72, %73 : i32
    %_result_T_39 = sv.wire sym @sym_42 {hw.verilogName = "_result_T_39"} : !hw.inout<i1>
    sv.assign %_result_T_39, %74 : i1
    %75 = sv.read_inout %_result_T_39 : !hw.inout<i1>
    %_result_T_40 = sv.wire sym @sym_43 {hw.verilogName = "_result_T_40"} : !hw.inout<i1>
    sv.assign %_result_T_40, %75 : i1
    %76 = sv.read_inout %_result_T_41 : !hw.inout<i4>
    %77 = comb.icmp bin eq %76, %c6_i4 : i4
    %_result_T_42 = sv.wire sym @sym_45 {hw.verilogName = "_result_T_42"} : !hw.inout<i1>
    sv.assign %_result_T_42, %77 : i1
    %78 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %79 = sv.read_inout %io_b_1 : !hw.inout<i32>
    %80 = comb.icmp bin ult %78, %79 : i32
    %_result_T_43 = sv.wire sym @sym_46 {hw.verilogName = "_result_T_43"} : !hw.inout<i1>
    sv.assign %_result_T_43, %80 : i1
    %81 = sv.read_inout %_result_T_43 : !hw.inout<i1>
    %_result_T_44 = sv.wire sym @sym_47 {hw.verilogName = "_result_T_44"} : !hw.inout<i1>
    sv.assign %_result_T_44, %81 : i1
    %82 = sv.read_inout %_result_T_44 : !hw.inout<i1>
    %83 = comb.concat %c0_i31, %82 : i31, i1
    %84 = sv.read_inout %_result_T_42 : !hw.inout<i1>
    %85 = comb.mux bin %84, %83, %c0_i32 : i32
    %_result_T_45 = sv.wire sym @sym_48 {hw.verilogName = "_result_T_45"} : !hw.inout<i32>
    sv.assign %_result_T_45, %85 : i32
    %86 = sv.read_inout %_result_T_40 : !hw.inout<i1>
    %87 = comb.concat %c0_i31, %86 : i31, i1
    %88 = sv.read_inout %_result_T_36 : !hw.inout<i1>
    %89 = sv.read_inout %_result_T_45 : !hw.inout<i32>
    %90 = comb.mux bin %88, %87, %89 : i32
    %_result_T_46 = sv.wire sym @sym_49 {hw.verilogName = "_result_T_46"} : !hw.inout<i32>
    sv.assign %_result_T_46, %90 : i32
    %91 = sv.read_inout %_result_T_30 : !hw.inout<i1>
    %92 = sv.read_inout %_result_T_34 : !hw.inout<i32>
    %93 = sv.read_inout %_result_T_46 : !hw.inout<i32>
    %94 = comb.mux bin %91, %92, %93 : i32
    %_result_T_47 = sv.wire sym @sym_50 {hw.verilogName = "_result_T_47"} : !hw.inout<i32>
    sv.assign %_result_T_47, %94 : i32
    %95 = sv.read_inout %_result_T_26 : !hw.inout<i1>
    %96 = sv.read_inout %_result_T_28 : !hw.inout<i32>
    %97 = sv.read_inout %_result_T_47 : !hw.inout<i32>
    %98 = comb.mux bin %95, %96, %97 : i32
    %_result_T_48 = sv.wire sym @sym_51 {hw.verilogName = "_result_T_48"} : !hw.inout<i32>
    sv.assign %_result_T_48, %98 : i32
    %99 = sv.read_inout %_result_T_48 : !hw.inout<i32>
    %100 = comb.concat %c0_i63, %99 : i63, i32
    %101 = sv.read_inout %_result_T_22 : !hw.inout<i1>
    %102 = sv.read_inout %_result_T_24 : !hw.inout<i95>
    %103 = comb.mux bin %101, %102, %100 : i95
    %_result_T_49 = sv.wire sym @sym_52 {hw.verilogName = "_result_T_49"} : !hw.inout<i95>
    sv.assign %_result_T_49, %103 : i95
    %104 = sv.read_inout %_result_T_20 : !hw.inout<i32>
    %105 = comb.concat %c0_i63, %104 : i63, i32
    %106 = sv.read_inout %_result_T_19 : !hw.inout<i1>
    %107 = sv.read_inout %_result_T_49 : !hw.inout<i95>
    %108 = comb.mux bin %106, %105, %107 : i95
    %_result_T_50 = sv.wire sym @sym_53 {hw.verilogName = "_result_T_50"} : !hw.inout<i95>
    sv.assign %_result_T_50, %108 : i95
    %109 = sv.read_inout %_result_T_17 : !hw.inout<i32>
    %110 = comb.concat %c0_i63, %109 : i63, i32
    %111 = sv.read_inout %_result_T_16 : !hw.inout<i1>
    %112 = sv.read_inout %_result_T_50 : !hw.inout<i95>
    %113 = comb.mux bin %111, %110, %112 : i95
    %_result_T_51 = sv.wire sym @sym_54 {hw.verilogName = "_result_T_51"} : !hw.inout<i95>
    sv.assign %_result_T_51, %113 : i95
    %114 = sv.read_inout %_result_T_14 : !hw.inout<i32>
    %115 = comb.concat %c0_i63, %114 : i63, i32
    %116 = sv.read_inout %_result_T_13 : !hw.inout<i1>
    %117 = sv.read_inout %_result_T_51 : !hw.inout<i95>
    %118 = comb.mux bin %116, %115, %117 : i95
    %_result_T_52 = sv.wire sym @sym_55 {hw.verilogName = "_result_T_52"} : !hw.inout<i95>
    sv.assign %_result_T_52, %118 : i95
    %119 = sv.read_inout %_result_T_11 : !hw.inout<i33>
    %120 = comb.concat %c0_i62, %119 : i62, i33
    %121 = sv.read_inout %_result_T_7 : !hw.inout<i1>
    %122 = sv.read_inout %_result_T_52 : !hw.inout<i95>
    %123 = comb.mux bin %121, %120, %122 : i95
    %_result_T_53 = sv.wire sym @sym_56 {hw.verilogName = "_result_T_53"} : !hw.inout<i95>
    sv.assign %_result_T_53, %123 : i95
    %124 = sv.read_inout %_result_T_5 : !hw.inout<i33>
    %125 = comb.concat %c0_i62, %124 : i62, i33
    %126 = sv.read_inout %_result_T_1 : !hw.inout<i1>
    %127 = sv.read_inout %_result_T_53 : !hw.inout<i95>
    %128 = comb.mux bin %126, %125, %127 : i95
    %result = sv.wire sym @sym_57 {hw.verilogName = "result"} : !hw.inout<i95>
    sv.assign %result, %128 : i95
    %129 = sv.read_inout %result : !hw.inout<i95>
    %130 = comb.extract %129 from 0 : (i95) -> i32
    %io_result = sv.wire sym @sym_1 {hw.verilogName = "io_result_0"} : !hw.inout<i32>
    sv.assign %io_result, %130 : i32
    %131 = sv.read_inout %io_result : !hw.inout<i32>
    hw.output %131 : i32
  }
  om.class @ALU32_Class(%basepath: !om.frozenbasepath) {
    om.class.fields
  }
}
