FIRRTL version 3.3.0
circuit StoreUnit :%[[
  {
    "class":"firrtl.transforms.DedupGroupAnnotation",
    "target":"~StoreUnit|StoreUnit",
    "group":"StoreUnit"
  }
]]
  module StoreUnit : @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 6:7]
    input clock : Clock @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 6:7]
    input reset : UInt<1> @[src/main/scala/OctoNyteCore/ExecutionUnits/StoreUnit.scala 6:7]
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
