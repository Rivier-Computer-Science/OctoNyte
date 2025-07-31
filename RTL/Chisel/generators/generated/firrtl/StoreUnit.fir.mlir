module {
  hw.module @StoreUnit(in %clock : i1, in %reset : i1, in %io_addr : i32, in %io_dataIn : i32, in %io_funct3 : i3, out io_memWrite : i32) {
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
  om.class @StoreUnit_Class(%basepath: !om.frozenbasepath) {
    om.class.fields
  }
}
