module {
  hw.module @LoadUnit(in %clock : i1, in %reset : i1, in %io_addr : i32, in %io_dataIn : i32, in %io_funct3 : i3, out io_dataOut : i32) {
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
  om.class @LoadUnit_Class(%basepath: !om.frozenbasepath) {
    om.class.fields
  }
}
