module {
  hw.module @LoadUnit(in %clock : i1, in %reset : i1, in %io_addr : i32, in %io_dataIn : i32, in %io_funct3 : i3, out io_dataOut : i32) {
    %extractedData = sv.wire sym @sym_20 {hw.verilogName = "extractedData"} : !hw.inout<i32>
    %io_addr_0 = sv.wire sym @sym name "io_addr" {hw.verilogName = "io_addr_0"} : !hw.inout<i32>
    sv.assign %io_addr_0, %io_addr : i32
    %io_dataIn_1 = sv.wire sym @sym_0 name "io_dataIn" {hw.verilogName = "io_dataIn_0"} : !hw.inout<i32>
    sv.assign %io_dataIn_1, %io_dataIn : i32
    %io_funct3_2 = sv.wire sym @sym_1 name "io_funct3" {hw.verilogName = "io_funct3_0"} : !hw.inout<i3>
    sv.assign %io_funct3_2, %io_funct3 : i3
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
    %_loadWidth_T_7 = sv.wire sym @sym_12 {hw.verilogName = "_loadWidth_T_7"} : !hw.inout<i2>
    sv.assign %_loadWidth_T_7, %c-2_i2 : i2
    %0 = sv.read_inout %io_dataIn_1 : !hw.inout<i32>
    %_extractedData_T_5 = sv.wire sym @sym_26 {hw.verilogName = "_extractedData_T_5"} : !hw.inout<i32>
    sv.assign %_extractedData_T_5, %0 : i32
    %_loadWidth_T_9 = sv.wire sym @sym_14 {hw.verilogName = "_loadWidth_T_9"} : !hw.inout<i2>
    %_isSigned_T_4 = sv.wire sym @sym_19 {hw.verilogName = "_isSigned_T_4"} : !hw.inout<i1>
    %1 = sv.read_inout %io_funct3_2 : !hw.inout<i3>
    %2 = comb.icmp bin eq %1, %c0_i3 : i3
    %3 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<i1>
    sv.assign %3, %2 : i1
    %_loadWidth_T = sv.wire sym @sym_5 {hw.verilogName = "_loadWidth_T"} : !hw.inout<i1>
    %4 = sv.read_inout %3 : !hw.inout<i1>
    sv.assign %_loadWidth_T, %4 : i1
    %_isSigned_T = sv.wire sym @sym_15 {hw.verilogName = "_isSigned_T"} : !hw.inout<i1>
    %5 = sv.read_inout %3 : !hw.inout<i1>
    sv.assign %_isSigned_T, %5 : i1
    %6 = sv.read_inout %io_funct3_2 : !hw.inout<i3>
    %7 = comb.icmp bin eq %6, %c-4_i3 : i3
    %_loadWidth_T_1 = sv.wire sym @sym_6 {hw.verilogName = "_loadWidth_T_1"} : !hw.inout<i1>
    sv.assign %_loadWidth_T_1, %7 : i1
    %8 = sv.read_inout %_loadWidth_T : !hw.inout<i1>
    %9 = sv.read_inout %_loadWidth_T_1 : !hw.inout<i1>
    %10 = comb.or bin %8, %9 : i1
    %_loadWidth_T_2 = sv.wire sym @sym_7 {hw.verilogName = "_loadWidth_T_2"} : !hw.inout<i1>
    sv.assign %_loadWidth_T_2, %10 : i1
    %11 = sv.read_inout %io_funct3_2 : !hw.inout<i3>
    %12 = comb.icmp bin eq %11, %c1_i3 : i3
    %13 = sv.wire {hw.verilogName = "_GEN_0"} : !hw.inout<i1>
    sv.assign %13, %12 : i1
    %_loadWidth_T_3 = sv.wire sym @sym_8 {hw.verilogName = "_loadWidth_T_3"} : !hw.inout<i1>
    %14 = sv.read_inout %13 : !hw.inout<i1>
    sv.assign %_loadWidth_T_3, %14 : i1
    %_isSigned_T_1 = sv.wire sym @sym_16 {hw.verilogName = "_isSigned_T_1"} : !hw.inout<i1>
    %15 = sv.read_inout %13 : !hw.inout<i1>
    sv.assign %_isSigned_T_1, %15 : i1
    %16 = sv.read_inout %io_funct3_2 : !hw.inout<i3>
    %17 = comb.icmp bin eq %16, %c-3_i3 : i3
    %_loadWidth_T_4 = sv.wire sym @sym_9 {hw.verilogName = "_loadWidth_T_4"} : !hw.inout<i1>
    sv.assign %_loadWidth_T_4, %17 : i1
    %18 = sv.read_inout %_loadWidth_T_3 : !hw.inout<i1>
    %19 = sv.read_inout %_loadWidth_T_4 : !hw.inout<i1>
    %20 = comb.or bin %18, %19 : i1
    %_loadWidth_T_5 = sv.wire sym @sym_10 {hw.verilogName = "_loadWidth_T_5"} : !hw.inout<i1>
    sv.assign %_loadWidth_T_5, %20 : i1
    %21 = sv.read_inout %io_funct3_2 : !hw.inout<i3>
    %22 = comb.icmp bin eq %21, %c2_i3 : i3
    %23 = sv.wire {hw.verilogName = "_GEN_1"} : !hw.inout<i1>
    sv.assign %23, %22 : i1
    %_loadWidth_T_6 = sv.wire sym @sym_11 {hw.verilogName = "_loadWidth_T_6"} : !hw.inout<i1>
    %24 = sv.read_inout %23 : !hw.inout<i1>
    sv.assign %_loadWidth_T_6, %24 : i1
    %_isSigned_T_3 = sv.wire sym @sym_18 {hw.verilogName = "_isSigned_T_3"} : !hw.inout<i1>
    %25 = sv.read_inout %23 : !hw.inout<i1>
    sv.assign %_isSigned_T_3, %25 : i1
    %26 = sv.read_inout %_loadWidth_T_5 : !hw.inout<i1>
    %27 = comb.mux bin %26, %c1_i2, %c-2_i2 : i2
    %_loadWidth_T_8 = sv.wire sym @sym_13 {hw.verilogName = "_loadWidth_T_8"} : !hw.inout<i2>
    sv.assign %_loadWidth_T_8, %27 : i2
    %28 = sv.read_inout %_loadWidth_T_2 : !hw.inout<i1>
    %29 = sv.read_inout %_loadWidth_T_8 : !hw.inout<i2>
    %30 = comb.mux bin %28, %c0_i2, %29 : i2
    sv.assign %_loadWidth_T_9, %30 : i2
    %31 = sv.read_inout %_loadWidth_T_9 : !hw.inout<i2>
    %loadWidth = sv.wire sym @sym_3 {hw.verilogName = "loadWidth"} : !hw.inout<i2>
    sv.assign %loadWidth, %31 : i2
    %32 = sv.read_inout %_isSigned_T : !hw.inout<i1>
    %33 = sv.read_inout %_isSigned_T_1 : !hw.inout<i1>
    %34 = comb.or bin %32, %33 : i1
    %_isSigned_T_2 = sv.wire sym @sym_17 {hw.verilogName = "_isSigned_T_2"} : !hw.inout<i1>
    sv.assign %_isSigned_T_2, %34 : i1
    %35 = sv.read_inout %_isSigned_T_3 : !hw.inout<i1>
    %36 = sv.read_inout %_isSigned_T_2 : !hw.inout<i1>
    %37 = comb.or bin %36, %35 : i1
    sv.assign %_isSigned_T_4, %37 : i1
    %38 = sv.read_inout %_isSigned_T_4 : !hw.inout<i1>
    %isSigned = sv.wire sym @sym_4 {hw.verilogName = "isSigned"} : !hw.inout<i1>
    sv.assign %isSigned, %38 : i1
    %_extractedData_T_8 = sv.wire sym @sym_29 {hw.verilogName = "_extractedData_T_8"} : !hw.inout<i32>
    %39 = sv.read_inout %extractedData : !hw.inout<i32>
    %_io_dataOut_T = sv.wire sym @sym_30 {hw.verilogName = "_io_dataOut_T"} : !hw.inout<i32>
    sv.assign %_io_dataOut_T, %39 : i32
    %40 = sv.read_inout %loadWidth : !hw.inout<i2>
    %41 = comb.icmp bin eq %40, %c0_i2 : i2
    %_extractedData_T = sv.wire sym @sym_21 {hw.verilogName = "_extractedData_T"} : !hw.inout<i1>
    sv.assign %_extractedData_T, %41 : i1
    %42 = sv.read_inout %io_dataIn_1 : !hw.inout<i32>
    %43 = comb.extract %42 from 0 : (i32) -> i8
    %_extractedData_T_1 = sv.wire sym @sym_22 {hw.verilogName = "_extractedData_T_1"} : !hw.inout<i8>
    sv.assign %_extractedData_T_1, %43 : i8
    %44 = sv.read_inout %loadWidth : !hw.inout<i2>
    %45 = comb.icmp bin eq %44, %c1_i2 : i2
    %_extractedData_T_2 = sv.wire sym @sym_23 {hw.verilogName = "_extractedData_T_2"} : !hw.inout<i1>
    sv.assign %_extractedData_T_2, %45 : i1
    %46 = sv.read_inout %io_dataIn_1 : !hw.inout<i32>
    %47 = comb.extract %46 from 0 : (i32) -> i16
    %_extractedData_T_3 = sv.wire sym @sym_24 {hw.verilogName = "_extractedData_T_3"} : !hw.inout<i16>
    sv.assign %_extractedData_T_3, %47 : i16
    %48 = sv.read_inout %loadWidth : !hw.inout<i2>
    %49 = comb.icmp bin eq %48, %c-2_i2 : i2
    %_extractedData_T_4 = sv.wire sym @sym_25 {hw.verilogName = "_extractedData_T_4"} : !hw.inout<i1>
    sv.assign %_extractedData_T_4, %49 : i1
    %50 = sv.read_inout %io_dataIn_1 : !hw.inout<i32>
    %51 = sv.read_inout %_extractedData_T_5 : !hw.inout<i32>
    %52 = sv.read_inout %_extractedData_T_4 : !hw.inout<i1>
    %53 = comb.mux bin %52, %51, %50 : i32
    %_extractedData_T_6 = sv.wire sym @sym_27 {hw.verilogName = "_extractedData_T_6"} : !hw.inout<i32>
    sv.assign %_extractedData_T_6, %53 : i32
    %54 = sv.read_inout %_extractedData_T_3 : !hw.inout<i16>
    %55 = comb.concat %c0_i16, %54 : i16, i16
    %56 = sv.read_inout %_extractedData_T_2 : !hw.inout<i1>
    %57 = sv.read_inout %_extractedData_T_6 : !hw.inout<i32>
    %58 = comb.mux bin %56, %55, %57 : i32
    %_extractedData_T_7 = sv.wire sym @sym_28 {hw.verilogName = "_extractedData_T_7"} : !hw.inout<i32>
    sv.assign %_extractedData_T_7, %58 : i32
    %59 = sv.read_inout %_extractedData_T_1 : !hw.inout<i8>
    %60 = comb.concat %c0_i24, %59 : i24, i8
    %61 = sv.read_inout %_extractedData_T : !hw.inout<i1>
    %62 = sv.read_inout %_extractedData_T_7 : !hw.inout<i32>
    %63 = comb.mux bin %61, %60, %62 : i32
    sv.assign %_extractedData_T_8, %63 : i32
    %64 = sv.read_inout %_extractedData_T_8 : !hw.inout<i32>
    sv.assign %extractedData, %64 : i32
    %65 = sv.read_inout %_io_dataOut_T : !hw.inout<i32>
    %_io_dataOut_T_1 = sv.wire sym @sym_31 {hw.verilogName = "_io_dataOut_T_1"} : !hw.inout<i32>
    sv.assign %_io_dataOut_T_1, %65 : i32
    %66 = sv.read_inout %extractedData : !hw.inout<i32>
    %67 = comb.concat %false, %66 : i1, i32
    %_io_dataOut_T_2 = sv.wire sym @sym_32 {hw.verilogName = "_io_dataOut_T_2"} : !hw.inout<i33>
    sv.assign %_io_dataOut_T_2, %67 : i33
    %68 = sv.read_inout %_io_dataOut_T_2 : !hw.inout<i33>
    %_io_dataOut_T_3 = sv.wire sym @sym_33 {hw.verilogName = "_io_dataOut_T_3"} : !hw.inout<i33>
    sv.assign %_io_dataOut_T_3, %68 : i33
    %69 = sv.read_inout %_io_dataOut_T_1 : !hw.inout<i32>
    %70 = comb.concat %false, %69 : i1, i32
    %71 = sv.read_inout %isSigned : !hw.inout<i1>
    %72 = sv.read_inout %_io_dataOut_T_3 : !hw.inout<i33>
    %73 = comb.mux bin %71, %70, %72 : i33
    %_io_dataOut_T_4 = sv.wire sym @sym_34 {hw.verilogName = "_io_dataOut_T_4"} : !hw.inout<i33>
    sv.assign %_io_dataOut_T_4, %73 : i33
    %74 = sv.read_inout %_io_dataOut_T_4 : !hw.inout<i33>
    %75 = comb.extract %74 from 0 : (i33) -> i32
    %io_dataOut = sv.wire sym @sym_2 {hw.verilogName = "io_dataOut_0"} : !hw.inout<i32>
    sv.assign %io_dataOut, %75 : i32
    %76 = sv.read_inout %io_dataOut : !hw.inout<i32>
    hw.output %76 : i32
  }
  om.class @LoadUnit_Class(%basepath: !om.frozenbasepath) {
    om.class.fields
  }
}
