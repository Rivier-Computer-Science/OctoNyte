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
    %io_threadID_0 = sv.wire sym @sym name "io_threadID" {hw.verilogName = "io_threadID_0"} : !hw.inout<i2>
    sv.assign %io_threadID_0, %io_threadID : i2
    %io_src1_1 = sv.wire sym @sym_0 name "io_src1" {hw.verilogName = "io_src1_0"} : !hw.inout<i5>
    sv.assign %io_src1_1, %io_src1 : i5
    %io_src2_2 = sv.wire sym @sym_1 name "io_src2" {hw.verilogName = "io_src2_0"} : !hw.inout<i5>
    sv.assign %io_src2_2, %io_src2 : i5
    %io_dst1_3 = sv.wire sym @sym_2 name "io_dst1" {hw.verilogName = "io_dst1_0"} : !hw.inout<i5>
    sv.assign %io_dst1_3, %io_dst1 : i5
    %io_wen_4 = sv.wire sym @sym_3 name "io_wen" {hw.verilogName = "io_wen_0"} : !hw.inout<i1>
    sv.assign %io_wen_4, %io_wen : i1
    %io_dst1data_5 = sv.wire sym @sym_4 name "io_dst1data" {hw.verilogName = "io_dst1data_0"} : !hw.inout<i32>
    sv.assign %io_dst1data_5, %io_dst1data : i32
    %c0_i32 = hw.constant 0 : i32
    %_regs_WIRE_0 = sv.wire sym @sym_7 {hw.verilogName = "_regs_WIRE_0"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_0, %c0_i32 : i32
    %_regs_WIRE_1 = sv.wire sym @sym_8 {hw.verilogName = "_regs_WIRE_1"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_1, %c0_i32 : i32
    %_regs_WIRE_2 = sv.wire sym @sym_9 {hw.verilogName = "_regs_WIRE_2"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_2, %c0_i32 : i32
    %_regs_WIRE_3 = sv.wire sym @sym_10 {hw.verilogName = "_regs_WIRE_3"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_3, %c0_i32 : i32
    %_regs_WIRE_4 = sv.wire sym @sym_11 {hw.verilogName = "_regs_WIRE_4"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_4, %c0_i32 : i32
    %_regs_WIRE_5 = sv.wire sym @sym_12 {hw.verilogName = "_regs_WIRE_5"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_5, %c0_i32 : i32
    %_regs_WIRE_6 = sv.wire sym @sym_13 {hw.verilogName = "_regs_WIRE_6"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_6, %c0_i32 : i32
    %_regs_WIRE_7 = sv.wire sym @sym_14 {hw.verilogName = "_regs_WIRE_7"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_7, %c0_i32 : i32
    %_regs_WIRE_8 = sv.wire sym @sym_15 {hw.verilogName = "_regs_WIRE_8"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_8, %c0_i32 : i32
    %_regs_WIRE_9 = sv.wire sym @sym_16 {hw.verilogName = "_regs_WIRE_9"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_9, %c0_i32 : i32
    %_regs_WIRE_10 = sv.wire sym @sym_17 {hw.verilogName = "_regs_WIRE_10"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_10, %c0_i32 : i32
    %_regs_WIRE_11 = sv.wire sym @sym_18 {hw.verilogName = "_regs_WIRE_11"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_11, %c0_i32 : i32
    %_regs_WIRE_12 = sv.wire sym @sym_19 {hw.verilogName = "_regs_WIRE_12"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_12, %c0_i32 : i32
    %_regs_WIRE_13 = sv.wire sym @sym_20 {hw.verilogName = "_regs_WIRE_13"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_13, %c0_i32 : i32
    %_regs_WIRE_14 = sv.wire sym @sym_21 {hw.verilogName = "_regs_WIRE_14"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_14, %c0_i32 : i32
    %_regs_WIRE_15 = sv.wire sym @sym_22 {hw.verilogName = "_regs_WIRE_15"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_15, %c0_i32 : i32
    %_regs_WIRE_16 = sv.wire sym @sym_23 {hw.verilogName = "_regs_WIRE_16"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_16, %c0_i32 : i32
    %_regs_WIRE_17 = sv.wire sym @sym_24 {hw.verilogName = "_regs_WIRE_17"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_17, %c0_i32 : i32
    %_regs_WIRE_18 = sv.wire sym @sym_25 {hw.verilogName = "_regs_WIRE_18"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_18, %c0_i32 : i32
    %_regs_WIRE_19 = sv.wire sym @sym_26 {hw.verilogName = "_regs_WIRE_19"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_19, %c0_i32 : i32
    %_regs_WIRE_20 = sv.wire sym @sym_27 {hw.verilogName = "_regs_WIRE_20"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_20, %c0_i32 : i32
    %_regs_WIRE_21 = sv.wire sym @sym_28 {hw.verilogName = "_regs_WIRE_21"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_21, %c0_i32 : i32
    %_regs_WIRE_22 = sv.wire sym @sym_29 {hw.verilogName = "_regs_WIRE_22"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_22, %c0_i32 : i32
    %_regs_WIRE_23 = sv.wire sym @sym_30 {hw.verilogName = "_regs_WIRE_23"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_23, %c0_i32 : i32
    %_regs_WIRE_24 = sv.wire sym @sym_31 {hw.verilogName = "_regs_WIRE_24"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_24, %c0_i32 : i32
    %_regs_WIRE_25 = sv.wire sym @sym_32 {hw.verilogName = "_regs_WIRE_25"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_25, %c0_i32 : i32
    %_regs_WIRE_26 = sv.wire sym @sym_33 {hw.verilogName = "_regs_WIRE_26"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_26, %c0_i32 : i32
    %_regs_WIRE_27 = sv.wire sym @sym_34 {hw.verilogName = "_regs_WIRE_27"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_27, %c0_i32 : i32
    %_regs_WIRE_28 = sv.wire sym @sym_35 {hw.verilogName = "_regs_WIRE_28"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_28, %c0_i32 : i32
    %_regs_WIRE_29 = sv.wire sym @sym_36 {hw.verilogName = "_regs_WIRE_29"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_29, %c0_i32 : i32
    %_regs_WIRE_30 = sv.wire sym @sym_37 {hw.verilogName = "_regs_WIRE_30"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_30, %c0_i32 : i32
    %_regs_WIRE_31 = sv.wire sym @sym_38 {hw.verilogName = "_regs_WIRE_31"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_31, %c0_i32 : i32
    %_regs_WIRE_32 = sv.wire sym @sym_39 {hw.verilogName = "_regs_WIRE_32"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_32, %c0_i32 : i32
    %_regs_WIRE_33 = sv.wire sym @sym_40 {hw.verilogName = "_regs_WIRE_33"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_33, %c0_i32 : i32
    %_regs_WIRE_34 = sv.wire sym @sym_41 {hw.verilogName = "_regs_WIRE_34"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_34, %c0_i32 : i32
    %_regs_WIRE_35 = sv.wire sym @sym_42 {hw.verilogName = "_regs_WIRE_35"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_35, %c0_i32 : i32
    %_regs_WIRE_36 = sv.wire sym @sym_43 {hw.verilogName = "_regs_WIRE_36"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_36, %c0_i32 : i32
    %_regs_WIRE_37 = sv.wire sym @sym_44 {hw.verilogName = "_regs_WIRE_37"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_37, %c0_i32 : i32
    %_regs_WIRE_38 = sv.wire sym @sym_45 {hw.verilogName = "_regs_WIRE_38"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_38, %c0_i32 : i32
    %_regs_WIRE_39 = sv.wire sym @sym_46 {hw.verilogName = "_regs_WIRE_39"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_39, %c0_i32 : i32
    %_regs_WIRE_40 = sv.wire sym @sym_47 {hw.verilogName = "_regs_WIRE_40"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_40, %c0_i32 : i32
    %_regs_WIRE_41 = sv.wire sym @sym_48 {hw.verilogName = "_regs_WIRE_41"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_41, %c0_i32 : i32
    %_regs_WIRE_42 = sv.wire sym @sym_49 {hw.verilogName = "_regs_WIRE_42"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_42, %c0_i32 : i32
    %_regs_WIRE_43 = sv.wire sym @sym_50 {hw.verilogName = "_regs_WIRE_43"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_43, %c0_i32 : i32
    %_regs_WIRE_44 = sv.wire sym @sym_51 {hw.verilogName = "_regs_WIRE_44"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_44, %c0_i32 : i32
    %_regs_WIRE_45 = sv.wire sym @sym_52 {hw.verilogName = "_regs_WIRE_45"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_45, %c0_i32 : i32
    %_regs_WIRE_46 = sv.wire sym @sym_53 {hw.verilogName = "_regs_WIRE_46"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_46, %c0_i32 : i32
    %_regs_WIRE_47 = sv.wire sym @sym_54 {hw.verilogName = "_regs_WIRE_47"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_47, %c0_i32 : i32
    %_regs_WIRE_48 = sv.wire sym @sym_55 {hw.verilogName = "_regs_WIRE_48"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_48, %c0_i32 : i32
    %_regs_WIRE_49 = sv.wire sym @sym_56 {hw.verilogName = "_regs_WIRE_49"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_49, %c0_i32 : i32
    %_regs_WIRE_50 = sv.wire sym @sym_57 {hw.verilogName = "_regs_WIRE_50"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_50, %c0_i32 : i32
    %_regs_WIRE_51 = sv.wire sym @sym_58 {hw.verilogName = "_regs_WIRE_51"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_51, %c0_i32 : i32
    %_regs_WIRE_52 = sv.wire sym @sym_59 {hw.verilogName = "_regs_WIRE_52"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_52, %c0_i32 : i32
    %_regs_WIRE_53 = sv.wire sym @sym_60 {hw.verilogName = "_regs_WIRE_53"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_53, %c0_i32 : i32
    %_regs_WIRE_54 = sv.wire sym @sym_61 {hw.verilogName = "_regs_WIRE_54"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_54, %c0_i32 : i32
    %_regs_WIRE_55 = sv.wire sym @sym_62 {hw.verilogName = "_regs_WIRE_55"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_55, %c0_i32 : i32
    %_regs_WIRE_56 = sv.wire sym @sym_63 {hw.verilogName = "_regs_WIRE_56"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_56, %c0_i32 : i32
    %_regs_WIRE_57 = sv.wire sym @sym_64 {hw.verilogName = "_regs_WIRE_57"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_57, %c0_i32 : i32
    %_regs_WIRE_58 = sv.wire sym @sym_65 {hw.verilogName = "_regs_WIRE_58"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_58, %c0_i32 : i32
    %_regs_WIRE_59 = sv.wire sym @sym_66 {hw.verilogName = "_regs_WIRE_59"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_59, %c0_i32 : i32
    %_regs_WIRE_60 = sv.wire sym @sym_67 {hw.verilogName = "_regs_WIRE_60"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_60, %c0_i32 : i32
    %_regs_WIRE_61 = sv.wire sym @sym_68 {hw.verilogName = "_regs_WIRE_61"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_61, %c0_i32 : i32
    %_regs_WIRE_62 = sv.wire sym @sym_69 {hw.verilogName = "_regs_WIRE_62"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_62, %c0_i32 : i32
    %_regs_WIRE_63 = sv.wire sym @sym_70 {hw.verilogName = "_regs_WIRE_63"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_63, %c0_i32 : i32
    %_regs_WIRE_64 = sv.wire sym @sym_71 {hw.verilogName = "_regs_WIRE_64"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_64, %c0_i32 : i32
    %_regs_WIRE_65 = sv.wire sym @sym_72 {hw.verilogName = "_regs_WIRE_65"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_65, %c0_i32 : i32
    %_regs_WIRE_66 = sv.wire sym @sym_73 {hw.verilogName = "_regs_WIRE_66"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_66, %c0_i32 : i32
    %_regs_WIRE_67 = sv.wire sym @sym_74 {hw.verilogName = "_regs_WIRE_67"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_67, %c0_i32 : i32
    %_regs_WIRE_68 = sv.wire sym @sym_75 {hw.verilogName = "_regs_WIRE_68"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_68, %c0_i32 : i32
    %_regs_WIRE_69 = sv.wire sym @sym_76 {hw.verilogName = "_regs_WIRE_69"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_69, %c0_i32 : i32
    %_regs_WIRE_70 = sv.wire sym @sym_77 {hw.verilogName = "_regs_WIRE_70"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_70, %c0_i32 : i32
    %_regs_WIRE_71 = sv.wire sym @sym_78 {hw.verilogName = "_regs_WIRE_71"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_71, %c0_i32 : i32
    %_regs_WIRE_72 = sv.wire sym @sym_79 {hw.verilogName = "_regs_WIRE_72"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_72, %c0_i32 : i32
    %_regs_WIRE_73 = sv.wire sym @sym_80 {hw.verilogName = "_regs_WIRE_73"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_73, %c0_i32 : i32
    %_regs_WIRE_74 = sv.wire sym @sym_81 {hw.verilogName = "_regs_WIRE_74"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_74, %c0_i32 : i32
    %_regs_WIRE_75 = sv.wire sym @sym_82 {hw.verilogName = "_regs_WIRE_75"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_75, %c0_i32 : i32
    %_regs_WIRE_76 = sv.wire sym @sym_83 {hw.verilogName = "_regs_WIRE_76"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_76, %c0_i32 : i32
    %_regs_WIRE_77 = sv.wire sym @sym_84 {hw.verilogName = "_regs_WIRE_77"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_77, %c0_i32 : i32
    %_regs_WIRE_78 = sv.wire sym @sym_85 {hw.verilogName = "_regs_WIRE_78"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_78, %c0_i32 : i32
    %_regs_WIRE_79 = sv.wire sym @sym_86 {hw.verilogName = "_regs_WIRE_79"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_79, %c0_i32 : i32
    %_regs_WIRE_80 = sv.wire sym @sym_87 {hw.verilogName = "_regs_WIRE_80"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_80, %c0_i32 : i32
    %_regs_WIRE_81 = sv.wire sym @sym_88 {hw.verilogName = "_regs_WIRE_81"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_81, %c0_i32 : i32
    %_regs_WIRE_82 = sv.wire sym @sym_89 {hw.verilogName = "_regs_WIRE_82"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_82, %c0_i32 : i32
    %_regs_WIRE_83 = sv.wire sym @sym_90 {hw.verilogName = "_regs_WIRE_83"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_83, %c0_i32 : i32
    %_regs_WIRE_84 = sv.wire sym @sym_91 {hw.verilogName = "_regs_WIRE_84"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_84, %c0_i32 : i32
    %_regs_WIRE_85 = sv.wire sym @sym_92 {hw.verilogName = "_regs_WIRE_85"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_85, %c0_i32 : i32
    %_regs_WIRE_86 = sv.wire sym @sym_93 {hw.verilogName = "_regs_WIRE_86"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_86, %c0_i32 : i32
    %_regs_WIRE_87 = sv.wire sym @sym_94 {hw.verilogName = "_regs_WIRE_87"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_87, %c0_i32 : i32
    %_regs_WIRE_88 = sv.wire sym @sym_95 {hw.verilogName = "_regs_WIRE_88"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_88, %c0_i32 : i32
    %_regs_WIRE_89 = sv.wire sym @sym_96 {hw.verilogName = "_regs_WIRE_89"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_89, %c0_i32 : i32
    %_regs_WIRE_90 = sv.wire sym @sym_97 {hw.verilogName = "_regs_WIRE_90"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_90, %c0_i32 : i32
    %_regs_WIRE_91 = sv.wire sym @sym_98 {hw.verilogName = "_regs_WIRE_91"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_91, %c0_i32 : i32
    %_regs_WIRE_92 = sv.wire sym @sym_99 {hw.verilogName = "_regs_WIRE_92"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_92, %c0_i32 : i32
    %_regs_WIRE_93 = sv.wire sym @sym_100 {hw.verilogName = "_regs_WIRE_93"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_93, %c0_i32 : i32
    %_regs_WIRE_94 = sv.wire sym @sym_101 {hw.verilogName = "_regs_WIRE_94"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_94, %c0_i32 : i32
    %_regs_WIRE_95 = sv.wire sym @sym_102 {hw.verilogName = "_regs_WIRE_95"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_95, %c0_i32 : i32
    %_regs_WIRE_96 = sv.wire sym @sym_103 {hw.verilogName = "_regs_WIRE_96"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_96, %c0_i32 : i32
    %_regs_WIRE_97 = sv.wire sym @sym_104 {hw.verilogName = "_regs_WIRE_97"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_97, %c0_i32 : i32
    %_regs_WIRE_98 = sv.wire sym @sym_105 {hw.verilogName = "_regs_WIRE_98"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_98, %c0_i32 : i32
    %_regs_WIRE_99 = sv.wire sym @sym_106 {hw.verilogName = "_regs_WIRE_99"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_99, %c0_i32 : i32
    %_regs_WIRE_100 = sv.wire sym @sym_107 {hw.verilogName = "_regs_WIRE_100"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_100, %c0_i32 : i32
    %_regs_WIRE_101 = sv.wire sym @sym_108 {hw.verilogName = "_regs_WIRE_101"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_101, %c0_i32 : i32
    %_regs_WIRE_102 = sv.wire sym @sym_109 {hw.verilogName = "_regs_WIRE_102"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_102, %c0_i32 : i32
    %_regs_WIRE_103 = sv.wire sym @sym_110 {hw.verilogName = "_regs_WIRE_103"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_103, %c0_i32 : i32
    %_regs_WIRE_104 = sv.wire sym @sym_111 {hw.verilogName = "_regs_WIRE_104"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_104, %c0_i32 : i32
    %_regs_WIRE_105 = sv.wire sym @sym_112 {hw.verilogName = "_regs_WIRE_105"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_105, %c0_i32 : i32
    %_regs_WIRE_106 = sv.wire sym @sym_113 {hw.verilogName = "_regs_WIRE_106"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_106, %c0_i32 : i32
    %_regs_WIRE_107 = sv.wire sym @sym_114 {hw.verilogName = "_regs_WIRE_107"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_107, %c0_i32 : i32
    %_regs_WIRE_108 = sv.wire sym @sym_115 {hw.verilogName = "_regs_WIRE_108"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_108, %c0_i32 : i32
    %_regs_WIRE_109 = sv.wire sym @sym_116 {hw.verilogName = "_regs_WIRE_109"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_109, %c0_i32 : i32
    %_regs_WIRE_110 = sv.wire sym @sym_117 {hw.verilogName = "_regs_WIRE_110"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_110, %c0_i32 : i32
    %_regs_WIRE_111 = sv.wire sym @sym_118 {hw.verilogName = "_regs_WIRE_111"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_111, %c0_i32 : i32
    %_regs_WIRE_112 = sv.wire sym @sym_119 {hw.verilogName = "_regs_WIRE_112"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_112, %c0_i32 : i32
    %_regs_WIRE_113 = sv.wire sym @sym_120 {hw.verilogName = "_regs_WIRE_113"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_113, %c0_i32 : i32
    %_regs_WIRE_114 = sv.wire sym @sym_121 {hw.verilogName = "_regs_WIRE_114"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_114, %c0_i32 : i32
    %_regs_WIRE_115 = sv.wire sym @sym_122 {hw.verilogName = "_regs_WIRE_115"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_115, %c0_i32 : i32
    %_regs_WIRE_116 = sv.wire sym @sym_123 {hw.verilogName = "_regs_WIRE_116"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_116, %c0_i32 : i32
    %_regs_WIRE_117 = sv.wire sym @sym_124 {hw.verilogName = "_regs_WIRE_117"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_117, %c0_i32 : i32
    %_regs_WIRE_118 = sv.wire sym @sym_125 {hw.verilogName = "_regs_WIRE_118"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_118, %c0_i32 : i32
    %_regs_WIRE_119 = sv.wire sym @sym_126 {hw.verilogName = "_regs_WIRE_119"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_119, %c0_i32 : i32
    %_regs_WIRE_120 = sv.wire sym @sym_127 {hw.verilogName = "_regs_WIRE_120"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_120, %c0_i32 : i32
    %_regs_WIRE_121 = sv.wire sym @sym_128 {hw.verilogName = "_regs_WIRE_121"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_121, %c0_i32 : i32
    %_regs_WIRE_122 = sv.wire sym @sym_129 {hw.verilogName = "_regs_WIRE_122"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_122, %c0_i32 : i32
    %_regs_WIRE_123 = sv.wire sym @sym_130 {hw.verilogName = "_regs_WIRE_123"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_123, %c0_i32 : i32
    %_regs_WIRE_124 = sv.wire sym @sym_131 {hw.verilogName = "_regs_WIRE_124"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_124, %c0_i32 : i32
    %_regs_WIRE_125 = sv.wire sym @sym_132 {hw.verilogName = "_regs_WIRE_125"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_125, %c0_i32 : i32
    %_regs_WIRE_126 = sv.wire sym @sym_133 {hw.verilogName = "_regs_WIRE_126"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_126, %c0_i32 : i32
    %_regs_WIRE_127 = sv.wire sym @sym_134 {hw.verilogName = "_regs_WIRE_127"} : !hw.inout<i32>
    sv.assign %_regs_WIRE_127, %c0_i32 : i32
    %regs_0 = sv.reg sym @sym_135 {hw.verilogName = "regs_0"} : !hw.inout<i32> 
    %regs_1 = sv.reg sym @sym_136 {hw.verilogName = "regs_1"} : !hw.inout<i32> 
    %regs_2 = sv.reg sym @sym_137 {hw.verilogName = "regs_2"} : !hw.inout<i32> 
    %regs_3 = sv.reg sym @sym_138 {hw.verilogName = "regs_3"} : !hw.inout<i32> 
    %regs_4 = sv.reg sym @sym_139 {hw.verilogName = "regs_4"} : !hw.inout<i32> 
    %regs_5 = sv.reg sym @sym_140 {hw.verilogName = "regs_5"} : !hw.inout<i32> 
    %regs_6 = sv.reg sym @sym_141 {hw.verilogName = "regs_6"} : !hw.inout<i32> 
    %regs_7 = sv.reg sym @sym_142 {hw.verilogName = "regs_7"} : !hw.inout<i32> 
    %regs_8 = sv.reg sym @sym_143 {hw.verilogName = "regs_8"} : !hw.inout<i32> 
    %regs_9 = sv.reg sym @sym_144 {hw.verilogName = "regs_9"} : !hw.inout<i32> 
    %regs_10 = sv.reg sym @sym_145 {hw.verilogName = "regs_10"} : !hw.inout<i32> 
    %regs_11 = sv.reg sym @sym_146 {hw.verilogName = "regs_11"} : !hw.inout<i32> 
    %regs_12 = sv.reg sym @sym_147 {hw.verilogName = "regs_12"} : !hw.inout<i32> 
    %regs_13 = sv.reg sym @sym_148 {hw.verilogName = "regs_13"} : !hw.inout<i32> 
    %regs_14 = sv.reg sym @sym_149 {hw.verilogName = "regs_14"} : !hw.inout<i32> 
    %regs_15 = sv.reg sym @sym_150 {hw.verilogName = "regs_15"} : !hw.inout<i32> 
    %regs_16 = sv.reg sym @sym_151 {hw.verilogName = "regs_16"} : !hw.inout<i32> 
    %regs_17 = sv.reg sym @sym_152 {hw.verilogName = "regs_17"} : !hw.inout<i32> 
    %regs_18 = sv.reg sym @sym_153 {hw.verilogName = "regs_18"} : !hw.inout<i32> 
    %regs_19 = sv.reg sym @sym_154 {hw.verilogName = "regs_19"} : !hw.inout<i32> 
    %regs_20 = sv.reg sym @sym_155 {hw.verilogName = "regs_20"} : !hw.inout<i32> 
    %regs_21 = sv.reg sym @sym_156 {hw.verilogName = "regs_21"} : !hw.inout<i32> 
    %regs_22 = sv.reg sym @sym_157 {hw.verilogName = "regs_22"} : !hw.inout<i32> 
    %regs_23 = sv.reg sym @sym_158 {hw.verilogName = "regs_23"} : !hw.inout<i32> 
    %regs_24 = sv.reg sym @sym_159 {hw.verilogName = "regs_24"} : !hw.inout<i32> 
    %regs_25 = sv.reg sym @sym_160 {hw.verilogName = "regs_25"} : !hw.inout<i32> 
    %regs_26 = sv.reg sym @sym_161 {hw.verilogName = "regs_26"} : !hw.inout<i32> 
    %regs_27 = sv.reg sym @sym_162 {hw.verilogName = "regs_27"} : !hw.inout<i32> 
    %regs_28 = sv.reg sym @sym_163 {hw.verilogName = "regs_28"} : !hw.inout<i32> 
    %regs_29 = sv.reg sym @sym_164 {hw.verilogName = "regs_29"} : !hw.inout<i32> 
    %regs_30 = sv.reg sym @sym_165 {hw.verilogName = "regs_30"} : !hw.inout<i32> 
    %regs_31 = sv.reg sym @sym_166 {hw.verilogName = "regs_31"} : !hw.inout<i32> 
    %regs_32 = sv.reg sym @sym_167 {hw.verilogName = "regs_32"} : !hw.inout<i32> 
    %regs_33 = sv.reg sym @sym_168 {hw.verilogName = "regs_33"} : !hw.inout<i32> 
    %regs_34 = sv.reg sym @sym_169 {hw.verilogName = "regs_34"} : !hw.inout<i32> 
    %regs_35 = sv.reg sym @sym_170 {hw.verilogName = "regs_35"} : !hw.inout<i32> 
    %regs_36 = sv.reg sym @sym_171 {hw.verilogName = "regs_36"} : !hw.inout<i32> 
    %regs_37 = sv.reg sym @sym_172 {hw.verilogName = "regs_37"} : !hw.inout<i32> 
    %regs_38 = sv.reg sym @sym_173 {hw.verilogName = "regs_38"} : !hw.inout<i32> 
    %regs_39 = sv.reg sym @sym_174 {hw.verilogName = "regs_39"} : !hw.inout<i32> 
    %regs_40 = sv.reg sym @sym_175 {hw.verilogName = "regs_40"} : !hw.inout<i32> 
    %regs_41 = sv.reg sym @sym_176 {hw.verilogName = "regs_41"} : !hw.inout<i32> 
    %regs_42 = sv.reg sym @sym_177 {hw.verilogName = "regs_42"} : !hw.inout<i32> 
    %regs_43 = sv.reg sym @sym_178 {hw.verilogName = "regs_43"} : !hw.inout<i32> 
    %regs_44 = sv.reg sym @sym_179 {hw.verilogName = "regs_44"} : !hw.inout<i32> 
    %regs_45 = sv.reg sym @sym_180 {hw.verilogName = "regs_45"} : !hw.inout<i32> 
    %regs_46 = sv.reg sym @sym_181 {hw.verilogName = "regs_46"} : !hw.inout<i32> 
    %regs_47 = sv.reg sym @sym_182 {hw.verilogName = "regs_47"} : !hw.inout<i32> 
    %regs_48 = sv.reg sym @sym_183 {hw.verilogName = "regs_48"} : !hw.inout<i32> 
    %regs_49 = sv.reg sym @sym_184 {hw.verilogName = "regs_49"} : !hw.inout<i32> 
    %regs_50 = sv.reg sym @sym_185 {hw.verilogName = "regs_50"} : !hw.inout<i32> 
    %regs_51 = sv.reg sym @sym_186 {hw.verilogName = "regs_51"} : !hw.inout<i32> 
    %regs_52 = sv.reg sym @sym_187 {hw.verilogName = "regs_52"} : !hw.inout<i32> 
    %regs_53 = sv.reg sym @sym_188 {hw.verilogName = "regs_53"} : !hw.inout<i32> 
    %regs_54 = sv.reg sym @sym_189 {hw.verilogName = "regs_54"} : !hw.inout<i32> 
    %regs_55 = sv.reg sym @sym_190 {hw.verilogName = "regs_55"} : !hw.inout<i32> 
    %regs_56 = sv.reg sym @sym_191 {hw.verilogName = "regs_56"} : !hw.inout<i32> 
    %regs_57 = sv.reg sym @sym_192 {hw.verilogName = "regs_57"} : !hw.inout<i32> 
    %regs_58 = sv.reg sym @sym_193 {hw.verilogName = "regs_58"} : !hw.inout<i32> 
    %regs_59 = sv.reg sym @sym_194 {hw.verilogName = "regs_59"} : !hw.inout<i32> 
    %regs_60 = sv.reg sym @sym_195 {hw.verilogName = "regs_60"} : !hw.inout<i32> 
    %regs_61 = sv.reg sym @sym_196 {hw.verilogName = "regs_61"} : !hw.inout<i32> 
    %regs_62 = sv.reg sym @sym_197 {hw.verilogName = "regs_62"} : !hw.inout<i32> 
    %regs_63 = sv.reg sym @sym_198 {hw.verilogName = "regs_63"} : !hw.inout<i32> 
    %regs_64 = sv.reg sym @sym_199 {hw.verilogName = "regs_64"} : !hw.inout<i32> 
    %regs_65 = sv.reg sym @sym_200 {hw.verilogName = "regs_65"} : !hw.inout<i32> 
    %regs_66 = sv.reg sym @sym_201 {hw.verilogName = "regs_66"} : !hw.inout<i32> 
    %regs_67 = sv.reg sym @sym_202 {hw.verilogName = "regs_67"} : !hw.inout<i32> 
    %regs_68 = sv.reg sym @sym_203 {hw.verilogName = "regs_68"} : !hw.inout<i32> 
    %regs_69 = sv.reg sym @sym_204 {hw.verilogName = "regs_69"} : !hw.inout<i32> 
    %regs_70 = sv.reg sym @sym_205 {hw.verilogName = "regs_70"} : !hw.inout<i32> 
    %regs_71 = sv.reg sym @sym_206 {hw.verilogName = "regs_71"} : !hw.inout<i32> 
    %regs_72 = sv.reg sym @sym_207 {hw.verilogName = "regs_72"} : !hw.inout<i32> 
    %regs_73 = sv.reg sym @sym_208 {hw.verilogName = "regs_73"} : !hw.inout<i32> 
    %regs_74 = sv.reg sym @sym_209 {hw.verilogName = "regs_74"} : !hw.inout<i32> 
    %regs_75 = sv.reg sym @sym_210 {hw.verilogName = "regs_75"} : !hw.inout<i32> 
    %regs_76 = sv.reg sym @sym_211 {hw.verilogName = "regs_76"} : !hw.inout<i32> 
    %regs_77 = sv.reg sym @sym_212 {hw.verilogName = "regs_77"} : !hw.inout<i32> 
    %regs_78 = sv.reg sym @sym_213 {hw.verilogName = "regs_78"} : !hw.inout<i32> 
    %regs_79 = sv.reg sym @sym_214 {hw.verilogName = "regs_79"} : !hw.inout<i32> 
    %regs_80 = sv.reg sym @sym_215 {hw.verilogName = "regs_80"} : !hw.inout<i32> 
    %regs_81 = sv.reg sym @sym_216 {hw.verilogName = "regs_81"} : !hw.inout<i32> 
    %regs_82 = sv.reg sym @sym_217 {hw.verilogName = "regs_82"} : !hw.inout<i32> 
    %regs_83 = sv.reg sym @sym_218 {hw.verilogName = "regs_83"} : !hw.inout<i32> 
    %regs_84 = sv.reg sym @sym_219 {hw.verilogName = "regs_84"} : !hw.inout<i32> 
    %regs_85 = sv.reg sym @sym_220 {hw.verilogName = "regs_85"} : !hw.inout<i32> 
    %regs_86 = sv.reg sym @sym_221 {hw.verilogName = "regs_86"} : !hw.inout<i32> 
    %regs_87 = sv.reg sym @sym_222 {hw.verilogName = "regs_87"} : !hw.inout<i32> 
    %regs_88 = sv.reg sym @sym_223 {hw.verilogName = "regs_88"} : !hw.inout<i32> 
    %regs_89 = sv.reg sym @sym_224 {hw.verilogName = "regs_89"} : !hw.inout<i32> 
    %regs_90 = sv.reg sym @sym_225 {hw.verilogName = "regs_90"} : !hw.inout<i32> 
    %regs_91 = sv.reg sym @sym_226 {hw.verilogName = "regs_91"} : !hw.inout<i32> 
    %regs_92 = sv.reg sym @sym_227 {hw.verilogName = "regs_92"} : !hw.inout<i32> 
    %regs_93 = sv.reg sym @sym_228 {hw.verilogName = "regs_93"} : !hw.inout<i32> 
    %regs_94 = sv.reg sym @sym_229 {hw.verilogName = "regs_94"} : !hw.inout<i32> 
    %regs_95 = sv.reg sym @sym_230 {hw.verilogName = "regs_95"} : !hw.inout<i32> 
    %regs_96 = sv.reg sym @sym_231 {hw.verilogName = "regs_96"} : !hw.inout<i32> 
    %regs_97 = sv.reg sym @sym_232 {hw.verilogName = "regs_97"} : !hw.inout<i32> 
    %regs_98 = sv.reg sym @sym_233 {hw.verilogName = "regs_98"} : !hw.inout<i32> 
    %regs_99 = sv.reg sym @sym_234 {hw.verilogName = "regs_99"} : !hw.inout<i32> 
    %regs_100 = sv.reg sym @sym_235 {hw.verilogName = "regs_100"} : !hw.inout<i32> 
    %regs_101 = sv.reg sym @sym_236 {hw.verilogName = "regs_101"} : !hw.inout<i32> 
    %regs_102 = sv.reg sym @sym_237 {hw.verilogName = "regs_102"} : !hw.inout<i32> 
    %regs_103 = sv.reg sym @sym_238 {hw.verilogName = "regs_103"} : !hw.inout<i32> 
    %regs_104 = sv.reg sym @sym_239 {hw.verilogName = "regs_104"} : !hw.inout<i32> 
    %regs_105 = sv.reg sym @sym_240 {hw.verilogName = "regs_105"} : !hw.inout<i32> 
    %regs_106 = sv.reg sym @sym_241 {hw.verilogName = "regs_106"} : !hw.inout<i32> 
    %regs_107 = sv.reg sym @sym_242 {hw.verilogName = "regs_107"} : !hw.inout<i32> 
    %regs_108 = sv.reg sym @sym_243 {hw.verilogName = "regs_108"} : !hw.inout<i32> 
    %regs_109 = sv.reg sym @sym_244 {hw.verilogName = "regs_109"} : !hw.inout<i32> 
    %regs_110 = sv.reg sym @sym_245 {hw.verilogName = "regs_110"} : !hw.inout<i32> 
    %regs_111 = sv.reg sym @sym_246 {hw.verilogName = "regs_111"} : !hw.inout<i32> 
    %regs_112 = sv.reg sym @sym_247 {hw.verilogName = "regs_112"} : !hw.inout<i32> 
    %regs_113 = sv.reg sym @sym_248 {hw.verilogName = "regs_113"} : !hw.inout<i32> 
    %regs_114 = sv.reg sym @sym_249 {hw.verilogName = "regs_114"} : !hw.inout<i32> 
    %regs_115 = sv.reg sym @sym_250 {hw.verilogName = "regs_115"} : !hw.inout<i32> 
    %regs_116 = sv.reg sym @sym_251 {hw.verilogName = "regs_116"} : !hw.inout<i32> 
    %regs_117 = sv.reg sym @sym_252 {hw.verilogName = "regs_117"} : !hw.inout<i32> 
    %regs_118 = sv.reg sym @sym_253 {hw.verilogName = "regs_118"} : !hw.inout<i32> 
    %regs_119 = sv.reg sym @sym_254 {hw.verilogName = "regs_119"} : !hw.inout<i32> 
    %regs_120 = sv.reg sym @sym_255 {hw.verilogName = "regs_120"} : !hw.inout<i32> 
    %regs_121 = sv.reg sym @sym_256 {hw.verilogName = "regs_121"} : !hw.inout<i32> 
    %regs_122 = sv.reg sym @sym_257 {hw.verilogName = "regs_122"} : !hw.inout<i32> 
    %regs_123 = sv.reg sym @sym_258 {hw.verilogName = "regs_123"} : !hw.inout<i32> 
    %regs_124 = sv.reg sym @sym_259 {hw.verilogName = "regs_124"} : !hw.inout<i32> 
    %regs_125 = sv.reg sym @sym_260 {hw.verilogName = "regs_125"} : !hw.inout<i32> 
    %regs_126 = sv.reg sym @sym_261 {hw.verilogName = "regs_126"} : !hw.inout<i32> 
    %regs_127 = sv.reg sym @sym_262 {hw.verilogName = "regs_127"} : !hw.inout<i32> 
    %0 = sv.read_inout %io_src1_1 : !hw.inout<i5>
    %1 = sv.read_inout %io_threadID_0 : !hw.inout<i2>
    %2 = comb.concat %1, %0 : i2, i5
    %effectiveSrc1 = sv.wire sym @sym_263 {hw.verilogName = "effectiveSrc1"} : !hw.inout<i7>
    sv.assign %effectiveSrc1, %2 : i7
    %3 = sv.read_inout %io_src2_2 : !hw.inout<i5>
    %4 = sv.read_inout %io_threadID_0 : !hw.inout<i2>
    %5 = comb.concat %4, %3 : i2, i5
    %effectiveSrc2 = sv.wire sym @sym_264 {hw.verilogName = "effectiveSrc2"} : !hw.inout<i7>
    sv.assign %effectiveSrc2, %5 : i7
    %6 = sv.read_inout %io_threadID_0 : !hw.inout<i2>
    %7 = sv.read_inout %io_dst1_3 : !hw.inout<i5>
    %8 = comb.concat %6, %7 : i2, i5
    %effectiveDst1 = sv.wire sym @sym_265 {hw.verilogName = "effectiveDst1"} : !hw.inout<i7>
    sv.assign %effectiveDst1, %8 : i7
    %9 = sv.read_inout %regs_0 : !hw.inout<i32>
    %10 = sv.read_inout %regs_1 : !hw.inout<i32>
    %11 = sv.read_inout %regs_2 : !hw.inout<i32>
    %12 = sv.read_inout %regs_3 : !hw.inout<i32>
    %13 = sv.read_inout %regs_4 : !hw.inout<i32>
    %14 = sv.read_inout %regs_5 : !hw.inout<i32>
    %15 = sv.read_inout %regs_6 : !hw.inout<i32>
    %16 = sv.read_inout %regs_7 : !hw.inout<i32>
    %17 = sv.read_inout %regs_8 : !hw.inout<i32>
    %18 = sv.read_inout %regs_9 : !hw.inout<i32>
    %19 = sv.read_inout %regs_10 : !hw.inout<i32>
    %20 = sv.read_inout %regs_11 : !hw.inout<i32>
    %21 = sv.read_inout %regs_12 : !hw.inout<i32>
    %22 = sv.read_inout %regs_13 : !hw.inout<i32>
    %23 = sv.read_inout %regs_14 : !hw.inout<i32>
    %24 = sv.read_inout %regs_15 : !hw.inout<i32>
    %25 = sv.read_inout %regs_16 : !hw.inout<i32>
    %26 = sv.read_inout %regs_17 : !hw.inout<i32>
    %27 = sv.read_inout %regs_18 : !hw.inout<i32>
    %28 = sv.read_inout %regs_19 : !hw.inout<i32>
    %29 = sv.read_inout %regs_20 : !hw.inout<i32>
    %30 = sv.read_inout %regs_21 : !hw.inout<i32>
    %31 = sv.read_inout %regs_22 : !hw.inout<i32>
    %32 = sv.read_inout %regs_23 : !hw.inout<i32>
    %33 = sv.read_inout %regs_24 : !hw.inout<i32>
    %34 = sv.read_inout %regs_25 : !hw.inout<i32>
    %35 = sv.read_inout %regs_26 : !hw.inout<i32>
    %36 = sv.read_inout %regs_27 : !hw.inout<i32>
    %37 = sv.read_inout %regs_28 : !hw.inout<i32>
    %38 = sv.read_inout %regs_29 : !hw.inout<i32>
    %39 = sv.read_inout %regs_30 : !hw.inout<i32>
    %40 = sv.read_inout %regs_31 : !hw.inout<i32>
    %41 = sv.read_inout %regs_32 : !hw.inout<i32>
    %42 = sv.read_inout %regs_33 : !hw.inout<i32>
    %43 = sv.read_inout %regs_34 : !hw.inout<i32>
    %44 = sv.read_inout %regs_35 : !hw.inout<i32>
    %45 = sv.read_inout %regs_36 : !hw.inout<i32>
    %46 = sv.read_inout %regs_37 : !hw.inout<i32>
    %47 = sv.read_inout %regs_38 : !hw.inout<i32>
    %48 = sv.read_inout %regs_39 : !hw.inout<i32>
    %49 = sv.read_inout %regs_40 : !hw.inout<i32>
    %50 = sv.read_inout %regs_41 : !hw.inout<i32>
    %51 = sv.read_inout %regs_42 : !hw.inout<i32>
    %52 = sv.read_inout %regs_43 : !hw.inout<i32>
    %53 = sv.read_inout %regs_44 : !hw.inout<i32>
    %54 = sv.read_inout %regs_45 : !hw.inout<i32>
    %55 = sv.read_inout %regs_46 : !hw.inout<i32>
    %56 = sv.read_inout %regs_47 : !hw.inout<i32>
    %57 = sv.read_inout %regs_48 : !hw.inout<i32>
    %58 = sv.read_inout %regs_49 : !hw.inout<i32>
    %59 = sv.read_inout %regs_50 : !hw.inout<i32>
    %60 = sv.read_inout %regs_51 : !hw.inout<i32>
    %61 = sv.read_inout %regs_52 : !hw.inout<i32>
    %62 = sv.read_inout %regs_53 : !hw.inout<i32>
    %63 = sv.read_inout %regs_54 : !hw.inout<i32>
    %64 = sv.read_inout %regs_55 : !hw.inout<i32>
    %65 = sv.read_inout %regs_56 : !hw.inout<i32>
    %66 = sv.read_inout %regs_57 : !hw.inout<i32>
    %67 = sv.read_inout %regs_58 : !hw.inout<i32>
    %68 = sv.read_inout %regs_59 : !hw.inout<i32>
    %69 = sv.read_inout %regs_60 : !hw.inout<i32>
    %70 = sv.read_inout %regs_61 : !hw.inout<i32>
    %71 = sv.read_inout %regs_62 : !hw.inout<i32>
    %72 = sv.read_inout %regs_63 : !hw.inout<i32>
    %73 = sv.read_inout %regs_64 : !hw.inout<i32>
    %74 = sv.read_inout %regs_65 : !hw.inout<i32>
    %75 = sv.read_inout %regs_66 : !hw.inout<i32>
    %76 = sv.read_inout %regs_67 : !hw.inout<i32>
    %77 = sv.read_inout %regs_68 : !hw.inout<i32>
    %78 = sv.read_inout %regs_69 : !hw.inout<i32>
    %79 = sv.read_inout %regs_70 : !hw.inout<i32>
    %80 = sv.read_inout %regs_71 : !hw.inout<i32>
    %81 = sv.read_inout %regs_72 : !hw.inout<i32>
    %82 = sv.read_inout %regs_73 : !hw.inout<i32>
    %83 = sv.read_inout %regs_74 : !hw.inout<i32>
    %84 = sv.read_inout %regs_75 : !hw.inout<i32>
    %85 = sv.read_inout %regs_76 : !hw.inout<i32>
    %86 = sv.read_inout %regs_77 : !hw.inout<i32>
    %87 = sv.read_inout %regs_78 : !hw.inout<i32>
    %88 = sv.read_inout %regs_79 : !hw.inout<i32>
    %89 = sv.read_inout %regs_80 : !hw.inout<i32>
    %90 = sv.read_inout %regs_81 : !hw.inout<i32>
    %91 = sv.read_inout %regs_82 : !hw.inout<i32>
    %92 = sv.read_inout %regs_83 : !hw.inout<i32>
    %93 = sv.read_inout %regs_84 : !hw.inout<i32>
    %94 = sv.read_inout %regs_85 : !hw.inout<i32>
    %95 = sv.read_inout %regs_86 : !hw.inout<i32>
    %96 = sv.read_inout %regs_87 : !hw.inout<i32>
    %97 = sv.read_inout %regs_88 : !hw.inout<i32>
    %98 = sv.read_inout %regs_89 : !hw.inout<i32>
    %99 = sv.read_inout %regs_90 : !hw.inout<i32>
    %100 = sv.read_inout %regs_91 : !hw.inout<i32>
    %101 = sv.read_inout %regs_92 : !hw.inout<i32>
    %102 = sv.read_inout %regs_93 : !hw.inout<i32>
    %103 = sv.read_inout %regs_94 : !hw.inout<i32>
    %104 = sv.read_inout %regs_95 : !hw.inout<i32>
    %105 = sv.read_inout %regs_96 : !hw.inout<i32>
    %106 = sv.read_inout %regs_97 : !hw.inout<i32>
    %107 = sv.read_inout %regs_98 : !hw.inout<i32>
    %108 = sv.read_inout %regs_99 : !hw.inout<i32>
    %109 = sv.read_inout %regs_100 : !hw.inout<i32>
    %110 = sv.read_inout %regs_101 : !hw.inout<i32>
    %111 = sv.read_inout %regs_102 : !hw.inout<i32>
    %112 = sv.read_inout %regs_103 : !hw.inout<i32>
    %113 = sv.read_inout %regs_104 : !hw.inout<i32>
    %114 = sv.read_inout %regs_105 : !hw.inout<i32>
    %115 = sv.read_inout %regs_106 : !hw.inout<i32>
    %116 = sv.read_inout %regs_107 : !hw.inout<i32>
    %117 = sv.read_inout %regs_108 : !hw.inout<i32>
    %118 = sv.read_inout %regs_109 : !hw.inout<i32>
    %119 = sv.read_inout %regs_110 : !hw.inout<i32>
    %120 = sv.read_inout %regs_111 : !hw.inout<i32>
    %121 = sv.read_inout %regs_112 : !hw.inout<i32>
    %122 = sv.read_inout %regs_113 : !hw.inout<i32>
    %123 = sv.read_inout %regs_114 : !hw.inout<i32>
    %124 = sv.read_inout %regs_115 : !hw.inout<i32>
    %125 = sv.read_inout %regs_116 : !hw.inout<i32>
    %126 = sv.read_inout %regs_117 : !hw.inout<i32>
    %127 = sv.read_inout %regs_118 : !hw.inout<i32>
    %128 = sv.read_inout %regs_119 : !hw.inout<i32>
    %129 = sv.read_inout %regs_120 : !hw.inout<i32>
    %130 = sv.read_inout %regs_121 : !hw.inout<i32>
    %131 = sv.read_inout %regs_122 : !hw.inout<i32>
    %132 = sv.read_inout %regs_123 : !hw.inout<i32>
    %133 = sv.read_inout %regs_124 : !hw.inout<i32>
    %134 = sv.read_inout %regs_125 : !hw.inout<i32>
    %135 = sv.read_inout %regs_126 : !hw.inout<i32>
    %136 = sv.read_inout %regs_127 : !hw.inout<i32>
    %137 = hw.array_create %136, %135, %134, %133, %132, %131, %130, %129, %128, %127, %126, %125, %124, %123, %122, %121, %120, %119, %118, %117, %116, %115, %114, %113, %112, %111, %110, %109, %108, %107, %106, %105, %104, %103, %102, %101, %100, %99, %98, %97, %96, %95, %94, %93, %92, %91, %90, %89, %88, %87, %86, %85, %84, %83, %82, %81, %80, %79, %78, %77, %76, %75, %74, %73, %72, %71, %70, %69, %68, %67, %66, %65, %64, %63, %62, %61, %60, %59, %58, %57, %56, %55, %54, %53, %52, %51, %50, %49, %48, %47, %46, %45, %44, %43, %42, %41, %40, %39, %38, %37, %36, %35, %34, %33, %32, %31, %30, %29, %28, %27, %26, %25, %24, %23, %22, %21, %20, %19, %18, %17, %16, %15, %14, %13, %12, %11, %10, %9 : i32
    %138 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<array<128xi32>>
    sv.assign %138, %137 : !hw.array<128xi32>
    %139 = sv.read_inout %effectiveSrc1 : !hw.inout<i7>
    %140 = sv.read_inout %138 : !hw.inout<array<128xi32>>
    %141 = hw.array_get %140[%139] : !hw.array<128xi32>, i7
    %io_src1data = sv.wire sym @sym_5 {hw.verilogName = "io_src1data_0"} : !hw.inout<i32>
    sv.assign %io_src1data, %141 : i32
    %142 = sv.read_inout %effectiveSrc2 : !hw.inout<i7>
    %143 = sv.read_inout %138 : !hw.inout<array<128xi32>>
    %144 = hw.array_get %143[%142] : !hw.array<128xi32>, i7
    %io_src2data = sv.wire sym @sym_6 {hw.verilogName = "io_src2data_0"} : !hw.inout<i32>
    sv.assign %io_src2data, %144 : i32
    sv.always posedge %clock {
      sv.if %reset {
        %c0_i32_6 = hw.constant 0 : i32
        sv.passign %regs_0, %c0_i32_6 : i32
        sv.passign %regs_1, %c0_i32_6 : i32
        sv.passign %regs_2, %c0_i32_6 : i32
        sv.passign %regs_3, %c0_i32_6 : i32
        sv.passign %regs_4, %c0_i32_6 : i32
        sv.passign %regs_5, %c0_i32_6 : i32
        sv.passign %regs_6, %c0_i32_6 : i32
        sv.passign %regs_7, %c0_i32_6 : i32
        sv.passign %regs_8, %c0_i32_6 : i32
        sv.passign %regs_9, %c0_i32_6 : i32
        sv.passign %regs_10, %c0_i32_6 : i32
        sv.passign %regs_11, %c0_i32_6 : i32
        sv.passign %regs_12, %c0_i32_6 : i32
        sv.passign %regs_13, %c0_i32_6 : i32
        sv.passign %regs_14, %c0_i32_6 : i32
        sv.passign %regs_15, %c0_i32_6 : i32
        sv.passign %regs_16, %c0_i32_6 : i32
        sv.passign %regs_17, %c0_i32_6 : i32
        sv.passign %regs_18, %c0_i32_6 : i32
        sv.passign %regs_19, %c0_i32_6 : i32
        sv.passign %regs_20, %c0_i32_6 : i32
        sv.passign %regs_21, %c0_i32_6 : i32
        sv.passign %regs_22, %c0_i32_6 : i32
        sv.passign %regs_23, %c0_i32_6 : i32
        sv.passign %regs_24, %c0_i32_6 : i32
        sv.passign %regs_25, %c0_i32_6 : i32
        sv.passign %regs_26, %c0_i32_6 : i32
        sv.passign %regs_27, %c0_i32_6 : i32
        sv.passign %regs_28, %c0_i32_6 : i32
        sv.passign %regs_29, %c0_i32_6 : i32
        sv.passign %regs_30, %c0_i32_6 : i32
        sv.passign %regs_31, %c0_i32_6 : i32
        sv.passign %regs_32, %c0_i32_6 : i32
        sv.passign %regs_33, %c0_i32_6 : i32
        sv.passign %regs_34, %c0_i32_6 : i32
        sv.passign %regs_35, %c0_i32_6 : i32
        sv.passign %regs_36, %c0_i32_6 : i32
        sv.passign %regs_37, %c0_i32_6 : i32
        sv.passign %regs_38, %c0_i32_6 : i32
        sv.passign %regs_39, %c0_i32_6 : i32
        sv.passign %regs_40, %c0_i32_6 : i32
        sv.passign %regs_41, %c0_i32_6 : i32
        sv.passign %regs_42, %c0_i32_6 : i32
        sv.passign %regs_43, %c0_i32_6 : i32
        sv.passign %regs_44, %c0_i32_6 : i32
        sv.passign %regs_45, %c0_i32_6 : i32
        sv.passign %regs_46, %c0_i32_6 : i32
        sv.passign %regs_47, %c0_i32_6 : i32
        sv.passign %regs_48, %c0_i32_6 : i32
        sv.passign %regs_49, %c0_i32_6 : i32
        sv.passign %regs_50, %c0_i32_6 : i32
        sv.passign %regs_51, %c0_i32_6 : i32
        sv.passign %regs_52, %c0_i32_6 : i32
        sv.passign %regs_53, %c0_i32_6 : i32
        sv.passign %regs_54, %c0_i32_6 : i32
        sv.passign %regs_55, %c0_i32_6 : i32
        sv.passign %regs_56, %c0_i32_6 : i32
        sv.passign %regs_57, %c0_i32_6 : i32
        sv.passign %regs_58, %c0_i32_6 : i32
        sv.passign %regs_59, %c0_i32_6 : i32
        sv.passign %regs_60, %c0_i32_6 : i32
        sv.passign %regs_61, %c0_i32_6 : i32
        sv.passign %regs_62, %c0_i32_6 : i32
        sv.passign %regs_63, %c0_i32_6 : i32
        sv.passign %regs_64, %c0_i32_6 : i32
        sv.passign %regs_65, %c0_i32_6 : i32
        sv.passign %regs_66, %c0_i32_6 : i32
        sv.passign %regs_67, %c0_i32_6 : i32
        sv.passign %regs_68, %c0_i32_6 : i32
        sv.passign %regs_69, %c0_i32_6 : i32
        sv.passign %regs_70, %c0_i32_6 : i32
        sv.passign %regs_71, %c0_i32_6 : i32
        sv.passign %regs_72, %c0_i32_6 : i32
        sv.passign %regs_73, %c0_i32_6 : i32
        sv.passign %regs_74, %c0_i32_6 : i32
        sv.passign %regs_75, %c0_i32_6 : i32
        sv.passign %regs_76, %c0_i32_6 : i32
        sv.passign %regs_77, %c0_i32_6 : i32
        sv.passign %regs_78, %c0_i32_6 : i32
        sv.passign %regs_79, %c0_i32_6 : i32
        sv.passign %regs_80, %c0_i32_6 : i32
        sv.passign %regs_81, %c0_i32_6 : i32
        sv.passign %regs_82, %c0_i32_6 : i32
        sv.passign %regs_83, %c0_i32_6 : i32
        sv.passign %regs_84, %c0_i32_6 : i32
        sv.passign %regs_85, %c0_i32_6 : i32
        sv.passign %regs_86, %c0_i32_6 : i32
        sv.passign %regs_87, %c0_i32_6 : i32
        sv.passign %regs_88, %c0_i32_6 : i32
        sv.passign %regs_89, %c0_i32_6 : i32
        sv.passign %regs_90, %c0_i32_6 : i32
        sv.passign %regs_91, %c0_i32_6 : i32
        sv.passign %regs_92, %c0_i32_6 : i32
        sv.passign %regs_93, %c0_i32_6 : i32
        sv.passign %regs_94, %c0_i32_6 : i32
        sv.passign %regs_95, %c0_i32_6 : i32
        sv.passign %regs_96, %c0_i32_6 : i32
        sv.passign %regs_97, %c0_i32_6 : i32
        sv.passign %regs_98, %c0_i32_6 : i32
        sv.passign %regs_99, %c0_i32_6 : i32
        sv.passign %regs_100, %c0_i32_6 : i32
        sv.passign %regs_101, %c0_i32_6 : i32
        sv.passign %regs_102, %c0_i32_6 : i32
        sv.passign %regs_103, %c0_i32_6 : i32
        sv.passign %regs_104, %c0_i32_6 : i32
        sv.passign %regs_105, %c0_i32_6 : i32
        sv.passign %regs_106, %c0_i32_6 : i32
        sv.passign %regs_107, %c0_i32_6 : i32
        sv.passign %regs_108, %c0_i32_6 : i32
        sv.passign %regs_109, %c0_i32_6 : i32
        sv.passign %regs_110, %c0_i32_6 : i32
        sv.passign %regs_111, %c0_i32_6 : i32
        sv.passign %regs_112, %c0_i32_6 : i32
        sv.passign %regs_113, %c0_i32_6 : i32
        sv.passign %regs_114, %c0_i32_6 : i32
        sv.passign %regs_115, %c0_i32_6 : i32
        sv.passign %regs_116, %c0_i32_6 : i32
        sv.passign %regs_117, %c0_i32_6 : i32
        sv.passign %regs_118, %c0_i32_6 : i32
        sv.passign %regs_119, %c0_i32_6 : i32
        sv.passign %regs_120, %c0_i32_6 : i32
        sv.passign %regs_121, %c0_i32_6 : i32
        sv.passign %regs_122, %c0_i32_6 : i32
        sv.passign %regs_123, %c0_i32_6 : i32
        sv.passign %regs_124, %c0_i32_6 : i32
        sv.passign %regs_125, %c0_i32_6 : i32
        sv.passign %regs_126, %c0_i32_6 : i32
        sv.passign %regs_127, %c0_i32_6 : i32
      } else {
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
        %147 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %148 = comb.icmp bin eq %147, %c0_i7 : i7
        %149 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %150 = comb.and bin %149, %148 : i1
        sv.if %150 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_0, %659 : i32
        }
        %151 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %152 = comb.icmp bin eq %151, %c1_i7 : i7
        %153 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %154 = comb.and bin %153, %152 : i1
        sv.if %154 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_1, %659 : i32
        }
        %155 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %156 = comb.icmp bin eq %155, %c2_i7 : i7
        %157 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %158 = comb.and bin %157, %156 : i1
        sv.if %158 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_2, %659 : i32
        }
        %159 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %160 = comb.icmp bin eq %159, %c3_i7 : i7
        %161 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %162 = comb.and bin %161, %160 : i1
        sv.if %162 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_3, %659 : i32
        }
        %163 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %164 = comb.icmp bin eq %163, %c4_i7 : i7
        %165 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %166 = comb.and bin %165, %164 : i1
        sv.if %166 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_4, %659 : i32
        }
        %167 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %168 = comb.icmp bin eq %167, %c5_i7 : i7
        %169 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %170 = comb.and bin %169, %168 : i1
        sv.if %170 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_5, %659 : i32
        }
        %171 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %172 = comb.icmp bin eq %171, %c6_i7 : i7
        %173 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %174 = comb.and bin %173, %172 : i1
        sv.if %174 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_6, %659 : i32
        }
        %175 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %176 = comb.icmp bin eq %175, %c7_i7 : i7
        %177 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %178 = comb.and bin %177, %176 : i1
        sv.if %178 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_7, %659 : i32
        }
        %179 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %180 = comb.icmp bin eq %179, %c8_i7 : i7
        %181 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %182 = comb.and bin %181, %180 : i1
        sv.if %182 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_8, %659 : i32
        }
        %183 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %184 = comb.icmp bin eq %183, %c9_i7 : i7
        %185 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %186 = comb.and bin %185, %184 : i1
        sv.if %186 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_9, %659 : i32
        }
        %187 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %188 = comb.icmp bin eq %187, %c10_i7 : i7
        %189 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %190 = comb.and bin %189, %188 : i1
        sv.if %190 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_10, %659 : i32
        }
        %191 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %192 = comb.icmp bin eq %191, %c11_i7 : i7
        %193 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %194 = comb.and bin %193, %192 : i1
        sv.if %194 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_11, %659 : i32
        }
        %195 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %196 = comb.icmp bin eq %195, %c12_i7 : i7
        %197 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %198 = comb.and bin %197, %196 : i1
        sv.if %198 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_12, %659 : i32
        }
        %199 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %200 = comb.icmp bin eq %199, %c13_i7 : i7
        %201 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %202 = comb.and bin %201, %200 : i1
        sv.if %202 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_13, %659 : i32
        }
        %203 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %204 = comb.icmp bin eq %203, %c14_i7 : i7
        %205 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %206 = comb.and bin %205, %204 : i1
        sv.if %206 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_14, %659 : i32
        }
        %207 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %208 = comb.icmp bin eq %207, %c15_i7 : i7
        %209 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %210 = comb.and bin %209, %208 : i1
        sv.if %210 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_15, %659 : i32
        }
        %211 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %212 = comb.icmp bin eq %211, %c16_i7 : i7
        %213 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %214 = comb.and bin %213, %212 : i1
        sv.if %214 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_16, %659 : i32
        }
        %215 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %216 = comb.icmp bin eq %215, %c17_i7 : i7
        %217 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %218 = comb.and bin %217, %216 : i1
        sv.if %218 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_17, %659 : i32
        }
        %219 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %220 = comb.icmp bin eq %219, %c18_i7 : i7
        %221 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %222 = comb.and bin %221, %220 : i1
        sv.if %222 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_18, %659 : i32
        }
        %223 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %224 = comb.icmp bin eq %223, %c19_i7 : i7
        %225 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %226 = comb.and bin %225, %224 : i1
        sv.if %226 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_19, %659 : i32
        }
        %227 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %228 = comb.icmp bin eq %227, %c20_i7 : i7
        %229 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %230 = comb.and bin %229, %228 : i1
        sv.if %230 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_20, %659 : i32
        }
        %231 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %232 = comb.icmp bin eq %231, %c21_i7 : i7
        %233 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %234 = comb.and bin %233, %232 : i1
        sv.if %234 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_21, %659 : i32
        }
        %235 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %236 = comb.icmp bin eq %235, %c22_i7 : i7
        %237 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %238 = comb.and bin %237, %236 : i1
        sv.if %238 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_22, %659 : i32
        }
        %239 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %240 = comb.icmp bin eq %239, %c23_i7 : i7
        %241 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %242 = comb.and bin %241, %240 : i1
        sv.if %242 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_23, %659 : i32
        }
        %243 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %244 = comb.icmp bin eq %243, %c24_i7 : i7
        %245 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %246 = comb.and bin %245, %244 : i1
        sv.if %246 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_24, %659 : i32
        }
        %247 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %248 = comb.icmp bin eq %247, %c25_i7 : i7
        %249 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %250 = comb.and bin %249, %248 : i1
        sv.if %250 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_25, %659 : i32
        }
        %251 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %252 = comb.icmp bin eq %251, %c26_i7 : i7
        %253 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %254 = comb.and bin %253, %252 : i1
        sv.if %254 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_26, %659 : i32
        }
        %255 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %256 = comb.icmp bin eq %255, %c27_i7 : i7
        %257 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %258 = comb.and bin %257, %256 : i1
        sv.if %258 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_27, %659 : i32
        }
        %259 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %260 = comb.icmp bin eq %259, %c28_i7 : i7
        %261 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %262 = comb.and bin %261, %260 : i1
        sv.if %262 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_28, %659 : i32
        }
        %263 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %264 = comb.icmp bin eq %263, %c29_i7 : i7
        %265 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %266 = comb.and bin %265, %264 : i1
        sv.if %266 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_29, %659 : i32
        }
        %267 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %268 = comb.icmp bin eq %267, %c30_i7 : i7
        %269 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %270 = comb.and bin %269, %268 : i1
        sv.if %270 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_30, %659 : i32
        }
        %271 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %272 = comb.icmp bin eq %271, %c31_i7 : i7
        %273 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %274 = comb.and bin %273, %272 : i1
        sv.if %274 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_31, %659 : i32
        }
        %275 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %276 = comb.icmp bin eq %275, %c32_i7 : i7
        %277 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %278 = comb.and bin %277, %276 : i1
        sv.if %278 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_32, %659 : i32
        }
        %279 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %280 = comb.icmp bin eq %279, %c33_i7 : i7
        %281 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %282 = comb.and bin %281, %280 : i1
        sv.if %282 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_33, %659 : i32
        }
        %283 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %284 = comb.icmp bin eq %283, %c34_i7 : i7
        %285 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %286 = comb.and bin %285, %284 : i1
        sv.if %286 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_34, %659 : i32
        }
        %287 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %288 = comb.icmp bin eq %287, %c35_i7 : i7
        %289 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %290 = comb.and bin %289, %288 : i1
        sv.if %290 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_35, %659 : i32
        }
        %291 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %292 = comb.icmp bin eq %291, %c36_i7 : i7
        %293 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %294 = comb.and bin %293, %292 : i1
        sv.if %294 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_36, %659 : i32
        }
        %295 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %296 = comb.icmp bin eq %295, %c37_i7 : i7
        %297 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %298 = comb.and bin %297, %296 : i1
        sv.if %298 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_37, %659 : i32
        }
        %299 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %300 = comb.icmp bin eq %299, %c38_i7 : i7
        %301 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %302 = comb.and bin %301, %300 : i1
        sv.if %302 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_38, %659 : i32
        }
        %303 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %304 = comb.icmp bin eq %303, %c39_i7 : i7
        %305 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %306 = comb.and bin %305, %304 : i1
        sv.if %306 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_39, %659 : i32
        }
        %307 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %308 = comb.icmp bin eq %307, %c40_i7 : i7
        %309 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %310 = comb.and bin %309, %308 : i1
        sv.if %310 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_40, %659 : i32
        }
        %311 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %312 = comb.icmp bin eq %311, %c41_i7 : i7
        %313 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %314 = comb.and bin %313, %312 : i1
        sv.if %314 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_41, %659 : i32
        }
        %315 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %316 = comb.icmp bin eq %315, %c42_i7 : i7
        %317 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %318 = comb.and bin %317, %316 : i1
        sv.if %318 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_42, %659 : i32
        }
        %319 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %320 = comb.icmp bin eq %319, %c43_i7 : i7
        %321 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %322 = comb.and bin %321, %320 : i1
        sv.if %322 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_43, %659 : i32
        }
        %323 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %324 = comb.icmp bin eq %323, %c44_i7 : i7
        %325 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %326 = comb.and bin %325, %324 : i1
        sv.if %326 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_44, %659 : i32
        }
        %327 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %328 = comb.icmp bin eq %327, %c45_i7 : i7
        %329 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %330 = comb.and bin %329, %328 : i1
        sv.if %330 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_45, %659 : i32
        }
        %331 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %332 = comb.icmp bin eq %331, %c46_i7 : i7
        %333 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %334 = comb.and bin %333, %332 : i1
        sv.if %334 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_46, %659 : i32
        }
        %335 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %336 = comb.icmp bin eq %335, %c47_i7 : i7
        %337 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %338 = comb.and bin %337, %336 : i1
        sv.if %338 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_47, %659 : i32
        }
        %339 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %340 = comb.icmp bin eq %339, %c48_i7 : i7
        %341 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %342 = comb.and bin %341, %340 : i1
        sv.if %342 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_48, %659 : i32
        }
        %343 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %344 = comb.icmp bin eq %343, %c49_i7 : i7
        %345 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %346 = comb.and bin %345, %344 : i1
        sv.if %346 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_49, %659 : i32
        }
        %347 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %348 = comb.icmp bin eq %347, %c50_i7 : i7
        %349 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %350 = comb.and bin %349, %348 : i1
        sv.if %350 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_50, %659 : i32
        }
        %351 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %352 = comb.icmp bin eq %351, %c51_i7 : i7
        %353 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %354 = comb.and bin %353, %352 : i1
        sv.if %354 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_51, %659 : i32
        }
        %355 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %356 = comb.icmp bin eq %355, %c52_i7 : i7
        %357 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %358 = comb.and bin %357, %356 : i1
        sv.if %358 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_52, %659 : i32
        }
        %359 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %360 = comb.icmp bin eq %359, %c53_i7 : i7
        %361 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %362 = comb.and bin %361, %360 : i1
        sv.if %362 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_53, %659 : i32
        }
        %363 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %364 = comb.icmp bin eq %363, %c54_i7 : i7
        %365 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %366 = comb.and bin %365, %364 : i1
        sv.if %366 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_54, %659 : i32
        }
        %367 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %368 = comb.icmp bin eq %367, %c55_i7 : i7
        %369 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %370 = comb.and bin %369, %368 : i1
        sv.if %370 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_55, %659 : i32
        }
        %371 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %372 = comb.icmp bin eq %371, %c56_i7 : i7
        %373 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %374 = comb.and bin %373, %372 : i1
        sv.if %374 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_56, %659 : i32
        }
        %375 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %376 = comb.icmp bin eq %375, %c57_i7 : i7
        %377 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %378 = comb.and bin %377, %376 : i1
        sv.if %378 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_57, %659 : i32
        }
        %379 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %380 = comb.icmp bin eq %379, %c58_i7 : i7
        %381 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %382 = comb.and bin %381, %380 : i1
        sv.if %382 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_58, %659 : i32
        }
        %383 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %384 = comb.icmp bin eq %383, %c59_i7 : i7
        %385 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %386 = comb.and bin %385, %384 : i1
        sv.if %386 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_59, %659 : i32
        }
        %387 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %388 = comb.icmp bin eq %387, %c60_i7 : i7
        %389 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %390 = comb.and bin %389, %388 : i1
        sv.if %390 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_60, %659 : i32
        }
        %391 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %392 = comb.icmp bin eq %391, %c61_i7 : i7
        %393 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %394 = comb.and bin %393, %392 : i1
        sv.if %394 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_61, %659 : i32
        }
        %395 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %396 = comb.icmp bin eq %395, %c62_i7 : i7
        %397 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %398 = comb.and bin %397, %396 : i1
        sv.if %398 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_62, %659 : i32
        }
        %399 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %400 = comb.icmp bin eq %399, %c63_i7 : i7
        %401 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %402 = comb.and bin %401, %400 : i1
        sv.if %402 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_63, %659 : i32
        }
        %403 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %404 = comb.icmp bin eq %403, %c-64_i7 : i7
        %405 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %406 = comb.and bin %405, %404 : i1
        sv.if %406 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_64, %659 : i32
        }
        %407 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %408 = comb.icmp bin eq %407, %c-63_i7 : i7
        %409 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %410 = comb.and bin %409, %408 : i1
        sv.if %410 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_65, %659 : i32
        }
        %411 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %412 = comb.icmp bin eq %411, %c-62_i7 : i7
        %413 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %414 = comb.and bin %413, %412 : i1
        sv.if %414 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_66, %659 : i32
        }
        %415 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %416 = comb.icmp bin eq %415, %c-61_i7 : i7
        %417 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %418 = comb.and bin %417, %416 : i1
        sv.if %418 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_67, %659 : i32
        }
        %419 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %420 = comb.icmp bin eq %419, %c-60_i7 : i7
        %421 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %422 = comb.and bin %421, %420 : i1
        sv.if %422 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_68, %659 : i32
        }
        %423 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %424 = comb.icmp bin eq %423, %c-59_i7 : i7
        %425 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %426 = comb.and bin %425, %424 : i1
        sv.if %426 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_69, %659 : i32
        }
        %427 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %428 = comb.icmp bin eq %427, %c-58_i7 : i7
        %429 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %430 = comb.and bin %429, %428 : i1
        sv.if %430 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_70, %659 : i32
        }
        %431 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %432 = comb.icmp bin eq %431, %c-57_i7 : i7
        %433 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %434 = comb.and bin %433, %432 : i1
        sv.if %434 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_71, %659 : i32
        }
        %435 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %436 = comb.icmp bin eq %435, %c-56_i7 : i7
        %437 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %438 = comb.and bin %437, %436 : i1
        sv.if %438 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_72, %659 : i32
        }
        %439 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %440 = comb.icmp bin eq %439, %c-55_i7 : i7
        %441 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %442 = comb.and bin %441, %440 : i1
        sv.if %442 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_73, %659 : i32
        }
        %443 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %444 = comb.icmp bin eq %443, %c-54_i7 : i7
        %445 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %446 = comb.and bin %445, %444 : i1
        sv.if %446 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_74, %659 : i32
        }
        %447 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %448 = comb.icmp bin eq %447, %c-53_i7 : i7
        %449 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %450 = comb.and bin %449, %448 : i1
        sv.if %450 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_75, %659 : i32
        }
        %451 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %452 = comb.icmp bin eq %451, %c-52_i7 : i7
        %453 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %454 = comb.and bin %453, %452 : i1
        sv.if %454 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_76, %659 : i32
        }
        %455 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %456 = comb.icmp bin eq %455, %c-51_i7 : i7
        %457 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %458 = comb.and bin %457, %456 : i1
        sv.if %458 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_77, %659 : i32
        }
        %459 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %460 = comb.icmp bin eq %459, %c-50_i7 : i7
        %461 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %462 = comb.and bin %461, %460 : i1
        sv.if %462 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_78, %659 : i32
        }
        %463 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %464 = comb.icmp bin eq %463, %c-49_i7 : i7
        %465 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %466 = comb.and bin %465, %464 : i1
        sv.if %466 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_79, %659 : i32
        }
        %467 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %468 = comb.icmp bin eq %467, %c-48_i7 : i7
        %469 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %470 = comb.and bin %469, %468 : i1
        sv.if %470 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_80, %659 : i32
        }
        %471 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %472 = comb.icmp bin eq %471, %c-47_i7 : i7
        %473 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %474 = comb.and bin %473, %472 : i1
        sv.if %474 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_81, %659 : i32
        }
        %475 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %476 = comb.icmp bin eq %475, %c-46_i7 : i7
        %477 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %478 = comb.and bin %477, %476 : i1
        sv.if %478 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_82, %659 : i32
        }
        %479 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %480 = comb.icmp bin eq %479, %c-45_i7 : i7
        %481 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %482 = comb.and bin %481, %480 : i1
        sv.if %482 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_83, %659 : i32
        }
        %483 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %484 = comb.icmp bin eq %483, %c-44_i7 : i7
        %485 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %486 = comb.and bin %485, %484 : i1
        sv.if %486 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_84, %659 : i32
        }
        %487 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %488 = comb.icmp bin eq %487, %c-43_i7 : i7
        %489 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %490 = comb.and bin %489, %488 : i1
        sv.if %490 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_85, %659 : i32
        }
        %491 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %492 = comb.icmp bin eq %491, %c-42_i7 : i7
        %493 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %494 = comb.and bin %493, %492 : i1
        sv.if %494 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_86, %659 : i32
        }
        %495 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %496 = comb.icmp bin eq %495, %c-41_i7 : i7
        %497 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %498 = comb.and bin %497, %496 : i1
        sv.if %498 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_87, %659 : i32
        }
        %499 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %500 = comb.icmp bin eq %499, %c-40_i7 : i7
        %501 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %502 = comb.and bin %501, %500 : i1
        sv.if %502 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_88, %659 : i32
        }
        %503 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %504 = comb.icmp bin eq %503, %c-39_i7 : i7
        %505 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %506 = comb.and bin %505, %504 : i1
        sv.if %506 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_89, %659 : i32
        }
        %507 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %508 = comb.icmp bin eq %507, %c-38_i7 : i7
        %509 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %510 = comb.and bin %509, %508 : i1
        sv.if %510 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_90, %659 : i32
        }
        %511 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %512 = comb.icmp bin eq %511, %c-37_i7 : i7
        %513 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %514 = comb.and bin %513, %512 : i1
        sv.if %514 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_91, %659 : i32
        }
        %515 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %516 = comb.icmp bin eq %515, %c-36_i7 : i7
        %517 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %518 = comb.and bin %517, %516 : i1
        sv.if %518 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_92, %659 : i32
        }
        %519 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %520 = comb.icmp bin eq %519, %c-35_i7 : i7
        %521 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %522 = comb.and bin %521, %520 : i1
        sv.if %522 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_93, %659 : i32
        }
        %523 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %524 = comb.icmp bin eq %523, %c-34_i7 : i7
        %525 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %526 = comb.and bin %525, %524 : i1
        sv.if %526 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_94, %659 : i32
        }
        %527 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %528 = comb.icmp bin eq %527, %c-33_i7 : i7
        %529 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %530 = comb.and bin %529, %528 : i1
        sv.if %530 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_95, %659 : i32
        }
        %531 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %532 = comb.icmp bin eq %531, %c-32_i7 : i7
        %533 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %534 = comb.and bin %533, %532 : i1
        sv.if %534 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_96, %659 : i32
        }
        %535 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %536 = comb.icmp bin eq %535, %c-31_i7 : i7
        %537 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %538 = comb.and bin %537, %536 : i1
        sv.if %538 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_97, %659 : i32
        }
        %539 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %540 = comb.icmp bin eq %539, %c-30_i7 : i7
        %541 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %542 = comb.and bin %541, %540 : i1
        sv.if %542 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_98, %659 : i32
        }
        %543 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %544 = comb.icmp bin eq %543, %c-29_i7 : i7
        %545 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %546 = comb.and bin %545, %544 : i1
        sv.if %546 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_99, %659 : i32
        }
        %547 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %548 = comb.icmp bin eq %547, %c-28_i7 : i7
        %549 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %550 = comb.and bin %549, %548 : i1
        sv.if %550 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_100, %659 : i32
        }
        %551 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %552 = comb.icmp bin eq %551, %c-27_i7 : i7
        %553 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %554 = comb.and bin %553, %552 : i1
        sv.if %554 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_101, %659 : i32
        }
        %555 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %556 = comb.icmp bin eq %555, %c-26_i7 : i7
        %557 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %558 = comb.and bin %557, %556 : i1
        sv.if %558 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_102, %659 : i32
        }
        %559 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %560 = comb.icmp bin eq %559, %c-25_i7 : i7
        %561 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %562 = comb.and bin %561, %560 : i1
        sv.if %562 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_103, %659 : i32
        }
        %563 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %564 = comb.icmp bin eq %563, %c-24_i7 : i7
        %565 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %566 = comb.and bin %565, %564 : i1
        sv.if %566 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_104, %659 : i32
        }
        %567 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %568 = comb.icmp bin eq %567, %c-23_i7 : i7
        %569 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %570 = comb.and bin %569, %568 : i1
        sv.if %570 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_105, %659 : i32
        }
        %571 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %572 = comb.icmp bin eq %571, %c-22_i7 : i7
        %573 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %574 = comb.and bin %573, %572 : i1
        sv.if %574 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_106, %659 : i32
        }
        %575 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %576 = comb.icmp bin eq %575, %c-21_i7 : i7
        %577 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %578 = comb.and bin %577, %576 : i1
        sv.if %578 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_107, %659 : i32
        }
        %579 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %580 = comb.icmp bin eq %579, %c-20_i7 : i7
        %581 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %582 = comb.and bin %581, %580 : i1
        sv.if %582 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_108, %659 : i32
        }
        %583 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %584 = comb.icmp bin eq %583, %c-19_i7 : i7
        %585 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %586 = comb.and bin %585, %584 : i1
        sv.if %586 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_109, %659 : i32
        }
        %587 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %588 = comb.icmp bin eq %587, %c-18_i7 : i7
        %589 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %590 = comb.and bin %589, %588 : i1
        sv.if %590 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_110, %659 : i32
        }
        %591 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %592 = comb.icmp bin eq %591, %c-17_i7 : i7
        %593 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %594 = comb.and bin %593, %592 : i1
        sv.if %594 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_111, %659 : i32
        }
        %595 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %596 = comb.icmp bin eq %595, %c-16_i7 : i7
        %597 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %598 = comb.and bin %597, %596 : i1
        sv.if %598 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_112, %659 : i32
        }
        %599 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %600 = comb.icmp bin eq %599, %c-15_i7 : i7
        %601 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %602 = comb.and bin %601, %600 : i1
        sv.if %602 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_113, %659 : i32
        }
        %603 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %604 = comb.icmp bin eq %603, %c-14_i7 : i7
        %605 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %606 = comb.and bin %605, %604 : i1
        sv.if %606 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_114, %659 : i32
        }
        %607 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %608 = comb.icmp bin eq %607, %c-13_i7 : i7
        %609 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %610 = comb.and bin %609, %608 : i1
        sv.if %610 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_115, %659 : i32
        }
        %611 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %612 = comb.icmp bin eq %611, %c-12_i7 : i7
        %613 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %614 = comb.and bin %613, %612 : i1
        sv.if %614 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_116, %659 : i32
        }
        %615 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %616 = comb.icmp bin eq %615, %c-11_i7 : i7
        %617 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %618 = comb.and bin %617, %616 : i1
        sv.if %618 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_117, %659 : i32
        }
        %619 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %620 = comb.icmp bin eq %619, %c-10_i7 : i7
        %621 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %622 = comb.and bin %621, %620 : i1
        sv.if %622 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_118, %659 : i32
        }
        %623 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %624 = comb.icmp bin eq %623, %c-9_i7 : i7
        %625 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %626 = comb.and bin %625, %624 : i1
        sv.if %626 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_119, %659 : i32
        }
        %627 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %628 = comb.icmp bin eq %627, %c-8_i7 : i7
        %629 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %630 = comb.and bin %629, %628 : i1
        sv.if %630 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_120, %659 : i32
        }
        %631 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %632 = comb.icmp bin eq %631, %c-7_i7 : i7
        %633 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %634 = comb.and bin %633, %632 : i1
        sv.if %634 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_121, %659 : i32
        }
        %635 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %636 = comb.icmp bin eq %635, %c-6_i7 : i7
        %637 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %638 = comb.and bin %637, %636 : i1
        sv.if %638 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_122, %659 : i32
        }
        %639 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %640 = comb.icmp bin eq %639, %c-5_i7 : i7
        %641 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %642 = comb.and bin %641, %640 : i1
        sv.if %642 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_123, %659 : i32
        }
        %643 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %644 = comb.icmp bin eq %643, %c-4_i7 : i7
        %645 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %646 = comb.and bin %645, %644 : i1
        sv.if %646 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_124, %659 : i32
        }
        %647 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %648 = comb.icmp bin eq %647, %c-3_i7 : i7
        %649 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %650 = comb.and bin %649, %648 : i1
        sv.if %650 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_125, %659 : i32
        }
        %651 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %652 = comb.icmp bin eq %651, %c-2_i7 : i7
        %653 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %654 = comb.and bin %653, %652 : i1
        sv.if %654 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_126, %659 : i32
        }
        %655 = sv.read_inout %effectiveDst1 : !hw.inout<i7>
        %656 = comb.icmp bin eq %655, %c-1_i7 : i7
        %657 = sv.read_inout %io_wen_4 : !hw.inout<i1>
        %658 = comb.and bin %657, %656 : i1
        sv.if %658 {
          %659 = sv.read_inout %io_dst1data_5 : !hw.inout<i32>
          sv.passign %regs_127, %659 : i32
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
              %403 = comb.extract %i from 0 : (i8) -> i7
              %404 = sv.array_index_inout %_RANDOM[%403] : !hw.inout<uarray<128xi32>>, i7
              sv.bpassign %404, %RANDOM : i32
            } {hw.verilogName = "i"}
            %147 = sv.array_index_inout %_RANDOM[%c0_i7] : !hw.inout<uarray<128xi32>>, i7
            %148 = sv.read_inout %147 : !hw.inout<i32>
            sv.bpassign %regs_0, %148 : i32
            %149 = sv.array_index_inout %_RANDOM[%c1_i7] : !hw.inout<uarray<128xi32>>, i7
            %150 = sv.read_inout %149 : !hw.inout<i32>
            sv.bpassign %regs_1, %150 : i32
            %151 = sv.array_index_inout %_RANDOM[%c2_i7] : !hw.inout<uarray<128xi32>>, i7
            %152 = sv.read_inout %151 : !hw.inout<i32>
            sv.bpassign %regs_2, %152 : i32
            %153 = sv.array_index_inout %_RANDOM[%c3_i7] : !hw.inout<uarray<128xi32>>, i7
            %154 = sv.read_inout %153 : !hw.inout<i32>
            sv.bpassign %regs_3, %154 : i32
            %155 = sv.array_index_inout %_RANDOM[%c4_i7] : !hw.inout<uarray<128xi32>>, i7
            %156 = sv.read_inout %155 : !hw.inout<i32>
            sv.bpassign %regs_4, %156 : i32
            %157 = sv.array_index_inout %_RANDOM[%c5_i7] : !hw.inout<uarray<128xi32>>, i7
            %158 = sv.read_inout %157 : !hw.inout<i32>
            sv.bpassign %regs_5, %158 : i32
            %159 = sv.array_index_inout %_RANDOM[%c6_i7] : !hw.inout<uarray<128xi32>>, i7
            %160 = sv.read_inout %159 : !hw.inout<i32>
            sv.bpassign %regs_6, %160 : i32
            %161 = sv.array_index_inout %_RANDOM[%c7_i7] : !hw.inout<uarray<128xi32>>, i7
            %162 = sv.read_inout %161 : !hw.inout<i32>
            sv.bpassign %regs_7, %162 : i32
            %163 = sv.array_index_inout %_RANDOM[%c8_i7] : !hw.inout<uarray<128xi32>>, i7
            %164 = sv.read_inout %163 : !hw.inout<i32>
            sv.bpassign %regs_8, %164 : i32
            %165 = sv.array_index_inout %_RANDOM[%c9_i7] : !hw.inout<uarray<128xi32>>, i7
            %166 = sv.read_inout %165 : !hw.inout<i32>
            sv.bpassign %regs_9, %166 : i32
            %167 = sv.array_index_inout %_RANDOM[%c10_i7] : !hw.inout<uarray<128xi32>>, i7
            %168 = sv.read_inout %167 : !hw.inout<i32>
            sv.bpassign %regs_10, %168 : i32
            %169 = sv.array_index_inout %_RANDOM[%c11_i7] : !hw.inout<uarray<128xi32>>, i7
            %170 = sv.read_inout %169 : !hw.inout<i32>
            sv.bpassign %regs_11, %170 : i32
            %171 = sv.array_index_inout %_RANDOM[%c12_i7] : !hw.inout<uarray<128xi32>>, i7
            %172 = sv.read_inout %171 : !hw.inout<i32>
            sv.bpassign %regs_12, %172 : i32
            %173 = sv.array_index_inout %_RANDOM[%c13_i7] : !hw.inout<uarray<128xi32>>, i7
            %174 = sv.read_inout %173 : !hw.inout<i32>
            sv.bpassign %regs_13, %174 : i32
            %175 = sv.array_index_inout %_RANDOM[%c14_i7] : !hw.inout<uarray<128xi32>>, i7
            %176 = sv.read_inout %175 : !hw.inout<i32>
            sv.bpassign %regs_14, %176 : i32
            %177 = sv.array_index_inout %_RANDOM[%c15_i7] : !hw.inout<uarray<128xi32>>, i7
            %178 = sv.read_inout %177 : !hw.inout<i32>
            sv.bpassign %regs_15, %178 : i32
            %179 = sv.array_index_inout %_RANDOM[%c16_i7] : !hw.inout<uarray<128xi32>>, i7
            %180 = sv.read_inout %179 : !hw.inout<i32>
            sv.bpassign %regs_16, %180 : i32
            %181 = sv.array_index_inout %_RANDOM[%c17_i7] : !hw.inout<uarray<128xi32>>, i7
            %182 = sv.read_inout %181 : !hw.inout<i32>
            sv.bpassign %regs_17, %182 : i32
            %183 = sv.array_index_inout %_RANDOM[%c18_i7] : !hw.inout<uarray<128xi32>>, i7
            %184 = sv.read_inout %183 : !hw.inout<i32>
            sv.bpassign %regs_18, %184 : i32
            %185 = sv.array_index_inout %_RANDOM[%c19_i7] : !hw.inout<uarray<128xi32>>, i7
            %186 = sv.read_inout %185 : !hw.inout<i32>
            sv.bpassign %regs_19, %186 : i32
            %187 = sv.array_index_inout %_RANDOM[%c20_i7] : !hw.inout<uarray<128xi32>>, i7
            %188 = sv.read_inout %187 : !hw.inout<i32>
            sv.bpassign %regs_20, %188 : i32
            %189 = sv.array_index_inout %_RANDOM[%c21_i7] : !hw.inout<uarray<128xi32>>, i7
            %190 = sv.read_inout %189 : !hw.inout<i32>
            sv.bpassign %regs_21, %190 : i32
            %191 = sv.array_index_inout %_RANDOM[%c22_i7] : !hw.inout<uarray<128xi32>>, i7
            %192 = sv.read_inout %191 : !hw.inout<i32>
            sv.bpassign %regs_22, %192 : i32
            %193 = sv.array_index_inout %_RANDOM[%c23_i7] : !hw.inout<uarray<128xi32>>, i7
            %194 = sv.read_inout %193 : !hw.inout<i32>
            sv.bpassign %regs_23, %194 : i32
            %195 = sv.array_index_inout %_RANDOM[%c24_i7] : !hw.inout<uarray<128xi32>>, i7
            %196 = sv.read_inout %195 : !hw.inout<i32>
            sv.bpassign %regs_24, %196 : i32
            %197 = sv.array_index_inout %_RANDOM[%c25_i7] : !hw.inout<uarray<128xi32>>, i7
            %198 = sv.read_inout %197 : !hw.inout<i32>
            sv.bpassign %regs_25, %198 : i32
            %199 = sv.array_index_inout %_RANDOM[%c26_i7] : !hw.inout<uarray<128xi32>>, i7
            %200 = sv.read_inout %199 : !hw.inout<i32>
            sv.bpassign %regs_26, %200 : i32
            %201 = sv.array_index_inout %_RANDOM[%c27_i7] : !hw.inout<uarray<128xi32>>, i7
            %202 = sv.read_inout %201 : !hw.inout<i32>
            sv.bpassign %regs_27, %202 : i32
            %203 = sv.array_index_inout %_RANDOM[%c28_i7] : !hw.inout<uarray<128xi32>>, i7
            %204 = sv.read_inout %203 : !hw.inout<i32>
            sv.bpassign %regs_28, %204 : i32
            %205 = sv.array_index_inout %_RANDOM[%c29_i7] : !hw.inout<uarray<128xi32>>, i7
            %206 = sv.read_inout %205 : !hw.inout<i32>
            sv.bpassign %regs_29, %206 : i32
            %207 = sv.array_index_inout %_RANDOM[%c30_i7] : !hw.inout<uarray<128xi32>>, i7
            %208 = sv.read_inout %207 : !hw.inout<i32>
            sv.bpassign %regs_30, %208 : i32
            %209 = sv.array_index_inout %_RANDOM[%c31_i7] : !hw.inout<uarray<128xi32>>, i7
            %210 = sv.read_inout %209 : !hw.inout<i32>
            sv.bpassign %regs_31, %210 : i32
            %211 = sv.array_index_inout %_RANDOM[%c32_i7] : !hw.inout<uarray<128xi32>>, i7
            %212 = sv.read_inout %211 : !hw.inout<i32>
            sv.bpassign %regs_32, %212 : i32
            %213 = sv.array_index_inout %_RANDOM[%c33_i7] : !hw.inout<uarray<128xi32>>, i7
            %214 = sv.read_inout %213 : !hw.inout<i32>
            sv.bpassign %regs_33, %214 : i32
            %215 = sv.array_index_inout %_RANDOM[%c34_i7] : !hw.inout<uarray<128xi32>>, i7
            %216 = sv.read_inout %215 : !hw.inout<i32>
            sv.bpassign %regs_34, %216 : i32
            %217 = sv.array_index_inout %_RANDOM[%c35_i7] : !hw.inout<uarray<128xi32>>, i7
            %218 = sv.read_inout %217 : !hw.inout<i32>
            sv.bpassign %regs_35, %218 : i32
            %219 = sv.array_index_inout %_RANDOM[%c36_i7] : !hw.inout<uarray<128xi32>>, i7
            %220 = sv.read_inout %219 : !hw.inout<i32>
            sv.bpassign %regs_36, %220 : i32
            %221 = sv.array_index_inout %_RANDOM[%c37_i7] : !hw.inout<uarray<128xi32>>, i7
            %222 = sv.read_inout %221 : !hw.inout<i32>
            sv.bpassign %regs_37, %222 : i32
            %223 = sv.array_index_inout %_RANDOM[%c38_i7] : !hw.inout<uarray<128xi32>>, i7
            %224 = sv.read_inout %223 : !hw.inout<i32>
            sv.bpassign %regs_38, %224 : i32
            %225 = sv.array_index_inout %_RANDOM[%c39_i7] : !hw.inout<uarray<128xi32>>, i7
            %226 = sv.read_inout %225 : !hw.inout<i32>
            sv.bpassign %regs_39, %226 : i32
            %227 = sv.array_index_inout %_RANDOM[%c40_i7] : !hw.inout<uarray<128xi32>>, i7
            %228 = sv.read_inout %227 : !hw.inout<i32>
            sv.bpassign %regs_40, %228 : i32
            %229 = sv.array_index_inout %_RANDOM[%c41_i7] : !hw.inout<uarray<128xi32>>, i7
            %230 = sv.read_inout %229 : !hw.inout<i32>
            sv.bpassign %regs_41, %230 : i32
            %231 = sv.array_index_inout %_RANDOM[%c42_i7] : !hw.inout<uarray<128xi32>>, i7
            %232 = sv.read_inout %231 : !hw.inout<i32>
            sv.bpassign %regs_42, %232 : i32
            %233 = sv.array_index_inout %_RANDOM[%c43_i7] : !hw.inout<uarray<128xi32>>, i7
            %234 = sv.read_inout %233 : !hw.inout<i32>
            sv.bpassign %regs_43, %234 : i32
            %235 = sv.array_index_inout %_RANDOM[%c44_i7] : !hw.inout<uarray<128xi32>>, i7
            %236 = sv.read_inout %235 : !hw.inout<i32>
            sv.bpassign %regs_44, %236 : i32
            %237 = sv.array_index_inout %_RANDOM[%c45_i7] : !hw.inout<uarray<128xi32>>, i7
            %238 = sv.read_inout %237 : !hw.inout<i32>
            sv.bpassign %regs_45, %238 : i32
            %239 = sv.array_index_inout %_RANDOM[%c46_i7] : !hw.inout<uarray<128xi32>>, i7
            %240 = sv.read_inout %239 : !hw.inout<i32>
            sv.bpassign %regs_46, %240 : i32
            %241 = sv.array_index_inout %_RANDOM[%c47_i7] : !hw.inout<uarray<128xi32>>, i7
            %242 = sv.read_inout %241 : !hw.inout<i32>
            sv.bpassign %regs_47, %242 : i32
            %243 = sv.array_index_inout %_RANDOM[%c48_i7] : !hw.inout<uarray<128xi32>>, i7
            %244 = sv.read_inout %243 : !hw.inout<i32>
            sv.bpassign %regs_48, %244 : i32
            %245 = sv.array_index_inout %_RANDOM[%c49_i7] : !hw.inout<uarray<128xi32>>, i7
            %246 = sv.read_inout %245 : !hw.inout<i32>
            sv.bpassign %regs_49, %246 : i32
            %247 = sv.array_index_inout %_RANDOM[%c50_i7] : !hw.inout<uarray<128xi32>>, i7
            %248 = sv.read_inout %247 : !hw.inout<i32>
            sv.bpassign %regs_50, %248 : i32
            %249 = sv.array_index_inout %_RANDOM[%c51_i7] : !hw.inout<uarray<128xi32>>, i7
            %250 = sv.read_inout %249 : !hw.inout<i32>
            sv.bpassign %regs_51, %250 : i32
            %251 = sv.array_index_inout %_RANDOM[%c52_i7] : !hw.inout<uarray<128xi32>>, i7
            %252 = sv.read_inout %251 : !hw.inout<i32>
            sv.bpassign %regs_52, %252 : i32
            %253 = sv.array_index_inout %_RANDOM[%c53_i7] : !hw.inout<uarray<128xi32>>, i7
            %254 = sv.read_inout %253 : !hw.inout<i32>
            sv.bpassign %regs_53, %254 : i32
            %255 = sv.array_index_inout %_RANDOM[%c54_i7] : !hw.inout<uarray<128xi32>>, i7
            %256 = sv.read_inout %255 : !hw.inout<i32>
            sv.bpassign %regs_54, %256 : i32
            %257 = sv.array_index_inout %_RANDOM[%c55_i7] : !hw.inout<uarray<128xi32>>, i7
            %258 = sv.read_inout %257 : !hw.inout<i32>
            sv.bpassign %regs_55, %258 : i32
            %259 = sv.array_index_inout %_RANDOM[%c56_i7] : !hw.inout<uarray<128xi32>>, i7
            %260 = sv.read_inout %259 : !hw.inout<i32>
            sv.bpassign %regs_56, %260 : i32
            %261 = sv.array_index_inout %_RANDOM[%c57_i7] : !hw.inout<uarray<128xi32>>, i7
            %262 = sv.read_inout %261 : !hw.inout<i32>
            sv.bpassign %regs_57, %262 : i32
            %263 = sv.array_index_inout %_RANDOM[%c58_i7] : !hw.inout<uarray<128xi32>>, i7
            %264 = sv.read_inout %263 : !hw.inout<i32>
            sv.bpassign %regs_58, %264 : i32
            %265 = sv.array_index_inout %_RANDOM[%c59_i7] : !hw.inout<uarray<128xi32>>, i7
            %266 = sv.read_inout %265 : !hw.inout<i32>
            sv.bpassign %regs_59, %266 : i32
            %267 = sv.array_index_inout %_RANDOM[%c60_i7] : !hw.inout<uarray<128xi32>>, i7
            %268 = sv.read_inout %267 : !hw.inout<i32>
            sv.bpassign %regs_60, %268 : i32
            %269 = sv.array_index_inout %_RANDOM[%c61_i7] : !hw.inout<uarray<128xi32>>, i7
            %270 = sv.read_inout %269 : !hw.inout<i32>
            sv.bpassign %regs_61, %270 : i32
            %271 = sv.array_index_inout %_RANDOM[%c62_i7] : !hw.inout<uarray<128xi32>>, i7
            %272 = sv.read_inout %271 : !hw.inout<i32>
            sv.bpassign %regs_62, %272 : i32
            %273 = sv.array_index_inout %_RANDOM[%c63_i7] : !hw.inout<uarray<128xi32>>, i7
            %274 = sv.read_inout %273 : !hw.inout<i32>
            sv.bpassign %regs_63, %274 : i32
            %275 = sv.array_index_inout %_RANDOM[%c-64_i7] : !hw.inout<uarray<128xi32>>, i7
            %276 = sv.read_inout %275 : !hw.inout<i32>
            sv.bpassign %regs_64, %276 : i32
            %277 = sv.array_index_inout %_RANDOM[%c-63_i7] : !hw.inout<uarray<128xi32>>, i7
            %278 = sv.read_inout %277 : !hw.inout<i32>
            sv.bpassign %regs_65, %278 : i32
            %279 = sv.array_index_inout %_RANDOM[%c-62_i7] : !hw.inout<uarray<128xi32>>, i7
            %280 = sv.read_inout %279 : !hw.inout<i32>
            sv.bpassign %regs_66, %280 : i32
            %281 = sv.array_index_inout %_RANDOM[%c-61_i7] : !hw.inout<uarray<128xi32>>, i7
            %282 = sv.read_inout %281 : !hw.inout<i32>
            sv.bpassign %regs_67, %282 : i32
            %283 = sv.array_index_inout %_RANDOM[%c-60_i7] : !hw.inout<uarray<128xi32>>, i7
            %284 = sv.read_inout %283 : !hw.inout<i32>
            sv.bpassign %regs_68, %284 : i32
            %285 = sv.array_index_inout %_RANDOM[%c-59_i7] : !hw.inout<uarray<128xi32>>, i7
            %286 = sv.read_inout %285 : !hw.inout<i32>
            sv.bpassign %regs_69, %286 : i32
            %287 = sv.array_index_inout %_RANDOM[%c-58_i7] : !hw.inout<uarray<128xi32>>, i7
            %288 = sv.read_inout %287 : !hw.inout<i32>
            sv.bpassign %regs_70, %288 : i32
            %289 = sv.array_index_inout %_RANDOM[%c-57_i7] : !hw.inout<uarray<128xi32>>, i7
            %290 = sv.read_inout %289 : !hw.inout<i32>
            sv.bpassign %regs_71, %290 : i32
            %291 = sv.array_index_inout %_RANDOM[%c-56_i7] : !hw.inout<uarray<128xi32>>, i7
            %292 = sv.read_inout %291 : !hw.inout<i32>
            sv.bpassign %regs_72, %292 : i32
            %293 = sv.array_index_inout %_RANDOM[%c-55_i7] : !hw.inout<uarray<128xi32>>, i7
            %294 = sv.read_inout %293 : !hw.inout<i32>
            sv.bpassign %regs_73, %294 : i32
            %295 = sv.array_index_inout %_RANDOM[%c-54_i7] : !hw.inout<uarray<128xi32>>, i7
            %296 = sv.read_inout %295 : !hw.inout<i32>
            sv.bpassign %regs_74, %296 : i32
            %297 = sv.array_index_inout %_RANDOM[%c-53_i7] : !hw.inout<uarray<128xi32>>, i7
            %298 = sv.read_inout %297 : !hw.inout<i32>
            sv.bpassign %regs_75, %298 : i32
            %299 = sv.array_index_inout %_RANDOM[%c-52_i7] : !hw.inout<uarray<128xi32>>, i7
            %300 = sv.read_inout %299 : !hw.inout<i32>
            sv.bpassign %regs_76, %300 : i32
            %301 = sv.array_index_inout %_RANDOM[%c-51_i7] : !hw.inout<uarray<128xi32>>, i7
            %302 = sv.read_inout %301 : !hw.inout<i32>
            sv.bpassign %regs_77, %302 : i32
            %303 = sv.array_index_inout %_RANDOM[%c-50_i7] : !hw.inout<uarray<128xi32>>, i7
            %304 = sv.read_inout %303 : !hw.inout<i32>
            sv.bpassign %regs_78, %304 : i32
            %305 = sv.array_index_inout %_RANDOM[%c-49_i7] : !hw.inout<uarray<128xi32>>, i7
            %306 = sv.read_inout %305 : !hw.inout<i32>
            sv.bpassign %regs_79, %306 : i32
            %307 = sv.array_index_inout %_RANDOM[%c-48_i7] : !hw.inout<uarray<128xi32>>, i7
            %308 = sv.read_inout %307 : !hw.inout<i32>
            sv.bpassign %regs_80, %308 : i32
            %309 = sv.array_index_inout %_RANDOM[%c-47_i7] : !hw.inout<uarray<128xi32>>, i7
            %310 = sv.read_inout %309 : !hw.inout<i32>
            sv.bpassign %regs_81, %310 : i32
            %311 = sv.array_index_inout %_RANDOM[%c-46_i7] : !hw.inout<uarray<128xi32>>, i7
            %312 = sv.read_inout %311 : !hw.inout<i32>
            sv.bpassign %regs_82, %312 : i32
            %313 = sv.array_index_inout %_RANDOM[%c-45_i7] : !hw.inout<uarray<128xi32>>, i7
            %314 = sv.read_inout %313 : !hw.inout<i32>
            sv.bpassign %regs_83, %314 : i32
            %315 = sv.array_index_inout %_RANDOM[%c-44_i7] : !hw.inout<uarray<128xi32>>, i7
            %316 = sv.read_inout %315 : !hw.inout<i32>
            sv.bpassign %regs_84, %316 : i32
            %317 = sv.array_index_inout %_RANDOM[%c-43_i7] : !hw.inout<uarray<128xi32>>, i7
            %318 = sv.read_inout %317 : !hw.inout<i32>
            sv.bpassign %regs_85, %318 : i32
            %319 = sv.array_index_inout %_RANDOM[%c-42_i7] : !hw.inout<uarray<128xi32>>, i7
            %320 = sv.read_inout %319 : !hw.inout<i32>
            sv.bpassign %regs_86, %320 : i32
            %321 = sv.array_index_inout %_RANDOM[%c-41_i7] : !hw.inout<uarray<128xi32>>, i7
            %322 = sv.read_inout %321 : !hw.inout<i32>
            sv.bpassign %regs_87, %322 : i32
            %323 = sv.array_index_inout %_RANDOM[%c-40_i7] : !hw.inout<uarray<128xi32>>, i7
            %324 = sv.read_inout %323 : !hw.inout<i32>
            sv.bpassign %regs_88, %324 : i32
            %325 = sv.array_index_inout %_RANDOM[%c-39_i7] : !hw.inout<uarray<128xi32>>, i7
            %326 = sv.read_inout %325 : !hw.inout<i32>
            sv.bpassign %regs_89, %326 : i32
            %327 = sv.array_index_inout %_RANDOM[%c-38_i7] : !hw.inout<uarray<128xi32>>, i7
            %328 = sv.read_inout %327 : !hw.inout<i32>
            sv.bpassign %regs_90, %328 : i32
            %329 = sv.array_index_inout %_RANDOM[%c-37_i7] : !hw.inout<uarray<128xi32>>, i7
            %330 = sv.read_inout %329 : !hw.inout<i32>
            sv.bpassign %regs_91, %330 : i32
            %331 = sv.array_index_inout %_RANDOM[%c-36_i7] : !hw.inout<uarray<128xi32>>, i7
            %332 = sv.read_inout %331 : !hw.inout<i32>
            sv.bpassign %regs_92, %332 : i32
            %333 = sv.array_index_inout %_RANDOM[%c-35_i7] : !hw.inout<uarray<128xi32>>, i7
            %334 = sv.read_inout %333 : !hw.inout<i32>
            sv.bpassign %regs_93, %334 : i32
            %335 = sv.array_index_inout %_RANDOM[%c-34_i7] : !hw.inout<uarray<128xi32>>, i7
            %336 = sv.read_inout %335 : !hw.inout<i32>
            sv.bpassign %regs_94, %336 : i32
            %337 = sv.array_index_inout %_RANDOM[%c-33_i7] : !hw.inout<uarray<128xi32>>, i7
            %338 = sv.read_inout %337 : !hw.inout<i32>
            sv.bpassign %regs_95, %338 : i32
            %339 = sv.array_index_inout %_RANDOM[%c-32_i7] : !hw.inout<uarray<128xi32>>, i7
            %340 = sv.read_inout %339 : !hw.inout<i32>
            sv.bpassign %regs_96, %340 : i32
            %341 = sv.array_index_inout %_RANDOM[%c-31_i7] : !hw.inout<uarray<128xi32>>, i7
            %342 = sv.read_inout %341 : !hw.inout<i32>
            sv.bpassign %regs_97, %342 : i32
            %343 = sv.array_index_inout %_RANDOM[%c-30_i7] : !hw.inout<uarray<128xi32>>, i7
            %344 = sv.read_inout %343 : !hw.inout<i32>
            sv.bpassign %regs_98, %344 : i32
            %345 = sv.array_index_inout %_RANDOM[%c-29_i7] : !hw.inout<uarray<128xi32>>, i7
            %346 = sv.read_inout %345 : !hw.inout<i32>
            sv.bpassign %regs_99, %346 : i32
            %347 = sv.array_index_inout %_RANDOM[%c-28_i7] : !hw.inout<uarray<128xi32>>, i7
            %348 = sv.read_inout %347 : !hw.inout<i32>
            sv.bpassign %regs_100, %348 : i32
            %349 = sv.array_index_inout %_RANDOM[%c-27_i7] : !hw.inout<uarray<128xi32>>, i7
            %350 = sv.read_inout %349 : !hw.inout<i32>
            sv.bpassign %regs_101, %350 : i32
            %351 = sv.array_index_inout %_RANDOM[%c-26_i7] : !hw.inout<uarray<128xi32>>, i7
            %352 = sv.read_inout %351 : !hw.inout<i32>
            sv.bpassign %regs_102, %352 : i32
            %353 = sv.array_index_inout %_RANDOM[%c-25_i7] : !hw.inout<uarray<128xi32>>, i7
            %354 = sv.read_inout %353 : !hw.inout<i32>
            sv.bpassign %regs_103, %354 : i32
            %355 = sv.array_index_inout %_RANDOM[%c-24_i7] : !hw.inout<uarray<128xi32>>, i7
            %356 = sv.read_inout %355 : !hw.inout<i32>
            sv.bpassign %regs_104, %356 : i32
            %357 = sv.array_index_inout %_RANDOM[%c-23_i7] : !hw.inout<uarray<128xi32>>, i7
            %358 = sv.read_inout %357 : !hw.inout<i32>
            sv.bpassign %regs_105, %358 : i32
            %359 = sv.array_index_inout %_RANDOM[%c-22_i7] : !hw.inout<uarray<128xi32>>, i7
            %360 = sv.read_inout %359 : !hw.inout<i32>
            sv.bpassign %regs_106, %360 : i32
            %361 = sv.array_index_inout %_RANDOM[%c-21_i7] : !hw.inout<uarray<128xi32>>, i7
            %362 = sv.read_inout %361 : !hw.inout<i32>
            sv.bpassign %regs_107, %362 : i32
            %363 = sv.array_index_inout %_RANDOM[%c-20_i7] : !hw.inout<uarray<128xi32>>, i7
            %364 = sv.read_inout %363 : !hw.inout<i32>
            sv.bpassign %regs_108, %364 : i32
            %365 = sv.array_index_inout %_RANDOM[%c-19_i7] : !hw.inout<uarray<128xi32>>, i7
            %366 = sv.read_inout %365 : !hw.inout<i32>
            sv.bpassign %regs_109, %366 : i32
            %367 = sv.array_index_inout %_RANDOM[%c-18_i7] : !hw.inout<uarray<128xi32>>, i7
            %368 = sv.read_inout %367 : !hw.inout<i32>
            sv.bpassign %regs_110, %368 : i32
            %369 = sv.array_index_inout %_RANDOM[%c-17_i7] : !hw.inout<uarray<128xi32>>, i7
            %370 = sv.read_inout %369 : !hw.inout<i32>
            sv.bpassign %regs_111, %370 : i32
            %371 = sv.array_index_inout %_RANDOM[%c-16_i7] : !hw.inout<uarray<128xi32>>, i7
            %372 = sv.read_inout %371 : !hw.inout<i32>
            sv.bpassign %regs_112, %372 : i32
            %373 = sv.array_index_inout %_RANDOM[%c-15_i7] : !hw.inout<uarray<128xi32>>, i7
            %374 = sv.read_inout %373 : !hw.inout<i32>
            sv.bpassign %regs_113, %374 : i32
            %375 = sv.array_index_inout %_RANDOM[%c-14_i7] : !hw.inout<uarray<128xi32>>, i7
            %376 = sv.read_inout %375 : !hw.inout<i32>
            sv.bpassign %regs_114, %376 : i32
            %377 = sv.array_index_inout %_RANDOM[%c-13_i7] : !hw.inout<uarray<128xi32>>, i7
            %378 = sv.read_inout %377 : !hw.inout<i32>
            sv.bpassign %regs_115, %378 : i32
            %379 = sv.array_index_inout %_RANDOM[%c-12_i7] : !hw.inout<uarray<128xi32>>, i7
            %380 = sv.read_inout %379 : !hw.inout<i32>
            sv.bpassign %regs_116, %380 : i32
            %381 = sv.array_index_inout %_RANDOM[%c-11_i7] : !hw.inout<uarray<128xi32>>, i7
            %382 = sv.read_inout %381 : !hw.inout<i32>
            sv.bpassign %regs_117, %382 : i32
            %383 = sv.array_index_inout %_RANDOM[%c-10_i7] : !hw.inout<uarray<128xi32>>, i7
            %384 = sv.read_inout %383 : !hw.inout<i32>
            sv.bpassign %regs_118, %384 : i32
            %385 = sv.array_index_inout %_RANDOM[%c-9_i7] : !hw.inout<uarray<128xi32>>, i7
            %386 = sv.read_inout %385 : !hw.inout<i32>
            sv.bpassign %regs_119, %386 : i32
            %387 = sv.array_index_inout %_RANDOM[%c-8_i7] : !hw.inout<uarray<128xi32>>, i7
            %388 = sv.read_inout %387 : !hw.inout<i32>
            sv.bpassign %regs_120, %388 : i32
            %389 = sv.array_index_inout %_RANDOM[%c-7_i7] : !hw.inout<uarray<128xi32>>, i7
            %390 = sv.read_inout %389 : !hw.inout<i32>
            sv.bpassign %regs_121, %390 : i32
            %391 = sv.array_index_inout %_RANDOM[%c-6_i7] : !hw.inout<uarray<128xi32>>, i7
            %392 = sv.read_inout %391 : !hw.inout<i32>
            sv.bpassign %regs_122, %392 : i32
            %393 = sv.array_index_inout %_RANDOM[%c-5_i7] : !hw.inout<uarray<128xi32>>, i7
            %394 = sv.read_inout %393 : !hw.inout<i32>
            sv.bpassign %regs_123, %394 : i32
            %395 = sv.array_index_inout %_RANDOM[%c-4_i7] : !hw.inout<uarray<128xi32>>, i7
            %396 = sv.read_inout %395 : !hw.inout<i32>
            sv.bpassign %regs_124, %396 : i32
            %397 = sv.array_index_inout %_RANDOM[%c-3_i7] : !hw.inout<uarray<128xi32>>, i7
            %398 = sv.read_inout %397 : !hw.inout<i32>
            sv.bpassign %regs_125, %398 : i32
            %399 = sv.array_index_inout %_RANDOM[%c-2_i7] : !hw.inout<uarray<128xi32>>, i7
            %400 = sv.read_inout %399 : !hw.inout<i32>
            sv.bpassign %regs_126, %400 : i32
            %401 = sv.array_index_inout %_RANDOM[%c-1_i7] : !hw.inout<uarray<128xi32>>, i7
            %402 = sv.read_inout %401 : !hw.inout<i32>
            sv.bpassign %regs_127, %402 : i32
          }
        }
        sv.ifdef  @FIRRTL_AFTER_INITIAL {
          sv.verbatim "`FIRRTL_AFTER_INITIAL"
        }
      }
    }
    %145 = sv.read_inout %io_src1data : !hw.inout<i32>
    %146 = sv.read_inout %io_src2data : !hw.inout<i32>
    hw.output %145, %146 : i32, i32
  }
  hw.module private @TetraNyteCore_Anon(in %io_a : i32, in %io_b : i32, in %io_fn : i5, out io_out : i32) {
    %io_a_0 = sv.wire sym @sym name "io_a" {hw.verilogName = "io_a_0"} : !hw.inout<i32>
    sv.assign %io_a_0, %io_a : i32
    %io_b_1 = sv.wire sym @sym_0 name "io_b" {hw.verilogName = "io_b_0"} : !hw.inout<i32>
    sv.assign %io_b_1, %io_b : i32
    %io_fn_2 = sv.wire sym @sym_1 name "io_fn" {hw.verilogName = "io_fn_0"} : !hw.inout<i5>
    sv.assign %io_fn_2, %io_fn : i5
    %c1_i5 = hw.constant 1 : i5
    %false = hw.constant false
    %c0_i5 = hw.constant 0 : i5
    %c0_i32 = hw.constant 0 : i32
    %0 = sv.read_inout %io_fn_2 : !hw.inout<i5>
    %1 = comb.icmp bin eq %0, %c0_i5 {sv.namehint = "_T"} : i5
    %2 = sv.read_inout %io_a_0 : !hw.inout<i32>
    %3 = comb.concat %false, %2 : i1, i32
    %4 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<i33>
    sv.assign %4, %3 : i33
    %5 = sv.read_inout %io_b_1 : !hw.inout<i32>
    %6 = comb.concat %false, %5 : i1, i32
    %7 = sv.wire {hw.verilogName = "_GEN_0"} : !hw.inout<i33>
    sv.assign %7, %6 : i33
    %8 = sv.read_inout %4 : !hw.inout<i33>
    %9 = sv.read_inout %7 : !hw.inout<i33>
    %10 = comb.add bin %8, %9 : i33
    %_io_out_T = sv.wire sym @sym_3 {hw.verilogName = "_io_out_T"} : !hw.inout<i33>
    sv.assign %_io_out_T, %10 : i33
    %11 = sv.read_inout %_io_out_T : !hw.inout<i33>
    %12 = comb.extract %11 from 0 : (i33) -> i32
    %_io_out_T_1 = sv.wire sym @sym_4 {hw.verilogName = "_io_out_T_1"} : !hw.inout<i32>
    sv.assign %_io_out_T_1, %12 : i32
    %13 = sv.read_inout %io_fn_2 : !hw.inout<i5>
    %14 = comb.icmp bin eq %13, %c1_i5 {sv.namehint = "_T_1"} : i5
    %15 = sv.read_inout %4 : !hw.inout<i33>
    %16 = sv.read_inout %7 : !hw.inout<i33>
    %17 = comb.sub bin %15, %16 : i33
    %_io_out_T_2 = sv.wire sym @sym_5 {hw.verilogName = "_io_out_T_2"} : !hw.inout<i33>
    sv.assign %_io_out_T_2, %17 : i33
    %18 = sv.read_inout %_io_out_T_2 : !hw.inout<i33>
    %19 = comb.extract %18 from 0 : (i33) -> i32
    %_io_out_T_3 = sv.wire sym @sym_6 {hw.verilogName = "_io_out_T_3"} : !hw.inout<i32>
    sv.assign %_io_out_T_3, %19 : i32
    %20 = sv.read_inout %_io_out_T_3 : !hw.inout<i32>
    %21 = comb.mux bin %14, %20, %c0_i32 : i32
    %22 = sv.read_inout %_io_out_T_1 : !hw.inout<i32>
    %23 = comb.mux bin %1, %22, %21 : i32
    %io_out = sv.wire sym @sym_2 {hw.verilogName = "io_out_0"} : !hw.inout<i32>
    sv.assign %io_out, %23 : i32
    %24 = sv.read_inout %io_out : !hw.inout<i32>
    hw.output %24 : i32
  }
  hw.module private @instrMem_1024x32(in %R0_addr : i10, in %R0_en : i1, in %R0_clk : i1, out R0_data : i32, in %W0_addr : i10, in %W0_en : i1, in %W0_clk : i1, in %W0_data : i32) attributes {comment = "VCS coverage exclude_file", emit.fragments = [@RANDOM_INIT_REG_FRAGMENT, @RANDOM_INIT_MEM_FRAGMENT, @RANDOM_INIT_FRAGMENT]} {
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
  hw.module @TetraNyteCore(in %clock : i1, in %reset : i1, out io_memAddr : i32, out io_memWdata : i32, in %io_memRdata : i32, out io_memWe : i1, in %io_instrWriteEnable : i1, in %io_instrWriteAddr : i10, in %io_instrWriteData : i32, in %io_debug : i1) attributes {emit.fragments = [@RANDOM_INIT_REG_FRAGMENT, @RANDOM_INIT_FRAGMENT]} {
    %io_memRdata_0 = sv.wire sym @sym_1 name "io_memRdata" {hw.verilogName = "io_memRdata_0"} : !hw.inout<i32>
    sv.assign %io_memRdata_0, %io_memRdata : i32
    %io_instrWriteEnable_1 = sv.wire sym @sym_3 name "io_instrWriteEnable" {hw.verilogName = "io_instrWriteEnable_0"} : !hw.inout<i1>
    sv.assign %io_instrWriteEnable_1, %io_instrWriteEnable : i1
    %io_instrWriteAddr_2 = sv.wire sym @sym_4 name "io_instrWriteAddr" {hw.verilogName = "io_instrWriteAddr_0"} : !hw.inout<i10>
    sv.assign %io_instrWriteAddr_2, %io_instrWriteAddr : i10
    %io_instrWriteData_3 = sv.wire sym @sym_5 name "io_instrWriteData" {hw.verilogName = "io_instrWriteData_0"} : !hw.inout<i32>
    sv.assign %io_instrWriteData_3, %io_instrWriteData : i32
    %io_debug_4 = sv.wire sym @sym_6 name "io_debug" {hw.verilogName = "io_debug_0"} : !hw.inout<i1>
    sv.assign %io_debug_4, %io_debug : i1
    %true = hw.constant true
    %ifWire_valid = sv.wire sym @sym_1160 {hw.verilogName = "ifWire_valid"} : !hw.inout<i1>
    sv.assign %ifWire_valid, %true : i1
    %c35_i7 = hw.constant 35 : i7
    %c3_i7 = hw.constant 3 : i7
    %c51_i7 = hw.constant 51 : i7
    %c4_i33 = hw.constant 4 : i33
    %c1_i3 = hw.constant 1 : i3
    %c0_i2 = hw.constant 0 : i2
    %_ifStage_WIRE_threadId = sv.wire sym @sym_18 {hw.verilogName = "_ifStage_WIRE_threadId"} : !hw.inout<i2>
    sv.assign %_ifStage_WIRE_threadId, %c0_i2 : i2
    %_ifStage_WIRE_1_threadId = sv.wire sym @sym_43 {hw.verilogName = "_ifStage_WIRE_1_threadId"} : !hw.inout<i2>
    sv.assign %_ifStage_WIRE_1_threadId, %c0_i2 : i2
    %_ifStage_WIRE_2_threadId = sv.wire sym @sym_68 {hw.verilogName = "_ifStage_WIRE_2_threadId"} : !hw.inout<i2>
    sv.assign %_ifStage_WIRE_2_threadId, %c0_i2 : i2
    %_ifStage_WIRE_3_threadId = sv.wire sym @sym_93 {hw.verilogName = "_ifStage_WIRE_3_threadId"} : !hw.inout<i2>
    sv.assign %_ifStage_WIRE_3_threadId, %c0_i2 : i2
    %_ifStage_WIRE_4_0_threadId = sv.wire sym @sym_118 {hw.verilogName = "_ifStage_WIRE_4_0_threadId"} : !hw.inout<i2>
    sv.assign %_ifStage_WIRE_4_0_threadId, %c0_i2 : i2
    %_ifStage_WIRE_4_1_threadId = sv.wire sym @sym_143 {hw.verilogName = "_ifStage_WIRE_4_1_threadId"} : !hw.inout<i2>
    sv.assign %_ifStage_WIRE_4_1_threadId, %c0_i2 : i2
    %_ifStage_WIRE_4_2_threadId = sv.wire sym @sym_168 {hw.verilogName = "_ifStage_WIRE_4_2_threadId"} : !hw.inout<i2>
    sv.assign %_ifStage_WIRE_4_2_threadId, %c0_i2 : i2
    %_ifStage_WIRE_4_3_threadId = sv.wire sym @sym_193 {hw.verilogName = "_ifStage_WIRE_4_3_threadId"} : !hw.inout<i2>
    sv.assign %_ifStage_WIRE_4_3_threadId, %c0_i2 : i2
    %_decStage_WIRE_threadId = sv.wire sym @sym_234 {hw.verilogName = "_decStage_WIRE_threadId"} : !hw.inout<i2>
    sv.assign %_decStage_WIRE_threadId, %c0_i2 : i2
    %_decStage_WIRE_1_threadId = sv.wire sym @sym_259 {hw.verilogName = "_decStage_WIRE_1_threadId"} : !hw.inout<i2>
    sv.assign %_decStage_WIRE_1_threadId, %c0_i2 : i2
    %_decStage_WIRE_2_threadId = sv.wire sym @sym_284 {hw.verilogName = "_decStage_WIRE_2_threadId"} : !hw.inout<i2>
    sv.assign %_decStage_WIRE_2_threadId, %c0_i2 : i2
    %_decStage_WIRE_3_threadId = sv.wire sym @sym_309 {hw.verilogName = "_decStage_WIRE_3_threadId"} : !hw.inout<i2>
    sv.assign %_decStage_WIRE_3_threadId, %c0_i2 : i2
    %_decStage_WIRE_4_0_threadId = sv.wire sym @sym_334 {hw.verilogName = "_decStage_WIRE_4_0_threadId"} : !hw.inout<i2>
    sv.assign %_decStage_WIRE_4_0_threadId, %c0_i2 : i2
    %_decStage_WIRE_4_1_threadId = sv.wire sym @sym_359 {hw.verilogName = "_decStage_WIRE_4_1_threadId"} : !hw.inout<i2>
    sv.assign %_decStage_WIRE_4_1_threadId, %c0_i2 : i2
    %_decStage_WIRE_4_2_threadId = sv.wire sym @sym_384 {hw.verilogName = "_decStage_WIRE_4_2_threadId"} : !hw.inout<i2>
    sv.assign %_decStage_WIRE_4_2_threadId, %c0_i2 : i2
    %_decStage_WIRE_4_3_threadId = sv.wire sym @sym_409 {hw.verilogName = "_decStage_WIRE_4_3_threadId"} : !hw.inout<i2>
    sv.assign %_decStage_WIRE_4_3_threadId, %c0_i2 : i2
    %_exStage_WIRE_threadId = sv.wire sym @sym_534 {hw.verilogName = "_exStage_WIRE_threadId"} : !hw.inout<i2>
    sv.assign %_exStage_WIRE_threadId, %c0_i2 : i2
    %_exStage_WIRE_1_threadId = sv.wire sym @sym_559 {hw.verilogName = "_exStage_WIRE_1_threadId"} : !hw.inout<i2>
    sv.assign %_exStage_WIRE_1_threadId, %c0_i2 : i2
    %_exStage_WIRE_2_threadId = sv.wire sym @sym_584 {hw.verilogName = "_exStage_WIRE_2_threadId"} : !hw.inout<i2>
    sv.assign %_exStage_WIRE_2_threadId, %c0_i2 : i2
    %_exStage_WIRE_3_threadId = sv.wire sym @sym_609 {hw.verilogName = "_exStage_WIRE_3_threadId"} : !hw.inout<i2>
    sv.assign %_exStage_WIRE_3_threadId, %c0_i2 : i2
    %_exStage_WIRE_4_0_threadId = sv.wire sym @sym_634 {hw.verilogName = "_exStage_WIRE_4_0_threadId"} : !hw.inout<i2>
    sv.assign %_exStage_WIRE_4_0_threadId, %c0_i2 : i2
    %_exStage_WIRE_4_1_threadId = sv.wire sym @sym_659 {hw.verilogName = "_exStage_WIRE_4_1_threadId"} : !hw.inout<i2>
    sv.assign %_exStage_WIRE_4_1_threadId, %c0_i2 : i2
    %_exStage_WIRE_4_2_threadId = sv.wire sym @sym_684 {hw.verilogName = "_exStage_WIRE_4_2_threadId"} : !hw.inout<i2>
    sv.assign %_exStage_WIRE_4_2_threadId, %c0_i2 : i2
    %_exStage_WIRE_4_3_threadId = sv.wire sym @sym_709 {hw.verilogName = "_exStage_WIRE_4_3_threadId"} : !hw.inout<i2>
    sv.assign %_exStage_WIRE_4_3_threadId, %c0_i2 : i2
    %_memStage_WIRE_threadId = sv.wire sym @sym_834 {hw.verilogName = "_memStage_WIRE_threadId"} : !hw.inout<i2>
    sv.assign %_memStage_WIRE_threadId, %c0_i2 : i2
    %_memStage_WIRE_1_threadId = sv.wire sym @sym_859 {hw.verilogName = "_memStage_WIRE_1_threadId"} : !hw.inout<i2>
    sv.assign %_memStage_WIRE_1_threadId, %c0_i2 : i2
    %_memStage_WIRE_2_threadId = sv.wire sym @sym_884 {hw.verilogName = "_memStage_WIRE_2_threadId"} : !hw.inout<i2>
    sv.assign %_memStage_WIRE_2_threadId, %c0_i2 : i2
    %_memStage_WIRE_3_threadId = sv.wire sym @sym_909 {hw.verilogName = "_memStage_WIRE_3_threadId"} : !hw.inout<i2>
    sv.assign %_memStage_WIRE_3_threadId, %c0_i2 : i2
    %_memStage_WIRE_4_0_threadId = sv.wire sym @sym_934 {hw.verilogName = "_memStage_WIRE_4_0_threadId"} : !hw.inout<i2>
    sv.assign %_memStage_WIRE_4_0_threadId, %c0_i2 : i2
    %_memStage_WIRE_4_1_threadId = sv.wire sym @sym_959 {hw.verilogName = "_memStage_WIRE_4_1_threadId"} : !hw.inout<i2>
    sv.assign %_memStage_WIRE_4_1_threadId, %c0_i2 : i2
    %_memStage_WIRE_4_2_threadId = sv.wire sym @sym_984 {hw.verilogName = "_memStage_WIRE_4_2_threadId"} : !hw.inout<i2>
    sv.assign %_memStage_WIRE_4_2_threadId, %c0_i2 : i2
    %_memStage_WIRE_4_3_threadId = sv.wire sym @sym_1009 {hw.verilogName = "_memStage_WIRE_4_3_threadId"} : !hw.inout<i2>
    sv.assign %_memStage_WIRE_4_3_threadId, %c0_i2 : i2
    %_ifWire_WIRE_threadId = sv.wire sym @sym_1134 {hw.verilogName = "_ifWire_WIRE_threadId"} : !hw.inout<i2>
    sv.assign %_ifWire_WIRE_threadId, %c0_i2 : i2
    %_decWire_WIRE_threadId = sv.wire sym @sym_1189 {hw.verilogName = "_decWire_WIRE_threadId"} : !hw.inout<i2>
    sv.assign %_decWire_WIRE_threadId, %c0_i2 : i2
    %_exWire_WIRE_threadId = sv.wire sym @sym_1243 {hw.verilogName = "_exWire_WIRE_threadId"} : !hw.inout<i2>
    sv.assign %_exWire_WIRE_threadId, %c0_i2 : i2
    %_memWire_WIRE_threadId = sv.wire sym @sym_1295 {hw.verilogName = "_memWire_WIRE_threadId"} : !hw.inout<i2>
    sv.assign %_memWire_WIRE_threadId, %c0_i2 : i2
    %false = hw.constant false
    %_ifStage_WIRE_valid = sv.wire sym @sym_19 {hw.verilogName = "_ifStage_WIRE_valid"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_valid, %false : i1
    %_ifStage_WIRE_isALU = sv.wire sym @sym_22 {hw.verilogName = "_ifStage_WIRE_isALU"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isALU, %false : i1
    %_ifStage_WIRE_isLoad = sv.wire sym @sym_23 {hw.verilogName = "_ifStage_WIRE_isLoad"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isLoad, %false : i1
    %_ifStage_WIRE_isStore = sv.wire sym @sym_24 {hw.verilogName = "_ifStage_WIRE_isStore"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isStore, %false : i1
    %_ifStage_WIRE_isBranch = sv.wire sym @sym_25 {hw.verilogName = "_ifStage_WIRE_isBranch"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isBranch, %false : i1
    %_ifStage_WIRE_isJAL = sv.wire sym @sym_26 {hw.verilogName = "_ifStage_WIRE_isJAL"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isJAL, %false : i1
    %_ifStage_WIRE_isJALR = sv.wire sym @sym_27 {hw.verilogName = "_ifStage_WIRE_isJALR"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isJALR, %false : i1
    %_ifStage_WIRE_isLUI = sv.wire sym @sym_28 {hw.verilogName = "_ifStage_WIRE_isLUI"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isLUI, %false : i1
    %_ifStage_WIRE_isAUIPC = sv.wire sym @sym_29 {hw.verilogName = "_ifStage_WIRE_isAUIPC"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isAUIPC, %false : i1
    %_ifStage_WIRE_isFence = sv.wire sym @sym_30 {hw.verilogName = "_ifStage_WIRE_isFence"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isFence, %false : i1
    %_ifStage_WIRE_isSystem = sv.wire sym @sym_31 {hw.verilogName = "_ifStage_WIRE_isSystem"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_isSystem, %false : i1
    %_ifStage_WIRE_1_valid = sv.wire sym @sym_44 {hw.verilogName = "_ifStage_WIRE_1_valid"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_valid, %false : i1
    %_ifStage_WIRE_1_isALU = sv.wire sym @sym_47 {hw.verilogName = "_ifStage_WIRE_1_isALU"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isALU, %false : i1
    %_ifStage_WIRE_1_isLoad = sv.wire sym @sym_48 {hw.verilogName = "_ifStage_WIRE_1_isLoad"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isLoad, %false : i1
    %_ifStage_WIRE_1_isStore = sv.wire sym @sym_49 {hw.verilogName = "_ifStage_WIRE_1_isStore"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isStore, %false : i1
    %_ifStage_WIRE_1_isBranch = sv.wire sym @sym_50 {hw.verilogName = "_ifStage_WIRE_1_isBranch"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isBranch, %false : i1
    %_ifStage_WIRE_1_isJAL = sv.wire sym @sym_51 {hw.verilogName = "_ifStage_WIRE_1_isJAL"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isJAL, %false : i1
    %_ifStage_WIRE_1_isJALR = sv.wire sym @sym_52 {hw.verilogName = "_ifStage_WIRE_1_isJALR"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isJALR, %false : i1
    %_ifStage_WIRE_1_isLUI = sv.wire sym @sym_53 {hw.verilogName = "_ifStage_WIRE_1_isLUI"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isLUI, %false : i1
    %_ifStage_WIRE_1_isAUIPC = sv.wire sym @sym_54 {hw.verilogName = "_ifStage_WIRE_1_isAUIPC"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isAUIPC, %false : i1
    %_ifStage_WIRE_1_isFence = sv.wire sym @sym_55 {hw.verilogName = "_ifStage_WIRE_1_isFence"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isFence, %false : i1
    %_ifStage_WIRE_1_isSystem = sv.wire sym @sym_56 {hw.verilogName = "_ifStage_WIRE_1_isSystem"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_1_isSystem, %false : i1
    %_ifStage_WIRE_2_valid = sv.wire sym @sym_69 {hw.verilogName = "_ifStage_WIRE_2_valid"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_valid, %false : i1
    %_ifStage_WIRE_2_isALU = sv.wire sym @sym_72 {hw.verilogName = "_ifStage_WIRE_2_isALU"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isALU, %false : i1
    %_ifStage_WIRE_2_isLoad = sv.wire sym @sym_73 {hw.verilogName = "_ifStage_WIRE_2_isLoad"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isLoad, %false : i1
    %_ifStage_WIRE_2_isStore = sv.wire sym @sym_74 {hw.verilogName = "_ifStage_WIRE_2_isStore"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isStore, %false : i1
    %_ifStage_WIRE_2_isBranch = sv.wire sym @sym_75 {hw.verilogName = "_ifStage_WIRE_2_isBranch"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isBranch, %false : i1
    %_ifStage_WIRE_2_isJAL = sv.wire sym @sym_76 {hw.verilogName = "_ifStage_WIRE_2_isJAL"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isJAL, %false : i1
    %_ifStage_WIRE_2_isJALR = sv.wire sym @sym_77 {hw.verilogName = "_ifStage_WIRE_2_isJALR"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isJALR, %false : i1
    %_ifStage_WIRE_2_isLUI = sv.wire sym @sym_78 {hw.verilogName = "_ifStage_WIRE_2_isLUI"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isLUI, %false : i1
    %_ifStage_WIRE_2_isAUIPC = sv.wire sym @sym_79 {hw.verilogName = "_ifStage_WIRE_2_isAUIPC"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isAUIPC, %false : i1
    %_ifStage_WIRE_2_isFence = sv.wire sym @sym_80 {hw.verilogName = "_ifStage_WIRE_2_isFence"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isFence, %false : i1
    %_ifStage_WIRE_2_isSystem = sv.wire sym @sym_81 {hw.verilogName = "_ifStage_WIRE_2_isSystem"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_2_isSystem, %false : i1
    %_ifStage_WIRE_3_valid = sv.wire sym @sym_94 {hw.verilogName = "_ifStage_WIRE_3_valid"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_valid, %false : i1
    %_ifStage_WIRE_3_isALU = sv.wire sym @sym_97 {hw.verilogName = "_ifStage_WIRE_3_isALU"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isALU, %false : i1
    %_ifStage_WIRE_3_isLoad = sv.wire sym @sym_98 {hw.verilogName = "_ifStage_WIRE_3_isLoad"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isLoad, %false : i1
    %_ifStage_WIRE_3_isStore = sv.wire sym @sym_99 {hw.verilogName = "_ifStage_WIRE_3_isStore"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isStore, %false : i1
    %_ifStage_WIRE_3_isBranch = sv.wire sym @sym_100 {hw.verilogName = "_ifStage_WIRE_3_isBranch"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isBranch, %false : i1
    %_ifStage_WIRE_3_isJAL = sv.wire sym @sym_101 {hw.verilogName = "_ifStage_WIRE_3_isJAL"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isJAL, %false : i1
    %_ifStage_WIRE_3_isJALR = sv.wire sym @sym_102 {hw.verilogName = "_ifStage_WIRE_3_isJALR"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isJALR, %false : i1
    %_ifStage_WIRE_3_isLUI = sv.wire sym @sym_103 {hw.verilogName = "_ifStage_WIRE_3_isLUI"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isLUI, %false : i1
    %_ifStage_WIRE_3_isAUIPC = sv.wire sym @sym_104 {hw.verilogName = "_ifStage_WIRE_3_isAUIPC"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isAUIPC, %false : i1
    %_ifStage_WIRE_3_isFence = sv.wire sym @sym_105 {hw.verilogName = "_ifStage_WIRE_3_isFence"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isFence, %false : i1
    %_ifStage_WIRE_3_isSystem = sv.wire sym @sym_106 {hw.verilogName = "_ifStage_WIRE_3_isSystem"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_3_isSystem, %false : i1
    %_ifStage_WIRE_4_0_valid = sv.wire sym @sym_119 {hw.verilogName = "_ifStage_WIRE_4_0_valid"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_valid, %false : i1
    %_ifStage_WIRE_4_0_isALU = sv.wire sym @sym_122 {hw.verilogName = "_ifStage_WIRE_4_0_isALU"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isALU, %false : i1
    %_ifStage_WIRE_4_0_isLoad = sv.wire sym @sym_123 {hw.verilogName = "_ifStage_WIRE_4_0_isLoad"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isLoad, %false : i1
    %_ifStage_WIRE_4_0_isStore = sv.wire sym @sym_124 {hw.verilogName = "_ifStage_WIRE_4_0_isStore"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isStore, %false : i1
    %_ifStage_WIRE_4_0_isBranch = sv.wire sym @sym_125 {hw.verilogName = "_ifStage_WIRE_4_0_isBranch"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isBranch, %false : i1
    %_ifStage_WIRE_4_0_isJAL = sv.wire sym @sym_126 {hw.verilogName = "_ifStage_WIRE_4_0_isJAL"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isJAL, %false : i1
    %_ifStage_WIRE_4_0_isJALR = sv.wire sym @sym_127 {hw.verilogName = "_ifStage_WIRE_4_0_isJALR"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isJALR, %false : i1
    %_ifStage_WIRE_4_0_isLUI = sv.wire sym @sym_128 {hw.verilogName = "_ifStage_WIRE_4_0_isLUI"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isLUI, %false : i1
    %_ifStage_WIRE_4_0_isAUIPC = sv.wire sym @sym_129 {hw.verilogName = "_ifStage_WIRE_4_0_isAUIPC"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isAUIPC, %false : i1
    %_ifStage_WIRE_4_0_isFence = sv.wire sym @sym_130 {hw.verilogName = "_ifStage_WIRE_4_0_isFence"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isFence, %false : i1
    %_ifStage_WIRE_4_0_isSystem = sv.wire sym @sym_131 {hw.verilogName = "_ifStage_WIRE_4_0_isSystem"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_0_isSystem, %false : i1
    %_ifStage_WIRE_4_1_valid = sv.wire sym @sym_144 {hw.verilogName = "_ifStage_WIRE_4_1_valid"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_valid, %false : i1
    %_ifStage_WIRE_4_1_isALU = sv.wire sym @sym_147 {hw.verilogName = "_ifStage_WIRE_4_1_isALU"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isALU, %false : i1
    %_ifStage_WIRE_4_1_isLoad = sv.wire sym @sym_148 {hw.verilogName = "_ifStage_WIRE_4_1_isLoad"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isLoad, %false : i1
    %_ifStage_WIRE_4_1_isStore = sv.wire sym @sym_149 {hw.verilogName = "_ifStage_WIRE_4_1_isStore"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isStore, %false : i1
    %_ifStage_WIRE_4_1_isBranch = sv.wire sym @sym_150 {hw.verilogName = "_ifStage_WIRE_4_1_isBranch"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isBranch, %false : i1
    %_ifStage_WIRE_4_1_isJAL = sv.wire sym @sym_151 {hw.verilogName = "_ifStage_WIRE_4_1_isJAL"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isJAL, %false : i1
    %_ifStage_WIRE_4_1_isJALR = sv.wire sym @sym_152 {hw.verilogName = "_ifStage_WIRE_4_1_isJALR"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isJALR, %false : i1
    %_ifStage_WIRE_4_1_isLUI = sv.wire sym @sym_153 {hw.verilogName = "_ifStage_WIRE_4_1_isLUI"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isLUI, %false : i1
    %_ifStage_WIRE_4_1_isAUIPC = sv.wire sym @sym_154 {hw.verilogName = "_ifStage_WIRE_4_1_isAUIPC"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isAUIPC, %false : i1
    %_ifStage_WIRE_4_1_isFence = sv.wire sym @sym_155 {hw.verilogName = "_ifStage_WIRE_4_1_isFence"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isFence, %false : i1
    %_ifStage_WIRE_4_1_isSystem = sv.wire sym @sym_156 {hw.verilogName = "_ifStage_WIRE_4_1_isSystem"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_1_isSystem, %false : i1
    %_ifStage_WIRE_4_2_valid = sv.wire sym @sym_169 {hw.verilogName = "_ifStage_WIRE_4_2_valid"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_valid, %false : i1
    %_ifStage_WIRE_4_2_isALU = sv.wire sym @sym_172 {hw.verilogName = "_ifStage_WIRE_4_2_isALU"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isALU, %false : i1
    %_ifStage_WIRE_4_2_isLoad = sv.wire sym @sym_173 {hw.verilogName = "_ifStage_WIRE_4_2_isLoad"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isLoad, %false : i1
    %_ifStage_WIRE_4_2_isStore = sv.wire sym @sym_174 {hw.verilogName = "_ifStage_WIRE_4_2_isStore"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isStore, %false : i1
    %_ifStage_WIRE_4_2_isBranch = sv.wire sym @sym_175 {hw.verilogName = "_ifStage_WIRE_4_2_isBranch"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isBranch, %false : i1
    %_ifStage_WIRE_4_2_isJAL = sv.wire sym @sym_176 {hw.verilogName = "_ifStage_WIRE_4_2_isJAL"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isJAL, %false : i1
    %_ifStage_WIRE_4_2_isJALR = sv.wire sym @sym_177 {hw.verilogName = "_ifStage_WIRE_4_2_isJALR"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isJALR, %false : i1
    %_ifStage_WIRE_4_2_isLUI = sv.wire sym @sym_178 {hw.verilogName = "_ifStage_WIRE_4_2_isLUI"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isLUI, %false : i1
    %_ifStage_WIRE_4_2_isAUIPC = sv.wire sym @sym_179 {hw.verilogName = "_ifStage_WIRE_4_2_isAUIPC"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isAUIPC, %false : i1
    %_ifStage_WIRE_4_2_isFence = sv.wire sym @sym_180 {hw.verilogName = "_ifStage_WIRE_4_2_isFence"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isFence, %false : i1
    %_ifStage_WIRE_4_2_isSystem = sv.wire sym @sym_181 {hw.verilogName = "_ifStage_WIRE_4_2_isSystem"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_2_isSystem, %false : i1
    %_ifStage_WIRE_4_3_valid = sv.wire sym @sym_194 {hw.verilogName = "_ifStage_WIRE_4_3_valid"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_valid, %false : i1
    %_ifStage_WIRE_4_3_isALU = sv.wire sym @sym_197 {hw.verilogName = "_ifStage_WIRE_4_3_isALU"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isALU, %false : i1
    %_ifStage_WIRE_4_3_isLoad = sv.wire sym @sym_198 {hw.verilogName = "_ifStage_WIRE_4_3_isLoad"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isLoad, %false : i1
    %_ifStage_WIRE_4_3_isStore = sv.wire sym @sym_199 {hw.verilogName = "_ifStage_WIRE_4_3_isStore"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isStore, %false : i1
    %_ifStage_WIRE_4_3_isBranch = sv.wire sym @sym_200 {hw.verilogName = "_ifStage_WIRE_4_3_isBranch"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isBranch, %false : i1
    %_ifStage_WIRE_4_3_isJAL = sv.wire sym @sym_201 {hw.verilogName = "_ifStage_WIRE_4_3_isJAL"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isJAL, %false : i1
    %_ifStage_WIRE_4_3_isJALR = sv.wire sym @sym_202 {hw.verilogName = "_ifStage_WIRE_4_3_isJALR"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isJALR, %false : i1
    %_ifStage_WIRE_4_3_isLUI = sv.wire sym @sym_203 {hw.verilogName = "_ifStage_WIRE_4_3_isLUI"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isLUI, %false : i1
    %_ifStage_WIRE_4_3_isAUIPC = sv.wire sym @sym_204 {hw.verilogName = "_ifStage_WIRE_4_3_isAUIPC"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isAUIPC, %false : i1
    %_ifStage_WIRE_4_3_isFence = sv.wire sym @sym_205 {hw.verilogName = "_ifStage_WIRE_4_3_isFence"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isFence, %false : i1
    %_ifStage_WIRE_4_3_isSystem = sv.wire sym @sym_206 {hw.verilogName = "_ifStage_WIRE_4_3_isSystem"} : !hw.inout<i1>
    sv.assign %_ifStage_WIRE_4_3_isSystem, %false : i1
    %_decStage_WIRE_valid = sv.wire sym @sym_235 {hw.verilogName = "_decStage_WIRE_valid"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_valid, %false : i1
    %_decStage_WIRE_isALU = sv.wire sym @sym_238 {hw.verilogName = "_decStage_WIRE_isALU"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isALU, %false : i1
    %_decStage_WIRE_isLoad = sv.wire sym @sym_239 {hw.verilogName = "_decStage_WIRE_isLoad"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isLoad, %false : i1
    %_decStage_WIRE_isStore = sv.wire sym @sym_240 {hw.verilogName = "_decStage_WIRE_isStore"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isStore, %false : i1
    %_decStage_WIRE_isBranch = sv.wire sym @sym_241 {hw.verilogName = "_decStage_WIRE_isBranch"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isBranch, %false : i1
    %_decStage_WIRE_isJAL = sv.wire sym @sym_242 {hw.verilogName = "_decStage_WIRE_isJAL"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isJAL, %false : i1
    %_decStage_WIRE_isJALR = sv.wire sym @sym_243 {hw.verilogName = "_decStage_WIRE_isJALR"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isJALR, %false : i1
    %_decStage_WIRE_isLUI = sv.wire sym @sym_244 {hw.verilogName = "_decStage_WIRE_isLUI"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isLUI, %false : i1
    %_decStage_WIRE_isAUIPC = sv.wire sym @sym_245 {hw.verilogName = "_decStage_WIRE_isAUIPC"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isAUIPC, %false : i1
    %_decStage_WIRE_isFence = sv.wire sym @sym_246 {hw.verilogName = "_decStage_WIRE_isFence"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isFence, %false : i1
    %_decStage_WIRE_isSystem = sv.wire sym @sym_247 {hw.verilogName = "_decStage_WIRE_isSystem"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_isSystem, %false : i1
    %_decStage_WIRE_1_valid = sv.wire sym @sym_260 {hw.verilogName = "_decStage_WIRE_1_valid"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_valid, %false : i1
    %_decStage_WIRE_1_isALU = sv.wire sym @sym_263 {hw.verilogName = "_decStage_WIRE_1_isALU"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isALU, %false : i1
    %_decStage_WIRE_1_isLoad = sv.wire sym @sym_264 {hw.verilogName = "_decStage_WIRE_1_isLoad"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isLoad, %false : i1
    %_decStage_WIRE_1_isStore = sv.wire sym @sym_265 {hw.verilogName = "_decStage_WIRE_1_isStore"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isStore, %false : i1
    %_decStage_WIRE_1_isBranch = sv.wire sym @sym_266 {hw.verilogName = "_decStage_WIRE_1_isBranch"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isBranch, %false : i1
    %_decStage_WIRE_1_isJAL = sv.wire sym @sym_267 {hw.verilogName = "_decStage_WIRE_1_isJAL"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isJAL, %false : i1
    %_decStage_WIRE_1_isJALR = sv.wire sym @sym_268 {hw.verilogName = "_decStage_WIRE_1_isJALR"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isJALR, %false : i1
    %_decStage_WIRE_1_isLUI = sv.wire sym @sym_269 {hw.verilogName = "_decStage_WIRE_1_isLUI"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isLUI, %false : i1
    %_decStage_WIRE_1_isAUIPC = sv.wire sym @sym_270 {hw.verilogName = "_decStage_WIRE_1_isAUIPC"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isAUIPC, %false : i1
    %_decStage_WIRE_1_isFence = sv.wire sym @sym_271 {hw.verilogName = "_decStage_WIRE_1_isFence"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isFence, %false : i1
    %_decStage_WIRE_1_isSystem = sv.wire sym @sym_272 {hw.verilogName = "_decStage_WIRE_1_isSystem"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_1_isSystem, %false : i1
    %_decStage_WIRE_2_valid = sv.wire sym @sym_285 {hw.verilogName = "_decStage_WIRE_2_valid"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_valid, %false : i1
    %_decStage_WIRE_2_isALU = sv.wire sym @sym_288 {hw.verilogName = "_decStage_WIRE_2_isALU"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isALU, %false : i1
    %_decStage_WIRE_2_isLoad = sv.wire sym @sym_289 {hw.verilogName = "_decStage_WIRE_2_isLoad"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isLoad, %false : i1
    %_decStage_WIRE_2_isStore = sv.wire sym @sym_290 {hw.verilogName = "_decStage_WIRE_2_isStore"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isStore, %false : i1
    %_decStage_WIRE_2_isBranch = sv.wire sym @sym_291 {hw.verilogName = "_decStage_WIRE_2_isBranch"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isBranch, %false : i1
    %_decStage_WIRE_2_isJAL = sv.wire sym @sym_292 {hw.verilogName = "_decStage_WIRE_2_isJAL"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isJAL, %false : i1
    %_decStage_WIRE_2_isJALR = sv.wire sym @sym_293 {hw.verilogName = "_decStage_WIRE_2_isJALR"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isJALR, %false : i1
    %_decStage_WIRE_2_isLUI = sv.wire sym @sym_294 {hw.verilogName = "_decStage_WIRE_2_isLUI"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isLUI, %false : i1
    %_decStage_WIRE_2_isAUIPC = sv.wire sym @sym_295 {hw.verilogName = "_decStage_WIRE_2_isAUIPC"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isAUIPC, %false : i1
    %_decStage_WIRE_2_isFence = sv.wire sym @sym_296 {hw.verilogName = "_decStage_WIRE_2_isFence"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isFence, %false : i1
    %_decStage_WIRE_2_isSystem = sv.wire sym @sym_297 {hw.verilogName = "_decStage_WIRE_2_isSystem"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_2_isSystem, %false : i1
    %_decStage_WIRE_3_valid = sv.wire sym @sym_310 {hw.verilogName = "_decStage_WIRE_3_valid"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_valid, %false : i1
    %_decStage_WIRE_3_isALU = sv.wire sym @sym_313 {hw.verilogName = "_decStage_WIRE_3_isALU"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isALU, %false : i1
    %_decStage_WIRE_3_isLoad = sv.wire sym @sym_314 {hw.verilogName = "_decStage_WIRE_3_isLoad"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isLoad, %false : i1
    %_decStage_WIRE_3_isStore = sv.wire sym @sym_315 {hw.verilogName = "_decStage_WIRE_3_isStore"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isStore, %false : i1
    %_decStage_WIRE_3_isBranch = sv.wire sym @sym_316 {hw.verilogName = "_decStage_WIRE_3_isBranch"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isBranch, %false : i1
    %_decStage_WIRE_3_isJAL = sv.wire sym @sym_317 {hw.verilogName = "_decStage_WIRE_3_isJAL"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isJAL, %false : i1
    %_decStage_WIRE_3_isJALR = sv.wire sym @sym_318 {hw.verilogName = "_decStage_WIRE_3_isJALR"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isJALR, %false : i1
    %_decStage_WIRE_3_isLUI = sv.wire sym @sym_319 {hw.verilogName = "_decStage_WIRE_3_isLUI"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isLUI, %false : i1
    %_decStage_WIRE_3_isAUIPC = sv.wire sym @sym_320 {hw.verilogName = "_decStage_WIRE_3_isAUIPC"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isAUIPC, %false : i1
    %_decStage_WIRE_3_isFence = sv.wire sym @sym_321 {hw.verilogName = "_decStage_WIRE_3_isFence"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isFence, %false : i1
    %_decStage_WIRE_3_isSystem = sv.wire sym @sym_322 {hw.verilogName = "_decStage_WIRE_3_isSystem"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_3_isSystem, %false : i1
    %_decStage_WIRE_4_0_valid = sv.wire sym @sym_335 {hw.verilogName = "_decStage_WIRE_4_0_valid"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_valid, %false : i1
    %_decStage_WIRE_4_0_isALU = sv.wire sym @sym_338 {hw.verilogName = "_decStage_WIRE_4_0_isALU"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isALU, %false : i1
    %_decStage_WIRE_4_0_isLoad = sv.wire sym @sym_339 {hw.verilogName = "_decStage_WIRE_4_0_isLoad"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isLoad, %false : i1
    %_decStage_WIRE_4_0_isStore = sv.wire sym @sym_340 {hw.verilogName = "_decStage_WIRE_4_0_isStore"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isStore, %false : i1
    %_decStage_WIRE_4_0_isBranch = sv.wire sym @sym_341 {hw.verilogName = "_decStage_WIRE_4_0_isBranch"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isBranch, %false : i1
    %_decStage_WIRE_4_0_isJAL = sv.wire sym @sym_342 {hw.verilogName = "_decStage_WIRE_4_0_isJAL"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isJAL, %false : i1
    %_decStage_WIRE_4_0_isJALR = sv.wire sym @sym_343 {hw.verilogName = "_decStage_WIRE_4_0_isJALR"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isJALR, %false : i1
    %_decStage_WIRE_4_0_isLUI = sv.wire sym @sym_344 {hw.verilogName = "_decStage_WIRE_4_0_isLUI"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isLUI, %false : i1
    %_decStage_WIRE_4_0_isAUIPC = sv.wire sym @sym_345 {hw.verilogName = "_decStage_WIRE_4_0_isAUIPC"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isAUIPC, %false : i1
    %_decStage_WIRE_4_0_isFence = sv.wire sym @sym_346 {hw.verilogName = "_decStage_WIRE_4_0_isFence"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isFence, %false : i1
    %_decStage_WIRE_4_0_isSystem = sv.wire sym @sym_347 {hw.verilogName = "_decStage_WIRE_4_0_isSystem"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_0_isSystem, %false : i1
    %_decStage_WIRE_4_1_valid = sv.wire sym @sym_360 {hw.verilogName = "_decStage_WIRE_4_1_valid"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_valid, %false : i1
    %_decStage_WIRE_4_1_isALU = sv.wire sym @sym_363 {hw.verilogName = "_decStage_WIRE_4_1_isALU"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isALU, %false : i1
    %_decStage_WIRE_4_1_isLoad = sv.wire sym @sym_364 {hw.verilogName = "_decStage_WIRE_4_1_isLoad"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isLoad, %false : i1
    %_decStage_WIRE_4_1_isStore = sv.wire sym @sym_365 {hw.verilogName = "_decStage_WIRE_4_1_isStore"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isStore, %false : i1
    %_decStage_WIRE_4_1_isBranch = sv.wire sym @sym_366 {hw.verilogName = "_decStage_WIRE_4_1_isBranch"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isBranch, %false : i1
    %_decStage_WIRE_4_1_isJAL = sv.wire sym @sym_367 {hw.verilogName = "_decStage_WIRE_4_1_isJAL"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isJAL, %false : i1
    %_decStage_WIRE_4_1_isJALR = sv.wire sym @sym_368 {hw.verilogName = "_decStage_WIRE_4_1_isJALR"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isJALR, %false : i1
    %_decStage_WIRE_4_1_isLUI = sv.wire sym @sym_369 {hw.verilogName = "_decStage_WIRE_4_1_isLUI"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isLUI, %false : i1
    %_decStage_WIRE_4_1_isAUIPC = sv.wire sym @sym_370 {hw.verilogName = "_decStage_WIRE_4_1_isAUIPC"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isAUIPC, %false : i1
    %_decStage_WIRE_4_1_isFence = sv.wire sym @sym_371 {hw.verilogName = "_decStage_WIRE_4_1_isFence"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isFence, %false : i1
    %_decStage_WIRE_4_1_isSystem = sv.wire sym @sym_372 {hw.verilogName = "_decStage_WIRE_4_1_isSystem"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_1_isSystem, %false : i1
    %_decStage_WIRE_4_2_valid = sv.wire sym @sym_385 {hw.verilogName = "_decStage_WIRE_4_2_valid"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_valid, %false : i1
    %_decStage_WIRE_4_2_isALU = sv.wire sym @sym_388 {hw.verilogName = "_decStage_WIRE_4_2_isALU"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isALU, %false : i1
    %_decStage_WIRE_4_2_isLoad = sv.wire sym @sym_389 {hw.verilogName = "_decStage_WIRE_4_2_isLoad"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isLoad, %false : i1
    %_decStage_WIRE_4_2_isStore = sv.wire sym @sym_390 {hw.verilogName = "_decStage_WIRE_4_2_isStore"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isStore, %false : i1
    %_decStage_WIRE_4_2_isBranch = sv.wire sym @sym_391 {hw.verilogName = "_decStage_WIRE_4_2_isBranch"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isBranch, %false : i1
    %_decStage_WIRE_4_2_isJAL = sv.wire sym @sym_392 {hw.verilogName = "_decStage_WIRE_4_2_isJAL"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isJAL, %false : i1
    %_decStage_WIRE_4_2_isJALR = sv.wire sym @sym_393 {hw.verilogName = "_decStage_WIRE_4_2_isJALR"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isJALR, %false : i1
    %_decStage_WIRE_4_2_isLUI = sv.wire sym @sym_394 {hw.verilogName = "_decStage_WIRE_4_2_isLUI"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isLUI, %false : i1
    %_decStage_WIRE_4_2_isAUIPC = sv.wire sym @sym_395 {hw.verilogName = "_decStage_WIRE_4_2_isAUIPC"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isAUIPC, %false : i1
    %_decStage_WIRE_4_2_isFence = sv.wire sym @sym_396 {hw.verilogName = "_decStage_WIRE_4_2_isFence"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isFence, %false : i1
    %_decStage_WIRE_4_2_isSystem = sv.wire sym @sym_397 {hw.verilogName = "_decStage_WIRE_4_2_isSystem"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_2_isSystem, %false : i1
    %_decStage_WIRE_4_3_valid = sv.wire sym @sym_410 {hw.verilogName = "_decStage_WIRE_4_3_valid"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_valid, %false : i1
    %_decStage_WIRE_4_3_isALU = sv.wire sym @sym_413 {hw.verilogName = "_decStage_WIRE_4_3_isALU"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isALU, %false : i1
    %_decStage_WIRE_4_3_isLoad = sv.wire sym @sym_414 {hw.verilogName = "_decStage_WIRE_4_3_isLoad"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isLoad, %false : i1
    %_decStage_WIRE_4_3_isStore = sv.wire sym @sym_415 {hw.verilogName = "_decStage_WIRE_4_3_isStore"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isStore, %false : i1
    %_decStage_WIRE_4_3_isBranch = sv.wire sym @sym_416 {hw.verilogName = "_decStage_WIRE_4_3_isBranch"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isBranch, %false : i1
    %_decStage_WIRE_4_3_isJAL = sv.wire sym @sym_417 {hw.verilogName = "_decStage_WIRE_4_3_isJAL"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isJAL, %false : i1
    %_decStage_WIRE_4_3_isJALR = sv.wire sym @sym_418 {hw.verilogName = "_decStage_WIRE_4_3_isJALR"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isJALR, %false : i1
    %_decStage_WIRE_4_3_isLUI = sv.wire sym @sym_419 {hw.verilogName = "_decStage_WIRE_4_3_isLUI"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isLUI, %false : i1
    %_decStage_WIRE_4_3_isAUIPC = sv.wire sym @sym_420 {hw.verilogName = "_decStage_WIRE_4_3_isAUIPC"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isAUIPC, %false : i1
    %_decStage_WIRE_4_3_isFence = sv.wire sym @sym_421 {hw.verilogName = "_decStage_WIRE_4_3_isFence"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isFence, %false : i1
    %_decStage_WIRE_4_3_isSystem = sv.wire sym @sym_422 {hw.verilogName = "_decStage_WIRE_4_3_isSystem"} : !hw.inout<i1>
    sv.assign %_decStage_WIRE_4_3_isSystem, %false : i1
    %_exStage_WIRE_valid = sv.wire sym @sym_535 {hw.verilogName = "_exStage_WIRE_valid"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_valid, %false : i1
    %_exStage_WIRE_isALU = sv.wire sym @sym_538 {hw.verilogName = "_exStage_WIRE_isALU"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isALU, %false : i1
    %_exStage_WIRE_isLoad = sv.wire sym @sym_539 {hw.verilogName = "_exStage_WIRE_isLoad"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isLoad, %false : i1
    %_exStage_WIRE_isStore = sv.wire sym @sym_540 {hw.verilogName = "_exStage_WIRE_isStore"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isStore, %false : i1
    %_exStage_WIRE_isBranch = sv.wire sym @sym_541 {hw.verilogName = "_exStage_WIRE_isBranch"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isBranch, %false : i1
    %_exStage_WIRE_isJAL = sv.wire sym @sym_542 {hw.verilogName = "_exStage_WIRE_isJAL"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isJAL, %false : i1
    %_exStage_WIRE_isJALR = sv.wire sym @sym_543 {hw.verilogName = "_exStage_WIRE_isJALR"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isJALR, %false : i1
    %_exStage_WIRE_isLUI = sv.wire sym @sym_544 {hw.verilogName = "_exStage_WIRE_isLUI"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isLUI, %false : i1
    %_exStage_WIRE_isAUIPC = sv.wire sym @sym_545 {hw.verilogName = "_exStage_WIRE_isAUIPC"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isAUIPC, %false : i1
    %_exStage_WIRE_isFence = sv.wire sym @sym_546 {hw.verilogName = "_exStage_WIRE_isFence"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isFence, %false : i1
    %_exStage_WIRE_isSystem = sv.wire sym @sym_547 {hw.verilogName = "_exStage_WIRE_isSystem"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_isSystem, %false : i1
    %_exStage_WIRE_1_valid = sv.wire sym @sym_560 {hw.verilogName = "_exStage_WIRE_1_valid"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_valid, %false : i1
    %_exStage_WIRE_1_isALU = sv.wire sym @sym_563 {hw.verilogName = "_exStage_WIRE_1_isALU"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isALU, %false : i1
    %_exStage_WIRE_1_isLoad = sv.wire sym @sym_564 {hw.verilogName = "_exStage_WIRE_1_isLoad"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isLoad, %false : i1
    %_exStage_WIRE_1_isStore = sv.wire sym @sym_565 {hw.verilogName = "_exStage_WIRE_1_isStore"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isStore, %false : i1
    %_exStage_WIRE_1_isBranch = sv.wire sym @sym_566 {hw.verilogName = "_exStage_WIRE_1_isBranch"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isBranch, %false : i1
    %_exStage_WIRE_1_isJAL = sv.wire sym @sym_567 {hw.verilogName = "_exStage_WIRE_1_isJAL"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isJAL, %false : i1
    %_exStage_WIRE_1_isJALR = sv.wire sym @sym_568 {hw.verilogName = "_exStage_WIRE_1_isJALR"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isJALR, %false : i1
    %_exStage_WIRE_1_isLUI = sv.wire sym @sym_569 {hw.verilogName = "_exStage_WIRE_1_isLUI"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isLUI, %false : i1
    %_exStage_WIRE_1_isAUIPC = sv.wire sym @sym_570 {hw.verilogName = "_exStage_WIRE_1_isAUIPC"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isAUIPC, %false : i1
    %_exStage_WIRE_1_isFence = sv.wire sym @sym_571 {hw.verilogName = "_exStage_WIRE_1_isFence"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isFence, %false : i1
    %_exStage_WIRE_1_isSystem = sv.wire sym @sym_572 {hw.verilogName = "_exStage_WIRE_1_isSystem"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_1_isSystem, %false : i1
    %_exStage_WIRE_2_valid = sv.wire sym @sym_585 {hw.verilogName = "_exStage_WIRE_2_valid"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_valid, %false : i1
    %_exStage_WIRE_2_isALU = sv.wire sym @sym_588 {hw.verilogName = "_exStage_WIRE_2_isALU"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isALU, %false : i1
    %_exStage_WIRE_2_isLoad = sv.wire sym @sym_589 {hw.verilogName = "_exStage_WIRE_2_isLoad"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isLoad, %false : i1
    %_exStage_WIRE_2_isStore = sv.wire sym @sym_590 {hw.verilogName = "_exStage_WIRE_2_isStore"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isStore, %false : i1
    %_exStage_WIRE_2_isBranch = sv.wire sym @sym_591 {hw.verilogName = "_exStage_WIRE_2_isBranch"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isBranch, %false : i1
    %_exStage_WIRE_2_isJAL = sv.wire sym @sym_592 {hw.verilogName = "_exStage_WIRE_2_isJAL"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isJAL, %false : i1
    %_exStage_WIRE_2_isJALR = sv.wire sym @sym_593 {hw.verilogName = "_exStage_WIRE_2_isJALR"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isJALR, %false : i1
    %_exStage_WIRE_2_isLUI = sv.wire sym @sym_594 {hw.verilogName = "_exStage_WIRE_2_isLUI"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isLUI, %false : i1
    %_exStage_WIRE_2_isAUIPC = sv.wire sym @sym_595 {hw.verilogName = "_exStage_WIRE_2_isAUIPC"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isAUIPC, %false : i1
    %_exStage_WIRE_2_isFence = sv.wire sym @sym_596 {hw.verilogName = "_exStage_WIRE_2_isFence"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isFence, %false : i1
    %_exStage_WIRE_2_isSystem = sv.wire sym @sym_597 {hw.verilogName = "_exStage_WIRE_2_isSystem"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_2_isSystem, %false : i1
    %_exStage_WIRE_3_valid = sv.wire sym @sym_610 {hw.verilogName = "_exStage_WIRE_3_valid"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_valid, %false : i1
    %_exStage_WIRE_3_isALU = sv.wire sym @sym_613 {hw.verilogName = "_exStage_WIRE_3_isALU"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isALU, %false : i1
    %_exStage_WIRE_3_isLoad = sv.wire sym @sym_614 {hw.verilogName = "_exStage_WIRE_3_isLoad"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isLoad, %false : i1
    %_exStage_WIRE_3_isStore = sv.wire sym @sym_615 {hw.verilogName = "_exStage_WIRE_3_isStore"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isStore, %false : i1
    %_exStage_WIRE_3_isBranch = sv.wire sym @sym_616 {hw.verilogName = "_exStage_WIRE_3_isBranch"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isBranch, %false : i1
    %_exStage_WIRE_3_isJAL = sv.wire sym @sym_617 {hw.verilogName = "_exStage_WIRE_3_isJAL"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isJAL, %false : i1
    %_exStage_WIRE_3_isJALR = sv.wire sym @sym_618 {hw.verilogName = "_exStage_WIRE_3_isJALR"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isJALR, %false : i1
    %_exStage_WIRE_3_isLUI = sv.wire sym @sym_619 {hw.verilogName = "_exStage_WIRE_3_isLUI"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isLUI, %false : i1
    %_exStage_WIRE_3_isAUIPC = sv.wire sym @sym_620 {hw.verilogName = "_exStage_WIRE_3_isAUIPC"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isAUIPC, %false : i1
    %_exStage_WIRE_3_isFence = sv.wire sym @sym_621 {hw.verilogName = "_exStage_WIRE_3_isFence"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isFence, %false : i1
    %_exStage_WIRE_3_isSystem = sv.wire sym @sym_622 {hw.verilogName = "_exStage_WIRE_3_isSystem"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_3_isSystem, %false : i1
    %_exStage_WIRE_4_0_valid = sv.wire sym @sym_635 {hw.verilogName = "_exStage_WIRE_4_0_valid"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_valid, %false : i1
    %_exStage_WIRE_4_0_isALU = sv.wire sym @sym_638 {hw.verilogName = "_exStage_WIRE_4_0_isALU"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isALU, %false : i1
    %_exStage_WIRE_4_0_isLoad = sv.wire sym @sym_639 {hw.verilogName = "_exStage_WIRE_4_0_isLoad"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isLoad, %false : i1
    %_exStage_WIRE_4_0_isStore = sv.wire sym @sym_640 {hw.verilogName = "_exStage_WIRE_4_0_isStore"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isStore, %false : i1
    %_exStage_WIRE_4_0_isBranch = sv.wire sym @sym_641 {hw.verilogName = "_exStage_WIRE_4_0_isBranch"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isBranch, %false : i1
    %_exStage_WIRE_4_0_isJAL = sv.wire sym @sym_642 {hw.verilogName = "_exStage_WIRE_4_0_isJAL"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isJAL, %false : i1
    %_exStage_WIRE_4_0_isJALR = sv.wire sym @sym_643 {hw.verilogName = "_exStage_WIRE_4_0_isJALR"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isJALR, %false : i1
    %_exStage_WIRE_4_0_isLUI = sv.wire sym @sym_644 {hw.verilogName = "_exStage_WIRE_4_0_isLUI"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isLUI, %false : i1
    %_exStage_WIRE_4_0_isAUIPC = sv.wire sym @sym_645 {hw.verilogName = "_exStage_WIRE_4_0_isAUIPC"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isAUIPC, %false : i1
    %_exStage_WIRE_4_0_isFence = sv.wire sym @sym_646 {hw.verilogName = "_exStage_WIRE_4_0_isFence"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isFence, %false : i1
    %_exStage_WIRE_4_0_isSystem = sv.wire sym @sym_647 {hw.verilogName = "_exStage_WIRE_4_0_isSystem"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_0_isSystem, %false : i1
    %_exStage_WIRE_4_1_valid = sv.wire sym @sym_660 {hw.verilogName = "_exStage_WIRE_4_1_valid"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_valid, %false : i1
    %_exStage_WIRE_4_1_isALU = sv.wire sym @sym_663 {hw.verilogName = "_exStage_WIRE_4_1_isALU"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isALU, %false : i1
    %_exStage_WIRE_4_1_isLoad = sv.wire sym @sym_664 {hw.verilogName = "_exStage_WIRE_4_1_isLoad"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isLoad, %false : i1
    %_exStage_WIRE_4_1_isStore = sv.wire sym @sym_665 {hw.verilogName = "_exStage_WIRE_4_1_isStore"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isStore, %false : i1
    %_exStage_WIRE_4_1_isBranch = sv.wire sym @sym_666 {hw.verilogName = "_exStage_WIRE_4_1_isBranch"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isBranch, %false : i1
    %_exStage_WIRE_4_1_isJAL = sv.wire sym @sym_667 {hw.verilogName = "_exStage_WIRE_4_1_isJAL"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isJAL, %false : i1
    %_exStage_WIRE_4_1_isJALR = sv.wire sym @sym_668 {hw.verilogName = "_exStage_WIRE_4_1_isJALR"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isJALR, %false : i1
    %_exStage_WIRE_4_1_isLUI = sv.wire sym @sym_669 {hw.verilogName = "_exStage_WIRE_4_1_isLUI"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isLUI, %false : i1
    %_exStage_WIRE_4_1_isAUIPC = sv.wire sym @sym_670 {hw.verilogName = "_exStage_WIRE_4_1_isAUIPC"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isAUIPC, %false : i1
    %_exStage_WIRE_4_1_isFence = sv.wire sym @sym_671 {hw.verilogName = "_exStage_WIRE_4_1_isFence"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isFence, %false : i1
    %_exStage_WIRE_4_1_isSystem = sv.wire sym @sym_672 {hw.verilogName = "_exStage_WIRE_4_1_isSystem"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_1_isSystem, %false : i1
    %_exStage_WIRE_4_2_valid = sv.wire sym @sym_685 {hw.verilogName = "_exStage_WIRE_4_2_valid"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_valid, %false : i1
    %_exStage_WIRE_4_2_isALU = sv.wire sym @sym_688 {hw.verilogName = "_exStage_WIRE_4_2_isALU"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isALU, %false : i1
    %_exStage_WIRE_4_2_isLoad = sv.wire sym @sym_689 {hw.verilogName = "_exStage_WIRE_4_2_isLoad"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isLoad, %false : i1
    %_exStage_WIRE_4_2_isStore = sv.wire sym @sym_690 {hw.verilogName = "_exStage_WIRE_4_2_isStore"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isStore, %false : i1
    %_exStage_WIRE_4_2_isBranch = sv.wire sym @sym_691 {hw.verilogName = "_exStage_WIRE_4_2_isBranch"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isBranch, %false : i1
    %_exStage_WIRE_4_2_isJAL = sv.wire sym @sym_692 {hw.verilogName = "_exStage_WIRE_4_2_isJAL"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isJAL, %false : i1
    %_exStage_WIRE_4_2_isJALR = sv.wire sym @sym_693 {hw.verilogName = "_exStage_WIRE_4_2_isJALR"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isJALR, %false : i1
    %_exStage_WIRE_4_2_isLUI = sv.wire sym @sym_694 {hw.verilogName = "_exStage_WIRE_4_2_isLUI"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isLUI, %false : i1
    %_exStage_WIRE_4_2_isAUIPC = sv.wire sym @sym_695 {hw.verilogName = "_exStage_WIRE_4_2_isAUIPC"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isAUIPC, %false : i1
    %_exStage_WIRE_4_2_isFence = sv.wire sym @sym_696 {hw.verilogName = "_exStage_WIRE_4_2_isFence"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isFence, %false : i1
    %_exStage_WIRE_4_2_isSystem = sv.wire sym @sym_697 {hw.verilogName = "_exStage_WIRE_4_2_isSystem"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_2_isSystem, %false : i1
    %_exStage_WIRE_4_3_valid = sv.wire sym @sym_710 {hw.verilogName = "_exStage_WIRE_4_3_valid"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_valid, %false : i1
    %_exStage_WIRE_4_3_isALU = sv.wire sym @sym_713 {hw.verilogName = "_exStage_WIRE_4_3_isALU"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isALU, %false : i1
    %_exStage_WIRE_4_3_isLoad = sv.wire sym @sym_714 {hw.verilogName = "_exStage_WIRE_4_3_isLoad"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isLoad, %false : i1
    %_exStage_WIRE_4_3_isStore = sv.wire sym @sym_715 {hw.verilogName = "_exStage_WIRE_4_3_isStore"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isStore, %false : i1
    %_exStage_WIRE_4_3_isBranch = sv.wire sym @sym_716 {hw.verilogName = "_exStage_WIRE_4_3_isBranch"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isBranch, %false : i1
    %_exStage_WIRE_4_3_isJAL = sv.wire sym @sym_717 {hw.verilogName = "_exStage_WIRE_4_3_isJAL"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isJAL, %false : i1
    %_exStage_WIRE_4_3_isJALR = sv.wire sym @sym_718 {hw.verilogName = "_exStage_WIRE_4_3_isJALR"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isJALR, %false : i1
    %_exStage_WIRE_4_3_isLUI = sv.wire sym @sym_719 {hw.verilogName = "_exStage_WIRE_4_3_isLUI"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isLUI, %false : i1
    %_exStage_WIRE_4_3_isAUIPC = sv.wire sym @sym_720 {hw.verilogName = "_exStage_WIRE_4_3_isAUIPC"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isAUIPC, %false : i1
    %_exStage_WIRE_4_3_isFence = sv.wire sym @sym_721 {hw.verilogName = "_exStage_WIRE_4_3_isFence"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isFence, %false : i1
    %_exStage_WIRE_4_3_isSystem = sv.wire sym @sym_722 {hw.verilogName = "_exStage_WIRE_4_3_isSystem"} : !hw.inout<i1>
    sv.assign %_exStage_WIRE_4_3_isSystem, %false : i1
    %_memStage_WIRE_valid = sv.wire sym @sym_835 {hw.verilogName = "_memStage_WIRE_valid"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_valid, %false : i1
    %_memStage_WIRE_isALU = sv.wire sym @sym_838 {hw.verilogName = "_memStage_WIRE_isALU"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isALU, %false : i1
    %_memStage_WIRE_isLoad = sv.wire sym @sym_839 {hw.verilogName = "_memStage_WIRE_isLoad"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isLoad, %false : i1
    %_memStage_WIRE_isStore = sv.wire sym @sym_840 {hw.verilogName = "_memStage_WIRE_isStore"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isStore, %false : i1
    %_memStage_WIRE_isBranch = sv.wire sym @sym_841 {hw.verilogName = "_memStage_WIRE_isBranch"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isBranch, %false : i1
    %_memStage_WIRE_isJAL = sv.wire sym @sym_842 {hw.verilogName = "_memStage_WIRE_isJAL"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isJAL, %false : i1
    %_memStage_WIRE_isJALR = sv.wire sym @sym_843 {hw.verilogName = "_memStage_WIRE_isJALR"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isJALR, %false : i1
    %_memStage_WIRE_isLUI = sv.wire sym @sym_844 {hw.verilogName = "_memStage_WIRE_isLUI"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isLUI, %false : i1
    %_memStage_WIRE_isAUIPC = sv.wire sym @sym_845 {hw.verilogName = "_memStage_WIRE_isAUIPC"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isAUIPC, %false : i1
    %_memStage_WIRE_isFence = sv.wire sym @sym_846 {hw.verilogName = "_memStage_WIRE_isFence"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isFence, %false : i1
    %_memStage_WIRE_isSystem = sv.wire sym @sym_847 {hw.verilogName = "_memStage_WIRE_isSystem"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_isSystem, %false : i1
    %_memStage_WIRE_1_valid = sv.wire sym @sym_860 {hw.verilogName = "_memStage_WIRE_1_valid"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_valid, %false : i1
    %_memStage_WIRE_1_isALU = sv.wire sym @sym_863 {hw.verilogName = "_memStage_WIRE_1_isALU"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isALU, %false : i1
    %_memStage_WIRE_1_isLoad = sv.wire sym @sym_864 {hw.verilogName = "_memStage_WIRE_1_isLoad"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isLoad, %false : i1
    %_memStage_WIRE_1_isStore = sv.wire sym @sym_865 {hw.verilogName = "_memStage_WIRE_1_isStore"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isStore, %false : i1
    %_memStage_WIRE_1_isBranch = sv.wire sym @sym_866 {hw.verilogName = "_memStage_WIRE_1_isBranch"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isBranch, %false : i1
    %_memStage_WIRE_1_isJAL = sv.wire sym @sym_867 {hw.verilogName = "_memStage_WIRE_1_isJAL"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isJAL, %false : i1
    %_memStage_WIRE_1_isJALR = sv.wire sym @sym_868 {hw.verilogName = "_memStage_WIRE_1_isJALR"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isJALR, %false : i1
    %_memStage_WIRE_1_isLUI = sv.wire sym @sym_869 {hw.verilogName = "_memStage_WIRE_1_isLUI"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isLUI, %false : i1
    %_memStage_WIRE_1_isAUIPC = sv.wire sym @sym_870 {hw.verilogName = "_memStage_WIRE_1_isAUIPC"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isAUIPC, %false : i1
    %_memStage_WIRE_1_isFence = sv.wire sym @sym_871 {hw.verilogName = "_memStage_WIRE_1_isFence"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isFence, %false : i1
    %_memStage_WIRE_1_isSystem = sv.wire sym @sym_872 {hw.verilogName = "_memStage_WIRE_1_isSystem"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_1_isSystem, %false : i1
    %_memStage_WIRE_2_valid = sv.wire sym @sym_885 {hw.verilogName = "_memStage_WIRE_2_valid"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_valid, %false : i1
    %_memStage_WIRE_2_isALU = sv.wire sym @sym_888 {hw.verilogName = "_memStage_WIRE_2_isALU"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isALU, %false : i1
    %_memStage_WIRE_2_isLoad = sv.wire sym @sym_889 {hw.verilogName = "_memStage_WIRE_2_isLoad"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isLoad, %false : i1
    %_memStage_WIRE_2_isStore = sv.wire sym @sym_890 {hw.verilogName = "_memStage_WIRE_2_isStore"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isStore, %false : i1
    %_memStage_WIRE_2_isBranch = sv.wire sym @sym_891 {hw.verilogName = "_memStage_WIRE_2_isBranch"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isBranch, %false : i1
    %_memStage_WIRE_2_isJAL = sv.wire sym @sym_892 {hw.verilogName = "_memStage_WIRE_2_isJAL"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isJAL, %false : i1
    %_memStage_WIRE_2_isJALR = sv.wire sym @sym_893 {hw.verilogName = "_memStage_WIRE_2_isJALR"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isJALR, %false : i1
    %_memStage_WIRE_2_isLUI = sv.wire sym @sym_894 {hw.verilogName = "_memStage_WIRE_2_isLUI"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isLUI, %false : i1
    %_memStage_WIRE_2_isAUIPC = sv.wire sym @sym_895 {hw.verilogName = "_memStage_WIRE_2_isAUIPC"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isAUIPC, %false : i1
    %_memStage_WIRE_2_isFence = sv.wire sym @sym_896 {hw.verilogName = "_memStage_WIRE_2_isFence"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isFence, %false : i1
    %_memStage_WIRE_2_isSystem = sv.wire sym @sym_897 {hw.verilogName = "_memStage_WIRE_2_isSystem"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_2_isSystem, %false : i1
    %_memStage_WIRE_3_valid = sv.wire sym @sym_910 {hw.verilogName = "_memStage_WIRE_3_valid"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_valid, %false : i1
    %_memStage_WIRE_3_isALU = sv.wire sym @sym_913 {hw.verilogName = "_memStage_WIRE_3_isALU"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isALU, %false : i1
    %_memStage_WIRE_3_isLoad = sv.wire sym @sym_914 {hw.verilogName = "_memStage_WIRE_3_isLoad"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isLoad, %false : i1
    %_memStage_WIRE_3_isStore = sv.wire sym @sym_915 {hw.verilogName = "_memStage_WIRE_3_isStore"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isStore, %false : i1
    %_memStage_WIRE_3_isBranch = sv.wire sym @sym_916 {hw.verilogName = "_memStage_WIRE_3_isBranch"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isBranch, %false : i1
    %_memStage_WIRE_3_isJAL = sv.wire sym @sym_917 {hw.verilogName = "_memStage_WIRE_3_isJAL"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isJAL, %false : i1
    %_memStage_WIRE_3_isJALR = sv.wire sym @sym_918 {hw.verilogName = "_memStage_WIRE_3_isJALR"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isJALR, %false : i1
    %_memStage_WIRE_3_isLUI = sv.wire sym @sym_919 {hw.verilogName = "_memStage_WIRE_3_isLUI"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isLUI, %false : i1
    %_memStage_WIRE_3_isAUIPC = sv.wire sym @sym_920 {hw.verilogName = "_memStage_WIRE_3_isAUIPC"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isAUIPC, %false : i1
    %_memStage_WIRE_3_isFence = sv.wire sym @sym_921 {hw.verilogName = "_memStage_WIRE_3_isFence"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isFence, %false : i1
    %_memStage_WIRE_3_isSystem = sv.wire sym @sym_922 {hw.verilogName = "_memStage_WIRE_3_isSystem"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_3_isSystem, %false : i1
    %_memStage_WIRE_4_0_valid = sv.wire sym @sym_935 {hw.verilogName = "_memStage_WIRE_4_0_valid"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_valid, %false : i1
    %_memStage_WIRE_4_0_isALU = sv.wire sym @sym_938 {hw.verilogName = "_memStage_WIRE_4_0_isALU"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isALU, %false : i1
    %_memStage_WIRE_4_0_isLoad = sv.wire sym @sym_939 {hw.verilogName = "_memStage_WIRE_4_0_isLoad"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isLoad, %false : i1
    %_memStage_WIRE_4_0_isStore = sv.wire sym @sym_940 {hw.verilogName = "_memStage_WIRE_4_0_isStore"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isStore, %false : i1
    %_memStage_WIRE_4_0_isBranch = sv.wire sym @sym_941 {hw.verilogName = "_memStage_WIRE_4_0_isBranch"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isBranch, %false : i1
    %_memStage_WIRE_4_0_isJAL = sv.wire sym @sym_942 {hw.verilogName = "_memStage_WIRE_4_0_isJAL"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isJAL, %false : i1
    %_memStage_WIRE_4_0_isJALR = sv.wire sym @sym_943 {hw.verilogName = "_memStage_WIRE_4_0_isJALR"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isJALR, %false : i1
    %_memStage_WIRE_4_0_isLUI = sv.wire sym @sym_944 {hw.verilogName = "_memStage_WIRE_4_0_isLUI"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isLUI, %false : i1
    %_memStage_WIRE_4_0_isAUIPC = sv.wire sym @sym_945 {hw.verilogName = "_memStage_WIRE_4_0_isAUIPC"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isAUIPC, %false : i1
    %_memStage_WIRE_4_0_isFence = sv.wire sym @sym_946 {hw.verilogName = "_memStage_WIRE_4_0_isFence"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isFence, %false : i1
    %_memStage_WIRE_4_0_isSystem = sv.wire sym @sym_947 {hw.verilogName = "_memStage_WIRE_4_0_isSystem"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_0_isSystem, %false : i1
    %_memStage_WIRE_4_1_valid = sv.wire sym @sym_960 {hw.verilogName = "_memStage_WIRE_4_1_valid"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_valid, %false : i1
    %_memStage_WIRE_4_1_isALU = sv.wire sym @sym_963 {hw.verilogName = "_memStage_WIRE_4_1_isALU"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isALU, %false : i1
    %_memStage_WIRE_4_1_isLoad = sv.wire sym @sym_964 {hw.verilogName = "_memStage_WIRE_4_1_isLoad"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isLoad, %false : i1
    %_memStage_WIRE_4_1_isStore = sv.wire sym @sym_965 {hw.verilogName = "_memStage_WIRE_4_1_isStore"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isStore, %false : i1
    %_memStage_WIRE_4_1_isBranch = sv.wire sym @sym_966 {hw.verilogName = "_memStage_WIRE_4_1_isBranch"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isBranch, %false : i1
    %_memStage_WIRE_4_1_isJAL = sv.wire sym @sym_967 {hw.verilogName = "_memStage_WIRE_4_1_isJAL"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isJAL, %false : i1
    %_memStage_WIRE_4_1_isJALR = sv.wire sym @sym_968 {hw.verilogName = "_memStage_WIRE_4_1_isJALR"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isJALR, %false : i1
    %_memStage_WIRE_4_1_isLUI = sv.wire sym @sym_969 {hw.verilogName = "_memStage_WIRE_4_1_isLUI"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isLUI, %false : i1
    %_memStage_WIRE_4_1_isAUIPC = sv.wire sym @sym_970 {hw.verilogName = "_memStage_WIRE_4_1_isAUIPC"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isAUIPC, %false : i1
    %_memStage_WIRE_4_1_isFence = sv.wire sym @sym_971 {hw.verilogName = "_memStage_WIRE_4_1_isFence"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isFence, %false : i1
    %_memStage_WIRE_4_1_isSystem = sv.wire sym @sym_972 {hw.verilogName = "_memStage_WIRE_4_1_isSystem"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_1_isSystem, %false : i1
    %_memStage_WIRE_4_2_valid = sv.wire sym @sym_985 {hw.verilogName = "_memStage_WIRE_4_2_valid"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_valid, %false : i1
    %_memStage_WIRE_4_2_isALU = sv.wire sym @sym_988 {hw.verilogName = "_memStage_WIRE_4_2_isALU"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isALU, %false : i1
    %_memStage_WIRE_4_2_isLoad = sv.wire sym @sym_989 {hw.verilogName = "_memStage_WIRE_4_2_isLoad"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isLoad, %false : i1
    %_memStage_WIRE_4_2_isStore = sv.wire sym @sym_990 {hw.verilogName = "_memStage_WIRE_4_2_isStore"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isStore, %false : i1
    %_memStage_WIRE_4_2_isBranch = sv.wire sym @sym_991 {hw.verilogName = "_memStage_WIRE_4_2_isBranch"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isBranch, %false : i1
    %_memStage_WIRE_4_2_isJAL = sv.wire sym @sym_992 {hw.verilogName = "_memStage_WIRE_4_2_isJAL"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isJAL, %false : i1
    %_memStage_WIRE_4_2_isJALR = sv.wire sym @sym_993 {hw.verilogName = "_memStage_WIRE_4_2_isJALR"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isJALR, %false : i1
    %_memStage_WIRE_4_2_isLUI = sv.wire sym @sym_994 {hw.verilogName = "_memStage_WIRE_4_2_isLUI"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isLUI, %false : i1
    %_memStage_WIRE_4_2_isAUIPC = sv.wire sym @sym_995 {hw.verilogName = "_memStage_WIRE_4_2_isAUIPC"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isAUIPC, %false : i1
    %_memStage_WIRE_4_2_isFence = sv.wire sym @sym_996 {hw.verilogName = "_memStage_WIRE_4_2_isFence"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isFence, %false : i1
    %_memStage_WIRE_4_2_isSystem = sv.wire sym @sym_997 {hw.verilogName = "_memStage_WIRE_4_2_isSystem"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_2_isSystem, %false : i1
    %_memStage_WIRE_4_3_valid = sv.wire sym @sym_1010 {hw.verilogName = "_memStage_WIRE_4_3_valid"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_valid, %false : i1
    %_memStage_WIRE_4_3_isALU = sv.wire sym @sym_1013 {hw.verilogName = "_memStage_WIRE_4_3_isALU"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isALU, %false : i1
    %_memStage_WIRE_4_3_isLoad = sv.wire sym @sym_1014 {hw.verilogName = "_memStage_WIRE_4_3_isLoad"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isLoad, %false : i1
    %_memStage_WIRE_4_3_isStore = sv.wire sym @sym_1015 {hw.verilogName = "_memStage_WIRE_4_3_isStore"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isStore, %false : i1
    %_memStage_WIRE_4_3_isBranch = sv.wire sym @sym_1016 {hw.verilogName = "_memStage_WIRE_4_3_isBranch"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isBranch, %false : i1
    %_memStage_WIRE_4_3_isJAL = sv.wire sym @sym_1017 {hw.verilogName = "_memStage_WIRE_4_3_isJAL"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isJAL, %false : i1
    %_memStage_WIRE_4_3_isJALR = sv.wire sym @sym_1018 {hw.verilogName = "_memStage_WIRE_4_3_isJALR"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isJALR, %false : i1
    %_memStage_WIRE_4_3_isLUI = sv.wire sym @sym_1019 {hw.verilogName = "_memStage_WIRE_4_3_isLUI"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isLUI, %false : i1
    %_memStage_WIRE_4_3_isAUIPC = sv.wire sym @sym_1020 {hw.verilogName = "_memStage_WIRE_4_3_isAUIPC"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isAUIPC, %false : i1
    %_memStage_WIRE_4_3_isFence = sv.wire sym @sym_1021 {hw.verilogName = "_memStage_WIRE_4_3_isFence"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isFence, %false : i1
    %_memStage_WIRE_4_3_isSystem = sv.wire sym @sym_1022 {hw.verilogName = "_memStage_WIRE_4_3_isSystem"} : !hw.inout<i1>
    sv.assign %_memStage_WIRE_4_3_isSystem, %false : i1
    %_ifWire_WIRE_valid = sv.wire sym @sym_1135 {hw.verilogName = "_ifWire_WIRE_valid"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_valid, %false : i1
    %_ifWire_WIRE_isALU = sv.wire sym @sym_1138 {hw.verilogName = "_ifWire_WIRE_isALU"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isALU, %false : i1
    %_ifWire_WIRE_isLoad = sv.wire sym @sym_1139 {hw.verilogName = "_ifWire_WIRE_isLoad"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isLoad, %false : i1
    %_ifWire_WIRE_isStore = sv.wire sym @sym_1140 {hw.verilogName = "_ifWire_WIRE_isStore"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isStore, %false : i1
    %_ifWire_WIRE_isBranch = sv.wire sym @sym_1141 {hw.verilogName = "_ifWire_WIRE_isBranch"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isBranch, %false : i1
    %_ifWire_WIRE_isJAL = sv.wire sym @sym_1142 {hw.verilogName = "_ifWire_WIRE_isJAL"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isJAL, %false : i1
    %_ifWire_WIRE_isJALR = sv.wire sym @sym_1143 {hw.verilogName = "_ifWire_WIRE_isJALR"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isJALR, %false : i1
    %_ifWire_WIRE_isLUI = sv.wire sym @sym_1144 {hw.verilogName = "_ifWire_WIRE_isLUI"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isLUI, %false : i1
    %_ifWire_WIRE_isAUIPC = sv.wire sym @sym_1145 {hw.verilogName = "_ifWire_WIRE_isAUIPC"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isAUIPC, %false : i1
    %_ifWire_WIRE_isFence = sv.wire sym @sym_1146 {hw.verilogName = "_ifWire_WIRE_isFence"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isFence, %false : i1
    %_ifWire_WIRE_isSystem = sv.wire sym @sym_1147 {hw.verilogName = "_ifWire_WIRE_isSystem"} : !hw.inout<i1>
    sv.assign %_ifWire_WIRE_isSystem, %false : i1
    %ifWire_isALU = sv.wire sym @sym_1163 {hw.verilogName = "ifWire_isALU"} : !hw.inout<i1>
    sv.assign %ifWire_isALU, %false : i1
    %ifWire_isLoad = sv.wire sym @sym_1164 {hw.verilogName = "ifWire_isLoad"} : !hw.inout<i1>
    sv.assign %ifWire_isLoad, %false : i1
    %ifWire_isStore = sv.wire sym @sym_1165 {hw.verilogName = "ifWire_isStore"} : !hw.inout<i1>
    sv.assign %ifWire_isStore, %false : i1
    %ifWire_isBranch = sv.wire sym @sym_1166 {hw.verilogName = "ifWire_isBranch"} : !hw.inout<i1>
    sv.assign %ifWire_isBranch, %false : i1
    %ifWire_isJAL = sv.wire sym @sym_1167 {hw.verilogName = "ifWire_isJAL"} : !hw.inout<i1>
    sv.assign %ifWire_isJAL, %false : i1
    %ifWire_isJALR = sv.wire sym @sym_1168 {hw.verilogName = "ifWire_isJALR"} : !hw.inout<i1>
    sv.assign %ifWire_isJALR, %false : i1
    %ifWire_isLUI = sv.wire sym @sym_1169 {hw.verilogName = "ifWire_isLUI"} : !hw.inout<i1>
    sv.assign %ifWire_isLUI, %false : i1
    %ifWire_isAUIPC = sv.wire sym @sym_1170 {hw.verilogName = "ifWire_isAUIPC"} : !hw.inout<i1>
    sv.assign %ifWire_isAUIPC, %false : i1
    %ifWire_isFence = sv.wire sym @sym_1171 {hw.verilogName = "ifWire_isFence"} : !hw.inout<i1>
    sv.assign %ifWire_isFence, %false : i1
    %ifWire_isSystem = sv.wire sym @sym_1172 {hw.verilogName = "ifWire_isSystem"} : !hw.inout<i1>
    sv.assign %ifWire_isSystem, %false : i1
    %_decWire_WIRE_valid = sv.wire sym @sym_1190 {hw.verilogName = "_decWire_WIRE_valid"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_valid, %false : i1
    %_decWire_WIRE_isALU = sv.wire sym @sym_1193 {hw.verilogName = "_decWire_WIRE_isALU"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isALU, %false : i1
    %_decWire_WIRE_isLoad = sv.wire sym @sym_1194 {hw.verilogName = "_decWire_WIRE_isLoad"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isLoad, %false : i1
    %_decWire_WIRE_isStore = sv.wire sym @sym_1195 {hw.verilogName = "_decWire_WIRE_isStore"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isStore, %false : i1
    %_decWire_WIRE_isBranch = sv.wire sym @sym_1196 {hw.verilogName = "_decWire_WIRE_isBranch"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isBranch, %false : i1
    %_decWire_WIRE_isJAL = sv.wire sym @sym_1197 {hw.verilogName = "_decWire_WIRE_isJAL"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isJAL, %false : i1
    %_decWire_WIRE_isJALR = sv.wire sym @sym_1198 {hw.verilogName = "_decWire_WIRE_isJALR"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isJALR, %false : i1
    %_decWire_WIRE_isLUI = sv.wire sym @sym_1199 {hw.verilogName = "_decWire_WIRE_isLUI"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isLUI, %false : i1
    %_decWire_WIRE_isAUIPC = sv.wire sym @sym_1200 {hw.verilogName = "_decWire_WIRE_isAUIPC"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isAUIPC, %false : i1
    %_decWire_WIRE_isFence = sv.wire sym @sym_1201 {hw.verilogName = "_decWire_WIRE_isFence"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isFence, %false : i1
    %_decWire_WIRE_isSystem = sv.wire sym @sym_1202 {hw.verilogName = "_decWire_WIRE_isSystem"} : !hw.inout<i1>
    sv.assign %_decWire_WIRE_isSystem, %false : i1
    %_exWire_WIRE_valid = sv.wire sym @sym_1244 {hw.verilogName = "_exWire_WIRE_valid"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_valid, %false : i1
    %_exWire_WIRE_isALU = sv.wire sym @sym_1247 {hw.verilogName = "_exWire_WIRE_isALU"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isALU, %false : i1
    %_exWire_WIRE_isLoad = sv.wire sym @sym_1248 {hw.verilogName = "_exWire_WIRE_isLoad"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isLoad, %false : i1
    %_exWire_WIRE_isStore = sv.wire sym @sym_1249 {hw.verilogName = "_exWire_WIRE_isStore"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isStore, %false : i1
    %_exWire_WIRE_isBranch = sv.wire sym @sym_1250 {hw.verilogName = "_exWire_WIRE_isBranch"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isBranch, %false : i1
    %_exWire_WIRE_isJAL = sv.wire sym @sym_1251 {hw.verilogName = "_exWire_WIRE_isJAL"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isJAL, %false : i1
    %_exWire_WIRE_isJALR = sv.wire sym @sym_1252 {hw.verilogName = "_exWire_WIRE_isJALR"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isJALR, %false : i1
    %_exWire_WIRE_isLUI = sv.wire sym @sym_1253 {hw.verilogName = "_exWire_WIRE_isLUI"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isLUI, %false : i1
    %_exWire_WIRE_isAUIPC = sv.wire sym @sym_1254 {hw.verilogName = "_exWire_WIRE_isAUIPC"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isAUIPC, %false : i1
    %_exWire_WIRE_isFence = sv.wire sym @sym_1255 {hw.verilogName = "_exWire_WIRE_isFence"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isFence, %false : i1
    %_exWire_WIRE_isSystem = sv.wire sym @sym_1256 {hw.verilogName = "_exWire_WIRE_isSystem"} : !hw.inout<i1>
    sv.assign %_exWire_WIRE_isSystem, %false : i1
    %_memWire_WIRE_valid = sv.wire sym @sym_1296 {hw.verilogName = "_memWire_WIRE_valid"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_valid, %false : i1
    %_memWire_WIRE_isALU = sv.wire sym @sym_1299 {hw.verilogName = "_memWire_WIRE_isALU"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isALU, %false : i1
    %_memWire_WIRE_isLoad = sv.wire sym @sym_1300 {hw.verilogName = "_memWire_WIRE_isLoad"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isLoad, %false : i1
    %_memWire_WIRE_isStore = sv.wire sym @sym_1301 {hw.verilogName = "_memWire_WIRE_isStore"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isStore, %false : i1
    %_memWire_WIRE_isBranch = sv.wire sym @sym_1302 {hw.verilogName = "_memWire_WIRE_isBranch"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isBranch, %false : i1
    %_memWire_WIRE_isJAL = sv.wire sym @sym_1303 {hw.verilogName = "_memWire_WIRE_isJAL"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isJAL, %false : i1
    %_memWire_WIRE_isJALR = sv.wire sym @sym_1304 {hw.verilogName = "_memWire_WIRE_isJALR"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isJALR, %false : i1
    %_memWire_WIRE_isLUI = sv.wire sym @sym_1305 {hw.verilogName = "_memWire_WIRE_isLUI"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isLUI, %false : i1
    %_memWire_WIRE_isAUIPC = sv.wire sym @sym_1306 {hw.verilogName = "_memWire_WIRE_isAUIPC"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isAUIPC, %false : i1
    %_memWire_WIRE_isFence = sv.wire sym @sym_1307 {hw.verilogName = "_memWire_WIRE_isFence"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isFence, %false : i1
    %_memWire_WIRE_isSystem = sv.wire sym @sym_1308 {hw.verilogName = "_memWire_WIRE_isSystem"} : !hw.inout<i1>
    sv.assign %_memWire_WIRE_isSystem, %false : i1
    %c0_i5 = hw.constant 0 : i5
    %_ifStage_WIRE_aluOp = sv.wire sym @sym_32 {hw.verilogName = "_ifStage_WIRE_aluOp"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_aluOp, %c0_i5 : i5
    %_ifStage_WIRE_rs1 = sv.wire sym @sym_34 {hw.verilogName = "_ifStage_WIRE_rs1"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_rs1, %c0_i5 : i5
    %_ifStage_WIRE_rs2 = sv.wire sym @sym_35 {hw.verilogName = "_ifStage_WIRE_rs2"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_rs2, %c0_i5 : i5
    %_ifStage_WIRE_rd = sv.wire sym @sym_36 {hw.verilogName = "_ifStage_WIRE_rd"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_rd, %c0_i5 : i5
    %_ifStage_WIRE_1_aluOp = sv.wire sym @sym_57 {hw.verilogName = "_ifStage_WIRE_1_aluOp"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_1_aluOp, %c0_i5 : i5
    %_ifStage_WIRE_1_rs1 = sv.wire sym @sym_59 {hw.verilogName = "_ifStage_WIRE_1_rs1"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_1_rs1, %c0_i5 : i5
    %_ifStage_WIRE_1_rs2 = sv.wire sym @sym_60 {hw.verilogName = "_ifStage_WIRE_1_rs2"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_1_rs2, %c0_i5 : i5
    %_ifStage_WIRE_1_rd = sv.wire sym @sym_61 {hw.verilogName = "_ifStage_WIRE_1_rd"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_1_rd, %c0_i5 : i5
    %_ifStage_WIRE_2_aluOp = sv.wire sym @sym_82 {hw.verilogName = "_ifStage_WIRE_2_aluOp"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_2_aluOp, %c0_i5 : i5
    %_ifStage_WIRE_2_rs1 = sv.wire sym @sym_84 {hw.verilogName = "_ifStage_WIRE_2_rs1"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_2_rs1, %c0_i5 : i5
    %_ifStage_WIRE_2_rs2 = sv.wire sym @sym_85 {hw.verilogName = "_ifStage_WIRE_2_rs2"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_2_rs2, %c0_i5 : i5
    %_ifStage_WIRE_2_rd = sv.wire sym @sym_86 {hw.verilogName = "_ifStage_WIRE_2_rd"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_2_rd, %c0_i5 : i5
    %_ifStage_WIRE_3_aluOp = sv.wire sym @sym_107 {hw.verilogName = "_ifStage_WIRE_3_aluOp"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_3_aluOp, %c0_i5 : i5
    %_ifStage_WIRE_3_rs1 = sv.wire sym @sym_109 {hw.verilogName = "_ifStage_WIRE_3_rs1"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_3_rs1, %c0_i5 : i5
    %_ifStage_WIRE_3_rs2 = sv.wire sym @sym_110 {hw.verilogName = "_ifStage_WIRE_3_rs2"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_3_rs2, %c0_i5 : i5
    %_ifStage_WIRE_3_rd = sv.wire sym @sym_111 {hw.verilogName = "_ifStage_WIRE_3_rd"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_3_rd, %c0_i5 : i5
    %_ifStage_WIRE_4_0_aluOp = sv.wire sym @sym_132 {hw.verilogName = "_ifStage_WIRE_4_0_aluOp"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_0_aluOp, %c0_i5 : i5
    %_ifStage_WIRE_4_0_rs1 = sv.wire sym @sym_134 {hw.verilogName = "_ifStage_WIRE_4_0_rs1"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_0_rs1, %c0_i5 : i5
    %_ifStage_WIRE_4_0_rs2 = sv.wire sym @sym_135 {hw.verilogName = "_ifStage_WIRE_4_0_rs2"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_0_rs2, %c0_i5 : i5
    %_ifStage_WIRE_4_0_rd = sv.wire sym @sym_136 {hw.verilogName = "_ifStage_WIRE_4_0_rd"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_0_rd, %c0_i5 : i5
    %_ifStage_WIRE_4_1_aluOp = sv.wire sym @sym_157 {hw.verilogName = "_ifStage_WIRE_4_1_aluOp"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_1_aluOp, %c0_i5 : i5
    %_ifStage_WIRE_4_1_rs1 = sv.wire sym @sym_159 {hw.verilogName = "_ifStage_WIRE_4_1_rs1"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_1_rs1, %c0_i5 : i5
    %_ifStage_WIRE_4_1_rs2 = sv.wire sym @sym_160 {hw.verilogName = "_ifStage_WIRE_4_1_rs2"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_1_rs2, %c0_i5 : i5
    %_ifStage_WIRE_4_1_rd = sv.wire sym @sym_161 {hw.verilogName = "_ifStage_WIRE_4_1_rd"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_1_rd, %c0_i5 : i5
    %_ifStage_WIRE_4_2_aluOp = sv.wire sym @sym_182 {hw.verilogName = "_ifStage_WIRE_4_2_aluOp"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_2_aluOp, %c0_i5 : i5
    %_ifStage_WIRE_4_2_rs1 = sv.wire sym @sym_184 {hw.verilogName = "_ifStage_WIRE_4_2_rs1"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_2_rs1, %c0_i5 : i5
    %_ifStage_WIRE_4_2_rs2 = sv.wire sym @sym_185 {hw.verilogName = "_ifStage_WIRE_4_2_rs2"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_2_rs2, %c0_i5 : i5
    %_ifStage_WIRE_4_2_rd = sv.wire sym @sym_186 {hw.verilogName = "_ifStage_WIRE_4_2_rd"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_2_rd, %c0_i5 : i5
    %_ifStage_WIRE_4_3_aluOp = sv.wire sym @sym_207 {hw.verilogName = "_ifStage_WIRE_4_3_aluOp"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_3_aluOp, %c0_i5 : i5
    %_ifStage_WIRE_4_3_rs1 = sv.wire sym @sym_209 {hw.verilogName = "_ifStage_WIRE_4_3_rs1"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_3_rs1, %c0_i5 : i5
    %_ifStage_WIRE_4_3_rs2 = sv.wire sym @sym_210 {hw.verilogName = "_ifStage_WIRE_4_3_rs2"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_3_rs2, %c0_i5 : i5
    %_ifStage_WIRE_4_3_rd = sv.wire sym @sym_211 {hw.verilogName = "_ifStage_WIRE_4_3_rd"} : !hw.inout<i5>
    sv.assign %_ifStage_WIRE_4_3_rd, %c0_i5 : i5
    %_decStage_WIRE_aluOp = sv.wire sym @sym_248 {hw.verilogName = "_decStage_WIRE_aluOp"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_aluOp, %c0_i5 : i5
    %_decStage_WIRE_rs1 = sv.wire sym @sym_250 {hw.verilogName = "_decStage_WIRE_rs1"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_rs1, %c0_i5 : i5
    %_decStage_WIRE_rs2 = sv.wire sym @sym_251 {hw.verilogName = "_decStage_WIRE_rs2"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_rs2, %c0_i5 : i5
    %_decStage_WIRE_rd = sv.wire sym @sym_252 {hw.verilogName = "_decStage_WIRE_rd"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_rd, %c0_i5 : i5
    %_decStage_WIRE_1_aluOp = sv.wire sym @sym_273 {hw.verilogName = "_decStage_WIRE_1_aluOp"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_1_aluOp, %c0_i5 : i5
    %_decStage_WIRE_1_rs1 = sv.wire sym @sym_275 {hw.verilogName = "_decStage_WIRE_1_rs1"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_1_rs1, %c0_i5 : i5
    %_decStage_WIRE_1_rs2 = sv.wire sym @sym_276 {hw.verilogName = "_decStage_WIRE_1_rs2"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_1_rs2, %c0_i5 : i5
    %_decStage_WIRE_1_rd = sv.wire sym @sym_277 {hw.verilogName = "_decStage_WIRE_1_rd"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_1_rd, %c0_i5 : i5
    %_decStage_WIRE_2_aluOp = sv.wire sym @sym_298 {hw.verilogName = "_decStage_WIRE_2_aluOp"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_2_aluOp, %c0_i5 : i5
    %_decStage_WIRE_2_rs1 = sv.wire sym @sym_300 {hw.verilogName = "_decStage_WIRE_2_rs1"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_2_rs1, %c0_i5 : i5
    %_decStage_WIRE_2_rs2 = sv.wire sym @sym_301 {hw.verilogName = "_decStage_WIRE_2_rs2"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_2_rs2, %c0_i5 : i5
    %_decStage_WIRE_2_rd = sv.wire sym @sym_302 {hw.verilogName = "_decStage_WIRE_2_rd"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_2_rd, %c0_i5 : i5
    %_decStage_WIRE_3_aluOp = sv.wire sym @sym_323 {hw.verilogName = "_decStage_WIRE_3_aluOp"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_3_aluOp, %c0_i5 : i5
    %_decStage_WIRE_3_rs1 = sv.wire sym @sym_325 {hw.verilogName = "_decStage_WIRE_3_rs1"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_3_rs1, %c0_i5 : i5
    %_decStage_WIRE_3_rs2 = sv.wire sym @sym_326 {hw.verilogName = "_decStage_WIRE_3_rs2"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_3_rs2, %c0_i5 : i5
    %_decStage_WIRE_3_rd = sv.wire sym @sym_327 {hw.verilogName = "_decStage_WIRE_3_rd"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_3_rd, %c0_i5 : i5
    %_decStage_WIRE_4_0_aluOp = sv.wire sym @sym_348 {hw.verilogName = "_decStage_WIRE_4_0_aluOp"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_0_aluOp, %c0_i5 : i5
    %_decStage_WIRE_4_0_rs1 = sv.wire sym @sym_350 {hw.verilogName = "_decStage_WIRE_4_0_rs1"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_0_rs1, %c0_i5 : i5
    %_decStage_WIRE_4_0_rs2 = sv.wire sym @sym_351 {hw.verilogName = "_decStage_WIRE_4_0_rs2"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_0_rs2, %c0_i5 : i5
    %_decStage_WIRE_4_0_rd = sv.wire sym @sym_352 {hw.verilogName = "_decStage_WIRE_4_0_rd"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_0_rd, %c0_i5 : i5
    %_decStage_WIRE_4_1_aluOp = sv.wire sym @sym_373 {hw.verilogName = "_decStage_WIRE_4_1_aluOp"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_1_aluOp, %c0_i5 : i5
    %_decStage_WIRE_4_1_rs1 = sv.wire sym @sym_375 {hw.verilogName = "_decStage_WIRE_4_1_rs1"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_1_rs1, %c0_i5 : i5
    %_decStage_WIRE_4_1_rs2 = sv.wire sym @sym_376 {hw.verilogName = "_decStage_WIRE_4_1_rs2"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_1_rs2, %c0_i5 : i5
    %_decStage_WIRE_4_1_rd = sv.wire sym @sym_377 {hw.verilogName = "_decStage_WIRE_4_1_rd"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_1_rd, %c0_i5 : i5
    %_decStage_WIRE_4_2_aluOp = sv.wire sym @sym_398 {hw.verilogName = "_decStage_WIRE_4_2_aluOp"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_2_aluOp, %c0_i5 : i5
    %_decStage_WIRE_4_2_rs1 = sv.wire sym @sym_400 {hw.verilogName = "_decStage_WIRE_4_2_rs1"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_2_rs1, %c0_i5 : i5
    %_decStage_WIRE_4_2_rs2 = sv.wire sym @sym_401 {hw.verilogName = "_decStage_WIRE_4_2_rs2"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_2_rs2, %c0_i5 : i5
    %_decStage_WIRE_4_2_rd = sv.wire sym @sym_402 {hw.verilogName = "_decStage_WIRE_4_2_rd"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_2_rd, %c0_i5 : i5
    %_decStage_WIRE_4_3_aluOp = sv.wire sym @sym_423 {hw.verilogName = "_decStage_WIRE_4_3_aluOp"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_3_aluOp, %c0_i5 : i5
    %_decStage_WIRE_4_3_rs1 = sv.wire sym @sym_425 {hw.verilogName = "_decStage_WIRE_4_3_rs1"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_3_rs1, %c0_i5 : i5
    %_decStage_WIRE_4_3_rs2 = sv.wire sym @sym_426 {hw.verilogName = "_decStage_WIRE_4_3_rs2"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_3_rs2, %c0_i5 : i5
    %_decStage_WIRE_4_3_rd = sv.wire sym @sym_427 {hw.verilogName = "_decStage_WIRE_4_3_rd"} : !hw.inout<i5>
    sv.assign %_decStage_WIRE_4_3_rd, %c0_i5 : i5
    %_exStage_WIRE_aluOp = sv.wire sym @sym_548 {hw.verilogName = "_exStage_WIRE_aluOp"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_aluOp, %c0_i5 : i5
    %_exStage_WIRE_rs1 = sv.wire sym @sym_550 {hw.verilogName = "_exStage_WIRE_rs1"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_rs1, %c0_i5 : i5
    %_exStage_WIRE_rs2 = sv.wire sym @sym_551 {hw.verilogName = "_exStage_WIRE_rs2"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_rs2, %c0_i5 : i5
    %_exStage_WIRE_rd = sv.wire sym @sym_552 {hw.verilogName = "_exStage_WIRE_rd"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_rd, %c0_i5 : i5
    %_exStage_WIRE_1_aluOp = sv.wire sym @sym_573 {hw.verilogName = "_exStage_WIRE_1_aluOp"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_1_aluOp, %c0_i5 : i5
    %_exStage_WIRE_1_rs1 = sv.wire sym @sym_575 {hw.verilogName = "_exStage_WIRE_1_rs1"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_1_rs1, %c0_i5 : i5
    %_exStage_WIRE_1_rs2 = sv.wire sym @sym_576 {hw.verilogName = "_exStage_WIRE_1_rs2"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_1_rs2, %c0_i5 : i5
    %_exStage_WIRE_1_rd = sv.wire sym @sym_577 {hw.verilogName = "_exStage_WIRE_1_rd"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_1_rd, %c0_i5 : i5
    %_exStage_WIRE_2_aluOp = sv.wire sym @sym_598 {hw.verilogName = "_exStage_WIRE_2_aluOp"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_2_aluOp, %c0_i5 : i5
    %_exStage_WIRE_2_rs1 = sv.wire sym @sym_600 {hw.verilogName = "_exStage_WIRE_2_rs1"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_2_rs1, %c0_i5 : i5
    %_exStage_WIRE_2_rs2 = sv.wire sym @sym_601 {hw.verilogName = "_exStage_WIRE_2_rs2"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_2_rs2, %c0_i5 : i5
    %_exStage_WIRE_2_rd = sv.wire sym @sym_602 {hw.verilogName = "_exStage_WIRE_2_rd"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_2_rd, %c0_i5 : i5
    %_exStage_WIRE_3_aluOp = sv.wire sym @sym_623 {hw.verilogName = "_exStage_WIRE_3_aluOp"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_3_aluOp, %c0_i5 : i5
    %_exStage_WIRE_3_rs1 = sv.wire sym @sym_625 {hw.verilogName = "_exStage_WIRE_3_rs1"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_3_rs1, %c0_i5 : i5
    %_exStage_WIRE_3_rs2 = sv.wire sym @sym_626 {hw.verilogName = "_exStage_WIRE_3_rs2"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_3_rs2, %c0_i5 : i5
    %_exStage_WIRE_3_rd = sv.wire sym @sym_627 {hw.verilogName = "_exStage_WIRE_3_rd"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_3_rd, %c0_i5 : i5
    %_exStage_WIRE_4_0_aluOp = sv.wire sym @sym_648 {hw.verilogName = "_exStage_WIRE_4_0_aluOp"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_0_aluOp, %c0_i5 : i5
    %_exStage_WIRE_4_0_rs1 = sv.wire sym @sym_650 {hw.verilogName = "_exStage_WIRE_4_0_rs1"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_0_rs1, %c0_i5 : i5
    %_exStage_WIRE_4_0_rs2 = sv.wire sym @sym_651 {hw.verilogName = "_exStage_WIRE_4_0_rs2"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_0_rs2, %c0_i5 : i5
    %_exStage_WIRE_4_0_rd = sv.wire sym @sym_652 {hw.verilogName = "_exStage_WIRE_4_0_rd"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_0_rd, %c0_i5 : i5
    %_exStage_WIRE_4_1_aluOp = sv.wire sym @sym_673 {hw.verilogName = "_exStage_WIRE_4_1_aluOp"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_1_aluOp, %c0_i5 : i5
    %_exStage_WIRE_4_1_rs1 = sv.wire sym @sym_675 {hw.verilogName = "_exStage_WIRE_4_1_rs1"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_1_rs1, %c0_i5 : i5
    %_exStage_WIRE_4_1_rs2 = sv.wire sym @sym_676 {hw.verilogName = "_exStage_WIRE_4_1_rs2"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_1_rs2, %c0_i5 : i5
    %_exStage_WIRE_4_1_rd = sv.wire sym @sym_677 {hw.verilogName = "_exStage_WIRE_4_1_rd"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_1_rd, %c0_i5 : i5
    %_exStage_WIRE_4_2_aluOp = sv.wire sym @sym_698 {hw.verilogName = "_exStage_WIRE_4_2_aluOp"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_2_aluOp, %c0_i5 : i5
    %_exStage_WIRE_4_2_rs1 = sv.wire sym @sym_700 {hw.verilogName = "_exStage_WIRE_4_2_rs1"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_2_rs1, %c0_i5 : i5
    %_exStage_WIRE_4_2_rs2 = sv.wire sym @sym_701 {hw.verilogName = "_exStage_WIRE_4_2_rs2"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_2_rs2, %c0_i5 : i5
    %_exStage_WIRE_4_2_rd = sv.wire sym @sym_702 {hw.verilogName = "_exStage_WIRE_4_2_rd"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_2_rd, %c0_i5 : i5
    %_exStage_WIRE_4_3_aluOp = sv.wire sym @sym_723 {hw.verilogName = "_exStage_WIRE_4_3_aluOp"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_3_aluOp, %c0_i5 : i5
    %_exStage_WIRE_4_3_rs1 = sv.wire sym @sym_725 {hw.verilogName = "_exStage_WIRE_4_3_rs1"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_3_rs1, %c0_i5 : i5
    %_exStage_WIRE_4_3_rs2 = sv.wire sym @sym_726 {hw.verilogName = "_exStage_WIRE_4_3_rs2"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_3_rs2, %c0_i5 : i5
    %_exStage_WIRE_4_3_rd = sv.wire sym @sym_727 {hw.verilogName = "_exStage_WIRE_4_3_rd"} : !hw.inout<i5>
    sv.assign %_exStage_WIRE_4_3_rd, %c0_i5 : i5
    %_memStage_WIRE_aluOp = sv.wire sym @sym_848 {hw.verilogName = "_memStage_WIRE_aluOp"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_aluOp, %c0_i5 : i5
    %_memStage_WIRE_rs1 = sv.wire sym @sym_850 {hw.verilogName = "_memStage_WIRE_rs1"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_rs1, %c0_i5 : i5
    %_memStage_WIRE_rs2 = sv.wire sym @sym_851 {hw.verilogName = "_memStage_WIRE_rs2"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_rs2, %c0_i5 : i5
    %_memStage_WIRE_rd = sv.wire sym @sym_852 {hw.verilogName = "_memStage_WIRE_rd"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_rd, %c0_i5 : i5
    %_memStage_WIRE_1_aluOp = sv.wire sym @sym_873 {hw.verilogName = "_memStage_WIRE_1_aluOp"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_1_aluOp, %c0_i5 : i5
    %_memStage_WIRE_1_rs1 = sv.wire sym @sym_875 {hw.verilogName = "_memStage_WIRE_1_rs1"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_1_rs1, %c0_i5 : i5
    %_memStage_WIRE_1_rs2 = sv.wire sym @sym_876 {hw.verilogName = "_memStage_WIRE_1_rs2"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_1_rs2, %c0_i5 : i5
    %_memStage_WIRE_1_rd = sv.wire sym @sym_877 {hw.verilogName = "_memStage_WIRE_1_rd"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_1_rd, %c0_i5 : i5
    %_memStage_WIRE_2_aluOp = sv.wire sym @sym_898 {hw.verilogName = "_memStage_WIRE_2_aluOp"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_2_aluOp, %c0_i5 : i5
    %_memStage_WIRE_2_rs1 = sv.wire sym @sym_900 {hw.verilogName = "_memStage_WIRE_2_rs1"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_2_rs1, %c0_i5 : i5
    %_memStage_WIRE_2_rs2 = sv.wire sym @sym_901 {hw.verilogName = "_memStage_WIRE_2_rs2"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_2_rs2, %c0_i5 : i5
    %_memStage_WIRE_2_rd = sv.wire sym @sym_902 {hw.verilogName = "_memStage_WIRE_2_rd"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_2_rd, %c0_i5 : i5
    %_memStage_WIRE_3_aluOp = sv.wire sym @sym_923 {hw.verilogName = "_memStage_WIRE_3_aluOp"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_3_aluOp, %c0_i5 : i5
    %_memStage_WIRE_3_rs1 = sv.wire sym @sym_925 {hw.verilogName = "_memStage_WIRE_3_rs1"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_3_rs1, %c0_i5 : i5
    %_memStage_WIRE_3_rs2 = sv.wire sym @sym_926 {hw.verilogName = "_memStage_WIRE_3_rs2"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_3_rs2, %c0_i5 : i5
    %_memStage_WIRE_3_rd = sv.wire sym @sym_927 {hw.verilogName = "_memStage_WIRE_3_rd"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_3_rd, %c0_i5 : i5
    %_memStage_WIRE_4_0_aluOp = sv.wire sym @sym_948 {hw.verilogName = "_memStage_WIRE_4_0_aluOp"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_0_aluOp, %c0_i5 : i5
    %_memStage_WIRE_4_0_rs1 = sv.wire sym @sym_950 {hw.verilogName = "_memStage_WIRE_4_0_rs1"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_0_rs1, %c0_i5 : i5
    %_memStage_WIRE_4_0_rs2 = sv.wire sym @sym_951 {hw.verilogName = "_memStage_WIRE_4_0_rs2"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_0_rs2, %c0_i5 : i5
    %_memStage_WIRE_4_0_rd = sv.wire sym @sym_952 {hw.verilogName = "_memStage_WIRE_4_0_rd"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_0_rd, %c0_i5 : i5
    %_memStage_WIRE_4_1_aluOp = sv.wire sym @sym_973 {hw.verilogName = "_memStage_WIRE_4_1_aluOp"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_1_aluOp, %c0_i5 : i5
    %_memStage_WIRE_4_1_rs1 = sv.wire sym @sym_975 {hw.verilogName = "_memStage_WIRE_4_1_rs1"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_1_rs1, %c0_i5 : i5
    %_memStage_WIRE_4_1_rs2 = sv.wire sym @sym_976 {hw.verilogName = "_memStage_WIRE_4_1_rs2"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_1_rs2, %c0_i5 : i5
    %_memStage_WIRE_4_1_rd = sv.wire sym @sym_977 {hw.verilogName = "_memStage_WIRE_4_1_rd"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_1_rd, %c0_i5 : i5
    %_memStage_WIRE_4_2_aluOp = sv.wire sym @sym_998 {hw.verilogName = "_memStage_WIRE_4_2_aluOp"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_2_aluOp, %c0_i5 : i5
    %_memStage_WIRE_4_2_rs1 = sv.wire sym @sym_1000 {hw.verilogName = "_memStage_WIRE_4_2_rs1"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_2_rs1, %c0_i5 : i5
    %_memStage_WIRE_4_2_rs2 = sv.wire sym @sym_1001 {hw.verilogName = "_memStage_WIRE_4_2_rs2"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_2_rs2, %c0_i5 : i5
    %_memStage_WIRE_4_2_rd = sv.wire sym @sym_1002 {hw.verilogName = "_memStage_WIRE_4_2_rd"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_2_rd, %c0_i5 : i5
    %_memStage_WIRE_4_3_aluOp = sv.wire sym @sym_1023 {hw.verilogName = "_memStage_WIRE_4_3_aluOp"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_3_aluOp, %c0_i5 : i5
    %_memStage_WIRE_4_3_rs1 = sv.wire sym @sym_1025 {hw.verilogName = "_memStage_WIRE_4_3_rs1"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_3_rs1, %c0_i5 : i5
    %_memStage_WIRE_4_3_rs2 = sv.wire sym @sym_1026 {hw.verilogName = "_memStage_WIRE_4_3_rs2"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_3_rs2, %c0_i5 : i5
    %_memStage_WIRE_4_3_rd = sv.wire sym @sym_1027 {hw.verilogName = "_memStage_WIRE_4_3_rd"} : !hw.inout<i5>
    sv.assign %_memStage_WIRE_4_3_rd, %c0_i5 : i5
    %_ifWire_WIRE_aluOp = sv.wire sym @sym_1148 {hw.verilogName = "_ifWire_WIRE_aluOp"} : !hw.inout<i5>
    sv.assign %_ifWire_WIRE_aluOp, %c0_i5 : i5
    %_ifWire_WIRE_rs1 = sv.wire sym @sym_1150 {hw.verilogName = "_ifWire_WIRE_rs1"} : !hw.inout<i5>
    sv.assign %_ifWire_WIRE_rs1, %c0_i5 : i5
    %_ifWire_WIRE_rs2 = sv.wire sym @sym_1151 {hw.verilogName = "_ifWire_WIRE_rs2"} : !hw.inout<i5>
    sv.assign %_ifWire_WIRE_rs2, %c0_i5 : i5
    %_ifWire_WIRE_rd = sv.wire sym @sym_1152 {hw.verilogName = "_ifWire_WIRE_rd"} : !hw.inout<i5>
    sv.assign %_ifWire_WIRE_rd, %c0_i5 : i5
    %ifWire_aluOp = sv.wire sym @sym_1173 {hw.verilogName = "ifWire_aluOp"} : !hw.inout<i5>
    sv.assign %ifWire_aluOp, %c0_i5 : i5
    %ifWire_rs1 = sv.wire sym @sym_1175 {hw.verilogName = "ifWire_rs1"} : !hw.inout<i5>
    sv.assign %ifWire_rs1, %c0_i5 : i5
    %ifWire_rs2 = sv.wire sym @sym_1176 {hw.verilogName = "ifWire_rs2"} : !hw.inout<i5>
    sv.assign %ifWire_rs2, %c0_i5 : i5
    %ifWire_rd = sv.wire sym @sym_1177 {hw.verilogName = "ifWire_rd"} : !hw.inout<i5>
    sv.assign %ifWire_rd, %c0_i5 : i5
    %_decWire_WIRE_aluOp = sv.wire sym @sym_1203 {hw.verilogName = "_decWire_WIRE_aluOp"} : !hw.inout<i5>
    sv.assign %_decWire_WIRE_aluOp, %c0_i5 : i5
    %_decWire_WIRE_rs1 = sv.wire sym @sym_1205 {hw.verilogName = "_decWire_WIRE_rs1"} : !hw.inout<i5>
    sv.assign %_decWire_WIRE_rs1, %c0_i5 : i5
    %_decWire_WIRE_rs2 = sv.wire sym @sym_1206 {hw.verilogName = "_decWire_WIRE_rs2"} : !hw.inout<i5>
    sv.assign %_decWire_WIRE_rs2, %c0_i5 : i5
    %_decWire_WIRE_rd = sv.wire sym @sym_1207 {hw.verilogName = "_decWire_WIRE_rd"} : !hw.inout<i5>
    sv.assign %_decWire_WIRE_rd, %c0_i5 : i5
    %_exWire_WIRE_aluOp = sv.wire sym @sym_1257 {hw.verilogName = "_exWire_WIRE_aluOp"} : !hw.inout<i5>
    sv.assign %_exWire_WIRE_aluOp, %c0_i5 : i5
    %_exWire_WIRE_rs1 = sv.wire sym @sym_1259 {hw.verilogName = "_exWire_WIRE_rs1"} : !hw.inout<i5>
    sv.assign %_exWire_WIRE_rs1, %c0_i5 : i5
    %_exWire_WIRE_rs2 = sv.wire sym @sym_1260 {hw.verilogName = "_exWire_WIRE_rs2"} : !hw.inout<i5>
    sv.assign %_exWire_WIRE_rs2, %c0_i5 : i5
    %_exWire_WIRE_rd = sv.wire sym @sym_1261 {hw.verilogName = "_exWire_WIRE_rd"} : !hw.inout<i5>
    sv.assign %_exWire_WIRE_rd, %c0_i5 : i5
    %_memWire_WIRE_aluOp = sv.wire sym @sym_1309 {hw.verilogName = "_memWire_WIRE_aluOp"} : !hw.inout<i5>
    sv.assign %_memWire_WIRE_aluOp, %c0_i5 : i5
    %_memWire_WIRE_rs1 = sv.wire sym @sym_1311 {hw.verilogName = "_memWire_WIRE_rs1"} : !hw.inout<i5>
    sv.assign %_memWire_WIRE_rs1, %c0_i5 : i5
    %_memWire_WIRE_rs2 = sv.wire sym @sym_1312 {hw.verilogName = "_memWire_WIRE_rs2"} : !hw.inout<i5>
    sv.assign %_memWire_WIRE_rs2, %c0_i5 : i5
    %_memWire_WIRE_rd = sv.wire sym @sym_1313 {hw.verilogName = "_memWire_WIRE_rd"} : !hw.inout<i5>
    sv.assign %_memWire_WIRE_rd, %c0_i5 : i5
    %c0_i32 = hw.constant 0 : i32
    %_pcRegs_WIRE_0 = sv.wire sym @sym_10 {hw.verilogName = "_pcRegs_WIRE_0"} : !hw.inout<i32>
    sv.assign %_pcRegs_WIRE_0, %c0_i32 : i32
    %_pcRegs_WIRE_1 = sv.wire sym @sym_11 {hw.verilogName = "_pcRegs_WIRE_1"} : !hw.inout<i32>
    sv.assign %_pcRegs_WIRE_1, %c0_i32 : i32
    %_pcRegs_WIRE_2 = sv.wire sym @sym_12 {hw.verilogName = "_pcRegs_WIRE_2"} : !hw.inout<i32>
    sv.assign %_pcRegs_WIRE_2, %c0_i32 : i32
    %_pcRegs_WIRE_3 = sv.wire sym @sym_13 {hw.verilogName = "_pcRegs_WIRE_3"} : !hw.inout<i32>
    sv.assign %_pcRegs_WIRE_3, %c0_i32 : i32
    %_ifStage_WIRE_pc = sv.wire sym @sym_20 {hw.verilogName = "_ifStage_WIRE_pc"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_pc, %c0_i32 : i32
    %_ifStage_WIRE_instr = sv.wire sym @sym_21 {hw.verilogName = "_ifStage_WIRE_instr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_instr, %c0_i32 : i32
    %_ifStage_WIRE_imm = sv.wire sym @sym_33 {hw.verilogName = "_ifStage_WIRE_imm"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_imm, %c0_i32 : i32
    %_ifStage_WIRE_rs1Data = sv.wire sym @sym_37 {hw.verilogName = "_ifStage_WIRE_rs1Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_rs1Data, %c0_i32 : i32
    %_ifStage_WIRE_rs2Data = sv.wire sym @sym_38 {hw.verilogName = "_ifStage_WIRE_rs2Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_rs2Data, %c0_i32 : i32
    %_ifStage_WIRE_memAddr = sv.wire sym @sym_39 {hw.verilogName = "_ifStage_WIRE_memAddr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_memAddr, %c0_i32 : i32
    %_ifStage_WIRE_memWdata = sv.wire sym @sym_40 {hw.verilogName = "_ifStage_WIRE_memWdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_memWdata, %c0_i32 : i32
    %_ifStage_WIRE_memRdata = sv.wire sym @sym_41 {hw.verilogName = "_ifStage_WIRE_memRdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_memRdata, %c0_i32 : i32
    %_ifStage_WIRE_aluResult = sv.wire sym @sym_42 {hw.verilogName = "_ifStage_WIRE_aluResult"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_aluResult, %c0_i32 : i32
    %_ifStage_WIRE_1_pc = sv.wire sym @sym_45 {hw.verilogName = "_ifStage_WIRE_1_pc"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_1_pc, %c0_i32 : i32
    %_ifStage_WIRE_1_instr = sv.wire sym @sym_46 {hw.verilogName = "_ifStage_WIRE_1_instr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_1_instr, %c0_i32 : i32
    %_ifStage_WIRE_1_imm = sv.wire sym @sym_58 {hw.verilogName = "_ifStage_WIRE_1_imm"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_1_imm, %c0_i32 : i32
    %_ifStage_WIRE_1_rs1Data = sv.wire sym @sym_62 {hw.verilogName = "_ifStage_WIRE_1_rs1Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_1_rs1Data, %c0_i32 : i32
    %_ifStage_WIRE_1_rs2Data = sv.wire sym @sym_63 {hw.verilogName = "_ifStage_WIRE_1_rs2Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_1_rs2Data, %c0_i32 : i32
    %_ifStage_WIRE_1_memAddr = sv.wire sym @sym_64 {hw.verilogName = "_ifStage_WIRE_1_memAddr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_1_memAddr, %c0_i32 : i32
    %_ifStage_WIRE_1_memWdata = sv.wire sym @sym_65 {hw.verilogName = "_ifStage_WIRE_1_memWdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_1_memWdata, %c0_i32 : i32
    %_ifStage_WIRE_1_memRdata = sv.wire sym @sym_66 {hw.verilogName = "_ifStage_WIRE_1_memRdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_1_memRdata, %c0_i32 : i32
    %_ifStage_WIRE_1_aluResult = sv.wire sym @sym_67 {hw.verilogName = "_ifStage_WIRE_1_aluResult"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_1_aluResult, %c0_i32 : i32
    %_ifStage_WIRE_2_pc = sv.wire sym @sym_70 {hw.verilogName = "_ifStage_WIRE_2_pc"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_2_pc, %c0_i32 : i32
    %_ifStage_WIRE_2_instr = sv.wire sym @sym_71 {hw.verilogName = "_ifStage_WIRE_2_instr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_2_instr, %c0_i32 : i32
    %_ifStage_WIRE_2_imm = sv.wire sym @sym_83 {hw.verilogName = "_ifStage_WIRE_2_imm"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_2_imm, %c0_i32 : i32
    %_ifStage_WIRE_2_rs1Data = sv.wire sym @sym_87 {hw.verilogName = "_ifStage_WIRE_2_rs1Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_2_rs1Data, %c0_i32 : i32
    %_ifStage_WIRE_2_rs2Data = sv.wire sym @sym_88 {hw.verilogName = "_ifStage_WIRE_2_rs2Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_2_rs2Data, %c0_i32 : i32
    %_ifStage_WIRE_2_memAddr = sv.wire sym @sym_89 {hw.verilogName = "_ifStage_WIRE_2_memAddr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_2_memAddr, %c0_i32 : i32
    %_ifStage_WIRE_2_memWdata = sv.wire sym @sym_90 {hw.verilogName = "_ifStage_WIRE_2_memWdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_2_memWdata, %c0_i32 : i32
    %_ifStage_WIRE_2_memRdata = sv.wire sym @sym_91 {hw.verilogName = "_ifStage_WIRE_2_memRdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_2_memRdata, %c0_i32 : i32
    %_ifStage_WIRE_2_aluResult = sv.wire sym @sym_92 {hw.verilogName = "_ifStage_WIRE_2_aluResult"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_2_aluResult, %c0_i32 : i32
    %_ifStage_WIRE_3_pc = sv.wire sym @sym_95 {hw.verilogName = "_ifStage_WIRE_3_pc"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_3_pc, %c0_i32 : i32
    %_ifStage_WIRE_3_instr = sv.wire sym @sym_96 {hw.verilogName = "_ifStage_WIRE_3_instr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_3_instr, %c0_i32 : i32
    %_ifStage_WIRE_3_imm = sv.wire sym @sym_108 {hw.verilogName = "_ifStage_WIRE_3_imm"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_3_imm, %c0_i32 : i32
    %_ifStage_WIRE_3_rs1Data = sv.wire sym @sym_112 {hw.verilogName = "_ifStage_WIRE_3_rs1Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_3_rs1Data, %c0_i32 : i32
    %_ifStage_WIRE_3_rs2Data = sv.wire sym @sym_113 {hw.verilogName = "_ifStage_WIRE_3_rs2Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_3_rs2Data, %c0_i32 : i32
    %_ifStage_WIRE_3_memAddr = sv.wire sym @sym_114 {hw.verilogName = "_ifStage_WIRE_3_memAddr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_3_memAddr, %c0_i32 : i32
    %_ifStage_WIRE_3_memWdata = sv.wire sym @sym_115 {hw.verilogName = "_ifStage_WIRE_3_memWdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_3_memWdata, %c0_i32 : i32
    %_ifStage_WIRE_3_memRdata = sv.wire sym @sym_116 {hw.verilogName = "_ifStage_WIRE_3_memRdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_3_memRdata, %c0_i32 : i32
    %_ifStage_WIRE_3_aluResult = sv.wire sym @sym_117 {hw.verilogName = "_ifStage_WIRE_3_aluResult"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_3_aluResult, %c0_i32 : i32
    %_ifStage_WIRE_4_0_pc = sv.wire sym @sym_120 {hw.verilogName = "_ifStage_WIRE_4_0_pc"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_0_pc, %c0_i32 : i32
    %_ifStage_WIRE_4_0_instr = sv.wire sym @sym_121 {hw.verilogName = "_ifStage_WIRE_4_0_instr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_0_instr, %c0_i32 : i32
    %_ifStage_WIRE_4_0_imm = sv.wire sym @sym_133 {hw.verilogName = "_ifStage_WIRE_4_0_imm"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_0_imm, %c0_i32 : i32
    %_ifStage_WIRE_4_0_rs1Data = sv.wire sym @sym_137 {hw.verilogName = "_ifStage_WIRE_4_0_rs1Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_0_rs1Data, %c0_i32 : i32
    %_ifStage_WIRE_4_0_rs2Data = sv.wire sym @sym_138 {hw.verilogName = "_ifStage_WIRE_4_0_rs2Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_0_rs2Data, %c0_i32 : i32
    %_ifStage_WIRE_4_0_memAddr = sv.wire sym @sym_139 {hw.verilogName = "_ifStage_WIRE_4_0_memAddr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_0_memAddr, %c0_i32 : i32
    %_ifStage_WIRE_4_0_memWdata = sv.wire sym @sym_140 {hw.verilogName = "_ifStage_WIRE_4_0_memWdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_0_memWdata, %c0_i32 : i32
    %_ifStage_WIRE_4_0_memRdata = sv.wire sym @sym_141 {hw.verilogName = "_ifStage_WIRE_4_0_memRdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_0_memRdata, %c0_i32 : i32
    %_ifStage_WIRE_4_0_aluResult = sv.wire sym @sym_142 {hw.verilogName = "_ifStage_WIRE_4_0_aluResult"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_0_aluResult, %c0_i32 : i32
    %_ifStage_WIRE_4_1_pc = sv.wire sym @sym_145 {hw.verilogName = "_ifStage_WIRE_4_1_pc"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_1_pc, %c0_i32 : i32
    %_ifStage_WIRE_4_1_instr = sv.wire sym @sym_146 {hw.verilogName = "_ifStage_WIRE_4_1_instr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_1_instr, %c0_i32 : i32
    %_ifStage_WIRE_4_1_imm = sv.wire sym @sym_158 {hw.verilogName = "_ifStage_WIRE_4_1_imm"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_1_imm, %c0_i32 : i32
    %_ifStage_WIRE_4_1_rs1Data = sv.wire sym @sym_162 {hw.verilogName = "_ifStage_WIRE_4_1_rs1Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_1_rs1Data, %c0_i32 : i32
    %_ifStage_WIRE_4_1_rs2Data = sv.wire sym @sym_163 {hw.verilogName = "_ifStage_WIRE_4_1_rs2Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_1_rs2Data, %c0_i32 : i32
    %_ifStage_WIRE_4_1_memAddr = sv.wire sym @sym_164 {hw.verilogName = "_ifStage_WIRE_4_1_memAddr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_1_memAddr, %c0_i32 : i32
    %_ifStage_WIRE_4_1_memWdata = sv.wire sym @sym_165 {hw.verilogName = "_ifStage_WIRE_4_1_memWdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_1_memWdata, %c0_i32 : i32
    %_ifStage_WIRE_4_1_memRdata = sv.wire sym @sym_166 {hw.verilogName = "_ifStage_WIRE_4_1_memRdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_1_memRdata, %c0_i32 : i32
    %_ifStage_WIRE_4_1_aluResult = sv.wire sym @sym_167 {hw.verilogName = "_ifStage_WIRE_4_1_aluResult"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_1_aluResult, %c0_i32 : i32
    %_ifStage_WIRE_4_2_pc = sv.wire sym @sym_170 {hw.verilogName = "_ifStage_WIRE_4_2_pc"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_2_pc, %c0_i32 : i32
    %_ifStage_WIRE_4_2_instr = sv.wire sym @sym_171 {hw.verilogName = "_ifStage_WIRE_4_2_instr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_2_instr, %c0_i32 : i32
    %_ifStage_WIRE_4_2_imm = sv.wire sym @sym_183 {hw.verilogName = "_ifStage_WIRE_4_2_imm"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_2_imm, %c0_i32 : i32
    %_ifStage_WIRE_4_2_rs1Data = sv.wire sym @sym_187 {hw.verilogName = "_ifStage_WIRE_4_2_rs1Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_2_rs1Data, %c0_i32 : i32
    %_ifStage_WIRE_4_2_rs2Data = sv.wire sym @sym_188 {hw.verilogName = "_ifStage_WIRE_4_2_rs2Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_2_rs2Data, %c0_i32 : i32
    %_ifStage_WIRE_4_2_memAddr = sv.wire sym @sym_189 {hw.verilogName = "_ifStage_WIRE_4_2_memAddr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_2_memAddr, %c0_i32 : i32
    %_ifStage_WIRE_4_2_memWdata = sv.wire sym @sym_190 {hw.verilogName = "_ifStage_WIRE_4_2_memWdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_2_memWdata, %c0_i32 : i32
    %_ifStage_WIRE_4_2_memRdata = sv.wire sym @sym_191 {hw.verilogName = "_ifStage_WIRE_4_2_memRdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_2_memRdata, %c0_i32 : i32
    %_ifStage_WIRE_4_2_aluResult = sv.wire sym @sym_192 {hw.verilogName = "_ifStage_WIRE_4_2_aluResult"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_2_aluResult, %c0_i32 : i32
    %_ifStage_WIRE_4_3_pc = sv.wire sym @sym_195 {hw.verilogName = "_ifStage_WIRE_4_3_pc"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_3_pc, %c0_i32 : i32
    %_ifStage_WIRE_4_3_instr = sv.wire sym @sym_196 {hw.verilogName = "_ifStage_WIRE_4_3_instr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_3_instr, %c0_i32 : i32
    %_ifStage_WIRE_4_3_imm = sv.wire sym @sym_208 {hw.verilogName = "_ifStage_WIRE_4_3_imm"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_3_imm, %c0_i32 : i32
    %_ifStage_WIRE_4_3_rs1Data = sv.wire sym @sym_212 {hw.verilogName = "_ifStage_WIRE_4_3_rs1Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_3_rs1Data, %c0_i32 : i32
    %_ifStage_WIRE_4_3_rs2Data = sv.wire sym @sym_213 {hw.verilogName = "_ifStage_WIRE_4_3_rs2Data"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_3_rs2Data, %c0_i32 : i32
    %_ifStage_WIRE_4_3_memAddr = sv.wire sym @sym_214 {hw.verilogName = "_ifStage_WIRE_4_3_memAddr"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_3_memAddr, %c0_i32 : i32
    %_ifStage_WIRE_4_3_memWdata = sv.wire sym @sym_215 {hw.verilogName = "_ifStage_WIRE_4_3_memWdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_3_memWdata, %c0_i32 : i32
    %_ifStage_WIRE_4_3_memRdata = sv.wire sym @sym_216 {hw.verilogName = "_ifStage_WIRE_4_3_memRdata"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_3_memRdata, %c0_i32 : i32
    %_ifStage_WIRE_4_3_aluResult = sv.wire sym @sym_217 {hw.verilogName = "_ifStage_WIRE_4_3_aluResult"} : !hw.inout<i32>
    sv.assign %_ifStage_WIRE_4_3_aluResult, %c0_i32 : i32
    %_decStage_WIRE_pc = sv.wire sym @sym_236 {hw.verilogName = "_decStage_WIRE_pc"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_pc, %c0_i32 : i32
    %_decStage_WIRE_instr = sv.wire sym @sym_237 {hw.verilogName = "_decStage_WIRE_instr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_instr, %c0_i32 : i32
    %_decStage_WIRE_imm = sv.wire sym @sym_249 {hw.verilogName = "_decStage_WIRE_imm"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_imm, %c0_i32 : i32
    %_decStage_WIRE_rs1Data = sv.wire sym @sym_253 {hw.verilogName = "_decStage_WIRE_rs1Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_rs1Data, %c0_i32 : i32
    %_decStage_WIRE_rs2Data = sv.wire sym @sym_254 {hw.verilogName = "_decStage_WIRE_rs2Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_rs2Data, %c0_i32 : i32
    %_decStage_WIRE_memAddr = sv.wire sym @sym_255 {hw.verilogName = "_decStage_WIRE_memAddr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_memAddr, %c0_i32 : i32
    %_decStage_WIRE_memWdata = sv.wire sym @sym_256 {hw.verilogName = "_decStage_WIRE_memWdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_memWdata, %c0_i32 : i32
    %_decStage_WIRE_memRdata = sv.wire sym @sym_257 {hw.verilogName = "_decStage_WIRE_memRdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_memRdata, %c0_i32 : i32
    %_decStage_WIRE_aluResult = sv.wire sym @sym_258 {hw.verilogName = "_decStage_WIRE_aluResult"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_aluResult, %c0_i32 : i32
    %_decStage_WIRE_1_pc = sv.wire sym @sym_261 {hw.verilogName = "_decStage_WIRE_1_pc"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_1_pc, %c0_i32 : i32
    %_decStage_WIRE_1_instr = sv.wire sym @sym_262 {hw.verilogName = "_decStage_WIRE_1_instr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_1_instr, %c0_i32 : i32
    %_decStage_WIRE_1_imm = sv.wire sym @sym_274 {hw.verilogName = "_decStage_WIRE_1_imm"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_1_imm, %c0_i32 : i32
    %_decStage_WIRE_1_rs1Data = sv.wire sym @sym_278 {hw.verilogName = "_decStage_WIRE_1_rs1Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_1_rs1Data, %c0_i32 : i32
    %_decStage_WIRE_1_rs2Data = sv.wire sym @sym_279 {hw.verilogName = "_decStage_WIRE_1_rs2Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_1_rs2Data, %c0_i32 : i32
    %_decStage_WIRE_1_memAddr = sv.wire sym @sym_280 {hw.verilogName = "_decStage_WIRE_1_memAddr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_1_memAddr, %c0_i32 : i32
    %_decStage_WIRE_1_memWdata = sv.wire sym @sym_281 {hw.verilogName = "_decStage_WIRE_1_memWdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_1_memWdata, %c0_i32 : i32
    %_decStage_WIRE_1_memRdata = sv.wire sym @sym_282 {hw.verilogName = "_decStage_WIRE_1_memRdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_1_memRdata, %c0_i32 : i32
    %_decStage_WIRE_1_aluResult = sv.wire sym @sym_283 {hw.verilogName = "_decStage_WIRE_1_aluResult"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_1_aluResult, %c0_i32 : i32
    %_decStage_WIRE_2_pc = sv.wire sym @sym_286 {hw.verilogName = "_decStage_WIRE_2_pc"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_2_pc, %c0_i32 : i32
    %_decStage_WIRE_2_instr = sv.wire sym @sym_287 {hw.verilogName = "_decStage_WIRE_2_instr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_2_instr, %c0_i32 : i32
    %_decStage_WIRE_2_imm = sv.wire sym @sym_299 {hw.verilogName = "_decStage_WIRE_2_imm"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_2_imm, %c0_i32 : i32
    %_decStage_WIRE_2_rs1Data = sv.wire sym @sym_303 {hw.verilogName = "_decStage_WIRE_2_rs1Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_2_rs1Data, %c0_i32 : i32
    %_decStage_WIRE_2_rs2Data = sv.wire sym @sym_304 {hw.verilogName = "_decStage_WIRE_2_rs2Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_2_rs2Data, %c0_i32 : i32
    %_decStage_WIRE_2_memAddr = sv.wire sym @sym_305 {hw.verilogName = "_decStage_WIRE_2_memAddr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_2_memAddr, %c0_i32 : i32
    %_decStage_WIRE_2_memWdata = sv.wire sym @sym_306 {hw.verilogName = "_decStage_WIRE_2_memWdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_2_memWdata, %c0_i32 : i32
    %_decStage_WIRE_2_memRdata = sv.wire sym @sym_307 {hw.verilogName = "_decStage_WIRE_2_memRdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_2_memRdata, %c0_i32 : i32
    %_decStage_WIRE_2_aluResult = sv.wire sym @sym_308 {hw.verilogName = "_decStage_WIRE_2_aluResult"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_2_aluResult, %c0_i32 : i32
    %_decStage_WIRE_3_pc = sv.wire sym @sym_311 {hw.verilogName = "_decStage_WIRE_3_pc"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_3_pc, %c0_i32 : i32
    %_decStage_WIRE_3_instr = sv.wire sym @sym_312 {hw.verilogName = "_decStage_WIRE_3_instr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_3_instr, %c0_i32 : i32
    %_decStage_WIRE_3_imm = sv.wire sym @sym_324 {hw.verilogName = "_decStage_WIRE_3_imm"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_3_imm, %c0_i32 : i32
    %_decStage_WIRE_3_rs1Data = sv.wire sym @sym_328 {hw.verilogName = "_decStage_WIRE_3_rs1Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_3_rs1Data, %c0_i32 : i32
    %_decStage_WIRE_3_rs2Data = sv.wire sym @sym_329 {hw.verilogName = "_decStage_WIRE_3_rs2Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_3_rs2Data, %c0_i32 : i32
    %_decStage_WIRE_3_memAddr = sv.wire sym @sym_330 {hw.verilogName = "_decStage_WIRE_3_memAddr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_3_memAddr, %c0_i32 : i32
    %_decStage_WIRE_3_memWdata = sv.wire sym @sym_331 {hw.verilogName = "_decStage_WIRE_3_memWdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_3_memWdata, %c0_i32 : i32
    %_decStage_WIRE_3_memRdata = sv.wire sym @sym_332 {hw.verilogName = "_decStage_WIRE_3_memRdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_3_memRdata, %c0_i32 : i32
    %_decStage_WIRE_3_aluResult = sv.wire sym @sym_333 {hw.verilogName = "_decStage_WIRE_3_aluResult"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_3_aluResult, %c0_i32 : i32
    %_decStage_WIRE_4_0_pc = sv.wire sym @sym_336 {hw.verilogName = "_decStage_WIRE_4_0_pc"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_0_pc, %c0_i32 : i32
    %_decStage_WIRE_4_0_instr = sv.wire sym @sym_337 {hw.verilogName = "_decStage_WIRE_4_0_instr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_0_instr, %c0_i32 : i32
    %_decStage_WIRE_4_0_imm = sv.wire sym @sym_349 {hw.verilogName = "_decStage_WIRE_4_0_imm"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_0_imm, %c0_i32 : i32
    %_decStage_WIRE_4_0_rs1Data = sv.wire sym @sym_353 {hw.verilogName = "_decStage_WIRE_4_0_rs1Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_0_rs1Data, %c0_i32 : i32
    %_decStage_WIRE_4_0_rs2Data = sv.wire sym @sym_354 {hw.verilogName = "_decStage_WIRE_4_0_rs2Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_0_rs2Data, %c0_i32 : i32
    %_decStage_WIRE_4_0_memAddr = sv.wire sym @sym_355 {hw.verilogName = "_decStage_WIRE_4_0_memAddr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_0_memAddr, %c0_i32 : i32
    %_decStage_WIRE_4_0_memWdata = sv.wire sym @sym_356 {hw.verilogName = "_decStage_WIRE_4_0_memWdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_0_memWdata, %c0_i32 : i32
    %_decStage_WIRE_4_0_memRdata = sv.wire sym @sym_357 {hw.verilogName = "_decStage_WIRE_4_0_memRdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_0_memRdata, %c0_i32 : i32
    %_decStage_WIRE_4_0_aluResult = sv.wire sym @sym_358 {hw.verilogName = "_decStage_WIRE_4_0_aluResult"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_0_aluResult, %c0_i32 : i32
    %_decStage_WIRE_4_1_pc = sv.wire sym @sym_361 {hw.verilogName = "_decStage_WIRE_4_1_pc"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_1_pc, %c0_i32 : i32
    %_decStage_WIRE_4_1_instr = sv.wire sym @sym_362 {hw.verilogName = "_decStage_WIRE_4_1_instr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_1_instr, %c0_i32 : i32
    %_decStage_WIRE_4_1_imm = sv.wire sym @sym_374 {hw.verilogName = "_decStage_WIRE_4_1_imm"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_1_imm, %c0_i32 : i32
    %_decStage_WIRE_4_1_rs1Data = sv.wire sym @sym_378 {hw.verilogName = "_decStage_WIRE_4_1_rs1Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_1_rs1Data, %c0_i32 : i32
    %_decStage_WIRE_4_1_rs2Data = sv.wire sym @sym_379 {hw.verilogName = "_decStage_WIRE_4_1_rs2Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_1_rs2Data, %c0_i32 : i32
    %_decStage_WIRE_4_1_memAddr = sv.wire sym @sym_380 {hw.verilogName = "_decStage_WIRE_4_1_memAddr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_1_memAddr, %c0_i32 : i32
    %_decStage_WIRE_4_1_memWdata = sv.wire sym @sym_381 {hw.verilogName = "_decStage_WIRE_4_1_memWdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_1_memWdata, %c0_i32 : i32
    %_decStage_WIRE_4_1_memRdata = sv.wire sym @sym_382 {hw.verilogName = "_decStage_WIRE_4_1_memRdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_1_memRdata, %c0_i32 : i32
    %_decStage_WIRE_4_1_aluResult = sv.wire sym @sym_383 {hw.verilogName = "_decStage_WIRE_4_1_aluResult"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_1_aluResult, %c0_i32 : i32
    %_decStage_WIRE_4_2_pc = sv.wire sym @sym_386 {hw.verilogName = "_decStage_WIRE_4_2_pc"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_2_pc, %c0_i32 : i32
    %_decStage_WIRE_4_2_instr = sv.wire sym @sym_387 {hw.verilogName = "_decStage_WIRE_4_2_instr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_2_instr, %c0_i32 : i32
    %_decStage_WIRE_4_2_imm = sv.wire sym @sym_399 {hw.verilogName = "_decStage_WIRE_4_2_imm"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_2_imm, %c0_i32 : i32
    %_decStage_WIRE_4_2_rs1Data = sv.wire sym @sym_403 {hw.verilogName = "_decStage_WIRE_4_2_rs1Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_2_rs1Data, %c0_i32 : i32
    %_decStage_WIRE_4_2_rs2Data = sv.wire sym @sym_404 {hw.verilogName = "_decStage_WIRE_4_2_rs2Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_2_rs2Data, %c0_i32 : i32
    %_decStage_WIRE_4_2_memAddr = sv.wire sym @sym_405 {hw.verilogName = "_decStage_WIRE_4_2_memAddr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_2_memAddr, %c0_i32 : i32
    %_decStage_WIRE_4_2_memWdata = sv.wire sym @sym_406 {hw.verilogName = "_decStage_WIRE_4_2_memWdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_2_memWdata, %c0_i32 : i32
    %_decStage_WIRE_4_2_memRdata = sv.wire sym @sym_407 {hw.verilogName = "_decStage_WIRE_4_2_memRdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_2_memRdata, %c0_i32 : i32
    %_decStage_WIRE_4_2_aluResult = sv.wire sym @sym_408 {hw.verilogName = "_decStage_WIRE_4_2_aluResult"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_2_aluResult, %c0_i32 : i32
    %_decStage_WIRE_4_3_pc = sv.wire sym @sym_411 {hw.verilogName = "_decStage_WIRE_4_3_pc"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_3_pc, %c0_i32 : i32
    %_decStage_WIRE_4_3_instr = sv.wire sym @sym_412 {hw.verilogName = "_decStage_WIRE_4_3_instr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_3_instr, %c0_i32 : i32
    %_decStage_WIRE_4_3_imm = sv.wire sym @sym_424 {hw.verilogName = "_decStage_WIRE_4_3_imm"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_3_imm, %c0_i32 : i32
    %_decStage_WIRE_4_3_rs1Data = sv.wire sym @sym_428 {hw.verilogName = "_decStage_WIRE_4_3_rs1Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_3_rs1Data, %c0_i32 : i32
    %_decStage_WIRE_4_3_rs2Data = sv.wire sym @sym_429 {hw.verilogName = "_decStage_WIRE_4_3_rs2Data"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_3_rs2Data, %c0_i32 : i32
    %_decStage_WIRE_4_3_memAddr = sv.wire sym @sym_430 {hw.verilogName = "_decStage_WIRE_4_3_memAddr"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_3_memAddr, %c0_i32 : i32
    %_decStage_WIRE_4_3_memWdata = sv.wire sym @sym_431 {hw.verilogName = "_decStage_WIRE_4_3_memWdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_3_memWdata, %c0_i32 : i32
    %_decStage_WIRE_4_3_memRdata = sv.wire sym @sym_432 {hw.verilogName = "_decStage_WIRE_4_3_memRdata"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_3_memRdata, %c0_i32 : i32
    %_decStage_WIRE_4_3_aluResult = sv.wire sym @sym_433 {hw.verilogName = "_decStage_WIRE_4_3_aluResult"} : !hw.inout<i32>
    sv.assign %_decStage_WIRE_4_3_aluResult, %c0_i32 : i32
    %_exStage_WIRE_pc = sv.wire sym @sym_536 {hw.verilogName = "_exStage_WIRE_pc"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_pc, %c0_i32 : i32
    %_exStage_WIRE_instr = sv.wire sym @sym_537 {hw.verilogName = "_exStage_WIRE_instr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_instr, %c0_i32 : i32
    %_exStage_WIRE_imm = sv.wire sym @sym_549 {hw.verilogName = "_exStage_WIRE_imm"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_imm, %c0_i32 : i32
    %_exStage_WIRE_rs1Data = sv.wire sym @sym_553 {hw.verilogName = "_exStage_WIRE_rs1Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_rs1Data, %c0_i32 : i32
    %_exStage_WIRE_rs2Data = sv.wire sym @sym_554 {hw.verilogName = "_exStage_WIRE_rs2Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_rs2Data, %c0_i32 : i32
    %_exStage_WIRE_memAddr = sv.wire sym @sym_555 {hw.verilogName = "_exStage_WIRE_memAddr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_memAddr, %c0_i32 : i32
    %_exStage_WIRE_memWdata = sv.wire sym @sym_556 {hw.verilogName = "_exStage_WIRE_memWdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_memWdata, %c0_i32 : i32
    %_exStage_WIRE_memRdata = sv.wire sym @sym_557 {hw.verilogName = "_exStage_WIRE_memRdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_memRdata, %c0_i32 : i32
    %_exStage_WIRE_aluResult = sv.wire sym @sym_558 {hw.verilogName = "_exStage_WIRE_aluResult"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_aluResult, %c0_i32 : i32
    %_exStage_WIRE_1_pc = sv.wire sym @sym_561 {hw.verilogName = "_exStage_WIRE_1_pc"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_1_pc, %c0_i32 : i32
    %_exStage_WIRE_1_instr = sv.wire sym @sym_562 {hw.verilogName = "_exStage_WIRE_1_instr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_1_instr, %c0_i32 : i32
    %_exStage_WIRE_1_imm = sv.wire sym @sym_574 {hw.verilogName = "_exStage_WIRE_1_imm"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_1_imm, %c0_i32 : i32
    %_exStage_WIRE_1_rs1Data = sv.wire sym @sym_578 {hw.verilogName = "_exStage_WIRE_1_rs1Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_1_rs1Data, %c0_i32 : i32
    %_exStage_WIRE_1_rs2Data = sv.wire sym @sym_579 {hw.verilogName = "_exStage_WIRE_1_rs2Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_1_rs2Data, %c0_i32 : i32
    %_exStage_WIRE_1_memAddr = sv.wire sym @sym_580 {hw.verilogName = "_exStage_WIRE_1_memAddr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_1_memAddr, %c0_i32 : i32
    %_exStage_WIRE_1_memWdata = sv.wire sym @sym_581 {hw.verilogName = "_exStage_WIRE_1_memWdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_1_memWdata, %c0_i32 : i32
    %_exStage_WIRE_1_memRdata = sv.wire sym @sym_582 {hw.verilogName = "_exStage_WIRE_1_memRdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_1_memRdata, %c0_i32 : i32
    %_exStage_WIRE_1_aluResult = sv.wire sym @sym_583 {hw.verilogName = "_exStage_WIRE_1_aluResult"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_1_aluResult, %c0_i32 : i32
    %_exStage_WIRE_2_pc = sv.wire sym @sym_586 {hw.verilogName = "_exStage_WIRE_2_pc"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_2_pc, %c0_i32 : i32
    %_exStage_WIRE_2_instr = sv.wire sym @sym_587 {hw.verilogName = "_exStage_WIRE_2_instr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_2_instr, %c0_i32 : i32
    %_exStage_WIRE_2_imm = sv.wire sym @sym_599 {hw.verilogName = "_exStage_WIRE_2_imm"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_2_imm, %c0_i32 : i32
    %_exStage_WIRE_2_rs1Data = sv.wire sym @sym_603 {hw.verilogName = "_exStage_WIRE_2_rs1Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_2_rs1Data, %c0_i32 : i32
    %_exStage_WIRE_2_rs2Data = sv.wire sym @sym_604 {hw.verilogName = "_exStage_WIRE_2_rs2Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_2_rs2Data, %c0_i32 : i32
    %_exStage_WIRE_2_memAddr = sv.wire sym @sym_605 {hw.verilogName = "_exStage_WIRE_2_memAddr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_2_memAddr, %c0_i32 : i32
    %_exStage_WIRE_2_memWdata = sv.wire sym @sym_606 {hw.verilogName = "_exStage_WIRE_2_memWdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_2_memWdata, %c0_i32 : i32
    %_exStage_WIRE_2_memRdata = sv.wire sym @sym_607 {hw.verilogName = "_exStage_WIRE_2_memRdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_2_memRdata, %c0_i32 : i32
    %_exStage_WIRE_2_aluResult = sv.wire sym @sym_608 {hw.verilogName = "_exStage_WIRE_2_aluResult"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_2_aluResult, %c0_i32 : i32
    %_exStage_WIRE_3_pc = sv.wire sym @sym_611 {hw.verilogName = "_exStage_WIRE_3_pc"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_3_pc, %c0_i32 : i32
    %_exStage_WIRE_3_instr = sv.wire sym @sym_612 {hw.verilogName = "_exStage_WIRE_3_instr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_3_instr, %c0_i32 : i32
    %_exStage_WIRE_3_imm = sv.wire sym @sym_624 {hw.verilogName = "_exStage_WIRE_3_imm"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_3_imm, %c0_i32 : i32
    %_exStage_WIRE_3_rs1Data = sv.wire sym @sym_628 {hw.verilogName = "_exStage_WIRE_3_rs1Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_3_rs1Data, %c0_i32 : i32
    %_exStage_WIRE_3_rs2Data = sv.wire sym @sym_629 {hw.verilogName = "_exStage_WIRE_3_rs2Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_3_rs2Data, %c0_i32 : i32
    %_exStage_WIRE_3_memAddr = sv.wire sym @sym_630 {hw.verilogName = "_exStage_WIRE_3_memAddr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_3_memAddr, %c0_i32 : i32
    %_exStage_WIRE_3_memWdata = sv.wire sym @sym_631 {hw.verilogName = "_exStage_WIRE_3_memWdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_3_memWdata, %c0_i32 : i32
    %_exStage_WIRE_3_memRdata = sv.wire sym @sym_632 {hw.verilogName = "_exStage_WIRE_3_memRdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_3_memRdata, %c0_i32 : i32
    %_exStage_WIRE_3_aluResult = sv.wire sym @sym_633 {hw.verilogName = "_exStage_WIRE_3_aluResult"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_3_aluResult, %c0_i32 : i32
    %_exStage_WIRE_4_0_pc = sv.wire sym @sym_636 {hw.verilogName = "_exStage_WIRE_4_0_pc"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_0_pc, %c0_i32 : i32
    %_exStage_WIRE_4_0_instr = sv.wire sym @sym_637 {hw.verilogName = "_exStage_WIRE_4_0_instr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_0_instr, %c0_i32 : i32
    %_exStage_WIRE_4_0_imm = sv.wire sym @sym_649 {hw.verilogName = "_exStage_WIRE_4_0_imm"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_0_imm, %c0_i32 : i32
    %_exStage_WIRE_4_0_rs1Data = sv.wire sym @sym_653 {hw.verilogName = "_exStage_WIRE_4_0_rs1Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_0_rs1Data, %c0_i32 : i32
    %_exStage_WIRE_4_0_rs2Data = sv.wire sym @sym_654 {hw.verilogName = "_exStage_WIRE_4_0_rs2Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_0_rs2Data, %c0_i32 : i32
    %_exStage_WIRE_4_0_memAddr = sv.wire sym @sym_655 {hw.verilogName = "_exStage_WIRE_4_0_memAddr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_0_memAddr, %c0_i32 : i32
    %_exStage_WIRE_4_0_memWdata = sv.wire sym @sym_656 {hw.verilogName = "_exStage_WIRE_4_0_memWdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_0_memWdata, %c0_i32 : i32
    %_exStage_WIRE_4_0_memRdata = sv.wire sym @sym_657 {hw.verilogName = "_exStage_WIRE_4_0_memRdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_0_memRdata, %c0_i32 : i32
    %_exStage_WIRE_4_0_aluResult = sv.wire sym @sym_658 {hw.verilogName = "_exStage_WIRE_4_0_aluResult"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_0_aluResult, %c0_i32 : i32
    %_exStage_WIRE_4_1_pc = sv.wire sym @sym_661 {hw.verilogName = "_exStage_WIRE_4_1_pc"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_1_pc, %c0_i32 : i32
    %_exStage_WIRE_4_1_instr = sv.wire sym @sym_662 {hw.verilogName = "_exStage_WIRE_4_1_instr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_1_instr, %c0_i32 : i32
    %_exStage_WIRE_4_1_imm = sv.wire sym @sym_674 {hw.verilogName = "_exStage_WIRE_4_1_imm"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_1_imm, %c0_i32 : i32
    %_exStage_WIRE_4_1_rs1Data = sv.wire sym @sym_678 {hw.verilogName = "_exStage_WIRE_4_1_rs1Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_1_rs1Data, %c0_i32 : i32
    %_exStage_WIRE_4_1_rs2Data = sv.wire sym @sym_679 {hw.verilogName = "_exStage_WIRE_4_1_rs2Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_1_rs2Data, %c0_i32 : i32
    %_exStage_WIRE_4_1_memAddr = sv.wire sym @sym_680 {hw.verilogName = "_exStage_WIRE_4_1_memAddr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_1_memAddr, %c0_i32 : i32
    %_exStage_WIRE_4_1_memWdata = sv.wire sym @sym_681 {hw.verilogName = "_exStage_WIRE_4_1_memWdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_1_memWdata, %c0_i32 : i32
    %_exStage_WIRE_4_1_memRdata = sv.wire sym @sym_682 {hw.verilogName = "_exStage_WIRE_4_1_memRdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_1_memRdata, %c0_i32 : i32
    %_exStage_WIRE_4_1_aluResult = sv.wire sym @sym_683 {hw.verilogName = "_exStage_WIRE_4_1_aluResult"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_1_aluResult, %c0_i32 : i32
    %_exStage_WIRE_4_2_pc = sv.wire sym @sym_686 {hw.verilogName = "_exStage_WIRE_4_2_pc"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_2_pc, %c0_i32 : i32
    %_exStage_WIRE_4_2_instr = sv.wire sym @sym_687 {hw.verilogName = "_exStage_WIRE_4_2_instr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_2_instr, %c0_i32 : i32
    %_exStage_WIRE_4_2_imm = sv.wire sym @sym_699 {hw.verilogName = "_exStage_WIRE_4_2_imm"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_2_imm, %c0_i32 : i32
    %_exStage_WIRE_4_2_rs1Data = sv.wire sym @sym_703 {hw.verilogName = "_exStage_WIRE_4_2_rs1Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_2_rs1Data, %c0_i32 : i32
    %_exStage_WIRE_4_2_rs2Data = sv.wire sym @sym_704 {hw.verilogName = "_exStage_WIRE_4_2_rs2Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_2_rs2Data, %c0_i32 : i32
    %_exStage_WIRE_4_2_memAddr = sv.wire sym @sym_705 {hw.verilogName = "_exStage_WIRE_4_2_memAddr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_2_memAddr, %c0_i32 : i32
    %_exStage_WIRE_4_2_memWdata = sv.wire sym @sym_706 {hw.verilogName = "_exStage_WIRE_4_2_memWdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_2_memWdata, %c0_i32 : i32
    %_exStage_WIRE_4_2_memRdata = sv.wire sym @sym_707 {hw.verilogName = "_exStage_WIRE_4_2_memRdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_2_memRdata, %c0_i32 : i32
    %_exStage_WIRE_4_2_aluResult = sv.wire sym @sym_708 {hw.verilogName = "_exStage_WIRE_4_2_aluResult"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_2_aluResult, %c0_i32 : i32
    %_exStage_WIRE_4_3_pc = sv.wire sym @sym_711 {hw.verilogName = "_exStage_WIRE_4_3_pc"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_3_pc, %c0_i32 : i32
    %_exStage_WIRE_4_3_instr = sv.wire sym @sym_712 {hw.verilogName = "_exStage_WIRE_4_3_instr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_3_instr, %c0_i32 : i32
    %_exStage_WIRE_4_3_imm = sv.wire sym @sym_724 {hw.verilogName = "_exStage_WIRE_4_3_imm"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_3_imm, %c0_i32 : i32
    %_exStage_WIRE_4_3_rs1Data = sv.wire sym @sym_728 {hw.verilogName = "_exStage_WIRE_4_3_rs1Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_3_rs1Data, %c0_i32 : i32
    %_exStage_WIRE_4_3_rs2Data = sv.wire sym @sym_729 {hw.verilogName = "_exStage_WIRE_4_3_rs2Data"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_3_rs2Data, %c0_i32 : i32
    %_exStage_WIRE_4_3_memAddr = sv.wire sym @sym_730 {hw.verilogName = "_exStage_WIRE_4_3_memAddr"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_3_memAddr, %c0_i32 : i32
    %_exStage_WIRE_4_3_memWdata = sv.wire sym @sym_731 {hw.verilogName = "_exStage_WIRE_4_3_memWdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_3_memWdata, %c0_i32 : i32
    %_exStage_WIRE_4_3_memRdata = sv.wire sym @sym_732 {hw.verilogName = "_exStage_WIRE_4_3_memRdata"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_3_memRdata, %c0_i32 : i32
    %_exStage_WIRE_4_3_aluResult = sv.wire sym @sym_733 {hw.verilogName = "_exStage_WIRE_4_3_aluResult"} : !hw.inout<i32>
    sv.assign %_exStage_WIRE_4_3_aluResult, %c0_i32 : i32
    %_memStage_WIRE_pc = sv.wire sym @sym_836 {hw.verilogName = "_memStage_WIRE_pc"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_pc, %c0_i32 : i32
    %_memStage_WIRE_instr = sv.wire sym @sym_837 {hw.verilogName = "_memStage_WIRE_instr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_instr, %c0_i32 : i32
    %_memStage_WIRE_imm = sv.wire sym @sym_849 {hw.verilogName = "_memStage_WIRE_imm"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_imm, %c0_i32 : i32
    %_memStage_WIRE_rs1Data = sv.wire sym @sym_853 {hw.verilogName = "_memStage_WIRE_rs1Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_rs1Data, %c0_i32 : i32
    %_memStage_WIRE_rs2Data = sv.wire sym @sym_854 {hw.verilogName = "_memStage_WIRE_rs2Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_rs2Data, %c0_i32 : i32
    %_memStage_WIRE_memAddr = sv.wire sym @sym_855 {hw.verilogName = "_memStage_WIRE_memAddr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_memAddr, %c0_i32 : i32
    %_memStage_WIRE_memWdata = sv.wire sym @sym_856 {hw.verilogName = "_memStage_WIRE_memWdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_memWdata, %c0_i32 : i32
    %_memStage_WIRE_memRdata = sv.wire sym @sym_857 {hw.verilogName = "_memStage_WIRE_memRdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_memRdata, %c0_i32 : i32
    %_memStage_WIRE_aluResult = sv.wire sym @sym_858 {hw.verilogName = "_memStage_WIRE_aluResult"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_aluResult, %c0_i32 : i32
    %_memStage_WIRE_1_pc = sv.wire sym @sym_861 {hw.verilogName = "_memStage_WIRE_1_pc"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_1_pc, %c0_i32 : i32
    %_memStage_WIRE_1_instr = sv.wire sym @sym_862 {hw.verilogName = "_memStage_WIRE_1_instr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_1_instr, %c0_i32 : i32
    %_memStage_WIRE_1_imm = sv.wire sym @sym_874 {hw.verilogName = "_memStage_WIRE_1_imm"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_1_imm, %c0_i32 : i32
    %_memStage_WIRE_1_rs1Data = sv.wire sym @sym_878 {hw.verilogName = "_memStage_WIRE_1_rs1Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_1_rs1Data, %c0_i32 : i32
    %_memStage_WIRE_1_rs2Data = sv.wire sym @sym_879 {hw.verilogName = "_memStage_WIRE_1_rs2Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_1_rs2Data, %c0_i32 : i32
    %_memStage_WIRE_1_memAddr = sv.wire sym @sym_880 {hw.verilogName = "_memStage_WIRE_1_memAddr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_1_memAddr, %c0_i32 : i32
    %_memStage_WIRE_1_memWdata = sv.wire sym @sym_881 {hw.verilogName = "_memStage_WIRE_1_memWdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_1_memWdata, %c0_i32 : i32
    %_memStage_WIRE_1_memRdata = sv.wire sym @sym_882 {hw.verilogName = "_memStage_WIRE_1_memRdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_1_memRdata, %c0_i32 : i32
    %_memStage_WIRE_1_aluResult = sv.wire sym @sym_883 {hw.verilogName = "_memStage_WIRE_1_aluResult"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_1_aluResult, %c0_i32 : i32
    %_memStage_WIRE_2_pc = sv.wire sym @sym_886 {hw.verilogName = "_memStage_WIRE_2_pc"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_2_pc, %c0_i32 : i32
    %_memStage_WIRE_2_instr = sv.wire sym @sym_887 {hw.verilogName = "_memStage_WIRE_2_instr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_2_instr, %c0_i32 : i32
    %_memStage_WIRE_2_imm = sv.wire sym @sym_899 {hw.verilogName = "_memStage_WIRE_2_imm"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_2_imm, %c0_i32 : i32
    %_memStage_WIRE_2_rs1Data = sv.wire sym @sym_903 {hw.verilogName = "_memStage_WIRE_2_rs1Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_2_rs1Data, %c0_i32 : i32
    %_memStage_WIRE_2_rs2Data = sv.wire sym @sym_904 {hw.verilogName = "_memStage_WIRE_2_rs2Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_2_rs2Data, %c0_i32 : i32
    %_memStage_WIRE_2_memAddr = sv.wire sym @sym_905 {hw.verilogName = "_memStage_WIRE_2_memAddr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_2_memAddr, %c0_i32 : i32
    %_memStage_WIRE_2_memWdata = sv.wire sym @sym_906 {hw.verilogName = "_memStage_WIRE_2_memWdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_2_memWdata, %c0_i32 : i32
    %_memStage_WIRE_2_memRdata = sv.wire sym @sym_907 {hw.verilogName = "_memStage_WIRE_2_memRdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_2_memRdata, %c0_i32 : i32
    %_memStage_WIRE_2_aluResult = sv.wire sym @sym_908 {hw.verilogName = "_memStage_WIRE_2_aluResult"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_2_aluResult, %c0_i32 : i32
    %_memStage_WIRE_3_pc = sv.wire sym @sym_911 {hw.verilogName = "_memStage_WIRE_3_pc"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_3_pc, %c0_i32 : i32
    %_memStage_WIRE_3_instr = sv.wire sym @sym_912 {hw.verilogName = "_memStage_WIRE_3_instr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_3_instr, %c0_i32 : i32
    %_memStage_WIRE_3_imm = sv.wire sym @sym_924 {hw.verilogName = "_memStage_WIRE_3_imm"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_3_imm, %c0_i32 : i32
    %_memStage_WIRE_3_rs1Data = sv.wire sym @sym_928 {hw.verilogName = "_memStage_WIRE_3_rs1Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_3_rs1Data, %c0_i32 : i32
    %_memStage_WIRE_3_rs2Data = sv.wire sym @sym_929 {hw.verilogName = "_memStage_WIRE_3_rs2Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_3_rs2Data, %c0_i32 : i32
    %_memStage_WIRE_3_memAddr = sv.wire sym @sym_930 {hw.verilogName = "_memStage_WIRE_3_memAddr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_3_memAddr, %c0_i32 : i32
    %_memStage_WIRE_3_memWdata = sv.wire sym @sym_931 {hw.verilogName = "_memStage_WIRE_3_memWdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_3_memWdata, %c0_i32 : i32
    %_memStage_WIRE_3_memRdata = sv.wire sym @sym_932 {hw.verilogName = "_memStage_WIRE_3_memRdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_3_memRdata, %c0_i32 : i32
    %_memStage_WIRE_3_aluResult = sv.wire sym @sym_933 {hw.verilogName = "_memStage_WIRE_3_aluResult"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_3_aluResult, %c0_i32 : i32
    %_memStage_WIRE_4_0_pc = sv.wire sym @sym_936 {hw.verilogName = "_memStage_WIRE_4_0_pc"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_0_pc, %c0_i32 : i32
    %_memStage_WIRE_4_0_instr = sv.wire sym @sym_937 {hw.verilogName = "_memStage_WIRE_4_0_instr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_0_instr, %c0_i32 : i32
    %_memStage_WIRE_4_0_imm = sv.wire sym @sym_949 {hw.verilogName = "_memStage_WIRE_4_0_imm"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_0_imm, %c0_i32 : i32
    %_memStage_WIRE_4_0_rs1Data = sv.wire sym @sym_953 {hw.verilogName = "_memStage_WIRE_4_0_rs1Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_0_rs1Data, %c0_i32 : i32
    %_memStage_WIRE_4_0_rs2Data = sv.wire sym @sym_954 {hw.verilogName = "_memStage_WIRE_4_0_rs2Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_0_rs2Data, %c0_i32 : i32
    %_memStage_WIRE_4_0_memAddr = sv.wire sym @sym_955 {hw.verilogName = "_memStage_WIRE_4_0_memAddr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_0_memAddr, %c0_i32 : i32
    %_memStage_WIRE_4_0_memWdata = sv.wire sym @sym_956 {hw.verilogName = "_memStage_WIRE_4_0_memWdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_0_memWdata, %c0_i32 : i32
    %_memStage_WIRE_4_0_memRdata = sv.wire sym @sym_957 {hw.verilogName = "_memStage_WIRE_4_0_memRdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_0_memRdata, %c0_i32 : i32
    %_memStage_WIRE_4_0_aluResult = sv.wire sym @sym_958 {hw.verilogName = "_memStage_WIRE_4_0_aluResult"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_0_aluResult, %c0_i32 : i32
    %_memStage_WIRE_4_1_pc = sv.wire sym @sym_961 {hw.verilogName = "_memStage_WIRE_4_1_pc"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_1_pc, %c0_i32 : i32
    %_memStage_WIRE_4_1_instr = sv.wire sym @sym_962 {hw.verilogName = "_memStage_WIRE_4_1_instr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_1_instr, %c0_i32 : i32
    %_memStage_WIRE_4_1_imm = sv.wire sym @sym_974 {hw.verilogName = "_memStage_WIRE_4_1_imm"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_1_imm, %c0_i32 : i32
    %_memStage_WIRE_4_1_rs1Data = sv.wire sym @sym_978 {hw.verilogName = "_memStage_WIRE_4_1_rs1Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_1_rs1Data, %c0_i32 : i32
    %_memStage_WIRE_4_1_rs2Data = sv.wire sym @sym_979 {hw.verilogName = "_memStage_WIRE_4_1_rs2Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_1_rs2Data, %c0_i32 : i32
    %_memStage_WIRE_4_1_memAddr = sv.wire sym @sym_980 {hw.verilogName = "_memStage_WIRE_4_1_memAddr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_1_memAddr, %c0_i32 : i32
    %_memStage_WIRE_4_1_memWdata = sv.wire sym @sym_981 {hw.verilogName = "_memStage_WIRE_4_1_memWdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_1_memWdata, %c0_i32 : i32
    %_memStage_WIRE_4_1_memRdata = sv.wire sym @sym_982 {hw.verilogName = "_memStage_WIRE_4_1_memRdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_1_memRdata, %c0_i32 : i32
    %_memStage_WIRE_4_1_aluResult = sv.wire sym @sym_983 {hw.verilogName = "_memStage_WIRE_4_1_aluResult"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_1_aluResult, %c0_i32 : i32
    %_memStage_WIRE_4_2_pc = sv.wire sym @sym_986 {hw.verilogName = "_memStage_WIRE_4_2_pc"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_2_pc, %c0_i32 : i32
    %_memStage_WIRE_4_2_instr = sv.wire sym @sym_987 {hw.verilogName = "_memStage_WIRE_4_2_instr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_2_instr, %c0_i32 : i32
    %_memStage_WIRE_4_2_imm = sv.wire sym @sym_999 {hw.verilogName = "_memStage_WIRE_4_2_imm"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_2_imm, %c0_i32 : i32
    %_memStage_WIRE_4_2_rs1Data = sv.wire sym @sym_1003 {hw.verilogName = "_memStage_WIRE_4_2_rs1Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_2_rs1Data, %c0_i32 : i32
    %_memStage_WIRE_4_2_rs2Data = sv.wire sym @sym_1004 {hw.verilogName = "_memStage_WIRE_4_2_rs2Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_2_rs2Data, %c0_i32 : i32
    %_memStage_WIRE_4_2_memAddr = sv.wire sym @sym_1005 {hw.verilogName = "_memStage_WIRE_4_2_memAddr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_2_memAddr, %c0_i32 : i32
    %_memStage_WIRE_4_2_memWdata = sv.wire sym @sym_1006 {hw.verilogName = "_memStage_WIRE_4_2_memWdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_2_memWdata, %c0_i32 : i32
    %_memStage_WIRE_4_2_memRdata = sv.wire sym @sym_1007 {hw.verilogName = "_memStage_WIRE_4_2_memRdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_2_memRdata, %c0_i32 : i32
    %_memStage_WIRE_4_2_aluResult = sv.wire sym @sym_1008 {hw.verilogName = "_memStage_WIRE_4_2_aluResult"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_2_aluResult, %c0_i32 : i32
    %_memStage_WIRE_4_3_pc = sv.wire sym @sym_1011 {hw.verilogName = "_memStage_WIRE_4_3_pc"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_3_pc, %c0_i32 : i32
    %_memStage_WIRE_4_3_instr = sv.wire sym @sym_1012 {hw.verilogName = "_memStage_WIRE_4_3_instr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_3_instr, %c0_i32 : i32
    %_memStage_WIRE_4_3_imm = sv.wire sym @sym_1024 {hw.verilogName = "_memStage_WIRE_4_3_imm"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_3_imm, %c0_i32 : i32
    %_memStage_WIRE_4_3_rs1Data = sv.wire sym @sym_1028 {hw.verilogName = "_memStage_WIRE_4_3_rs1Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_3_rs1Data, %c0_i32 : i32
    %_memStage_WIRE_4_3_rs2Data = sv.wire sym @sym_1029 {hw.verilogName = "_memStage_WIRE_4_3_rs2Data"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_3_rs2Data, %c0_i32 : i32
    %_memStage_WIRE_4_3_memAddr = sv.wire sym @sym_1030 {hw.verilogName = "_memStage_WIRE_4_3_memAddr"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_3_memAddr, %c0_i32 : i32
    %_memStage_WIRE_4_3_memWdata = sv.wire sym @sym_1031 {hw.verilogName = "_memStage_WIRE_4_3_memWdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_3_memWdata, %c0_i32 : i32
    %_memStage_WIRE_4_3_memRdata = sv.wire sym @sym_1032 {hw.verilogName = "_memStage_WIRE_4_3_memRdata"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_3_memRdata, %c0_i32 : i32
    %_memStage_WIRE_4_3_aluResult = sv.wire sym @sym_1033 {hw.verilogName = "_memStage_WIRE_4_3_aluResult"} : !hw.inout<i32>
    sv.assign %_memStage_WIRE_4_3_aluResult, %c0_i32 : i32
    %_ifWire_WIRE_pc = sv.wire sym @sym_1136 {hw.verilogName = "_ifWire_WIRE_pc"} : !hw.inout<i32>
    sv.assign %_ifWire_WIRE_pc, %c0_i32 : i32
    %_ifWire_WIRE_instr = sv.wire sym @sym_1137 {hw.verilogName = "_ifWire_WIRE_instr"} : !hw.inout<i32>
    sv.assign %_ifWire_WIRE_instr, %c0_i32 : i32
    %_ifWire_WIRE_imm = sv.wire sym @sym_1149 {hw.verilogName = "_ifWire_WIRE_imm"} : !hw.inout<i32>
    sv.assign %_ifWire_WIRE_imm, %c0_i32 : i32
    %_ifWire_WIRE_rs1Data = sv.wire sym @sym_1153 {hw.verilogName = "_ifWire_WIRE_rs1Data"} : !hw.inout<i32>
    sv.assign %_ifWire_WIRE_rs1Data, %c0_i32 : i32
    %_ifWire_WIRE_rs2Data = sv.wire sym @sym_1154 {hw.verilogName = "_ifWire_WIRE_rs2Data"} : !hw.inout<i32>
    sv.assign %_ifWire_WIRE_rs2Data, %c0_i32 : i32
    %_ifWire_WIRE_memAddr = sv.wire sym @sym_1155 {hw.verilogName = "_ifWire_WIRE_memAddr"} : !hw.inout<i32>
    sv.assign %_ifWire_WIRE_memAddr, %c0_i32 : i32
    %_ifWire_WIRE_memWdata = sv.wire sym @sym_1156 {hw.verilogName = "_ifWire_WIRE_memWdata"} : !hw.inout<i32>
    sv.assign %_ifWire_WIRE_memWdata, %c0_i32 : i32
    %_ifWire_WIRE_memRdata = sv.wire sym @sym_1157 {hw.verilogName = "_ifWire_WIRE_memRdata"} : !hw.inout<i32>
    sv.assign %_ifWire_WIRE_memRdata, %c0_i32 : i32
    %_ifWire_WIRE_aluResult = sv.wire sym @sym_1158 {hw.verilogName = "_ifWire_WIRE_aluResult"} : !hw.inout<i32>
    sv.assign %_ifWire_WIRE_aluResult, %c0_i32 : i32
    %ifWire_imm = sv.wire sym @sym_1174 {hw.verilogName = "ifWire_imm"} : !hw.inout<i32>
    sv.assign %ifWire_imm, %c0_i32 : i32
    %ifWire_rs1Data = sv.wire sym @sym_1178 {hw.verilogName = "ifWire_rs1Data"} : !hw.inout<i32>
    sv.assign %ifWire_rs1Data, %c0_i32 : i32
    %ifWire_rs2Data = sv.wire sym @sym_1179 {hw.verilogName = "ifWire_rs2Data"} : !hw.inout<i32>
    sv.assign %ifWire_rs2Data, %c0_i32 : i32
    %ifWire_memAddr = sv.wire sym @sym_1180 {hw.verilogName = "ifWire_memAddr"} : !hw.inout<i32>
    sv.assign %ifWire_memAddr, %c0_i32 : i32
    %ifWire_memWdata = sv.wire sym @sym_1181 {hw.verilogName = "ifWire_memWdata"} : !hw.inout<i32>
    sv.assign %ifWire_memWdata, %c0_i32 : i32
    %ifWire_memRdata = sv.wire sym @sym_1182 {hw.verilogName = "ifWire_memRdata"} : !hw.inout<i32>
    sv.assign %ifWire_memRdata, %c0_i32 : i32
    %ifWire_aluResult = sv.wire sym @sym_1183 {hw.verilogName = "ifWire_aluResult"} : !hw.inout<i32>
    sv.assign %ifWire_aluResult, %c0_i32 : i32
    %_decWire_WIRE_pc = sv.wire sym @sym_1191 {hw.verilogName = "_decWire_WIRE_pc"} : !hw.inout<i32>
    sv.assign %_decWire_WIRE_pc, %c0_i32 : i32
    %_decWire_WIRE_instr = sv.wire sym @sym_1192 {hw.verilogName = "_decWire_WIRE_instr"} : !hw.inout<i32>
    sv.assign %_decWire_WIRE_instr, %c0_i32 : i32
    %_decWire_WIRE_imm = sv.wire sym @sym_1204 {hw.verilogName = "_decWire_WIRE_imm"} : !hw.inout<i32>
    sv.assign %_decWire_WIRE_imm, %c0_i32 : i32
    %_decWire_WIRE_rs1Data = sv.wire sym @sym_1208 {hw.verilogName = "_decWire_WIRE_rs1Data"} : !hw.inout<i32>
    sv.assign %_decWire_WIRE_rs1Data, %c0_i32 : i32
    %_decWire_WIRE_rs2Data = sv.wire sym @sym_1209 {hw.verilogName = "_decWire_WIRE_rs2Data"} : !hw.inout<i32>
    sv.assign %_decWire_WIRE_rs2Data, %c0_i32 : i32
    %_decWire_WIRE_memAddr = sv.wire sym @sym_1210 {hw.verilogName = "_decWire_WIRE_memAddr"} : !hw.inout<i32>
    sv.assign %_decWire_WIRE_memAddr, %c0_i32 : i32
    %_decWire_WIRE_memWdata = sv.wire sym @sym_1211 {hw.verilogName = "_decWire_WIRE_memWdata"} : !hw.inout<i32>
    sv.assign %_decWire_WIRE_memWdata, %c0_i32 : i32
    %_decWire_WIRE_memRdata = sv.wire sym @sym_1212 {hw.verilogName = "_decWire_WIRE_memRdata"} : !hw.inout<i32>
    sv.assign %_decWire_WIRE_memRdata, %c0_i32 : i32
    %_decWire_WIRE_aluResult = sv.wire sym @sym_1213 {hw.verilogName = "_decWire_WIRE_aluResult"} : !hw.inout<i32>
    sv.assign %_decWire_WIRE_aluResult, %c0_i32 : i32
    %_exWire_WIRE_pc = sv.wire sym @sym_1245 {hw.verilogName = "_exWire_WIRE_pc"} : !hw.inout<i32>
    sv.assign %_exWire_WIRE_pc, %c0_i32 : i32
    %_exWire_WIRE_instr = sv.wire sym @sym_1246 {hw.verilogName = "_exWire_WIRE_instr"} : !hw.inout<i32>
    sv.assign %_exWire_WIRE_instr, %c0_i32 : i32
    %_exWire_WIRE_imm = sv.wire sym @sym_1258 {hw.verilogName = "_exWire_WIRE_imm"} : !hw.inout<i32>
    sv.assign %_exWire_WIRE_imm, %c0_i32 : i32
    %_exWire_WIRE_rs1Data = sv.wire sym @sym_1262 {hw.verilogName = "_exWire_WIRE_rs1Data"} : !hw.inout<i32>
    sv.assign %_exWire_WIRE_rs1Data, %c0_i32 : i32
    %_exWire_WIRE_rs2Data = sv.wire sym @sym_1263 {hw.verilogName = "_exWire_WIRE_rs2Data"} : !hw.inout<i32>
    sv.assign %_exWire_WIRE_rs2Data, %c0_i32 : i32
    %_exWire_WIRE_memAddr = sv.wire sym @sym_1264 {hw.verilogName = "_exWire_WIRE_memAddr"} : !hw.inout<i32>
    sv.assign %_exWire_WIRE_memAddr, %c0_i32 : i32
    %_exWire_WIRE_memWdata = sv.wire sym @sym_1265 {hw.verilogName = "_exWire_WIRE_memWdata"} : !hw.inout<i32>
    sv.assign %_exWire_WIRE_memWdata, %c0_i32 : i32
    %_exWire_WIRE_memRdata = sv.wire sym @sym_1266 {hw.verilogName = "_exWire_WIRE_memRdata"} : !hw.inout<i32>
    sv.assign %_exWire_WIRE_memRdata, %c0_i32 : i32
    %_exWire_WIRE_aluResult = sv.wire sym @sym_1267 {hw.verilogName = "_exWire_WIRE_aluResult"} : !hw.inout<i32>
    sv.assign %_exWire_WIRE_aluResult, %c0_i32 : i32
    %_memWire_WIRE_pc = sv.wire sym @sym_1297 {hw.verilogName = "_memWire_WIRE_pc"} : !hw.inout<i32>
    sv.assign %_memWire_WIRE_pc, %c0_i32 : i32
    %_memWire_WIRE_instr = sv.wire sym @sym_1298 {hw.verilogName = "_memWire_WIRE_instr"} : !hw.inout<i32>
    sv.assign %_memWire_WIRE_instr, %c0_i32 : i32
    %_memWire_WIRE_imm = sv.wire sym @sym_1310 {hw.verilogName = "_memWire_WIRE_imm"} : !hw.inout<i32>
    sv.assign %_memWire_WIRE_imm, %c0_i32 : i32
    %_memWire_WIRE_rs1Data = sv.wire sym @sym_1314 {hw.verilogName = "_memWire_WIRE_rs1Data"} : !hw.inout<i32>
    sv.assign %_memWire_WIRE_rs1Data, %c0_i32 : i32
    %_memWire_WIRE_rs2Data = sv.wire sym @sym_1315 {hw.verilogName = "_memWire_WIRE_rs2Data"} : !hw.inout<i32>
    sv.assign %_memWire_WIRE_rs2Data, %c0_i32 : i32
    %_memWire_WIRE_memAddr = sv.wire sym @sym_1316 {hw.verilogName = "_memWire_WIRE_memAddr"} : !hw.inout<i32>
    sv.assign %_memWire_WIRE_memAddr, %c0_i32 : i32
    %_memWire_WIRE_memWdata = sv.wire sym @sym_1317 {hw.verilogName = "_memWire_WIRE_memWdata"} : !hw.inout<i32>
    sv.assign %_memWire_WIRE_memWdata, %c0_i32 : i32
    %_memWire_WIRE_memRdata = sv.wire sym @sym_1318 {hw.verilogName = "_memWire_WIRE_memRdata"} : !hw.inout<i32>
    sv.assign %_memWire_WIRE_memRdata, %c0_i32 : i32
    %_memWire_WIRE_aluResult = sv.wire sym @sym_1319 {hw.verilogName = "_memWire_WIRE_aluResult"} : !hw.inout<i32>
    sv.assign %_memWire_WIRE_aluResult, %c0_i32 : i32
    %memWire_memAddr = sv.wire sym @sym_1341 {hw.verilogName = "memWire_memAddr"} : !hw.inout<i32>
    %memWire_memWdata = sv.wire sym @sym_1342 {hw.verilogName = "memWire_memWdata"} : !hw.inout<i32>
    %0 = sv.read_inout %io_memRdata_0 : !hw.inout<i32>
    %memWire_memRdata = sv.wire sym @sym_1343 {hw.verilogName = "memWire_memRdata"} : !hw.inout<i32>
    sv.assign %memWire_memRdata, %0 : i32
    %_io_memWe_T = sv.wire sym @sym_1345 {hw.verilogName = "_io_memWe_T"} : !hw.inout<i1>
    %currentThread = sv.reg sym @sym_7 {hw.verilogName = "currentThread", sv.namehint = "currentThread"} : !hw.inout<i2> 
    %1 = sv.read_inout %currentThread : !hw.inout<i2>
    %ifWire_threadId = sv.wire sym @sym_1159 {hw.verilogName = "ifWire_threadId"} : !hw.inout<i2>
    sv.assign %ifWire_threadId, %1 : i2
    %2 = sv.read_inout %currentThread : !hw.inout<i2>
    %3 = comb.concat %false, %2 : i1, i2
    %4 = comb.add bin %3, %c1_i3 : i3
    %_currentThread_T = sv.wire sym @sym_8 {hw.verilogName = "_currentThread_T"} : !hw.inout<i3>
    sv.assign %_currentThread_T, %4 : i3
    %5 = sv.read_inout %_currentThread_T : !hw.inout<i3>
    %6 = comb.extract %5 from 0 : (i3) -> i2
    %_currentThread_T_1 = sv.wire sym @sym_9 {hw.verilogName = "_currentThread_T_1"} : !hw.inout<i2>
    sv.assign %_currentThread_T_1, %6 : i2
    %pcRegs_0 = sv.reg sym @sym_14 {hw.verilogName = "pcRegs_0"} : !hw.inout<i32> 
    %pcRegs_1 = sv.reg sym @sym_15 {hw.verilogName = "pcRegs_1"} : !hw.inout<i32> 
    %pcRegs_2 = sv.reg sym @sym_16 {hw.verilogName = "pcRegs_2"} : !hw.inout<i32> 
    %pcRegs_3 = sv.reg sym @sym_17 {hw.verilogName = "pcRegs_3"} : !hw.inout<i32> 
    %ifStage_0_threadId = sv.reg sym @sym_218 {hw.verilogName = "ifStage_0_threadId"} : !hw.inout<i2> 
    %ifStage_0_valid = sv.reg sym @sym_219 {hw.verilogName = "ifStage_0_valid"} : !hw.inout<i1> 
    %ifStage_0_pc = sv.reg sym @sym_220 {hw.verilogName = "ifStage_0_pc"} : !hw.inout<i32> 
    %ifStage_0_instr = sv.reg sym @sym_221 {hw.verilogName = "ifStage_0_instr"} : !hw.inout<i32> 
    %ifStage_1_threadId = sv.reg sym @sym_222 {hw.verilogName = "ifStage_1_threadId"} : !hw.inout<i2> 
    %ifStage_1_valid = sv.reg sym @sym_223 {hw.verilogName = "ifStage_1_valid"} : !hw.inout<i1> 
    %ifStage_1_pc = sv.reg sym @sym_224 {hw.verilogName = "ifStage_1_pc"} : !hw.inout<i32> 
    %ifStage_1_instr = sv.reg sym @sym_225 {hw.verilogName = "ifStage_1_instr"} : !hw.inout<i32> 
    %ifStage_2_threadId = sv.reg sym @sym_226 {hw.verilogName = "ifStage_2_threadId"} : !hw.inout<i2> 
    %ifStage_2_valid = sv.reg sym @sym_227 {hw.verilogName = "ifStage_2_valid"} : !hw.inout<i1> 
    %ifStage_2_pc = sv.reg sym @sym_228 {hw.verilogName = "ifStage_2_pc"} : !hw.inout<i32> 
    %ifStage_2_instr = sv.reg sym @sym_229 {hw.verilogName = "ifStage_2_instr"} : !hw.inout<i32> 
    %ifStage_3_threadId = sv.reg sym @sym_230 {hw.verilogName = "ifStage_3_threadId"} : !hw.inout<i2> 
    %ifStage_3_valid = sv.reg sym @sym_231 {hw.verilogName = "ifStage_3_valid"} : !hw.inout<i1> 
    %ifStage_3_pc = sv.reg sym @sym_232 {hw.verilogName = "ifStage_3_pc"} : !hw.inout<i32> 
    %ifStage_3_instr = sv.reg sym @sym_233 {hw.verilogName = "ifStage_3_instr"} : !hw.inout<i32> 
    %decStage_0_threadId = sv.reg sym @sym_434 {hw.verilogName = "decStage_0_threadId"} : !hw.inout<i2> 
    %decStage_0_valid = sv.reg sym @sym_435 {hw.verilogName = "decStage_0_valid"} : !hw.inout<i1> 
    %decStage_0_pc = sv.reg sym @sym_436 {hw.verilogName = "decStage_0_pc"} : !hw.inout<i32> 
    %decStage_0_instr = sv.reg sym @sym_437 {hw.verilogName = "decStage_0_instr"} : !hw.inout<i32> 
    %decStage_0_isALU = sv.reg sym @sym_438 {hw.verilogName = "decStage_0_isALU"} : !hw.inout<i1> 
    %decStage_0_isLoad = sv.reg sym @sym_439 {hw.verilogName = "decStage_0_isLoad"} : !hw.inout<i1> 
    %decStage_0_isStore = sv.reg sym @sym_440 {hw.verilogName = "decStage_0_isStore"} : !hw.inout<i1> 
    %decStage_0_isBranch = sv.reg sym @sym_441 {hw.verilogName = "decStage_0_isBranch"} : !hw.inout<i1> 
    %decStage_0_isJAL = sv.reg sym @sym_442 {hw.verilogName = "decStage_0_isJAL"} : !hw.inout<i1> 
    %decStage_0_isJALR = sv.reg sym @sym_443 {hw.verilogName = "decStage_0_isJALR"} : !hw.inout<i1> 
    %decStage_0_isLUI = sv.reg sym @sym_444 {hw.verilogName = "decStage_0_isLUI"} : !hw.inout<i1> 
    %decStage_0_isAUIPC = sv.reg sym @sym_445 {hw.verilogName = "decStage_0_isAUIPC"} : !hw.inout<i1> 
    %decStage_0_isFence = sv.reg sym @sym_446 {hw.verilogName = "decStage_0_isFence"} : !hw.inout<i1> 
    %decStage_0_isSystem = sv.reg sym @sym_447 {hw.verilogName = "decStage_0_isSystem"} : !hw.inout<i1> 
    %decStage_0_aluOp = sv.reg sym @sym_448 {hw.verilogName = "decStage_0_aluOp"} : !hw.inout<i5> 
    %decStage_0_imm = sv.reg sym @sym_449 {hw.verilogName = "decStage_0_imm"} : !hw.inout<i32> 
    %decStage_0_rs1 = sv.reg sym @sym_450 {hw.verilogName = "decStage_0_rs1"} : !hw.inout<i5> 
    %decStage_0_rs2 = sv.reg sym @sym_451 {hw.verilogName = "decStage_0_rs2"} : !hw.inout<i5> 
    %decStage_0_rd = sv.reg sym @sym_452 {hw.verilogName = "decStage_0_rd"} : !hw.inout<i5> 
    %decStage_0_rs1Data = sv.reg sym @sym_453 {hw.verilogName = "decStage_0_rs1Data"} : !hw.inout<i32> 
    %decStage_0_rs2Data = sv.reg sym @sym_454 {hw.verilogName = "decStage_0_rs2Data"} : !hw.inout<i32> 
    %decStage_0_memAddr = sv.reg sym @sym_455 {hw.verilogName = "decStage_0_memAddr"} : !hw.inout<i32> 
    %decStage_0_memWdata = sv.reg sym @sym_456 {hw.verilogName = "decStage_0_memWdata"} : !hw.inout<i32> 
    %decStage_0_memRdata = sv.reg sym @sym_457 {hw.verilogName = "decStage_0_memRdata"} : !hw.inout<i32> 
    %decStage_0_aluResult = sv.reg sym @sym_458 {hw.verilogName = "decStage_0_aluResult"} : !hw.inout<i32> 
    %decStage_1_threadId = sv.reg sym @sym_459 {hw.verilogName = "decStage_1_threadId"} : !hw.inout<i2> 
    %decStage_1_valid = sv.reg sym @sym_460 {hw.verilogName = "decStage_1_valid"} : !hw.inout<i1> 
    %decStage_1_pc = sv.reg sym @sym_461 {hw.verilogName = "decStage_1_pc"} : !hw.inout<i32> 
    %decStage_1_instr = sv.reg sym @sym_462 {hw.verilogName = "decStage_1_instr"} : !hw.inout<i32> 
    %decStage_1_isALU = sv.reg sym @sym_463 {hw.verilogName = "decStage_1_isALU"} : !hw.inout<i1> 
    %decStage_1_isLoad = sv.reg sym @sym_464 {hw.verilogName = "decStage_1_isLoad"} : !hw.inout<i1> 
    %decStage_1_isStore = sv.reg sym @sym_465 {hw.verilogName = "decStage_1_isStore"} : !hw.inout<i1> 
    %decStage_1_isBranch = sv.reg sym @sym_466 {hw.verilogName = "decStage_1_isBranch"} : !hw.inout<i1> 
    %decStage_1_isJAL = sv.reg sym @sym_467 {hw.verilogName = "decStage_1_isJAL"} : !hw.inout<i1> 
    %decStage_1_isJALR = sv.reg sym @sym_468 {hw.verilogName = "decStage_1_isJALR"} : !hw.inout<i1> 
    %decStage_1_isLUI = sv.reg sym @sym_469 {hw.verilogName = "decStage_1_isLUI"} : !hw.inout<i1> 
    %decStage_1_isAUIPC = sv.reg sym @sym_470 {hw.verilogName = "decStage_1_isAUIPC"} : !hw.inout<i1> 
    %decStage_1_isFence = sv.reg sym @sym_471 {hw.verilogName = "decStage_1_isFence"} : !hw.inout<i1> 
    %decStage_1_isSystem = sv.reg sym @sym_472 {hw.verilogName = "decStage_1_isSystem"} : !hw.inout<i1> 
    %decStage_1_aluOp = sv.reg sym @sym_473 {hw.verilogName = "decStage_1_aluOp"} : !hw.inout<i5> 
    %decStage_1_imm = sv.reg sym @sym_474 {hw.verilogName = "decStage_1_imm"} : !hw.inout<i32> 
    %decStage_1_rs1 = sv.reg sym @sym_475 {hw.verilogName = "decStage_1_rs1"} : !hw.inout<i5> 
    %decStage_1_rs2 = sv.reg sym @sym_476 {hw.verilogName = "decStage_1_rs2"} : !hw.inout<i5> 
    %decStage_1_rd = sv.reg sym @sym_477 {hw.verilogName = "decStage_1_rd"} : !hw.inout<i5> 
    %decStage_1_rs1Data = sv.reg sym @sym_478 {hw.verilogName = "decStage_1_rs1Data"} : !hw.inout<i32> 
    %decStage_1_rs2Data = sv.reg sym @sym_479 {hw.verilogName = "decStage_1_rs2Data"} : !hw.inout<i32> 
    %decStage_1_memAddr = sv.reg sym @sym_480 {hw.verilogName = "decStage_1_memAddr"} : !hw.inout<i32> 
    %decStage_1_memWdata = sv.reg sym @sym_481 {hw.verilogName = "decStage_1_memWdata"} : !hw.inout<i32> 
    %decStage_1_memRdata = sv.reg sym @sym_482 {hw.verilogName = "decStage_1_memRdata"} : !hw.inout<i32> 
    %decStage_1_aluResult = sv.reg sym @sym_483 {hw.verilogName = "decStage_1_aluResult"} : !hw.inout<i32> 
    %decStage_2_threadId = sv.reg sym @sym_484 {hw.verilogName = "decStage_2_threadId"} : !hw.inout<i2> 
    %decStage_2_valid = sv.reg sym @sym_485 {hw.verilogName = "decStage_2_valid"} : !hw.inout<i1> 
    %decStage_2_pc = sv.reg sym @sym_486 {hw.verilogName = "decStage_2_pc"} : !hw.inout<i32> 
    %decStage_2_instr = sv.reg sym @sym_487 {hw.verilogName = "decStage_2_instr"} : !hw.inout<i32> 
    %decStage_2_isALU = sv.reg sym @sym_488 {hw.verilogName = "decStage_2_isALU"} : !hw.inout<i1> 
    %decStage_2_isLoad = sv.reg sym @sym_489 {hw.verilogName = "decStage_2_isLoad"} : !hw.inout<i1> 
    %decStage_2_isStore = sv.reg sym @sym_490 {hw.verilogName = "decStage_2_isStore"} : !hw.inout<i1> 
    %decStage_2_isBranch = sv.reg sym @sym_491 {hw.verilogName = "decStage_2_isBranch"} : !hw.inout<i1> 
    %decStage_2_isJAL = sv.reg sym @sym_492 {hw.verilogName = "decStage_2_isJAL"} : !hw.inout<i1> 
    %decStage_2_isJALR = sv.reg sym @sym_493 {hw.verilogName = "decStage_2_isJALR"} : !hw.inout<i1> 
    %decStage_2_isLUI = sv.reg sym @sym_494 {hw.verilogName = "decStage_2_isLUI"} : !hw.inout<i1> 
    %decStage_2_isAUIPC = sv.reg sym @sym_495 {hw.verilogName = "decStage_2_isAUIPC"} : !hw.inout<i1> 
    %decStage_2_isFence = sv.reg sym @sym_496 {hw.verilogName = "decStage_2_isFence"} : !hw.inout<i1> 
    %decStage_2_isSystem = sv.reg sym @sym_497 {hw.verilogName = "decStage_2_isSystem"} : !hw.inout<i1> 
    %decStage_2_aluOp = sv.reg sym @sym_498 {hw.verilogName = "decStage_2_aluOp"} : !hw.inout<i5> 
    %decStage_2_imm = sv.reg sym @sym_499 {hw.verilogName = "decStage_2_imm"} : !hw.inout<i32> 
    %decStage_2_rs1 = sv.reg sym @sym_500 {hw.verilogName = "decStage_2_rs1"} : !hw.inout<i5> 
    %decStage_2_rs2 = sv.reg sym @sym_501 {hw.verilogName = "decStage_2_rs2"} : !hw.inout<i5> 
    %decStage_2_rd = sv.reg sym @sym_502 {hw.verilogName = "decStage_2_rd"} : !hw.inout<i5> 
    %decStage_2_rs1Data = sv.reg sym @sym_503 {hw.verilogName = "decStage_2_rs1Data"} : !hw.inout<i32> 
    %decStage_2_rs2Data = sv.reg sym @sym_504 {hw.verilogName = "decStage_2_rs2Data"} : !hw.inout<i32> 
    %decStage_2_memAddr = sv.reg sym @sym_505 {hw.verilogName = "decStage_2_memAddr"} : !hw.inout<i32> 
    %decStage_2_memWdata = sv.reg sym @sym_506 {hw.verilogName = "decStage_2_memWdata"} : !hw.inout<i32> 
    %decStage_2_memRdata = sv.reg sym @sym_507 {hw.verilogName = "decStage_2_memRdata"} : !hw.inout<i32> 
    %decStage_2_aluResult = sv.reg sym @sym_508 {hw.verilogName = "decStage_2_aluResult"} : !hw.inout<i32> 
    %decStage_3_threadId = sv.reg sym @sym_509 {hw.verilogName = "decStage_3_threadId"} : !hw.inout<i2> 
    %decStage_3_valid = sv.reg sym @sym_510 {hw.verilogName = "decStage_3_valid"} : !hw.inout<i1> 
    %decStage_3_pc = sv.reg sym @sym_511 {hw.verilogName = "decStage_3_pc"} : !hw.inout<i32> 
    %decStage_3_instr = sv.reg sym @sym_512 {hw.verilogName = "decStage_3_instr"} : !hw.inout<i32> 
    %decStage_3_isALU = sv.reg sym @sym_513 {hw.verilogName = "decStage_3_isALU"} : !hw.inout<i1> 
    %decStage_3_isLoad = sv.reg sym @sym_514 {hw.verilogName = "decStage_3_isLoad"} : !hw.inout<i1> 
    %decStage_3_isStore = sv.reg sym @sym_515 {hw.verilogName = "decStage_3_isStore"} : !hw.inout<i1> 
    %decStage_3_isBranch = sv.reg sym @sym_516 {hw.verilogName = "decStage_3_isBranch"} : !hw.inout<i1> 
    %decStage_3_isJAL = sv.reg sym @sym_517 {hw.verilogName = "decStage_3_isJAL"} : !hw.inout<i1> 
    %decStage_3_isJALR = sv.reg sym @sym_518 {hw.verilogName = "decStage_3_isJALR"} : !hw.inout<i1> 
    %decStage_3_isLUI = sv.reg sym @sym_519 {hw.verilogName = "decStage_3_isLUI"} : !hw.inout<i1> 
    %decStage_3_isAUIPC = sv.reg sym @sym_520 {hw.verilogName = "decStage_3_isAUIPC"} : !hw.inout<i1> 
    %decStage_3_isFence = sv.reg sym @sym_521 {hw.verilogName = "decStage_3_isFence"} : !hw.inout<i1> 
    %decStage_3_isSystem = sv.reg sym @sym_522 {hw.verilogName = "decStage_3_isSystem"} : !hw.inout<i1> 
    %decStage_3_aluOp = sv.reg sym @sym_523 {hw.verilogName = "decStage_3_aluOp"} : !hw.inout<i5> 
    %decStage_3_imm = sv.reg sym @sym_524 {hw.verilogName = "decStage_3_imm"} : !hw.inout<i32> 
    %decStage_3_rs1 = sv.reg sym @sym_525 {hw.verilogName = "decStage_3_rs1"} : !hw.inout<i5> 
    %decStage_3_rs2 = sv.reg sym @sym_526 {hw.verilogName = "decStage_3_rs2"} : !hw.inout<i5> 
    %decStage_3_rd = sv.reg sym @sym_527 {hw.verilogName = "decStage_3_rd"} : !hw.inout<i5> 
    %decStage_3_rs1Data = sv.reg sym @sym_528 {hw.verilogName = "decStage_3_rs1Data"} : !hw.inout<i32> 
    %decStage_3_rs2Data = sv.reg sym @sym_529 {hw.verilogName = "decStage_3_rs2Data"} : !hw.inout<i32> 
    %decStage_3_memAddr = sv.reg sym @sym_530 {hw.verilogName = "decStage_3_memAddr"} : !hw.inout<i32> 
    %decStage_3_memWdata = sv.reg sym @sym_531 {hw.verilogName = "decStage_3_memWdata"} : !hw.inout<i32> 
    %decStage_3_memRdata = sv.reg sym @sym_532 {hw.verilogName = "decStage_3_memRdata"} : !hw.inout<i32> 
    %decStage_3_aluResult = sv.reg sym @sym_533 {hw.verilogName = "decStage_3_aluResult"} : !hw.inout<i32> 
    %exStage_0_threadId = sv.reg sym @sym_734 {hw.verilogName = "exStage_0_threadId"} : !hw.inout<i2> 
    %exStage_0_valid = sv.reg sym @sym_735 {hw.verilogName = "exStage_0_valid"} : !hw.inout<i1> 
    %exStage_0_pc = sv.reg sym @sym_736 {hw.verilogName = "exStage_0_pc"} : !hw.inout<i32> 
    %exStage_0_instr = sv.reg sym @sym_737 {hw.verilogName = "exStage_0_instr"} : !hw.inout<i32> 
    %exStage_0_isALU = sv.reg sym @sym_738 {hw.verilogName = "exStage_0_isALU"} : !hw.inout<i1> 
    %exStage_0_isLoad = sv.reg sym @sym_739 {hw.verilogName = "exStage_0_isLoad"} : !hw.inout<i1> 
    %exStage_0_isStore = sv.reg sym @sym_740 {hw.verilogName = "exStage_0_isStore"} : !hw.inout<i1> 
    %exStage_0_isBranch = sv.reg sym @sym_741 {hw.verilogName = "exStage_0_isBranch"} : !hw.inout<i1> 
    %exStage_0_isJAL = sv.reg sym @sym_742 {hw.verilogName = "exStage_0_isJAL"} : !hw.inout<i1> 
    %exStage_0_isJALR = sv.reg sym @sym_743 {hw.verilogName = "exStage_0_isJALR"} : !hw.inout<i1> 
    %exStage_0_isLUI = sv.reg sym @sym_744 {hw.verilogName = "exStage_0_isLUI"} : !hw.inout<i1> 
    %exStage_0_isAUIPC = sv.reg sym @sym_745 {hw.verilogName = "exStage_0_isAUIPC"} : !hw.inout<i1> 
    %exStage_0_isFence = sv.reg sym @sym_746 {hw.verilogName = "exStage_0_isFence"} : !hw.inout<i1> 
    %exStage_0_isSystem = sv.reg sym @sym_747 {hw.verilogName = "exStage_0_isSystem"} : !hw.inout<i1> 
    %exStage_0_aluOp = sv.reg sym @sym_748 {hw.verilogName = "exStage_0_aluOp"} : !hw.inout<i5> 
    %exStage_0_imm = sv.reg sym @sym_749 {hw.verilogName = "exStage_0_imm"} : !hw.inout<i32> 
    %exStage_0_rs1 = sv.reg sym @sym_750 {hw.verilogName = "exStage_0_rs1"} : !hw.inout<i5> 
    %exStage_0_rs2 = sv.reg sym @sym_751 {hw.verilogName = "exStage_0_rs2"} : !hw.inout<i5> 
    %exStage_0_rd = sv.reg sym @sym_752 {hw.verilogName = "exStage_0_rd"} : !hw.inout<i5> 
    %exStage_0_rs1Data = sv.reg sym @sym_753 {hw.verilogName = "exStage_0_rs1Data"} : !hw.inout<i32> 
    %exStage_0_rs2Data = sv.reg sym @sym_754 {hw.verilogName = "exStage_0_rs2Data"} : !hw.inout<i32> 
    %exStage_0_memAddr = sv.reg sym @sym_755 {hw.verilogName = "exStage_0_memAddr"} : !hw.inout<i32> 
    %exStage_0_memWdata = sv.reg sym @sym_756 {hw.verilogName = "exStage_0_memWdata"} : !hw.inout<i32> 
    %exStage_0_memRdata = sv.reg sym @sym_757 {hw.verilogName = "exStage_0_memRdata"} : !hw.inout<i32> 
    %exStage_0_aluResult = sv.reg sym @sym_758 {hw.verilogName = "exStage_0_aluResult"} : !hw.inout<i32> 
    %exStage_1_threadId = sv.reg sym @sym_759 {hw.verilogName = "exStage_1_threadId"} : !hw.inout<i2> 
    %exStage_1_valid = sv.reg sym @sym_760 {hw.verilogName = "exStage_1_valid"} : !hw.inout<i1> 
    %exStage_1_pc = sv.reg sym @sym_761 {hw.verilogName = "exStage_1_pc"} : !hw.inout<i32> 
    %exStage_1_instr = sv.reg sym @sym_762 {hw.verilogName = "exStage_1_instr"} : !hw.inout<i32> 
    %exStage_1_isALU = sv.reg sym @sym_763 {hw.verilogName = "exStage_1_isALU"} : !hw.inout<i1> 
    %exStage_1_isLoad = sv.reg sym @sym_764 {hw.verilogName = "exStage_1_isLoad"} : !hw.inout<i1> 
    %exStage_1_isStore = sv.reg sym @sym_765 {hw.verilogName = "exStage_1_isStore"} : !hw.inout<i1> 
    %exStage_1_isBranch = sv.reg sym @sym_766 {hw.verilogName = "exStage_1_isBranch"} : !hw.inout<i1> 
    %exStage_1_isJAL = sv.reg sym @sym_767 {hw.verilogName = "exStage_1_isJAL"} : !hw.inout<i1> 
    %exStage_1_isJALR = sv.reg sym @sym_768 {hw.verilogName = "exStage_1_isJALR"} : !hw.inout<i1> 
    %exStage_1_isLUI = sv.reg sym @sym_769 {hw.verilogName = "exStage_1_isLUI"} : !hw.inout<i1> 
    %exStage_1_isAUIPC = sv.reg sym @sym_770 {hw.verilogName = "exStage_1_isAUIPC"} : !hw.inout<i1> 
    %exStage_1_isFence = sv.reg sym @sym_771 {hw.verilogName = "exStage_1_isFence"} : !hw.inout<i1> 
    %exStage_1_isSystem = sv.reg sym @sym_772 {hw.verilogName = "exStage_1_isSystem"} : !hw.inout<i1> 
    %exStage_1_aluOp = sv.reg sym @sym_773 {hw.verilogName = "exStage_1_aluOp"} : !hw.inout<i5> 
    %exStage_1_imm = sv.reg sym @sym_774 {hw.verilogName = "exStage_1_imm"} : !hw.inout<i32> 
    %exStage_1_rs1 = sv.reg sym @sym_775 {hw.verilogName = "exStage_1_rs1"} : !hw.inout<i5> 
    %exStage_1_rs2 = sv.reg sym @sym_776 {hw.verilogName = "exStage_1_rs2"} : !hw.inout<i5> 
    %exStage_1_rd = sv.reg sym @sym_777 {hw.verilogName = "exStage_1_rd"} : !hw.inout<i5> 
    %exStage_1_rs1Data = sv.reg sym @sym_778 {hw.verilogName = "exStage_1_rs1Data"} : !hw.inout<i32> 
    %exStage_1_rs2Data = sv.reg sym @sym_779 {hw.verilogName = "exStage_1_rs2Data"} : !hw.inout<i32> 
    %exStage_1_memAddr = sv.reg sym @sym_780 {hw.verilogName = "exStage_1_memAddr"} : !hw.inout<i32> 
    %exStage_1_memWdata = sv.reg sym @sym_781 {hw.verilogName = "exStage_1_memWdata"} : !hw.inout<i32> 
    %exStage_1_memRdata = sv.reg sym @sym_782 {hw.verilogName = "exStage_1_memRdata"} : !hw.inout<i32> 
    %exStage_1_aluResult = sv.reg sym @sym_783 {hw.verilogName = "exStage_1_aluResult"} : !hw.inout<i32> 
    %exStage_2_threadId = sv.reg sym @sym_784 {hw.verilogName = "exStage_2_threadId"} : !hw.inout<i2> 
    %exStage_2_valid = sv.reg sym @sym_785 {hw.verilogName = "exStage_2_valid"} : !hw.inout<i1> 
    %exStage_2_pc = sv.reg sym @sym_786 {hw.verilogName = "exStage_2_pc"} : !hw.inout<i32> 
    %exStage_2_instr = sv.reg sym @sym_787 {hw.verilogName = "exStage_2_instr"} : !hw.inout<i32> 
    %exStage_2_isALU = sv.reg sym @sym_788 {hw.verilogName = "exStage_2_isALU"} : !hw.inout<i1> 
    %exStage_2_isLoad = sv.reg sym @sym_789 {hw.verilogName = "exStage_2_isLoad"} : !hw.inout<i1> 
    %exStage_2_isStore = sv.reg sym @sym_790 {hw.verilogName = "exStage_2_isStore"} : !hw.inout<i1> 
    %exStage_2_isBranch = sv.reg sym @sym_791 {hw.verilogName = "exStage_2_isBranch"} : !hw.inout<i1> 
    %exStage_2_isJAL = sv.reg sym @sym_792 {hw.verilogName = "exStage_2_isJAL"} : !hw.inout<i1> 
    %exStage_2_isJALR = sv.reg sym @sym_793 {hw.verilogName = "exStage_2_isJALR"} : !hw.inout<i1> 
    %exStage_2_isLUI = sv.reg sym @sym_794 {hw.verilogName = "exStage_2_isLUI"} : !hw.inout<i1> 
    %exStage_2_isAUIPC = sv.reg sym @sym_795 {hw.verilogName = "exStage_2_isAUIPC"} : !hw.inout<i1> 
    %exStage_2_isFence = sv.reg sym @sym_796 {hw.verilogName = "exStage_2_isFence"} : !hw.inout<i1> 
    %exStage_2_isSystem = sv.reg sym @sym_797 {hw.verilogName = "exStage_2_isSystem"} : !hw.inout<i1> 
    %exStage_2_aluOp = sv.reg sym @sym_798 {hw.verilogName = "exStage_2_aluOp"} : !hw.inout<i5> 
    %exStage_2_imm = sv.reg sym @sym_799 {hw.verilogName = "exStage_2_imm"} : !hw.inout<i32> 
    %exStage_2_rs1 = sv.reg sym @sym_800 {hw.verilogName = "exStage_2_rs1"} : !hw.inout<i5> 
    %exStage_2_rs2 = sv.reg sym @sym_801 {hw.verilogName = "exStage_2_rs2"} : !hw.inout<i5> 
    %exStage_2_rd = sv.reg sym @sym_802 {hw.verilogName = "exStage_2_rd"} : !hw.inout<i5> 
    %exStage_2_rs1Data = sv.reg sym @sym_803 {hw.verilogName = "exStage_2_rs1Data"} : !hw.inout<i32> 
    %exStage_2_rs2Data = sv.reg sym @sym_804 {hw.verilogName = "exStage_2_rs2Data"} : !hw.inout<i32> 
    %exStage_2_memAddr = sv.reg sym @sym_805 {hw.verilogName = "exStage_2_memAddr"} : !hw.inout<i32> 
    %exStage_2_memWdata = sv.reg sym @sym_806 {hw.verilogName = "exStage_2_memWdata"} : !hw.inout<i32> 
    %exStage_2_memRdata = sv.reg sym @sym_807 {hw.verilogName = "exStage_2_memRdata"} : !hw.inout<i32> 
    %exStage_2_aluResult = sv.reg sym @sym_808 {hw.verilogName = "exStage_2_aluResult"} : !hw.inout<i32> 
    %exStage_3_threadId = sv.reg sym @sym_809 {hw.verilogName = "exStage_3_threadId"} : !hw.inout<i2> 
    %exStage_3_valid = sv.reg sym @sym_810 {hw.verilogName = "exStage_3_valid"} : !hw.inout<i1> 
    %exStage_3_pc = sv.reg sym @sym_811 {hw.verilogName = "exStage_3_pc"} : !hw.inout<i32> 
    %exStage_3_instr = sv.reg sym @sym_812 {hw.verilogName = "exStage_3_instr"} : !hw.inout<i32> 
    %exStage_3_isALU = sv.reg sym @sym_813 {hw.verilogName = "exStage_3_isALU"} : !hw.inout<i1> 
    %exStage_3_isLoad = sv.reg sym @sym_814 {hw.verilogName = "exStage_3_isLoad"} : !hw.inout<i1> 
    %exStage_3_isStore = sv.reg sym @sym_815 {hw.verilogName = "exStage_3_isStore"} : !hw.inout<i1> 
    %exStage_3_isBranch = sv.reg sym @sym_816 {hw.verilogName = "exStage_3_isBranch"} : !hw.inout<i1> 
    %exStage_3_isJAL = sv.reg sym @sym_817 {hw.verilogName = "exStage_3_isJAL"} : !hw.inout<i1> 
    %exStage_3_isJALR = sv.reg sym @sym_818 {hw.verilogName = "exStage_3_isJALR"} : !hw.inout<i1> 
    %exStage_3_isLUI = sv.reg sym @sym_819 {hw.verilogName = "exStage_3_isLUI"} : !hw.inout<i1> 
    %exStage_3_isAUIPC = sv.reg sym @sym_820 {hw.verilogName = "exStage_3_isAUIPC"} : !hw.inout<i1> 
    %exStage_3_isFence = sv.reg sym @sym_821 {hw.verilogName = "exStage_3_isFence"} : !hw.inout<i1> 
    %exStage_3_isSystem = sv.reg sym @sym_822 {hw.verilogName = "exStage_3_isSystem"} : !hw.inout<i1> 
    %exStage_3_aluOp = sv.reg sym @sym_823 {hw.verilogName = "exStage_3_aluOp"} : !hw.inout<i5> 
    %exStage_3_imm = sv.reg sym @sym_824 {hw.verilogName = "exStage_3_imm"} : !hw.inout<i32> 
    %exStage_3_rs1 = sv.reg sym @sym_825 {hw.verilogName = "exStage_3_rs1"} : !hw.inout<i5> 
    %exStage_3_rs2 = sv.reg sym @sym_826 {hw.verilogName = "exStage_3_rs2"} : !hw.inout<i5> 
    %exStage_3_rd = sv.reg sym @sym_827 {hw.verilogName = "exStage_3_rd"} : !hw.inout<i5> 
    %exStage_3_rs1Data = sv.reg sym @sym_828 {hw.verilogName = "exStage_3_rs1Data"} : !hw.inout<i32> 
    %exStage_3_rs2Data = sv.reg sym @sym_829 {hw.verilogName = "exStage_3_rs2Data"} : !hw.inout<i32> 
    %exStage_3_memAddr = sv.reg sym @sym_830 {hw.verilogName = "exStage_3_memAddr"} : !hw.inout<i32> 
    %exStage_3_memWdata = sv.reg sym @sym_831 {hw.verilogName = "exStage_3_memWdata"} : !hw.inout<i32> 
    %exStage_3_memRdata = sv.reg sym @sym_832 {hw.verilogName = "exStage_3_memRdata"} : !hw.inout<i32> 
    %exStage_3_aluResult = sv.reg sym @sym_833 {hw.verilogName = "exStage_3_aluResult"} : !hw.inout<i32> 
    %memStage_0_threadId = sv.reg sym @sym_1034 {hw.verilogName = "memStage_0_threadId"} : !hw.inout<i2> 
    %memStage_0_valid = sv.reg sym @sym_1035 {hw.verilogName = "memStage_0_valid"} : !hw.inout<i1> 
    %memStage_0_pc = sv.reg sym @sym_1036 {hw.verilogName = "memStage_0_pc"} : !hw.inout<i32> 
    %memStage_0_instr = sv.reg sym @sym_1037 {hw.verilogName = "memStage_0_instr"} : !hw.inout<i32> 
    %memStage_0_isALU = sv.reg sym @sym_1038 {hw.verilogName = "memStage_0_isALU"} : !hw.inout<i1> 
    %memStage_0_isLoad = sv.reg sym @sym_1039 {hw.verilogName = "memStage_0_isLoad"} : !hw.inout<i1> 
    %memStage_0_isStore = sv.reg sym @sym_1040 {hw.verilogName = "memStage_0_isStore"} : !hw.inout<i1> 
    %memStage_0_isBranch = sv.reg sym @sym_1041 {hw.verilogName = "memStage_0_isBranch"} : !hw.inout<i1> 
    %memStage_0_isJAL = sv.reg sym @sym_1042 {hw.verilogName = "memStage_0_isJAL"} : !hw.inout<i1> 
    %memStage_0_isJALR = sv.reg sym @sym_1043 {hw.verilogName = "memStage_0_isJALR"} : !hw.inout<i1> 
    %memStage_0_isLUI = sv.reg sym @sym_1044 {hw.verilogName = "memStage_0_isLUI"} : !hw.inout<i1> 
    %memStage_0_isAUIPC = sv.reg sym @sym_1045 {hw.verilogName = "memStage_0_isAUIPC"} : !hw.inout<i1> 
    %memStage_0_isFence = sv.reg sym @sym_1046 {hw.verilogName = "memStage_0_isFence"} : !hw.inout<i1> 
    %memStage_0_isSystem = sv.reg sym @sym_1047 {hw.verilogName = "memStage_0_isSystem"} : !hw.inout<i1> 
    %memStage_0_aluOp = sv.reg sym @sym_1048 {hw.verilogName = "memStage_0_aluOp"} : !hw.inout<i5> 
    %memStage_0_imm = sv.reg sym @sym_1049 {hw.verilogName = "memStage_0_imm"} : !hw.inout<i32> 
    %memStage_0_rs1 = sv.reg sym @sym_1050 {hw.verilogName = "memStage_0_rs1"} : !hw.inout<i5> 
    %memStage_0_rs2 = sv.reg sym @sym_1051 {hw.verilogName = "memStage_0_rs2"} : !hw.inout<i5> 
    %memStage_0_rd = sv.reg sym @sym_1052 {hw.verilogName = "memStage_0_rd"} : !hw.inout<i5> 
    %memStage_0_rs1Data = sv.reg sym @sym_1053 {hw.verilogName = "memStage_0_rs1Data"} : !hw.inout<i32> 
    %memStage_0_rs2Data = sv.reg sym @sym_1054 {hw.verilogName = "memStage_0_rs2Data"} : !hw.inout<i32> 
    %memStage_0_memAddr = sv.reg sym @sym_1055 {hw.verilogName = "memStage_0_memAddr"} : !hw.inout<i32> 
    %memStage_0_memWdata = sv.reg sym @sym_1056 {hw.verilogName = "memStage_0_memWdata"} : !hw.inout<i32> 
    %memStage_0_memRdata = sv.reg sym @sym_1057 {hw.verilogName = "memStage_0_memRdata"} : !hw.inout<i32> 
    %memStage_0_aluResult = sv.reg sym @sym_1058 {hw.verilogName = "memStage_0_aluResult"} : !hw.inout<i32> 
    %memStage_1_threadId = sv.reg sym @sym_1059 {hw.verilogName = "memStage_1_threadId"} : !hw.inout<i2> 
    %memStage_1_valid = sv.reg sym @sym_1060 {hw.verilogName = "memStage_1_valid"} : !hw.inout<i1> 
    %memStage_1_pc = sv.reg sym @sym_1061 {hw.verilogName = "memStage_1_pc"} : !hw.inout<i32> 
    %memStage_1_instr = sv.reg sym @sym_1062 {hw.verilogName = "memStage_1_instr"} : !hw.inout<i32> 
    %memStage_1_isALU = sv.reg sym @sym_1063 {hw.verilogName = "memStage_1_isALU"} : !hw.inout<i1> 
    %memStage_1_isLoad = sv.reg sym @sym_1064 {hw.verilogName = "memStage_1_isLoad"} : !hw.inout<i1> 
    %memStage_1_isStore = sv.reg sym @sym_1065 {hw.verilogName = "memStage_1_isStore"} : !hw.inout<i1> 
    %memStage_1_isBranch = sv.reg sym @sym_1066 {hw.verilogName = "memStage_1_isBranch"} : !hw.inout<i1> 
    %memStage_1_isJAL = sv.reg sym @sym_1067 {hw.verilogName = "memStage_1_isJAL"} : !hw.inout<i1> 
    %memStage_1_isJALR = sv.reg sym @sym_1068 {hw.verilogName = "memStage_1_isJALR"} : !hw.inout<i1> 
    %memStage_1_isLUI = sv.reg sym @sym_1069 {hw.verilogName = "memStage_1_isLUI"} : !hw.inout<i1> 
    %memStage_1_isAUIPC = sv.reg sym @sym_1070 {hw.verilogName = "memStage_1_isAUIPC"} : !hw.inout<i1> 
    %memStage_1_isFence = sv.reg sym @sym_1071 {hw.verilogName = "memStage_1_isFence"} : !hw.inout<i1> 
    %memStage_1_isSystem = sv.reg sym @sym_1072 {hw.verilogName = "memStage_1_isSystem"} : !hw.inout<i1> 
    %memStage_1_aluOp = sv.reg sym @sym_1073 {hw.verilogName = "memStage_1_aluOp"} : !hw.inout<i5> 
    %memStage_1_imm = sv.reg sym @sym_1074 {hw.verilogName = "memStage_1_imm"} : !hw.inout<i32> 
    %memStage_1_rs1 = sv.reg sym @sym_1075 {hw.verilogName = "memStage_1_rs1"} : !hw.inout<i5> 
    %memStage_1_rs2 = sv.reg sym @sym_1076 {hw.verilogName = "memStage_1_rs2"} : !hw.inout<i5> 
    %memStage_1_rd = sv.reg sym @sym_1077 {hw.verilogName = "memStage_1_rd"} : !hw.inout<i5> 
    %memStage_1_rs1Data = sv.reg sym @sym_1078 {hw.verilogName = "memStage_1_rs1Data"} : !hw.inout<i32> 
    %memStage_1_rs2Data = sv.reg sym @sym_1079 {hw.verilogName = "memStage_1_rs2Data"} : !hw.inout<i32> 
    %memStage_1_memAddr = sv.reg sym @sym_1080 {hw.verilogName = "memStage_1_memAddr"} : !hw.inout<i32> 
    %memStage_1_memWdata = sv.reg sym @sym_1081 {hw.verilogName = "memStage_1_memWdata"} : !hw.inout<i32> 
    %memStage_1_memRdata = sv.reg sym @sym_1082 {hw.verilogName = "memStage_1_memRdata"} : !hw.inout<i32> 
    %memStage_1_aluResult = sv.reg sym @sym_1083 {hw.verilogName = "memStage_1_aluResult"} : !hw.inout<i32> 
    %memStage_2_threadId = sv.reg sym @sym_1084 {hw.verilogName = "memStage_2_threadId"} : !hw.inout<i2> 
    %memStage_2_valid = sv.reg sym @sym_1085 {hw.verilogName = "memStage_2_valid"} : !hw.inout<i1> 
    %memStage_2_pc = sv.reg sym @sym_1086 {hw.verilogName = "memStage_2_pc"} : !hw.inout<i32> 
    %memStage_2_instr = sv.reg sym @sym_1087 {hw.verilogName = "memStage_2_instr"} : !hw.inout<i32> 
    %memStage_2_isALU = sv.reg sym @sym_1088 {hw.verilogName = "memStage_2_isALU"} : !hw.inout<i1> 
    %memStage_2_isLoad = sv.reg sym @sym_1089 {hw.verilogName = "memStage_2_isLoad"} : !hw.inout<i1> 
    %memStage_2_isStore = sv.reg sym @sym_1090 {hw.verilogName = "memStage_2_isStore"} : !hw.inout<i1> 
    %memStage_2_isBranch = sv.reg sym @sym_1091 {hw.verilogName = "memStage_2_isBranch"} : !hw.inout<i1> 
    %memStage_2_isJAL = sv.reg sym @sym_1092 {hw.verilogName = "memStage_2_isJAL"} : !hw.inout<i1> 
    %memStage_2_isJALR = sv.reg sym @sym_1093 {hw.verilogName = "memStage_2_isJALR"} : !hw.inout<i1> 
    %memStage_2_isLUI = sv.reg sym @sym_1094 {hw.verilogName = "memStage_2_isLUI"} : !hw.inout<i1> 
    %memStage_2_isAUIPC = sv.reg sym @sym_1095 {hw.verilogName = "memStage_2_isAUIPC"} : !hw.inout<i1> 
    %memStage_2_isFence = sv.reg sym @sym_1096 {hw.verilogName = "memStage_2_isFence"} : !hw.inout<i1> 
    %memStage_2_isSystem = sv.reg sym @sym_1097 {hw.verilogName = "memStage_2_isSystem"} : !hw.inout<i1> 
    %memStage_2_aluOp = sv.reg sym @sym_1098 {hw.verilogName = "memStage_2_aluOp"} : !hw.inout<i5> 
    %memStage_2_imm = sv.reg sym @sym_1099 {hw.verilogName = "memStage_2_imm"} : !hw.inout<i32> 
    %memStage_2_rs1 = sv.reg sym @sym_1100 {hw.verilogName = "memStage_2_rs1"} : !hw.inout<i5> 
    %memStage_2_rs2 = sv.reg sym @sym_1101 {hw.verilogName = "memStage_2_rs2"} : !hw.inout<i5> 
    %memStage_2_rd = sv.reg sym @sym_1102 {hw.verilogName = "memStage_2_rd"} : !hw.inout<i5> 
    %memStage_2_rs1Data = sv.reg sym @sym_1103 {hw.verilogName = "memStage_2_rs1Data"} : !hw.inout<i32> 
    %memStage_2_rs2Data = sv.reg sym @sym_1104 {hw.verilogName = "memStage_2_rs2Data"} : !hw.inout<i32> 
    %memStage_2_memAddr = sv.reg sym @sym_1105 {hw.verilogName = "memStage_2_memAddr"} : !hw.inout<i32> 
    %memStage_2_memWdata = sv.reg sym @sym_1106 {hw.verilogName = "memStage_2_memWdata"} : !hw.inout<i32> 
    %memStage_2_memRdata = sv.reg sym @sym_1107 {hw.verilogName = "memStage_2_memRdata"} : !hw.inout<i32> 
    %memStage_2_aluResult = sv.reg sym @sym_1108 {hw.verilogName = "memStage_2_aluResult"} : !hw.inout<i32> 
    %memStage_3_threadId = sv.reg sym @sym_1109 {hw.verilogName = "memStage_3_threadId"} : !hw.inout<i2> 
    %memStage_3_valid = sv.reg sym @sym_1110 {hw.verilogName = "memStage_3_valid"} : !hw.inout<i1> 
    %memStage_3_pc = sv.reg sym @sym_1111 {hw.verilogName = "memStage_3_pc"} : !hw.inout<i32> 
    %memStage_3_instr = sv.reg sym @sym_1112 {hw.verilogName = "memStage_3_instr"} : !hw.inout<i32> 
    %memStage_3_isALU = sv.reg sym @sym_1113 {hw.verilogName = "memStage_3_isALU"} : !hw.inout<i1> 
    %memStage_3_isLoad = sv.reg sym @sym_1114 {hw.verilogName = "memStage_3_isLoad"} : !hw.inout<i1> 
    %memStage_3_isStore = sv.reg sym @sym_1115 {hw.verilogName = "memStage_3_isStore"} : !hw.inout<i1> 
    %memStage_3_isBranch = sv.reg sym @sym_1116 {hw.verilogName = "memStage_3_isBranch"} : !hw.inout<i1> 
    %memStage_3_isJAL = sv.reg sym @sym_1117 {hw.verilogName = "memStage_3_isJAL"} : !hw.inout<i1> 
    %memStage_3_isJALR = sv.reg sym @sym_1118 {hw.verilogName = "memStage_3_isJALR"} : !hw.inout<i1> 
    %memStage_3_isLUI = sv.reg sym @sym_1119 {hw.verilogName = "memStage_3_isLUI"} : !hw.inout<i1> 
    %memStage_3_isAUIPC = sv.reg sym @sym_1120 {hw.verilogName = "memStage_3_isAUIPC"} : !hw.inout<i1> 
    %memStage_3_isFence = sv.reg sym @sym_1121 {hw.verilogName = "memStage_3_isFence"} : !hw.inout<i1> 
    %memStage_3_isSystem = sv.reg sym @sym_1122 {hw.verilogName = "memStage_3_isSystem"} : !hw.inout<i1> 
    %memStage_3_aluOp = sv.reg sym @sym_1123 {hw.verilogName = "memStage_3_aluOp"} : !hw.inout<i5> 
    %memStage_3_imm = sv.reg sym @sym_1124 {hw.verilogName = "memStage_3_imm"} : !hw.inout<i32> 
    %memStage_3_rs1 = sv.reg sym @sym_1125 {hw.verilogName = "memStage_3_rs1"} : !hw.inout<i5> 
    %memStage_3_rs2 = sv.reg sym @sym_1126 {hw.verilogName = "memStage_3_rs2"} : !hw.inout<i5> 
    %memStage_3_rd = sv.reg sym @sym_1127 {hw.verilogName = "memStage_3_rd"} : !hw.inout<i5> 
    %memStage_3_rs1Data = sv.reg sym @sym_1128 {hw.verilogName = "memStage_3_rs1Data"} : !hw.inout<i32> 
    %memStage_3_rs2Data = sv.reg sym @sym_1129 {hw.verilogName = "memStage_3_rs2Data"} : !hw.inout<i32> 
    %memStage_3_memAddr = sv.reg sym @sym_1130 {hw.verilogName = "memStage_3_memAddr"} : !hw.inout<i32> 
    %memStage_3_memWdata = sv.reg sym @sym_1131 {hw.verilogName = "memStage_3_memWdata"} : !hw.inout<i32> 
    %memStage_3_memRdata = sv.reg sym @sym_1132 {hw.verilogName = "memStage_3_memRdata"} : !hw.inout<i32> 
    %memStage_3_aluResult = sv.reg sym @sym_1133 {hw.verilogName = "memStage_3_aluResult"} : !hw.inout<i32> 
    %7 = sv.read_inout %pcRegs_0 : !hw.inout<i32>
    %8 = sv.read_inout %pcRegs_1 : !hw.inout<i32>
    %9 = sv.read_inout %pcRegs_2 : !hw.inout<i32>
    %10 = sv.read_inout %pcRegs_3 : !hw.inout<i32>
    %11 = hw.array_create %10, %9, %8, %7 : i32
    %12 = sv.wire {hw.verilogName = "_GEN"} : !hw.inout<array<4xi32>>
    sv.assign %12, %11 : !hw.array<4xi32>
    %13 = sv.read_inout %currentThread : !hw.inout<i2>
    %14 = sv.read_inout %12 : !hw.inout<array<4xi32>>
    %15 = hw.array_get %14[%13] : !hw.array<4xi32>, i2
    %ifWire_pc = sv.wire sym @sym_1161 {hw.verilogName = "ifWire_pc"} : !hw.inout<i32>
    sv.assign %ifWire_pc, %15 : i32
    %16 = sv.read_inout %ifWire_pc : !hw.inout<i32>
    %17 = comb.extract %16 from 2 : (i32) -> i30
    %_ifWire_instr_T = sv.wire sym @sym_1184 {hw.verilogName = "_ifWire_instr_T"} : !hw.inout<i30>
    sv.assign %_ifWire_instr_T, %17 : i30
    %18 = sv.read_inout %_ifWire_instr_T : !hw.inout<i30>
    %_ifWire_instr_WIRE = sv.wire sym @sym_1185 {hw.verilogName = "_ifWire_instr_WIRE"} : !hw.inout<i30>
    sv.assign %_ifWire_instr_WIRE, %18 : i30
    %19 = sv.read_inout %_ifWire_instr_WIRE : !hw.inout<i30>
    %20 = comb.extract %19 from 0 : (i30) -> i10
    %_ifWire_instr_T_1 = sv.wire sym @sym_1186 {hw.verilogName = "_ifWire_instr_T_1"} : !hw.inout<i10>
    sv.assign %_ifWire_instr_T_1, %20 : i10
    %21 = sv.read_inout %ifWire_pc : !hw.inout<i32>
    %22 = comb.concat %false, %21 : i1, i32
    %23 = comb.add bin %22, %c4_i33 : i33
    %_pcRegs_T = sv.wire sym @sym_1187 {hw.verilogName = "_pcRegs_T"} : !hw.inout<i33>
    sv.assign %_pcRegs_T, %23 : i33
    %24 = sv.read_inout %_pcRegs_T : !hw.inout<i33>
    %25 = comb.extract %24 from 0 : (i33) -> i32
    %_pcRegs_T_1 = sv.wire sym @sym_1188 {hw.verilogName = "_pcRegs_T_1"} : !hw.inout<i32>
    sv.assign %_pcRegs_T_1, %25 : i32
    %26 = sv.read_inout %decStage_0_threadId : !hw.inout<i2>
    %27 = sv.read_inout %decStage_1_threadId : !hw.inout<i2>
    %28 = sv.read_inout %decStage_2_threadId : !hw.inout<i2>
    %29 = sv.read_inout %decStage_3_threadId : !hw.inout<i2>
    %30 = hw.array_create %29, %28, %27, %26 : i2
    %31 = sv.wire {hw.verilogName = "_GEN_0"} : !hw.inout<array<4xi2>>
    sv.assign %31, %30 : !hw.array<4xi2>
    %32 = sv.read_inout %currentThread : !hw.inout<i2>
    %33 = sv.read_inout %31 : !hw.inout<array<4xi2>>
    %34 = hw.array_get %33[%32] : !hw.array<4xi2>, i2
    %decWire_threadId = sv.wire sym @sym_1214 {hw.verilogName = "decWire_threadId"} : !hw.inout<i2>
    sv.assign %decWire_threadId, %34 : i2
    %35 = sv.read_inout %decStage_0_valid : !hw.inout<i1>
    %36 = sv.read_inout %decStage_1_valid : !hw.inout<i1>
    %37 = sv.read_inout %decStage_2_valid : !hw.inout<i1>
    %38 = sv.read_inout %decStage_3_valid : !hw.inout<i1>
    %39 = hw.array_create %38, %37, %36, %35 : i1
    %40 = sv.wire {hw.verilogName = "_GEN_1"} : !hw.inout<array<4xi1>>
    sv.assign %40, %39 : !hw.array<4xi1>
    %41 = sv.read_inout %currentThread : !hw.inout<i2>
    %42 = sv.read_inout %40 : !hw.inout<array<4xi1>>
    %43 = hw.array_get %42[%41] : !hw.array<4xi1>, i2
    %decWire_valid = sv.wire sym @sym_1215 {hw.verilogName = "decWire_valid"} : !hw.inout<i1>
    sv.assign %decWire_valid, %43 : i1
    %44 = sv.read_inout %decStage_0_pc : !hw.inout<i32>
    %45 = sv.read_inout %decStage_1_pc : !hw.inout<i32>
    %46 = sv.read_inout %decStage_2_pc : !hw.inout<i32>
    %47 = sv.read_inout %decStage_3_pc : !hw.inout<i32>
    %48 = hw.array_create %47, %46, %45, %44 : i32
    %49 = sv.wire {hw.verilogName = "_GEN_2"} : !hw.inout<array<4xi32>>
    sv.assign %49, %48 : !hw.array<4xi32>
    %50 = sv.read_inout %currentThread : !hw.inout<i2>
    %51 = sv.read_inout %49 : !hw.inout<array<4xi32>>
    %52 = hw.array_get %51[%50] : !hw.array<4xi32>, i2
    %decWire_pc = sv.wire sym @sym_1216 {hw.verilogName = "decWire_pc"} : !hw.inout<i32>
    sv.assign %decWire_pc, %52 : i32
    %53 = sv.read_inout %decStage_0_instr : !hw.inout<i32>
    %54 = sv.read_inout %decStage_1_instr : !hw.inout<i32>
    %55 = sv.read_inout %decStage_2_instr : !hw.inout<i32>
    %56 = sv.read_inout %decStage_3_instr : !hw.inout<i32>
    %57 = hw.array_create %56, %55, %54, %53 : i32
    %58 = sv.wire {hw.verilogName = "_GEN_3"} : !hw.inout<array<4xi32>>
    sv.assign %58, %57 : !hw.array<4xi32>
    %59 = sv.read_inout %currentThread : !hw.inout<i2>
    %60 = sv.read_inout %58 : !hw.inout<array<4xi32>>
    %61 = hw.array_get %60[%59] : !hw.array<4xi32>, i2
    %decWire_instr = sv.wire sym @sym_1217 {hw.verilogName = "decWire_instr"} : !hw.inout<i32>
    sv.assign %decWire_instr, %61 : i32
    %62 = sv.read_inout %decStage_0_isALU : !hw.inout<i1>
    %63 = sv.read_inout %decStage_1_isALU : !hw.inout<i1>
    %64 = sv.read_inout %decStage_2_isALU : !hw.inout<i1>
    %65 = sv.read_inout %decStage_3_isALU : !hw.inout<i1>
    %66 = hw.array_create %65, %64, %63, %62 : i1
    %67 = sv.wire {hw.verilogName = "_GEN_4"} : !hw.inout<array<4xi1>>
    sv.assign %67, %66 : !hw.array<4xi1>
    %68 = sv.read_inout %currentThread : !hw.inout<i2>
    %69 = sv.read_inout %67 : !hw.inout<array<4xi1>>
    %70 = hw.array_get %69[%68] : !hw.array<4xi1>, i2
    %71 = sv.read_inout %decStage_0_isLoad : !hw.inout<i1>
    %72 = sv.read_inout %decStage_1_isLoad : !hw.inout<i1>
    %73 = sv.read_inout %decStage_2_isLoad : !hw.inout<i1>
    %74 = sv.read_inout %decStage_3_isLoad : !hw.inout<i1>
    %75 = hw.array_create %74, %73, %72, %71 : i1
    %76 = sv.wire {hw.verilogName = "_GEN_5"} : !hw.inout<array<4xi1>>
    sv.assign %76, %75 : !hw.array<4xi1>
    %77 = sv.read_inout %currentThread : !hw.inout<i2>
    %78 = sv.read_inout %76 : !hw.inout<array<4xi1>>
    %79 = hw.array_get %78[%77] : !hw.array<4xi1>, i2
    %80 = sv.read_inout %decStage_0_isStore : !hw.inout<i1>
    %81 = sv.read_inout %decStage_1_isStore : !hw.inout<i1>
    %82 = sv.read_inout %decStage_2_isStore : !hw.inout<i1>
    %83 = sv.read_inout %decStage_3_isStore : !hw.inout<i1>
    %84 = hw.array_create %83, %82, %81, %80 : i1
    %85 = sv.wire {hw.verilogName = "_GEN_6"} : !hw.inout<array<4xi1>>
    sv.assign %85, %84 : !hw.array<4xi1>
    %86 = sv.read_inout %currentThread : !hw.inout<i2>
    %87 = sv.read_inout %85 : !hw.inout<array<4xi1>>
    %88 = hw.array_get %87[%86] : !hw.array<4xi1>, i2
    %89 = sv.read_inout %decStage_0_isBranch : !hw.inout<i1>
    %90 = sv.read_inout %decStage_1_isBranch : !hw.inout<i1>
    %91 = sv.read_inout %decStage_2_isBranch : !hw.inout<i1>
    %92 = sv.read_inout %decStage_3_isBranch : !hw.inout<i1>
    %93 = hw.array_create %92, %91, %90, %89 : i1
    %94 = sv.wire {hw.verilogName = "_GEN_7"} : !hw.inout<array<4xi1>>
    sv.assign %94, %93 : !hw.array<4xi1>
    %95 = sv.read_inout %currentThread : !hw.inout<i2>
    %96 = sv.read_inout %94 : !hw.inout<array<4xi1>>
    %97 = hw.array_get %96[%95] : !hw.array<4xi1>, i2
    %decWire_isBranch = sv.wire sym @sym_1221 {hw.verilogName = "decWire_isBranch"} : !hw.inout<i1>
    sv.assign %decWire_isBranch, %97 : i1
    %98 = sv.read_inout %decStage_0_isJAL : !hw.inout<i1>
    %99 = sv.read_inout %decStage_1_isJAL : !hw.inout<i1>
    %100 = sv.read_inout %decStage_2_isJAL : !hw.inout<i1>
    %101 = sv.read_inout %decStage_3_isJAL : !hw.inout<i1>
    %102 = hw.array_create %101, %100, %99, %98 : i1
    %103 = sv.wire {hw.verilogName = "_GEN_8"} : !hw.inout<array<4xi1>>
    sv.assign %103, %102 : !hw.array<4xi1>
    %104 = sv.read_inout %currentThread : !hw.inout<i2>
    %105 = sv.read_inout %103 : !hw.inout<array<4xi1>>
    %106 = hw.array_get %105[%104] : !hw.array<4xi1>, i2
    %decWire_isJAL = sv.wire sym @sym_1222 {hw.verilogName = "decWire_isJAL"} : !hw.inout<i1>
    sv.assign %decWire_isJAL, %106 : i1
    %107 = sv.read_inout %decStage_0_isJALR : !hw.inout<i1>
    %108 = sv.read_inout %decStage_1_isJALR : !hw.inout<i1>
    %109 = sv.read_inout %decStage_2_isJALR : !hw.inout<i1>
    %110 = sv.read_inout %decStage_3_isJALR : !hw.inout<i1>
    %111 = hw.array_create %110, %109, %108, %107 : i1
    %112 = sv.wire {hw.verilogName = "_GEN_9"} : !hw.inout<array<4xi1>>
    sv.assign %112, %111 : !hw.array<4xi1>
    %113 = sv.read_inout %currentThread : !hw.inout<i2>
    %114 = sv.read_inout %112 : !hw.inout<array<4xi1>>
    %115 = hw.array_get %114[%113] : !hw.array<4xi1>, i2
    %decWire_isJALR = sv.wire sym @sym_1223 {hw.verilogName = "decWire_isJALR"} : !hw.inout<i1>
    sv.assign %decWire_isJALR, %115 : i1
    %116 = sv.read_inout %decStage_0_isLUI : !hw.inout<i1>
    %117 = sv.read_inout %decStage_1_isLUI : !hw.inout<i1>
    %118 = sv.read_inout %decStage_2_isLUI : !hw.inout<i1>
    %119 = sv.read_inout %decStage_3_isLUI : !hw.inout<i1>
    %120 = hw.array_create %119, %118, %117, %116 : i1
    %121 = sv.wire {hw.verilogName = "_GEN_10"} : !hw.inout<array<4xi1>>
    sv.assign %121, %120 : !hw.array<4xi1>
    %122 = sv.read_inout %currentThread : !hw.inout<i2>
    %123 = sv.read_inout %121 : !hw.inout<array<4xi1>>
    %124 = hw.array_get %123[%122] : !hw.array<4xi1>, i2
    %decWire_isLUI = sv.wire sym @sym_1224 {hw.verilogName = "decWire_isLUI"} : !hw.inout<i1>
    sv.assign %decWire_isLUI, %124 : i1
    %125 = sv.read_inout %decStage_0_isAUIPC : !hw.inout<i1>
    %126 = sv.read_inout %decStage_1_isAUIPC : !hw.inout<i1>
    %127 = sv.read_inout %decStage_2_isAUIPC : !hw.inout<i1>
    %128 = sv.read_inout %decStage_3_isAUIPC : !hw.inout<i1>
    %129 = hw.array_create %128, %127, %126, %125 : i1
    %130 = sv.wire {hw.verilogName = "_GEN_11"} : !hw.inout<array<4xi1>>
    sv.assign %130, %129 : !hw.array<4xi1>
    %131 = sv.read_inout %currentThread : !hw.inout<i2>
    %132 = sv.read_inout %130 : !hw.inout<array<4xi1>>
    %133 = hw.array_get %132[%131] : !hw.array<4xi1>, i2
    %decWire_isAUIPC = sv.wire sym @sym_1225 {hw.verilogName = "decWire_isAUIPC"} : !hw.inout<i1>
    sv.assign %decWire_isAUIPC, %133 : i1
    %134 = sv.read_inout %decStage_0_isFence : !hw.inout<i1>
    %135 = sv.read_inout %decStage_1_isFence : !hw.inout<i1>
    %136 = sv.read_inout %decStage_2_isFence : !hw.inout<i1>
    %137 = sv.read_inout %decStage_3_isFence : !hw.inout<i1>
    %138 = hw.array_create %137, %136, %135, %134 : i1
    %139 = sv.wire {hw.verilogName = "_GEN_12"} : !hw.inout<array<4xi1>>
    sv.assign %139, %138 : !hw.array<4xi1>
    %140 = sv.read_inout %currentThread : !hw.inout<i2>
    %141 = sv.read_inout %139 : !hw.inout<array<4xi1>>
    %142 = hw.array_get %141[%140] : !hw.array<4xi1>, i2
    %decWire_isFence = sv.wire sym @sym_1226 {hw.verilogName = "decWire_isFence"} : !hw.inout<i1>
    sv.assign %decWire_isFence, %142 : i1
    %143 = sv.read_inout %decStage_0_isSystem : !hw.inout<i1>
    %144 = sv.read_inout %decStage_1_isSystem : !hw.inout<i1>
    %145 = sv.read_inout %decStage_2_isSystem : !hw.inout<i1>
    %146 = sv.read_inout %decStage_3_isSystem : !hw.inout<i1>
    %147 = hw.array_create %146, %145, %144, %143 : i1
    %148 = sv.wire {hw.verilogName = "_GEN_13"} : !hw.inout<array<4xi1>>
    sv.assign %148, %147 : !hw.array<4xi1>
    %149 = sv.read_inout %currentThread : !hw.inout<i2>
    %150 = sv.read_inout %148 : !hw.inout<array<4xi1>>
    %151 = hw.array_get %150[%149] : !hw.array<4xi1>, i2
    %decWire_isSystem = sv.wire sym @sym_1227 {hw.verilogName = "decWire_isSystem"} : !hw.inout<i1>
    sv.assign %decWire_isSystem, %151 : i1
    %152 = sv.read_inout %decStage_0_aluOp : !hw.inout<i5>
    %153 = sv.read_inout %decStage_1_aluOp : !hw.inout<i5>
    %154 = sv.read_inout %decStage_2_aluOp : !hw.inout<i5>
    %155 = sv.read_inout %decStage_3_aluOp : !hw.inout<i5>
    %156 = hw.array_create %155, %154, %153, %152 : i5
    %157 = sv.wire {hw.verilogName = "_GEN_14"} : !hw.inout<array<4xi5>>
    sv.assign %157, %156 : !hw.array<4xi5>
    %158 = sv.read_inout %currentThread : !hw.inout<i2>
    %159 = sv.read_inout %157 : !hw.inout<array<4xi5>>
    %160 = hw.array_get %159[%158] : !hw.array<4xi5>, i2
    %decWire_aluOp = sv.wire sym @sym_1228 {hw.verilogName = "decWire_aluOp"} : !hw.inout<i5>
    sv.assign %decWire_aluOp, %160 : i5
    %161 = sv.read_inout %decStage_0_imm : !hw.inout<i32>
    %162 = sv.read_inout %decStage_1_imm : !hw.inout<i32>
    %163 = sv.read_inout %decStage_2_imm : !hw.inout<i32>
    %164 = sv.read_inout %decStage_3_imm : !hw.inout<i32>
    %165 = hw.array_create %164, %163, %162, %161 : i32
    %166 = sv.wire {hw.verilogName = "_GEN_15"} : !hw.inout<array<4xi32>>
    sv.assign %166, %165 : !hw.array<4xi32>
    %167 = sv.read_inout %currentThread : !hw.inout<i2>
    %168 = sv.read_inout %166 : !hw.inout<array<4xi32>>
    %169 = hw.array_get %168[%167] : !hw.array<4xi32>, i2
    %decWire_imm = sv.wire sym @sym_1229 {hw.verilogName = "decWire_imm"} : !hw.inout<i32>
    sv.assign %decWire_imm, %169 : i32
    %170 = sv.read_inout %decStage_0_memAddr : !hw.inout<i32>
    %171 = sv.read_inout %decStage_1_memAddr : !hw.inout<i32>
    %172 = sv.read_inout %decStage_2_memAddr : !hw.inout<i32>
    %173 = sv.read_inout %decStage_3_memAddr : !hw.inout<i32>
    %174 = hw.array_create %173, %172, %171, %170 : i32
    %175 = sv.wire {hw.verilogName = "_GEN_16"} : !hw.inout<array<4xi32>>
    sv.assign %175, %174 : !hw.array<4xi32>
    %176 = sv.read_inout %currentThread : !hw.inout<i2>
    %177 = sv.read_inout %175 : !hw.inout<array<4xi32>>
    %178 = hw.array_get %177[%176] : !hw.array<4xi32>, i2
    %decWire_memAddr = sv.wire sym @sym_1235 {hw.verilogName = "decWire_memAddr"} : !hw.inout<i32>
    sv.assign %decWire_memAddr, %178 : i32
    %179 = sv.read_inout %decStage_0_memWdata : !hw.inout<i32>
    %180 = sv.read_inout %decStage_1_memWdata : !hw.inout<i32>
    %181 = sv.read_inout %decStage_2_memWdata : !hw.inout<i32>
    %182 = sv.read_inout %decStage_3_memWdata : !hw.inout<i32>
    %183 = hw.array_create %182, %181, %180, %179 : i32
    %184 = sv.wire {hw.verilogName = "_GEN_17"} : !hw.inout<array<4xi32>>
    sv.assign %184, %183 : !hw.array<4xi32>
    %185 = sv.read_inout %currentThread : !hw.inout<i2>
    %186 = sv.read_inout %184 : !hw.inout<array<4xi32>>
    %187 = hw.array_get %186[%185] : !hw.array<4xi32>, i2
    %decWire_memWdata = sv.wire sym @sym_1236 {hw.verilogName = "decWire_memWdata"} : !hw.inout<i32>
    sv.assign %decWire_memWdata, %187 : i32
    %188 = sv.read_inout %decStage_0_memRdata : !hw.inout<i32>
    %189 = sv.read_inout %decStage_1_memRdata : !hw.inout<i32>
    %190 = sv.read_inout %decStage_2_memRdata : !hw.inout<i32>
    %191 = sv.read_inout %decStage_3_memRdata : !hw.inout<i32>
    %192 = hw.array_create %191, %190, %189, %188 : i32
    %193 = sv.wire {hw.verilogName = "_GEN_18"} : !hw.inout<array<4xi32>>
    sv.assign %193, %192 : !hw.array<4xi32>
    %194 = sv.read_inout %currentThread : !hw.inout<i2>
    %195 = sv.read_inout %193 : !hw.inout<array<4xi32>>
    %196 = hw.array_get %195[%194] : !hw.array<4xi32>, i2
    %decWire_memRdata = sv.wire sym @sym_1237 {hw.verilogName = "decWire_memRdata"} : !hw.inout<i32>
    sv.assign %decWire_memRdata, %196 : i32
    %197 = sv.read_inout %decStage_0_aluResult : !hw.inout<i32>
    %198 = sv.read_inout %decStage_1_aluResult : !hw.inout<i32>
    %199 = sv.read_inout %decStage_2_aluResult : !hw.inout<i32>
    %200 = sv.read_inout %decStage_3_aluResult : !hw.inout<i32>
    %201 = hw.array_create %200, %199, %198, %197 : i32
    %202 = sv.wire {hw.verilogName = "_GEN_19"} : !hw.inout<array<4xi32>>
    sv.assign %202, %201 : !hw.array<4xi32>
    %203 = sv.read_inout %currentThread : !hw.inout<i2>
    %204 = sv.read_inout %202 : !hw.inout<array<4xi32>>
    %205 = hw.array_get %204[%203] : !hw.array<4xi32>, i2
    %decWire_aluResult = sv.wire sym @sym_1238 {hw.verilogName = "decWire_aluResult"} : !hw.inout<i32>
    sv.assign %decWire_aluResult, %205 : i32
    %_decWire_rs1_T = sv.wire sym @sym_1240 {hw.verilogName = "_decWire_rs1_T"} : !hw.inout<i5>
    %_decWire_rs2_T = sv.wire sym @sym_1241 {hw.verilogName = "_decWire_rs2_T"} : !hw.inout<i5>
    %_decWire_rd_T = sv.wire sym @sym_1242 {hw.verilogName = "_decWire_rd_T"} : !hw.inout<i5>
    %206 = sv.read_inout %decWire_instr : !hw.inout<i32>
    %207 = comb.extract %206 from 0 : (i32) -> i7
    %opcode = sv.wire sym @sym_1239 {hw.verilogName = "opcode"} : !hw.inout<i7>
    sv.assign %opcode, %207 : i7
    %208 = sv.read_inout %opcode : !hw.inout<i7>
    %209 = comb.icmp bin eq %208, %c51_i7 : i7
    %_T = sv.wire {hw.verilogName = "_T"} : !hw.inout<i1>
    sv.assign %_T, %209 : i1
    %210 = sv.read_inout %_T : !hw.inout<i1>
    %211 = comb.or %210, %70 : i1
    %decWire_isALU = sv.wire sym @sym_1218 {hw.verilogName = "decWire_isALU"} : !hw.inout<i1>
    sv.assign %decWire_isALU, %211 : i1
    %212 = sv.read_inout %opcode : !hw.inout<i7>
    %213 = comb.icmp bin eq %212, %c3_i7 : i7
    %_T_1 = sv.wire {hw.verilogName = "_T_1"} : !hw.inout<i1>
    sv.assign %_T_1, %213 : i1
    %214 = sv.read_inout %_T : !hw.inout<i1>
    %215 = comb.xor %214, %true : i1
    %216 = sv.read_inout %_T_1 : !hw.inout<i1>
    %217 = comb.and %215, %216 : i1
    %218 = comb.or %217, %79 : i1
    %decWire_isLoad = sv.wire sym @sym_1219 {hw.verilogName = "decWire_isLoad"} : !hw.inout<i1>
    sv.assign %decWire_isLoad, %218 : i1
    %219 = sv.read_inout %opcode : !hw.inout<i7>
    %220 = comb.icmp bin eq %219, %c35_i7 {sv.namehint = "_T_2"} : i7
    %221 = sv.read_inout %_T : !hw.inout<i1>
    %222 = sv.read_inout %_T_1 : !hw.inout<i1>
    %223 = comb.or bin %221, %222 : i1
    %224 = comb.xor %223, %true : i1
    %225 = comb.and %224, %220 : i1
    %226 = comb.or %225, %88 : i1
    %decWire_isStore = sv.wire sym @sym_1220 {hw.verilogName = "decWire_isStore"} : !hw.inout<i1>
    sv.assign %decWire_isStore, %226 : i1
    %227 = sv.read_inout %decWire_instr : !hw.inout<i32>
    %228 = comb.extract %227 from 15 : (i32) -> i5
    sv.assign %_decWire_rs1_T, %228 : i5
    %229 = sv.read_inout %_decWire_rs1_T : !hw.inout<i5>
    %decWire_rs1 = sv.wire sym @sym_1230 {hw.verilogName = "decWire_rs1", sv.namehint = "decWire_rs1"} : !hw.inout<i5>
    sv.assign %decWire_rs1, %229 : i5
    %230 = sv.read_inout %decWire_instr : !hw.inout<i32>
    %231 = comb.extract %230 from 20 : (i32) -> i5
    sv.assign %_decWire_rs2_T, %231 : i5
    %232 = sv.read_inout %_decWire_rs2_T : !hw.inout<i5>
    %decWire_rs2 = sv.wire sym @sym_1231 {hw.verilogName = "decWire_rs2", sv.namehint = "decWire_rs2"} : !hw.inout<i5>
    sv.assign %decWire_rs2, %232 : i5
    %233 = sv.read_inout %decWire_instr : !hw.inout<i32>
    %234 = comb.extract %233 from 7 : (i32) -> i5
    sv.assign %_decWire_rd_T, %234 : i5
    %235 = sv.read_inout %_decWire_rd_T : !hw.inout<i5>
    %decWire_rd = sv.wire sym @sym_1232 {hw.verilogName = "decWire_rd"} : !hw.inout<i5>
    sv.assign %decWire_rd, %235 : i5
    %236 = sv.read_inout %exStage_0_threadId : !hw.inout<i2>
    %237 = sv.read_inout %exStage_1_threadId : !hw.inout<i2>
    %238 = sv.read_inout %exStage_2_threadId : !hw.inout<i2>
    %239 = sv.read_inout %exStage_3_threadId : !hw.inout<i2>
    %240 = hw.array_create %239, %238, %237, %236 : i2
    %241 = sv.wire {hw.verilogName = "_GEN_20"} : !hw.inout<array<4xi2>>
    sv.assign %241, %240 : !hw.array<4xi2>
    %242 = sv.read_inout %currentThread : !hw.inout<i2>
    %243 = sv.read_inout %241 : !hw.inout<array<4xi2>>
    %244 = hw.array_get %243[%242] : !hw.array<4xi2>, i2
    %exWire_threadId = sv.wire sym @sym_1268 {hw.verilogName = "exWire_threadId"} : !hw.inout<i2>
    sv.assign %exWire_threadId, %244 : i2
    %245 = sv.read_inout %exStage_0_valid : !hw.inout<i1>
    %246 = sv.read_inout %exStage_1_valid : !hw.inout<i1>
    %247 = sv.read_inout %exStage_2_valid : !hw.inout<i1>
    %248 = sv.read_inout %exStage_3_valid : !hw.inout<i1>
    %249 = hw.array_create %248, %247, %246, %245 : i1
    %250 = sv.wire {hw.verilogName = "_GEN_21"} : !hw.inout<array<4xi1>>
    sv.assign %250, %249 : !hw.array<4xi1>
    %251 = sv.read_inout %currentThread : !hw.inout<i2>
    %252 = sv.read_inout %250 : !hw.inout<array<4xi1>>
    %253 = hw.array_get %252[%251] : !hw.array<4xi1>, i2
    %exWire_valid = sv.wire sym @sym_1269 {hw.verilogName = "exWire_valid"} : !hw.inout<i1>
    sv.assign %exWire_valid, %253 : i1
    %254 = sv.read_inout %exStage_0_pc : !hw.inout<i32>
    %255 = sv.read_inout %exStage_1_pc : !hw.inout<i32>
    %256 = sv.read_inout %exStage_2_pc : !hw.inout<i32>
    %257 = sv.read_inout %exStage_3_pc : !hw.inout<i32>
    %258 = hw.array_create %257, %256, %255, %254 : i32
    %259 = sv.wire {hw.verilogName = "_GEN_22"} : !hw.inout<array<4xi32>>
    sv.assign %259, %258 : !hw.array<4xi32>
    %260 = sv.read_inout %currentThread : !hw.inout<i2>
    %261 = sv.read_inout %259 : !hw.inout<array<4xi32>>
    %262 = hw.array_get %261[%260] : !hw.array<4xi32>, i2
    %exWire_pc = sv.wire sym @sym_1270 {hw.verilogName = "exWire_pc"} : !hw.inout<i32>
    sv.assign %exWire_pc, %262 : i32
    %263 = sv.read_inout %exStage_0_instr : !hw.inout<i32>
    %264 = sv.read_inout %exStage_1_instr : !hw.inout<i32>
    %265 = sv.read_inout %exStage_2_instr : !hw.inout<i32>
    %266 = sv.read_inout %exStage_3_instr : !hw.inout<i32>
    %267 = hw.array_create %266, %265, %264, %263 : i32
    %268 = sv.wire {hw.verilogName = "_GEN_23"} : !hw.inout<array<4xi32>>
    sv.assign %268, %267 : !hw.array<4xi32>
    %269 = sv.read_inout %currentThread : !hw.inout<i2>
    %270 = sv.read_inout %268 : !hw.inout<array<4xi32>>
    %271 = hw.array_get %270[%269] : !hw.array<4xi32>, i2
    %exWire_instr = sv.wire sym @sym_1271 {hw.verilogName = "exWire_instr"} : !hw.inout<i32>
    sv.assign %exWire_instr, %271 : i32
    %272 = sv.read_inout %exStage_0_isALU : !hw.inout<i1>
    %273 = sv.read_inout %exStage_1_isALU : !hw.inout<i1>
    %274 = sv.read_inout %exStage_2_isALU : !hw.inout<i1>
    %275 = sv.read_inout %exStage_3_isALU : !hw.inout<i1>
    %276 = hw.array_create %275, %274, %273, %272 : i1
    %277 = sv.wire {hw.verilogName = "_GEN_24"} : !hw.inout<array<4xi1>>
    sv.assign %277, %276 : !hw.array<4xi1>
    %278 = sv.read_inout %currentThread : !hw.inout<i2>
    %279 = sv.read_inout %277 : !hw.inout<array<4xi1>>
    %280 = hw.array_get %279[%278] : !hw.array<4xi1>, i2
    %exWire_isALU = sv.wire sym @sym_1272 {hw.verilogName = "exWire_isALU"} : !hw.inout<i1>
    sv.assign %exWire_isALU, %280 : i1
    %281 = sv.read_inout %exStage_0_isLoad : !hw.inout<i1>
    %282 = sv.read_inout %exStage_1_isLoad : !hw.inout<i1>
    %283 = sv.read_inout %exStage_2_isLoad : !hw.inout<i1>
    %284 = sv.read_inout %exStage_3_isLoad : !hw.inout<i1>
    %285 = hw.array_create %284, %283, %282, %281 : i1
    %286 = sv.wire {hw.verilogName = "_GEN_25"} : !hw.inout<array<4xi1>>
    sv.assign %286, %285 : !hw.array<4xi1>
    %287 = sv.read_inout %currentThread : !hw.inout<i2>
    %288 = sv.read_inout %286 : !hw.inout<array<4xi1>>
    %289 = hw.array_get %288[%287] : !hw.array<4xi1>, i2
    %exWire_isLoad = sv.wire sym @sym_1273 {hw.verilogName = "exWire_isLoad"} : !hw.inout<i1>
    sv.assign %exWire_isLoad, %289 : i1
    %290 = sv.read_inout %exStage_0_isStore : !hw.inout<i1>
    %291 = sv.read_inout %exStage_1_isStore : !hw.inout<i1>
    %292 = sv.read_inout %exStage_2_isStore : !hw.inout<i1>
    %293 = sv.read_inout %exStage_3_isStore : !hw.inout<i1>
    %294 = hw.array_create %293, %292, %291, %290 : i1
    %295 = sv.wire {hw.verilogName = "_GEN_26"} : !hw.inout<array<4xi1>>
    sv.assign %295, %294 : !hw.array<4xi1>
    %296 = sv.read_inout %currentThread : !hw.inout<i2>
    %297 = sv.read_inout %295 : !hw.inout<array<4xi1>>
    %298 = hw.array_get %297[%296] : !hw.array<4xi1>, i2
    %exWire_isStore = sv.wire sym @sym_1274 {hw.verilogName = "exWire_isStore"} : !hw.inout<i1>
    sv.assign %exWire_isStore, %298 : i1
    %299 = sv.read_inout %exStage_0_isBranch : !hw.inout<i1>
    %300 = sv.read_inout %exStage_1_isBranch : !hw.inout<i1>
    %301 = sv.read_inout %exStage_2_isBranch : !hw.inout<i1>
    %302 = sv.read_inout %exStage_3_isBranch : !hw.inout<i1>
    %303 = hw.array_create %302, %301, %300, %299 : i1
    %304 = sv.wire {hw.verilogName = "_GEN_27"} : !hw.inout<array<4xi1>>
    sv.assign %304, %303 : !hw.array<4xi1>
    %305 = sv.read_inout %currentThread : !hw.inout<i2>
    %306 = sv.read_inout %304 : !hw.inout<array<4xi1>>
    %307 = hw.array_get %306[%305] : !hw.array<4xi1>, i2
    %exWire_isBranch = sv.wire sym @sym_1275 {hw.verilogName = "exWire_isBranch"} : !hw.inout<i1>
    sv.assign %exWire_isBranch, %307 : i1
    %308 = sv.read_inout %exStage_0_isJAL : !hw.inout<i1>
    %309 = sv.read_inout %exStage_1_isJAL : !hw.inout<i1>
    %310 = sv.read_inout %exStage_2_isJAL : !hw.inout<i1>
    %311 = sv.read_inout %exStage_3_isJAL : !hw.inout<i1>
    %312 = hw.array_create %311, %310, %309, %308 : i1
    %313 = sv.wire {hw.verilogName = "_GEN_28"} : !hw.inout<array<4xi1>>
    sv.assign %313, %312 : !hw.array<4xi1>
    %314 = sv.read_inout %currentThread : !hw.inout<i2>
    %315 = sv.read_inout %313 : !hw.inout<array<4xi1>>
    %316 = hw.array_get %315[%314] : !hw.array<4xi1>, i2
    %exWire_isJAL = sv.wire sym @sym_1276 {hw.verilogName = "exWire_isJAL"} : !hw.inout<i1>
    sv.assign %exWire_isJAL, %316 : i1
    %317 = sv.read_inout %exStage_0_isJALR : !hw.inout<i1>
    %318 = sv.read_inout %exStage_1_isJALR : !hw.inout<i1>
    %319 = sv.read_inout %exStage_2_isJALR : !hw.inout<i1>
    %320 = sv.read_inout %exStage_3_isJALR : !hw.inout<i1>
    %321 = hw.array_create %320, %319, %318, %317 : i1
    %322 = sv.wire {hw.verilogName = "_GEN_29"} : !hw.inout<array<4xi1>>
    sv.assign %322, %321 : !hw.array<4xi1>
    %323 = sv.read_inout %currentThread : !hw.inout<i2>
    %324 = sv.read_inout %322 : !hw.inout<array<4xi1>>
    %325 = hw.array_get %324[%323] : !hw.array<4xi1>, i2
    %exWire_isJALR = sv.wire sym @sym_1277 {hw.verilogName = "exWire_isJALR"} : !hw.inout<i1>
    sv.assign %exWire_isJALR, %325 : i1
    %326 = sv.read_inout %exStage_0_isLUI : !hw.inout<i1>
    %327 = sv.read_inout %exStage_1_isLUI : !hw.inout<i1>
    %328 = sv.read_inout %exStage_2_isLUI : !hw.inout<i1>
    %329 = sv.read_inout %exStage_3_isLUI : !hw.inout<i1>
    %330 = hw.array_create %329, %328, %327, %326 : i1
    %331 = sv.wire {hw.verilogName = "_GEN_30"} : !hw.inout<array<4xi1>>
    sv.assign %331, %330 : !hw.array<4xi1>
    %332 = sv.read_inout %currentThread : !hw.inout<i2>
    %333 = sv.read_inout %331 : !hw.inout<array<4xi1>>
    %334 = hw.array_get %333[%332] : !hw.array<4xi1>, i2
    %exWire_isLUI = sv.wire sym @sym_1278 {hw.verilogName = "exWire_isLUI"} : !hw.inout<i1>
    sv.assign %exWire_isLUI, %334 : i1
    %335 = sv.read_inout %exStage_0_isAUIPC : !hw.inout<i1>
    %336 = sv.read_inout %exStage_1_isAUIPC : !hw.inout<i1>
    %337 = sv.read_inout %exStage_2_isAUIPC : !hw.inout<i1>
    %338 = sv.read_inout %exStage_3_isAUIPC : !hw.inout<i1>
    %339 = hw.array_create %338, %337, %336, %335 : i1
    %340 = sv.wire {hw.verilogName = "_GEN_31"} : !hw.inout<array<4xi1>>
    sv.assign %340, %339 : !hw.array<4xi1>
    %341 = sv.read_inout %currentThread : !hw.inout<i2>
    %342 = sv.read_inout %340 : !hw.inout<array<4xi1>>
    %343 = hw.array_get %342[%341] : !hw.array<4xi1>, i2
    %exWire_isAUIPC = sv.wire sym @sym_1279 {hw.verilogName = "exWire_isAUIPC"} : !hw.inout<i1>
    sv.assign %exWire_isAUIPC, %343 : i1
    %344 = sv.read_inout %exStage_0_isFence : !hw.inout<i1>
    %345 = sv.read_inout %exStage_1_isFence : !hw.inout<i1>
    %346 = sv.read_inout %exStage_2_isFence : !hw.inout<i1>
    %347 = sv.read_inout %exStage_3_isFence : !hw.inout<i1>
    %348 = hw.array_create %347, %346, %345, %344 : i1
    %349 = sv.wire {hw.verilogName = "_GEN_32"} : !hw.inout<array<4xi1>>
    sv.assign %349, %348 : !hw.array<4xi1>
    %350 = sv.read_inout %currentThread : !hw.inout<i2>
    %351 = sv.read_inout %349 : !hw.inout<array<4xi1>>
    %352 = hw.array_get %351[%350] : !hw.array<4xi1>, i2
    %exWire_isFence = sv.wire sym @sym_1280 {hw.verilogName = "exWire_isFence"} : !hw.inout<i1>
    sv.assign %exWire_isFence, %352 : i1
    %353 = sv.read_inout %exStage_0_isSystem : !hw.inout<i1>
    %354 = sv.read_inout %exStage_1_isSystem : !hw.inout<i1>
    %355 = sv.read_inout %exStage_2_isSystem : !hw.inout<i1>
    %356 = sv.read_inout %exStage_3_isSystem : !hw.inout<i1>
    %357 = hw.array_create %356, %355, %354, %353 : i1
    %358 = sv.wire {hw.verilogName = "_GEN_33"} : !hw.inout<array<4xi1>>
    sv.assign %358, %357 : !hw.array<4xi1>
    %359 = sv.read_inout %currentThread : !hw.inout<i2>
    %360 = sv.read_inout %358 : !hw.inout<array<4xi1>>
    %361 = hw.array_get %360[%359] : !hw.array<4xi1>, i2
    %exWire_isSystem = sv.wire sym @sym_1281 {hw.verilogName = "exWire_isSystem"} : !hw.inout<i1>
    sv.assign %exWire_isSystem, %361 : i1
    %362 = sv.read_inout %exStage_0_aluOp : !hw.inout<i5>
    %363 = sv.read_inout %exStage_1_aluOp : !hw.inout<i5>
    %364 = sv.read_inout %exStage_2_aluOp : !hw.inout<i5>
    %365 = sv.read_inout %exStage_3_aluOp : !hw.inout<i5>
    %366 = hw.array_create %365, %364, %363, %362 : i5
    %367 = sv.wire {hw.verilogName = "_GEN_34"} : !hw.inout<array<4xi5>>
    sv.assign %367, %366 : !hw.array<4xi5>
    %368 = sv.read_inout %currentThread : !hw.inout<i2>
    %369 = sv.read_inout %367 : !hw.inout<array<4xi5>>
    %370 = hw.array_get %369[%368] : !hw.array<4xi5>, i2
    %exWire_aluOp = sv.wire sym @sym_1282 {hw.verilogName = "exWire_aluOp", sv.namehint = "alu.io_fn"} : !hw.inout<i5>
    sv.assign %exWire_aluOp, %370 : i5
    %371 = sv.read_inout %exStage_0_imm : !hw.inout<i32>
    %372 = sv.read_inout %exStage_1_imm : !hw.inout<i32>
    %373 = sv.read_inout %exStage_2_imm : !hw.inout<i32>
    %374 = sv.read_inout %exStage_3_imm : !hw.inout<i32>
    %375 = hw.array_create %374, %373, %372, %371 : i32
    %376 = sv.wire {hw.verilogName = "_GEN_35"} : !hw.inout<array<4xi32>>
    sv.assign %376, %375 : !hw.array<4xi32>
    %377 = sv.read_inout %currentThread : !hw.inout<i2>
    %378 = sv.read_inout %376 : !hw.inout<array<4xi32>>
    %379 = hw.array_get %378[%377] : !hw.array<4xi32>, i2
    %exWire_imm = sv.wire sym @sym_1283 {hw.verilogName = "exWire_imm"} : !hw.inout<i32>
    sv.assign %exWire_imm, %379 : i32
    %380 = sv.read_inout %exStage_0_rs1 : !hw.inout<i5>
    %381 = sv.read_inout %exStage_1_rs1 : !hw.inout<i5>
    %382 = sv.read_inout %exStage_2_rs1 : !hw.inout<i5>
    %383 = sv.read_inout %exStage_3_rs1 : !hw.inout<i5>
    %384 = hw.array_create %383, %382, %381, %380 : i5
    %385 = sv.wire {hw.verilogName = "_GEN_36"} : !hw.inout<array<4xi5>>
    sv.assign %385, %384 : !hw.array<4xi5>
    %386 = sv.read_inout %currentThread : !hw.inout<i2>
    %387 = sv.read_inout %385 : !hw.inout<array<4xi5>>
    %388 = hw.array_get %387[%386] : !hw.array<4xi5>, i2
    %exWire_rs1 = sv.wire sym @sym_1284 {hw.verilogName = "exWire_rs1"} : !hw.inout<i5>
    sv.assign %exWire_rs1, %388 : i5
    %389 = sv.read_inout %exStage_0_rs2 : !hw.inout<i5>
    %390 = sv.read_inout %exStage_1_rs2 : !hw.inout<i5>
    %391 = sv.read_inout %exStage_2_rs2 : !hw.inout<i5>
    %392 = sv.read_inout %exStage_3_rs2 : !hw.inout<i5>
    %393 = hw.array_create %392, %391, %390, %389 : i5
    %394 = sv.wire {hw.verilogName = "_GEN_37"} : !hw.inout<array<4xi5>>
    sv.assign %394, %393 : !hw.array<4xi5>
    %395 = sv.read_inout %currentThread : !hw.inout<i2>
    %396 = sv.read_inout %394 : !hw.inout<array<4xi5>>
    %397 = hw.array_get %396[%395] : !hw.array<4xi5>, i2
    %exWire_rs2 = sv.wire sym @sym_1285 {hw.verilogName = "exWire_rs2"} : !hw.inout<i5>
    sv.assign %exWire_rs2, %397 : i5
    %398 = sv.read_inout %exStage_0_rd : !hw.inout<i5>
    %399 = sv.read_inout %exStage_1_rd : !hw.inout<i5>
    %400 = sv.read_inout %exStage_2_rd : !hw.inout<i5>
    %401 = sv.read_inout %exStage_3_rd : !hw.inout<i5>
    %402 = hw.array_create %401, %400, %399, %398 : i5
    %403 = sv.wire {hw.verilogName = "_GEN_38"} : !hw.inout<array<4xi5>>
    sv.assign %403, %402 : !hw.array<4xi5>
    %404 = sv.read_inout %currentThread : !hw.inout<i2>
    %405 = sv.read_inout %403 : !hw.inout<array<4xi5>>
    %406 = hw.array_get %405[%404] : !hw.array<4xi5>, i2
    %exWire_rd = sv.wire sym @sym_1286 {hw.verilogName = "exWire_rd"} : !hw.inout<i5>
    sv.assign %exWire_rd, %406 : i5
    %407 = sv.read_inout %exStage_0_rs1Data : !hw.inout<i32>
    %408 = sv.read_inout %exStage_1_rs1Data : !hw.inout<i32>
    %409 = sv.read_inout %exStage_2_rs1Data : !hw.inout<i32>
    %410 = sv.read_inout %exStage_3_rs1Data : !hw.inout<i32>
    %411 = hw.array_create %410, %409, %408, %407 : i32
    %412 = sv.wire {hw.verilogName = "_GEN_39"} : !hw.inout<array<4xi32>>
    sv.assign %412, %411 : !hw.array<4xi32>
    %413 = sv.read_inout %currentThread : !hw.inout<i2>
    %414 = sv.read_inout %412 : !hw.inout<array<4xi32>>
    %415 = hw.array_get %414[%413] : !hw.array<4xi32>, i2
    %exWire_rs1Data = sv.wire sym @sym_1287 {hw.verilogName = "exWire_rs1Data", sv.namehint = "alu.io_a"} : !hw.inout<i32>
    sv.assign %exWire_rs1Data, %415 : i32
    %416 = sv.read_inout %exStage_0_rs2Data : !hw.inout<i32>
    %417 = sv.read_inout %exStage_1_rs2Data : !hw.inout<i32>
    %418 = sv.read_inout %exStage_2_rs2Data : !hw.inout<i32>
    %419 = sv.read_inout %exStage_3_rs2Data : !hw.inout<i32>
    %420 = hw.array_create %419, %418, %417, %416 : i32
    %421 = sv.wire {hw.verilogName = "_GEN_40"} : !hw.inout<array<4xi32>>
    sv.assign %421, %420 : !hw.array<4xi32>
    %422 = sv.read_inout %currentThread : !hw.inout<i2>
    %423 = sv.read_inout %421 : !hw.inout<array<4xi32>>
    %424 = hw.array_get %423[%422] : !hw.array<4xi32>, i2
    %exWire_rs2Data = sv.wire sym @sym_1288 {hw.verilogName = "exWire_rs2Data", sv.namehint = "alu.io_b"} : !hw.inout<i32>
    sv.assign %exWire_rs2Data, %424 : i32
    %425 = sv.read_inout %exStage_0_memAddr : !hw.inout<i32>
    %426 = sv.read_inout %exStage_1_memAddr : !hw.inout<i32>
    %427 = sv.read_inout %exStage_2_memAddr : !hw.inout<i32>
    %428 = sv.read_inout %exStage_3_memAddr : !hw.inout<i32>
    %429 = hw.array_create %428, %427, %426, %425 : i32
    %430 = sv.wire {hw.verilogName = "_GEN_41"} : !hw.inout<array<4xi32>>
    sv.assign %430, %429 : !hw.array<4xi32>
    %431 = sv.read_inout %currentThread : !hw.inout<i2>
    %432 = sv.read_inout %430 : !hw.inout<array<4xi32>>
    %433 = hw.array_get %432[%431] : !hw.array<4xi32>, i2
    %434 = sv.read_inout %exStage_0_memWdata : !hw.inout<i32>
    %435 = sv.read_inout %exStage_1_memWdata : !hw.inout<i32>
    %436 = sv.read_inout %exStage_2_memWdata : !hw.inout<i32>
    %437 = sv.read_inout %exStage_3_memWdata : !hw.inout<i32>
    %438 = hw.array_create %437, %436, %435, %434 : i32
    %439 = sv.wire {hw.verilogName = "_GEN_42"} : !hw.inout<array<4xi32>>
    sv.assign %439, %438 : !hw.array<4xi32>
    %440 = sv.read_inout %currentThread : !hw.inout<i2>
    %441 = sv.read_inout %439 : !hw.inout<array<4xi32>>
    %442 = hw.array_get %441[%440] : !hw.array<4xi32>, i2
    %443 = sv.read_inout %exStage_0_memRdata : !hw.inout<i32>
    %444 = sv.read_inout %exStage_1_memRdata : !hw.inout<i32>
    %445 = sv.read_inout %exStage_2_memRdata : !hw.inout<i32>
    %446 = sv.read_inout %exStage_3_memRdata : !hw.inout<i32>
    %447 = hw.array_create %446, %445, %444, %443 : i32
    %448 = sv.wire {hw.verilogName = "_GEN_43"} : !hw.inout<array<4xi32>>
    sv.assign %448, %447 : !hw.array<4xi32>
    %449 = sv.read_inout %currentThread : !hw.inout<i2>
    %450 = sv.read_inout %448 : !hw.inout<array<4xi32>>
    %451 = hw.array_get %450[%449] : !hw.array<4xi32>, i2
    %exWire_memRdata = sv.wire sym @sym_1291 {hw.verilogName = "exWire_memRdata"} : !hw.inout<i32>
    sv.assign %exWire_memRdata, %451 : i32
    %452 = sv.read_inout %exWire_isLoad : !hw.inout<i1>
    %453 = sv.read_inout %exWire_isStore : !hw.inout<i1>
    %454 = comb.or bin %452, %453 : i1
    %_T_3 = sv.wire {hw.verilogName = "_T_3"} : !hw.inout<i1>
    sv.assign %_T_3, %454 : i1
    %455 = sv.read_inout %exWire_rs1Data : !hw.inout<i32>
    %456 = comb.concat %false, %455 : i1, i32
    %457 = sv.read_inout %exWire_imm : !hw.inout<i32>
    %458 = comb.concat %false, %457 : i1, i32
    %459 = comb.add bin %456, %458 : i33
    %_exWire_memAddr_T = sv.wire sym @sym_1293 {hw.verilogName = "_exWire_memAddr_T"} : !hw.inout<i33>
    sv.assign %_exWire_memAddr_T, %459 : i33
    %460 = sv.read_inout %_exWire_memAddr_T : !hw.inout<i33>
    %461 = comb.extract %460 from 0 : (i33) -> i32
    %_exWire_memAddr_T_1 = sv.wire sym @sym_1294 {hw.verilogName = "_exWire_memAddr_T_1"} : !hw.inout<i32>
    sv.assign %_exWire_memAddr_T_1, %461 : i32
    %462 = sv.read_inout %_exWire_memAddr_T_1 : !hw.inout<i32>
    %463 = sv.read_inout %_T_3 : !hw.inout<i1>
    %464 = comb.mux bin %463, %462, %433 : i32
    %exWire_memAddr = sv.wire sym @sym_1289 {hw.verilogName = "exWire_memAddr"} : !hw.inout<i32>
    sv.assign %exWire_memAddr, %464 : i32
    %465 = sv.read_inout %exWire_rs2Data : !hw.inout<i32>
    %466 = sv.read_inout %_T_3 : !hw.inout<i1>
    %467 = comb.mux bin %466, %465, %442 : i32
    %exWire_memWdata = sv.wire sym @sym_1290 {hw.verilogName = "exWire_memWdata"} : !hw.inout<i32>
    sv.assign %exWire_memWdata, %467 : i32
    %468 = sv.read_inout %memStage_0_threadId : !hw.inout<i2>
    %469 = sv.read_inout %memStage_1_threadId : !hw.inout<i2>
    %470 = sv.read_inout %memStage_2_threadId : !hw.inout<i2>
    %471 = sv.read_inout %memStage_3_threadId : !hw.inout<i2>
    %472 = hw.array_create %471, %470, %469, %468 : i2
    %473 = sv.wire {hw.verilogName = "_GEN_44"} : !hw.inout<array<4xi2>>
    sv.assign %473, %472 : !hw.array<4xi2>
    %474 = sv.read_inout %currentThread : !hw.inout<i2>
    %475 = sv.read_inout %473 : !hw.inout<array<4xi2>>
    %476 = hw.array_get %475[%474] : !hw.array<4xi2>, i2
    %memWire_threadId = sv.wire sym @sym_1320 {hw.verilogName = "memWire_threadId"} : !hw.inout<i2>
    sv.assign %memWire_threadId, %476 : i2
    %477 = sv.read_inout %memStage_0_valid : !hw.inout<i1>
    %478 = sv.read_inout %memStage_1_valid : !hw.inout<i1>
    %479 = sv.read_inout %memStage_2_valid : !hw.inout<i1>
    %480 = sv.read_inout %memStage_3_valid : !hw.inout<i1>
    %481 = hw.array_create %480, %479, %478, %477 : i1
    %482 = sv.wire {hw.verilogName = "_GEN_45"} : !hw.inout<array<4xi1>>
    sv.assign %482, %481 : !hw.array<4xi1>
    %483 = sv.read_inout %currentThread : !hw.inout<i2>
    %484 = sv.read_inout %482 : !hw.inout<array<4xi1>>
    %485 = hw.array_get %484[%483] : !hw.array<4xi1>, i2
    %memWire_valid = sv.wire sym @sym_1321 {hw.verilogName = "memWire_valid"} : !hw.inout<i1>
    sv.assign %memWire_valid, %485 : i1
    %486 = sv.read_inout %memStage_0_pc : !hw.inout<i32>
    %487 = sv.read_inout %memStage_1_pc : !hw.inout<i32>
    %488 = sv.read_inout %memStage_2_pc : !hw.inout<i32>
    %489 = sv.read_inout %memStage_3_pc : !hw.inout<i32>
    %490 = hw.array_create %489, %488, %487, %486 : i32
    %491 = sv.wire {hw.verilogName = "_GEN_46"} : !hw.inout<array<4xi32>>
    sv.assign %491, %490 : !hw.array<4xi32>
    %492 = sv.read_inout %currentThread : !hw.inout<i2>
    %493 = sv.read_inout %491 : !hw.inout<array<4xi32>>
    %494 = hw.array_get %493[%492] : !hw.array<4xi32>, i2
    %memWire_pc = sv.wire sym @sym_1322 {hw.verilogName = "memWire_pc"} : !hw.inout<i32>
    sv.assign %memWire_pc, %494 : i32
    %495 = sv.read_inout %memStage_0_instr : !hw.inout<i32>
    %496 = sv.read_inout %memStage_1_instr : !hw.inout<i32>
    %497 = sv.read_inout %memStage_2_instr : !hw.inout<i32>
    %498 = sv.read_inout %memStage_3_instr : !hw.inout<i32>
    %499 = hw.array_create %498, %497, %496, %495 : i32
    %500 = sv.wire {hw.verilogName = "_GEN_47"} : !hw.inout<array<4xi32>>
    sv.assign %500, %499 : !hw.array<4xi32>
    %501 = sv.read_inout %currentThread : !hw.inout<i2>
    %502 = sv.read_inout %500 : !hw.inout<array<4xi32>>
    %503 = hw.array_get %502[%501] : !hw.array<4xi32>, i2
    %memWire_instr = sv.wire sym @sym_1323 {hw.verilogName = "memWire_instr"} : !hw.inout<i32>
    sv.assign %memWire_instr, %503 : i32
    %504 = sv.read_inout %memStage_0_isALU : !hw.inout<i1>
    %505 = sv.read_inout %memStage_1_isALU : !hw.inout<i1>
    %506 = sv.read_inout %memStage_2_isALU : !hw.inout<i1>
    %507 = sv.read_inout %memStage_3_isALU : !hw.inout<i1>
    %508 = hw.array_create %507, %506, %505, %504 : i1
    %509 = sv.wire {hw.verilogName = "_GEN_48"} : !hw.inout<array<4xi1>>
    sv.assign %509, %508 : !hw.array<4xi1>
    %510 = sv.read_inout %currentThread : !hw.inout<i2>
    %511 = sv.read_inout %509 : !hw.inout<array<4xi1>>
    %512 = hw.array_get %511[%510] : !hw.array<4xi1>, i2
    %memWire_isALU = sv.wire sym @sym_1324 {hw.verilogName = "memWire_isALU"} : !hw.inout<i1>
    sv.assign %memWire_isALU, %512 : i1
    %513 = sv.read_inout %memStage_0_isLoad : !hw.inout<i1>
    %514 = sv.read_inout %memStage_1_isLoad : !hw.inout<i1>
    %515 = sv.read_inout %memStage_2_isLoad : !hw.inout<i1>
    %516 = sv.read_inout %memStage_3_isLoad : !hw.inout<i1>
    %517 = hw.array_create %516, %515, %514, %513 : i1
    %518 = sv.wire {hw.verilogName = "_GEN_49"} : !hw.inout<array<4xi1>>
    sv.assign %518, %517 : !hw.array<4xi1>
    %519 = sv.read_inout %currentThread : !hw.inout<i2>
    %520 = sv.read_inout %518 : !hw.inout<array<4xi1>>
    %521 = hw.array_get %520[%519] : !hw.array<4xi1>, i2
    %memWire_isLoad = sv.wire sym @sym_1325 {hw.verilogName = "memWire_isLoad"} : !hw.inout<i1>
    sv.assign %memWire_isLoad, %521 : i1
    %522 = sv.read_inout %memStage_0_isStore : !hw.inout<i1>
    %523 = sv.read_inout %memStage_1_isStore : !hw.inout<i1>
    %524 = sv.read_inout %memStage_2_isStore : !hw.inout<i1>
    %525 = sv.read_inout %memStage_3_isStore : !hw.inout<i1>
    %526 = hw.array_create %525, %524, %523, %522 : i1
    %527 = sv.wire {hw.verilogName = "_GEN_50"} : !hw.inout<array<4xi1>>
    sv.assign %527, %526 : !hw.array<4xi1>
    %528 = sv.read_inout %currentThread : !hw.inout<i2>
    %529 = sv.read_inout %527 : !hw.inout<array<4xi1>>
    %530 = hw.array_get %529[%528] : !hw.array<4xi1>, i2
    %memWire_isStore = sv.wire sym @sym_1326 {hw.verilogName = "memWire_isStore"} : !hw.inout<i1>
    sv.assign %memWire_isStore, %530 : i1
    %531 = sv.read_inout %memStage_0_isBranch : !hw.inout<i1>
    %532 = sv.read_inout %memStage_1_isBranch : !hw.inout<i1>
    %533 = sv.read_inout %memStage_2_isBranch : !hw.inout<i1>
    %534 = sv.read_inout %memStage_3_isBranch : !hw.inout<i1>
    %535 = hw.array_create %534, %533, %532, %531 : i1
    %536 = sv.wire {hw.verilogName = "_GEN_51"} : !hw.inout<array<4xi1>>
    sv.assign %536, %535 : !hw.array<4xi1>
    %537 = sv.read_inout %currentThread : !hw.inout<i2>
    %538 = sv.read_inout %536 : !hw.inout<array<4xi1>>
    %539 = hw.array_get %538[%537] : !hw.array<4xi1>, i2
    %memWire_isBranch = sv.wire sym @sym_1327 {hw.verilogName = "memWire_isBranch"} : !hw.inout<i1>
    sv.assign %memWire_isBranch, %539 : i1
    %540 = sv.read_inout %memStage_0_isJAL : !hw.inout<i1>
    %541 = sv.read_inout %memStage_1_isJAL : !hw.inout<i1>
    %542 = sv.read_inout %memStage_2_isJAL : !hw.inout<i1>
    %543 = sv.read_inout %memStage_3_isJAL : !hw.inout<i1>
    %544 = hw.array_create %543, %542, %541, %540 : i1
    %545 = sv.wire {hw.verilogName = "_GEN_52"} : !hw.inout<array<4xi1>>
    sv.assign %545, %544 : !hw.array<4xi1>
    %546 = sv.read_inout %currentThread : !hw.inout<i2>
    %547 = sv.read_inout %545 : !hw.inout<array<4xi1>>
    %548 = hw.array_get %547[%546] : !hw.array<4xi1>, i2
    %memWire_isJAL = sv.wire sym @sym_1328 {hw.verilogName = "memWire_isJAL"} : !hw.inout<i1>
    sv.assign %memWire_isJAL, %548 : i1
    %549 = sv.read_inout %memStage_0_isJALR : !hw.inout<i1>
    %550 = sv.read_inout %memStage_1_isJALR : !hw.inout<i1>
    %551 = sv.read_inout %memStage_2_isJALR : !hw.inout<i1>
    %552 = sv.read_inout %memStage_3_isJALR : !hw.inout<i1>
    %553 = hw.array_create %552, %551, %550, %549 : i1
    %554 = sv.wire {hw.verilogName = "_GEN_53"} : !hw.inout<array<4xi1>>
    sv.assign %554, %553 : !hw.array<4xi1>
    %555 = sv.read_inout %currentThread : !hw.inout<i2>
    %556 = sv.read_inout %554 : !hw.inout<array<4xi1>>
    %557 = hw.array_get %556[%555] : !hw.array<4xi1>, i2
    %memWire_isJALR = sv.wire sym @sym_1329 {hw.verilogName = "memWire_isJALR"} : !hw.inout<i1>
    sv.assign %memWire_isJALR, %557 : i1
    %558 = sv.read_inout %memStage_0_isLUI : !hw.inout<i1>
    %559 = sv.read_inout %memStage_1_isLUI : !hw.inout<i1>
    %560 = sv.read_inout %memStage_2_isLUI : !hw.inout<i1>
    %561 = sv.read_inout %memStage_3_isLUI : !hw.inout<i1>
    %562 = hw.array_create %561, %560, %559, %558 : i1
    %563 = sv.wire {hw.verilogName = "_GEN_54"} : !hw.inout<array<4xi1>>
    sv.assign %563, %562 : !hw.array<4xi1>
    %564 = sv.read_inout %currentThread : !hw.inout<i2>
    %565 = sv.read_inout %563 : !hw.inout<array<4xi1>>
    %566 = hw.array_get %565[%564] : !hw.array<4xi1>, i2
    %memWire_isLUI = sv.wire sym @sym_1330 {hw.verilogName = "memWire_isLUI"} : !hw.inout<i1>
    sv.assign %memWire_isLUI, %566 : i1
    %567 = sv.read_inout %memStage_0_isAUIPC : !hw.inout<i1>
    %568 = sv.read_inout %memStage_1_isAUIPC : !hw.inout<i1>
    %569 = sv.read_inout %memStage_2_isAUIPC : !hw.inout<i1>
    %570 = sv.read_inout %memStage_3_isAUIPC : !hw.inout<i1>
    %571 = hw.array_create %570, %569, %568, %567 : i1
    %572 = sv.wire {hw.verilogName = "_GEN_55"} : !hw.inout<array<4xi1>>
    sv.assign %572, %571 : !hw.array<4xi1>
    %573 = sv.read_inout %currentThread : !hw.inout<i2>
    %574 = sv.read_inout %572 : !hw.inout<array<4xi1>>
    %575 = hw.array_get %574[%573] : !hw.array<4xi1>, i2
    %memWire_isAUIPC = sv.wire sym @sym_1331 {hw.verilogName = "memWire_isAUIPC"} : !hw.inout<i1>
    sv.assign %memWire_isAUIPC, %575 : i1
    %576 = sv.read_inout %memStage_0_isFence : !hw.inout<i1>
    %577 = sv.read_inout %memStage_1_isFence : !hw.inout<i1>
    %578 = sv.read_inout %memStage_2_isFence : !hw.inout<i1>
    %579 = sv.read_inout %memStage_3_isFence : !hw.inout<i1>
    %580 = hw.array_create %579, %578, %577, %576 : i1
    %581 = sv.wire {hw.verilogName = "_GEN_56"} : !hw.inout<array<4xi1>>
    sv.assign %581, %580 : !hw.array<4xi1>
    %582 = sv.read_inout %currentThread : !hw.inout<i2>
    %583 = sv.read_inout %581 : !hw.inout<array<4xi1>>
    %584 = hw.array_get %583[%582] : !hw.array<4xi1>, i2
    %memWire_isFence = sv.wire sym @sym_1332 {hw.verilogName = "memWire_isFence"} : !hw.inout<i1>
    sv.assign %memWire_isFence, %584 : i1
    %585 = sv.read_inout %memStage_0_isSystem : !hw.inout<i1>
    %586 = sv.read_inout %memStage_1_isSystem : !hw.inout<i1>
    %587 = sv.read_inout %memStage_2_isSystem : !hw.inout<i1>
    %588 = sv.read_inout %memStage_3_isSystem : !hw.inout<i1>
    %589 = hw.array_create %588, %587, %586, %585 : i1
    %590 = sv.wire {hw.verilogName = "_GEN_57"} : !hw.inout<array<4xi1>>
    sv.assign %590, %589 : !hw.array<4xi1>
    %591 = sv.read_inout %currentThread : !hw.inout<i2>
    %592 = sv.read_inout %590 : !hw.inout<array<4xi1>>
    %593 = hw.array_get %592[%591] : !hw.array<4xi1>, i2
    %memWire_isSystem = sv.wire sym @sym_1333 {hw.verilogName = "memWire_isSystem"} : !hw.inout<i1>
    sv.assign %memWire_isSystem, %593 : i1
    %594 = sv.read_inout %memStage_0_aluOp : !hw.inout<i5>
    %595 = sv.read_inout %memStage_1_aluOp : !hw.inout<i5>
    %596 = sv.read_inout %memStage_2_aluOp : !hw.inout<i5>
    %597 = sv.read_inout %memStage_3_aluOp : !hw.inout<i5>
    %598 = hw.array_create %597, %596, %595, %594 : i5
    %599 = sv.wire {hw.verilogName = "_GEN_58"} : !hw.inout<array<4xi5>>
    sv.assign %599, %598 : !hw.array<4xi5>
    %600 = sv.read_inout %currentThread : !hw.inout<i2>
    %601 = sv.read_inout %599 : !hw.inout<array<4xi5>>
    %602 = hw.array_get %601[%600] : !hw.array<4xi5>, i2
    %memWire_aluOp = sv.wire sym @sym_1334 {hw.verilogName = "memWire_aluOp"} : !hw.inout<i5>
    sv.assign %memWire_aluOp, %602 : i5
    %603 = sv.read_inout %memStage_0_imm : !hw.inout<i32>
    %604 = sv.read_inout %memStage_1_imm : !hw.inout<i32>
    %605 = sv.read_inout %memStage_2_imm : !hw.inout<i32>
    %606 = sv.read_inout %memStage_3_imm : !hw.inout<i32>
    %607 = hw.array_create %606, %605, %604, %603 : i32
    %608 = sv.wire {hw.verilogName = "_GEN_59"} : !hw.inout<array<4xi32>>
    sv.assign %608, %607 : !hw.array<4xi32>
    %609 = sv.read_inout %currentThread : !hw.inout<i2>
    %610 = sv.read_inout %608 : !hw.inout<array<4xi32>>
    %611 = hw.array_get %610[%609] : !hw.array<4xi32>, i2
    %memWire_imm = sv.wire sym @sym_1335 {hw.verilogName = "memWire_imm"} : !hw.inout<i32>
    sv.assign %memWire_imm, %611 : i32
    %612 = sv.read_inout %memStage_0_rs1 : !hw.inout<i5>
    %613 = sv.read_inout %memStage_1_rs1 : !hw.inout<i5>
    %614 = sv.read_inout %memStage_2_rs1 : !hw.inout<i5>
    %615 = sv.read_inout %memStage_3_rs1 : !hw.inout<i5>
    %616 = hw.array_create %615, %614, %613, %612 : i5
    %617 = sv.wire {hw.verilogName = "_GEN_60"} : !hw.inout<array<4xi5>>
    sv.assign %617, %616 : !hw.array<4xi5>
    %618 = sv.read_inout %currentThread : !hw.inout<i2>
    %619 = sv.read_inout %617 : !hw.inout<array<4xi5>>
    %620 = hw.array_get %619[%618] : !hw.array<4xi5>, i2
    %memWire_rs1 = sv.wire sym @sym_1336 {hw.verilogName = "memWire_rs1"} : !hw.inout<i5>
    sv.assign %memWire_rs1, %620 : i5
    %621 = sv.read_inout %memStage_0_rs2 : !hw.inout<i5>
    %622 = sv.read_inout %memStage_1_rs2 : !hw.inout<i5>
    %623 = sv.read_inout %memStage_2_rs2 : !hw.inout<i5>
    %624 = sv.read_inout %memStage_3_rs2 : !hw.inout<i5>
    %625 = hw.array_create %624, %623, %622, %621 : i5
    %626 = sv.wire {hw.verilogName = "_GEN_61"} : !hw.inout<array<4xi5>>
    sv.assign %626, %625 : !hw.array<4xi5>
    %627 = sv.read_inout %currentThread : !hw.inout<i2>
    %628 = sv.read_inout %626 : !hw.inout<array<4xi5>>
    %629 = hw.array_get %628[%627] : !hw.array<4xi5>, i2
    %memWire_rs2 = sv.wire sym @sym_1337 {hw.verilogName = "memWire_rs2"} : !hw.inout<i5>
    sv.assign %memWire_rs2, %629 : i5
    %630 = sv.read_inout %memStage_0_rd : !hw.inout<i5>
    %631 = sv.read_inout %memStage_1_rd : !hw.inout<i5>
    %632 = sv.read_inout %memStage_2_rd : !hw.inout<i5>
    %633 = sv.read_inout %memStage_3_rd : !hw.inout<i5>
    %634 = hw.array_create %633, %632, %631, %630 : i5
    %635 = sv.wire {hw.verilogName = "_GEN_62"} : !hw.inout<array<4xi5>>
    sv.assign %635, %634 : !hw.array<4xi5>
    %636 = sv.read_inout %currentThread : !hw.inout<i2>
    %637 = sv.read_inout %635 : !hw.inout<array<4xi5>>
    %638 = hw.array_get %637[%636] : !hw.array<4xi5>, i2
    %memWire_rd = sv.wire sym @sym_1338 {hw.verilogName = "memWire_rd", sv.namehint = "memWire_rd"} : !hw.inout<i5>
    sv.assign %memWire_rd, %638 : i5
    %639 = sv.read_inout %memStage_0_rs1Data : !hw.inout<i32>
    %640 = sv.read_inout %memStage_1_rs1Data : !hw.inout<i32>
    %641 = sv.read_inout %memStage_2_rs1Data : !hw.inout<i32>
    %642 = sv.read_inout %memStage_3_rs1Data : !hw.inout<i32>
    %643 = hw.array_create %642, %641, %640, %639 : i32
    %644 = sv.wire {hw.verilogName = "_GEN_63"} : !hw.inout<array<4xi32>>
    sv.assign %644, %643 : !hw.array<4xi32>
    %645 = sv.read_inout %currentThread : !hw.inout<i2>
    %646 = sv.read_inout %644 : !hw.inout<array<4xi32>>
    %647 = hw.array_get %646[%645] : !hw.array<4xi32>, i2
    %memWire_rs1Data = sv.wire sym @sym_1339 {hw.verilogName = "memWire_rs1Data"} : !hw.inout<i32>
    sv.assign %memWire_rs1Data, %647 : i32
    %648 = sv.read_inout %memStage_0_rs2Data : !hw.inout<i32>
    %649 = sv.read_inout %memStage_1_rs2Data : !hw.inout<i32>
    %650 = sv.read_inout %memStage_2_rs2Data : !hw.inout<i32>
    %651 = sv.read_inout %memStage_3_rs2Data : !hw.inout<i32>
    %652 = hw.array_create %651, %650, %649, %648 : i32
    %653 = sv.wire {hw.verilogName = "_GEN_64"} : !hw.inout<array<4xi32>>
    sv.assign %653, %652 : !hw.array<4xi32>
    %654 = sv.read_inout %currentThread : !hw.inout<i2>
    %655 = sv.read_inout %653 : !hw.inout<array<4xi32>>
    %656 = hw.array_get %655[%654] : !hw.array<4xi32>, i2
    %memWire_rs2Data = sv.wire sym @sym_1340 {hw.verilogName = "memWire_rs2Data"} : !hw.inout<i32>
    sv.assign %memWire_rs2Data, %656 : i32
    %657 = sv.read_inout %memStage_0_memAddr : !hw.inout<i32>
    %658 = sv.read_inout %memStage_1_memAddr : !hw.inout<i32>
    %659 = sv.read_inout %memStage_2_memAddr : !hw.inout<i32>
    %660 = sv.read_inout %memStage_3_memAddr : !hw.inout<i32>
    %661 = hw.array_create %660, %659, %658, %657 : i32
    %662 = sv.wire {hw.verilogName = "_GEN_65"} : !hw.inout<array<4xi32>>
    sv.assign %662, %661 : !hw.array<4xi32>
    %663 = sv.read_inout %currentThread : !hw.inout<i2>
    %664 = sv.read_inout %662 : !hw.inout<array<4xi32>>
    %665 = hw.array_get %664[%663] : !hw.array<4xi32>, i2
    sv.assign %memWire_memAddr, %665 : i32
    %666 = sv.read_inout %memStage_0_memWdata : !hw.inout<i32>
    %667 = sv.read_inout %memStage_1_memWdata : !hw.inout<i32>
    %668 = sv.read_inout %memStage_2_memWdata : !hw.inout<i32>
    %669 = sv.read_inout %memStage_3_memWdata : !hw.inout<i32>
    %670 = hw.array_create %669, %668, %667, %666 : i32
    %671 = sv.wire {hw.verilogName = "_GEN_66"} : !hw.inout<array<4xi32>>
    sv.assign %671, %670 : !hw.array<4xi32>
    %672 = sv.read_inout %currentThread : !hw.inout<i2>
    %673 = sv.read_inout %671 : !hw.inout<array<4xi32>>
    %674 = hw.array_get %673[%672] : !hw.array<4xi32>, i2
    sv.assign %memWire_memWdata, %674 : i32
    %675 = sv.read_inout %memStage_0_aluResult : !hw.inout<i32>
    %676 = sv.read_inout %memStage_1_aluResult : !hw.inout<i32>
    %677 = sv.read_inout %memStage_2_aluResult : !hw.inout<i32>
    %678 = sv.read_inout %memStage_3_aluResult : !hw.inout<i32>
    %679 = hw.array_create %678, %677, %676, %675 : i32
    %680 = sv.wire {hw.verilogName = "_GEN_67"} : !hw.inout<array<4xi32>>
    sv.assign %680, %679 : !hw.array<4xi32>
    %681 = sv.read_inout %currentThread : !hw.inout<i2>
    %682 = sv.read_inout %680 : !hw.inout<array<4xi32>>
    %683 = hw.array_get %682[%681] : !hw.array<4xi32>, i2
    %memWire_aluResult = sv.wire sym @sym_1344 {hw.verilogName = "memWire_aluResult"} : !hw.inout<i32>
    sv.assign %memWire_aluResult, %683 : i32
    %684 = sv.read_inout %memWire_memAddr : !hw.inout<i32>
    %io_memAddr = sv.wire sym @sym {hw.verilogName = "io_memAddr_0"} : !hw.inout<i32>
    sv.assign %io_memAddr, %684 : i32
    %685 = sv.read_inout %memWire_memWdata : !hw.inout<i32>
    %io_memWdata = sv.wire sym @sym_0 {hw.verilogName = "io_memWdata_0"} : !hw.inout<i32>
    sv.assign %io_memWdata, %685 : i32
    %686 = sv.read_inout %memWire_valid : !hw.inout<i1>
    %687 = sv.read_inout %memWire_isStore : !hw.inout<i1>
    %688 = comb.and bin %687, %686 : i1
    sv.assign %_io_memWe_T, %688 : i1
    %689 = sv.read_inout %_io_memWe_T : !hw.inout<i1>
    %io_memWe = sv.wire sym @sym_2 {hw.verilogName = "io_memWe_0"} : !hw.inout<i1>
    sv.assign %io_memWe, %689 : i1
    %690 = sv.read_inout %memWire_memRdata : !hw.inout<i32>
    %691 = sv.read_inout %memWire_isLoad : !hw.inout<i1>
    %692 = sv.read_inout %memWire_aluResult : !hw.inout<i32>
    %693 = comb.mux bin %691, %690, %692 : i32
    %wbData = sv.wire sym @sym_1346 {hw.verilogName = "wbData", sv.namehint = "wbData"} : !hw.inout<i32>
    sv.assign %wbData, %693 : i32
    %694 = sv.read_inout %memWire_rd : !hw.inout<i5>
    %695 = comb.icmp bin ne %694, %c0_i5 : i5
    %_regFile_io_wen_T = sv.wire sym @sym_1347 {hw.verilogName = "_regFile_io_wen_T"} : !hw.inout<i1>
    sv.assign %_regFile_io_wen_T, %695 : i1
    %696 = sv.read_inout %_regFile_io_wen_T : !hw.inout<i1>
    %697 = sv.read_inout %memWire_valid : !hw.inout<i1>
    %698 = comb.and bin %697, %696 : i1
    %_regFile_io_wen_T_1 = sv.wire sym @sym_1348 {hw.verilogName = "_regFile_io_wen_T_1"} : !hw.inout<i1>
    sv.assign %_regFile_io_wen_T_1, %698 : i1
    %699 = sv.read_inout %memWire_isALU : !hw.inout<i1>
    %700 = sv.read_inout %memWire_isLoad : !hw.inout<i1>
    %701 = comb.or bin %700, %699 : i1
    %_regFile_io_wen_T_2 = sv.wire sym @sym_1349 {hw.verilogName = "_regFile_io_wen_T_2"} : !hw.inout<i1>
    sv.assign %_regFile_io_wen_T_2, %701 : i1
    %702 = sv.read_inout %_regFile_io_wen_T_1 : !hw.inout<i1>
    %703 = sv.read_inout %_regFile_io_wen_T_2 : !hw.inout<i1>
    %704 = comb.and bin %702, %703 : i1
    %_regFile_io_wen_T_3 = sv.wire sym @sym_1350 {hw.verilogName = "_regFile_io_wen_T_3", sv.namehint = "regFile.io_wen"} : !hw.inout<i1>
    sv.assign %_regFile_io_wen_T_3, %704 : i1
    %ifWire_instr = sv.wire sym @sym_1162 {hw.verilogName = "ifWire_instr"} : !hw.inout<i32>
    %decWire_rs1Data = sv.wire sym @sym_1233 {hw.verilogName = "decWire_rs1Data"} : !hw.inout<i32>
    %decWire_rs2Data = sv.wire sym @sym_1234 {hw.verilogName = "decWire_rs2Data"} : !hw.inout<i32>
    %exWire_aluResult = sv.wire sym @sym_1292 {hw.verilogName = "exWire_aluResult"} : !hw.inout<i32>
    sv.always posedge %clock {
      sv.if %reset {
        %c0_i2_5 = hw.constant 0 : i2
        %false_6 = hw.constant false
        %c0_i5_7 = hw.constant 0 : i5
        %c0_i32_8 = hw.constant 0 : i32
        sv.passign %currentThread, %c0_i2_5 : i2
        sv.passign %pcRegs_0, %c0_i32_8 : i32
        sv.passign %pcRegs_1, %c0_i32_8 : i32
        sv.passign %pcRegs_2, %c0_i32_8 : i32
        sv.passign %pcRegs_3, %c0_i32_8 : i32
        sv.passign %ifStage_0_threadId, %c0_i2_5 : i2
        sv.passign %ifStage_0_valid, %false_6 : i1
        sv.passign %ifStage_0_pc, %c0_i32_8 : i32
        sv.passign %ifStage_0_instr, %c0_i32_8 : i32
        sv.passign %ifStage_1_threadId, %c0_i2_5 : i2
        sv.passign %ifStage_1_valid, %false_6 : i1
        sv.passign %ifStage_1_pc, %c0_i32_8 : i32
        sv.passign %ifStage_1_instr, %c0_i32_8 : i32
        sv.passign %ifStage_2_threadId, %c0_i2_5 : i2
        sv.passign %ifStage_2_valid, %false_6 : i1
        sv.passign %ifStage_2_pc, %c0_i32_8 : i32
        sv.passign %ifStage_2_instr, %c0_i32_8 : i32
        sv.passign %ifStage_3_threadId, %c0_i2_5 : i2
        sv.passign %ifStage_3_valid, %false_6 : i1
        sv.passign %ifStage_3_pc, %c0_i32_8 : i32
        sv.passign %ifStage_3_instr, %c0_i32_8 : i32
        sv.passign %decStage_0_threadId, %c0_i2_5 : i2
        sv.passign %decStage_0_valid, %false_6 : i1
        sv.passign %decStage_0_pc, %c0_i32_8 : i32
        sv.passign %decStage_0_instr, %c0_i32_8 : i32
        sv.passign %decStage_0_isALU, %false_6 : i1
        sv.passign %decStage_0_isLoad, %false_6 : i1
        sv.passign %decStage_0_isStore, %false_6 : i1
        sv.passign %decStage_0_isBranch, %false_6 : i1
        sv.passign %decStage_0_isJAL, %false_6 : i1
        sv.passign %decStage_0_isJALR, %false_6 : i1
        sv.passign %decStage_0_isLUI, %false_6 : i1
        sv.passign %decStage_0_isAUIPC, %false_6 : i1
        sv.passign %decStage_0_isFence, %false_6 : i1
        sv.passign %decStage_0_isSystem, %false_6 : i1
        sv.passign %decStage_0_aluOp, %c0_i5_7 : i5
        sv.passign %decStage_0_imm, %c0_i32_8 : i32
        sv.passign %decStage_0_rs1, %c0_i5_7 : i5
        sv.passign %decStage_0_rs2, %c0_i5_7 : i5
        sv.passign %decStage_0_rd, %c0_i5_7 : i5
        sv.passign %decStage_0_rs1Data, %c0_i32_8 : i32
        sv.passign %decStage_0_rs2Data, %c0_i32_8 : i32
        sv.passign %decStage_0_memAddr, %c0_i32_8 : i32
        sv.passign %decStage_0_memWdata, %c0_i32_8 : i32
        sv.passign %decStage_0_memRdata, %c0_i32_8 : i32
        sv.passign %decStage_0_aluResult, %c0_i32_8 : i32
        sv.passign %decStage_1_threadId, %c0_i2_5 : i2
        sv.passign %decStage_1_valid, %false_6 : i1
        sv.passign %decStage_1_pc, %c0_i32_8 : i32
        sv.passign %decStage_1_instr, %c0_i32_8 : i32
        sv.passign %decStage_1_isALU, %false_6 : i1
        sv.passign %decStage_1_isLoad, %false_6 : i1
        sv.passign %decStage_1_isStore, %false_6 : i1
        sv.passign %decStage_1_isBranch, %false_6 : i1
        sv.passign %decStage_1_isJAL, %false_6 : i1
        sv.passign %decStage_1_isJALR, %false_6 : i1
        sv.passign %decStage_1_isLUI, %false_6 : i1
        sv.passign %decStage_1_isAUIPC, %false_6 : i1
        sv.passign %decStage_1_isFence, %false_6 : i1
        sv.passign %decStage_1_isSystem, %false_6 : i1
        sv.passign %decStage_1_aluOp, %c0_i5_7 : i5
        sv.passign %decStage_1_imm, %c0_i32_8 : i32
        sv.passign %decStage_1_rs1, %c0_i5_7 : i5
        sv.passign %decStage_1_rs2, %c0_i5_7 : i5
        sv.passign %decStage_1_rd, %c0_i5_7 : i5
        sv.passign %decStage_1_rs1Data, %c0_i32_8 : i32
        sv.passign %decStage_1_rs2Data, %c0_i32_8 : i32
        sv.passign %decStage_1_memAddr, %c0_i32_8 : i32
        sv.passign %decStage_1_memWdata, %c0_i32_8 : i32
        sv.passign %decStage_1_memRdata, %c0_i32_8 : i32
        sv.passign %decStage_1_aluResult, %c0_i32_8 : i32
        sv.passign %decStage_2_threadId, %c0_i2_5 : i2
        sv.passign %decStage_2_valid, %false_6 : i1
        sv.passign %decStage_2_pc, %c0_i32_8 : i32
        sv.passign %decStage_2_instr, %c0_i32_8 : i32
        sv.passign %decStage_2_isALU, %false_6 : i1
        sv.passign %decStage_2_isLoad, %false_6 : i1
        sv.passign %decStage_2_isStore, %false_6 : i1
        sv.passign %decStage_2_isBranch, %false_6 : i1
        sv.passign %decStage_2_isJAL, %false_6 : i1
        sv.passign %decStage_2_isJALR, %false_6 : i1
        sv.passign %decStage_2_isLUI, %false_6 : i1
        sv.passign %decStage_2_isAUIPC, %false_6 : i1
        sv.passign %decStage_2_isFence, %false_6 : i1
        sv.passign %decStage_2_isSystem, %false_6 : i1
        sv.passign %decStage_2_aluOp, %c0_i5_7 : i5
        sv.passign %decStage_2_imm, %c0_i32_8 : i32
        sv.passign %decStage_2_rs1, %c0_i5_7 : i5
        sv.passign %decStage_2_rs2, %c0_i5_7 : i5
        sv.passign %decStage_2_rd, %c0_i5_7 : i5
        sv.passign %decStage_2_rs1Data, %c0_i32_8 : i32
        sv.passign %decStage_2_rs2Data, %c0_i32_8 : i32
        sv.passign %decStage_2_memAddr, %c0_i32_8 : i32
        sv.passign %decStage_2_memWdata, %c0_i32_8 : i32
        sv.passign %decStage_2_memRdata, %c0_i32_8 : i32
        sv.passign %decStage_2_aluResult, %c0_i32_8 : i32
        sv.passign %decStage_3_threadId, %c0_i2_5 : i2
        sv.passign %decStage_3_valid, %false_6 : i1
        sv.passign %decStage_3_pc, %c0_i32_8 : i32
        sv.passign %decStage_3_instr, %c0_i32_8 : i32
        sv.passign %decStage_3_isALU, %false_6 : i1
        sv.passign %decStage_3_isLoad, %false_6 : i1
        sv.passign %decStage_3_isStore, %false_6 : i1
        sv.passign %decStage_3_isBranch, %false_6 : i1
        sv.passign %decStage_3_isJAL, %false_6 : i1
        sv.passign %decStage_3_isJALR, %false_6 : i1
        sv.passign %decStage_3_isLUI, %false_6 : i1
        sv.passign %decStage_3_isAUIPC, %false_6 : i1
        sv.passign %decStage_3_isFence, %false_6 : i1
        sv.passign %decStage_3_isSystem, %false_6 : i1
        sv.passign %decStage_3_aluOp, %c0_i5_7 : i5
        sv.passign %decStage_3_imm, %c0_i32_8 : i32
        sv.passign %decStage_3_rs1, %c0_i5_7 : i5
        sv.passign %decStage_3_rs2, %c0_i5_7 : i5
        sv.passign %decStage_3_rd, %c0_i5_7 : i5
        sv.passign %decStage_3_rs1Data, %c0_i32_8 : i32
        sv.passign %decStage_3_rs2Data, %c0_i32_8 : i32
        sv.passign %decStage_3_memAddr, %c0_i32_8 : i32
        sv.passign %decStage_3_memWdata, %c0_i32_8 : i32
        sv.passign %decStage_3_memRdata, %c0_i32_8 : i32
        sv.passign %decStage_3_aluResult, %c0_i32_8 : i32
        sv.passign %exStage_0_threadId, %c0_i2_5 : i2
        sv.passign %exStage_0_valid, %false_6 : i1
        sv.passign %exStage_0_pc, %c0_i32_8 : i32
        sv.passign %exStage_0_instr, %c0_i32_8 : i32
        sv.passign %exStage_0_isALU, %false_6 : i1
        sv.passign %exStage_0_isLoad, %false_6 : i1
        sv.passign %exStage_0_isStore, %false_6 : i1
        sv.passign %exStage_0_isBranch, %false_6 : i1
        sv.passign %exStage_0_isJAL, %false_6 : i1
        sv.passign %exStage_0_isJALR, %false_6 : i1
        sv.passign %exStage_0_isLUI, %false_6 : i1
        sv.passign %exStage_0_isAUIPC, %false_6 : i1
        sv.passign %exStage_0_isFence, %false_6 : i1
        sv.passign %exStage_0_isSystem, %false_6 : i1
        sv.passign %exStage_0_aluOp, %c0_i5_7 : i5
        sv.passign %exStage_0_imm, %c0_i32_8 : i32
        sv.passign %exStage_0_rs1, %c0_i5_7 : i5
        sv.passign %exStage_0_rs2, %c0_i5_7 : i5
        sv.passign %exStage_0_rd, %c0_i5_7 : i5
        sv.passign %exStage_0_rs1Data, %c0_i32_8 : i32
        sv.passign %exStage_0_rs2Data, %c0_i32_8 : i32
        sv.passign %exStage_0_memAddr, %c0_i32_8 : i32
        sv.passign %exStage_0_memWdata, %c0_i32_8 : i32
        sv.passign %exStage_0_memRdata, %c0_i32_8 : i32
        sv.passign %exStage_0_aluResult, %c0_i32_8 : i32
        sv.passign %exStage_1_threadId, %c0_i2_5 : i2
        sv.passign %exStage_1_valid, %false_6 : i1
        sv.passign %exStage_1_pc, %c0_i32_8 : i32
        sv.passign %exStage_1_instr, %c0_i32_8 : i32
        sv.passign %exStage_1_isALU, %false_6 : i1
        sv.passign %exStage_1_isLoad, %false_6 : i1
        sv.passign %exStage_1_isStore, %false_6 : i1
        sv.passign %exStage_1_isBranch, %false_6 : i1
        sv.passign %exStage_1_isJAL, %false_6 : i1
        sv.passign %exStage_1_isJALR, %false_6 : i1
        sv.passign %exStage_1_isLUI, %false_6 : i1
        sv.passign %exStage_1_isAUIPC, %false_6 : i1
        sv.passign %exStage_1_isFence, %false_6 : i1
        sv.passign %exStage_1_isSystem, %false_6 : i1
        sv.passign %exStage_1_aluOp, %c0_i5_7 : i5
        sv.passign %exStage_1_imm, %c0_i32_8 : i32
        sv.passign %exStage_1_rs1, %c0_i5_7 : i5
        sv.passign %exStage_1_rs2, %c0_i5_7 : i5
        sv.passign %exStage_1_rd, %c0_i5_7 : i5
        sv.passign %exStage_1_rs1Data, %c0_i32_8 : i32
        sv.passign %exStage_1_rs2Data, %c0_i32_8 : i32
        sv.passign %exStage_1_memAddr, %c0_i32_8 : i32
        sv.passign %exStage_1_memWdata, %c0_i32_8 : i32
        sv.passign %exStage_1_memRdata, %c0_i32_8 : i32
        sv.passign %exStage_1_aluResult, %c0_i32_8 : i32
        sv.passign %exStage_2_threadId, %c0_i2_5 : i2
        sv.passign %exStage_2_valid, %false_6 : i1
        sv.passign %exStage_2_pc, %c0_i32_8 : i32
        sv.passign %exStage_2_instr, %c0_i32_8 : i32
        sv.passign %exStage_2_isALU, %false_6 : i1
        sv.passign %exStage_2_isLoad, %false_6 : i1
        sv.passign %exStage_2_isStore, %false_6 : i1
        sv.passign %exStage_2_isBranch, %false_6 : i1
        sv.passign %exStage_2_isJAL, %false_6 : i1
        sv.passign %exStage_2_isJALR, %false_6 : i1
        sv.passign %exStage_2_isLUI, %false_6 : i1
        sv.passign %exStage_2_isAUIPC, %false_6 : i1
        sv.passign %exStage_2_isFence, %false_6 : i1
        sv.passign %exStage_2_isSystem, %false_6 : i1
        sv.passign %exStage_2_aluOp, %c0_i5_7 : i5
        sv.passign %exStage_2_imm, %c0_i32_8 : i32
        sv.passign %exStage_2_rs1, %c0_i5_7 : i5
        sv.passign %exStage_2_rs2, %c0_i5_7 : i5
        sv.passign %exStage_2_rd, %c0_i5_7 : i5
        sv.passign %exStage_2_rs1Data, %c0_i32_8 : i32
        sv.passign %exStage_2_rs2Data, %c0_i32_8 : i32
        sv.passign %exStage_2_memAddr, %c0_i32_8 : i32
        sv.passign %exStage_2_memWdata, %c0_i32_8 : i32
        sv.passign %exStage_2_memRdata, %c0_i32_8 : i32
        sv.passign %exStage_2_aluResult, %c0_i32_8 : i32
        sv.passign %exStage_3_threadId, %c0_i2_5 : i2
        sv.passign %exStage_3_valid, %false_6 : i1
        sv.passign %exStage_3_pc, %c0_i32_8 : i32
        sv.passign %exStage_3_instr, %c0_i32_8 : i32
        sv.passign %exStage_3_isALU, %false_6 : i1
        sv.passign %exStage_3_isLoad, %false_6 : i1
        sv.passign %exStage_3_isStore, %false_6 : i1
        sv.passign %exStage_3_isBranch, %false_6 : i1
        sv.passign %exStage_3_isJAL, %false_6 : i1
        sv.passign %exStage_3_isJALR, %false_6 : i1
        sv.passign %exStage_3_isLUI, %false_6 : i1
        sv.passign %exStage_3_isAUIPC, %false_6 : i1
        sv.passign %exStage_3_isFence, %false_6 : i1
        sv.passign %exStage_3_isSystem, %false_6 : i1
        sv.passign %exStage_3_aluOp, %c0_i5_7 : i5
        sv.passign %exStage_3_imm, %c0_i32_8 : i32
        sv.passign %exStage_3_rs1, %c0_i5_7 : i5
        sv.passign %exStage_3_rs2, %c0_i5_7 : i5
        sv.passign %exStage_3_rd, %c0_i5_7 : i5
        sv.passign %exStage_3_rs1Data, %c0_i32_8 : i32
        sv.passign %exStage_3_rs2Data, %c0_i32_8 : i32
        sv.passign %exStage_3_memAddr, %c0_i32_8 : i32
        sv.passign %exStage_3_memWdata, %c0_i32_8 : i32
        sv.passign %exStage_3_memRdata, %c0_i32_8 : i32
        sv.passign %exStage_3_aluResult, %c0_i32_8 : i32
        sv.passign %memStage_0_threadId, %c0_i2_5 : i2
        sv.passign %memStage_0_valid, %false_6 : i1
        sv.passign %memStage_0_pc, %c0_i32_8 : i32
        sv.passign %memStage_0_instr, %c0_i32_8 : i32
        sv.passign %memStage_0_isALU, %false_6 : i1
        sv.passign %memStage_0_isLoad, %false_6 : i1
        sv.passign %memStage_0_isStore, %false_6 : i1
        sv.passign %memStage_0_isBranch, %false_6 : i1
        sv.passign %memStage_0_isJAL, %false_6 : i1
        sv.passign %memStage_0_isJALR, %false_6 : i1
        sv.passign %memStage_0_isLUI, %false_6 : i1
        sv.passign %memStage_0_isAUIPC, %false_6 : i1
        sv.passign %memStage_0_isFence, %false_6 : i1
        sv.passign %memStage_0_isSystem, %false_6 : i1
        sv.passign %memStage_0_aluOp, %c0_i5_7 : i5
        sv.passign %memStage_0_imm, %c0_i32_8 : i32
        sv.passign %memStage_0_rs1, %c0_i5_7 : i5
        sv.passign %memStage_0_rs2, %c0_i5_7 : i5
        sv.passign %memStage_0_rd, %c0_i5_7 : i5
        sv.passign %memStage_0_rs1Data, %c0_i32_8 : i32
        sv.passign %memStage_0_rs2Data, %c0_i32_8 : i32
        sv.passign %memStage_0_memAddr, %c0_i32_8 : i32
        sv.passign %memStage_0_memWdata, %c0_i32_8 : i32
        sv.passign %memStage_0_memRdata, %c0_i32_8 : i32
        sv.passign %memStage_0_aluResult, %c0_i32_8 : i32
        sv.passign %memStage_1_threadId, %c0_i2_5 : i2
        sv.passign %memStage_1_valid, %false_6 : i1
        sv.passign %memStage_1_pc, %c0_i32_8 : i32
        sv.passign %memStage_1_instr, %c0_i32_8 : i32
        sv.passign %memStage_1_isALU, %false_6 : i1
        sv.passign %memStage_1_isLoad, %false_6 : i1
        sv.passign %memStage_1_isStore, %false_6 : i1
        sv.passign %memStage_1_isBranch, %false_6 : i1
        sv.passign %memStage_1_isJAL, %false_6 : i1
        sv.passign %memStage_1_isJALR, %false_6 : i1
        sv.passign %memStage_1_isLUI, %false_6 : i1
        sv.passign %memStage_1_isAUIPC, %false_6 : i1
        sv.passign %memStage_1_isFence, %false_6 : i1
        sv.passign %memStage_1_isSystem, %false_6 : i1
        sv.passign %memStage_1_aluOp, %c0_i5_7 : i5
        sv.passign %memStage_1_imm, %c0_i32_8 : i32
        sv.passign %memStage_1_rs1, %c0_i5_7 : i5
        sv.passign %memStage_1_rs2, %c0_i5_7 : i5
        sv.passign %memStage_1_rd, %c0_i5_7 : i5
        sv.passign %memStage_1_rs1Data, %c0_i32_8 : i32
        sv.passign %memStage_1_rs2Data, %c0_i32_8 : i32
        sv.passign %memStage_1_memAddr, %c0_i32_8 : i32
        sv.passign %memStage_1_memWdata, %c0_i32_8 : i32
        sv.passign %memStage_1_memRdata, %c0_i32_8 : i32
        sv.passign %memStage_1_aluResult, %c0_i32_8 : i32
        sv.passign %memStage_2_threadId, %c0_i2_5 : i2
        sv.passign %memStage_2_valid, %false_6 : i1
        sv.passign %memStage_2_pc, %c0_i32_8 : i32
        sv.passign %memStage_2_instr, %c0_i32_8 : i32
        sv.passign %memStage_2_isALU, %false_6 : i1
        sv.passign %memStage_2_isLoad, %false_6 : i1
        sv.passign %memStage_2_isStore, %false_6 : i1
        sv.passign %memStage_2_isBranch, %false_6 : i1
        sv.passign %memStage_2_isJAL, %false_6 : i1
        sv.passign %memStage_2_isJALR, %false_6 : i1
        sv.passign %memStage_2_isLUI, %false_6 : i1
        sv.passign %memStage_2_isAUIPC, %false_6 : i1
        sv.passign %memStage_2_isFence, %false_6 : i1
        sv.passign %memStage_2_isSystem, %false_6 : i1
        sv.passign %memStage_2_aluOp, %c0_i5_7 : i5
        sv.passign %memStage_2_imm, %c0_i32_8 : i32
        sv.passign %memStage_2_rs1, %c0_i5_7 : i5
        sv.passign %memStage_2_rs2, %c0_i5_7 : i5
        sv.passign %memStage_2_rd, %c0_i5_7 : i5
        sv.passign %memStage_2_rs1Data, %c0_i32_8 : i32
        sv.passign %memStage_2_rs2Data, %c0_i32_8 : i32
        sv.passign %memStage_2_memAddr, %c0_i32_8 : i32
        sv.passign %memStage_2_memWdata, %c0_i32_8 : i32
        sv.passign %memStage_2_memRdata, %c0_i32_8 : i32
        sv.passign %memStage_2_aluResult, %c0_i32_8 : i32
        sv.passign %memStage_3_threadId, %c0_i2_5 : i2
        sv.passign %memStage_3_valid, %false_6 : i1
        sv.passign %memStage_3_pc, %c0_i32_8 : i32
        sv.passign %memStage_3_instr, %c0_i32_8 : i32
        sv.passign %memStage_3_isALU, %false_6 : i1
        sv.passign %memStage_3_isLoad, %false_6 : i1
        sv.passign %memStage_3_isStore, %false_6 : i1
        sv.passign %memStage_3_isBranch, %false_6 : i1
        sv.passign %memStage_3_isJAL, %false_6 : i1
        sv.passign %memStage_3_isJALR, %false_6 : i1
        sv.passign %memStage_3_isLUI, %false_6 : i1
        sv.passign %memStage_3_isAUIPC, %false_6 : i1
        sv.passign %memStage_3_isFence, %false_6 : i1
        sv.passign %memStage_3_isSystem, %false_6 : i1
        sv.passign %memStage_3_aluOp, %c0_i5_7 : i5
        sv.passign %memStage_3_imm, %c0_i32_8 : i32
        sv.passign %memStage_3_rs1, %c0_i5_7 : i5
        sv.passign %memStage_3_rs2, %c0_i5_7 : i5
        sv.passign %memStage_3_rd, %c0_i5_7 : i5
        sv.passign %memStage_3_rs1Data, %c0_i32_8 : i32
        sv.passign %memStage_3_rs2Data, %c0_i32_8 : i32
        sv.passign %memStage_3_memAddr, %c0_i32_8 : i32
        sv.passign %memStage_3_memWdata, %c0_i32_8 : i32
        sv.passign %memStage_3_memRdata, %c0_i32_8 : i32
        sv.passign %memStage_3_aluResult, %c0_i32_8 : i32
      } else {
        %721 = sv.logic {hw.verilogName = "_GEN_68"} : !hw.inout<i1>
        %722 = sv.logic {hw.verilogName = "_GEN_69"} : !hw.inout<i1>
        %723 = sv.logic {hw.verilogName = "_GEN_70"} : !hw.inout<i1>
        %c1_i2 = hw.constant 1 : i2
        %c-2_i2 = hw.constant -2 : i2
        %c0_i2_5 = hw.constant 0 : i2
        %724 = sv.read_inout %currentThread : !hw.inout<i2>
        %725 = comb.icmp bin eq %724, %c0_i2_5 : i2
        sv.bpassign %721, %725 : i1
        %726 = sv.read_inout %currentThread : !hw.inout<i2>
        %727 = comb.icmp bin eq %726, %c1_i2 : i2
        sv.bpassign %722, %727 : i1
        %728 = sv.read_inout %currentThread : !hw.inout<i2>
        %729 = comb.icmp bin eq %728, %c-2_i2 : i2
        sv.bpassign %723, %729 : i1
        %730 = sv.read_inout %_currentThread_T_1 : !hw.inout<i2>
        sv.passign %currentThread, %730 : i2
        %731 = sv.read_inout %721 : !hw.inout<i1>
        sv.if %731 {
          %1049 = sv.read_inout %_pcRegs_T_1 : !hw.inout<i32>
          sv.passign %pcRegs_0, %1049 : i32
          %1050 = sv.read_inout %ifWire_threadId : !hw.inout<i2>
          sv.passign %ifStage_0_threadId, %1050 : i2
          %1051 = sv.read_inout %ifWire_pc : !hw.inout<i32>
          sv.passign %ifStage_0_pc, %1051 : i32
          %1052 = sv.read_inout %ifWire_instr : !hw.inout<i32>
          sv.passign %ifStage_0_instr, %1052 : i32
          %1053 = sv.read_inout %decWire_threadId : !hw.inout<i2>
          sv.passign %decStage_0_threadId, %1053 : i2
          %1054 = sv.read_inout %decWire_valid : !hw.inout<i1>
          sv.passign %decStage_0_valid, %1054 : i1
          %1055 = sv.read_inout %decWire_pc : !hw.inout<i32>
          sv.passign %decStage_0_pc, %1055 : i32
          %1056 = sv.read_inout %decWire_instr : !hw.inout<i32>
          sv.passign %decStage_0_instr, %1056 : i32
          %1057 = sv.read_inout %decWire_aluOp : !hw.inout<i5>
          sv.passign %decStage_0_aluOp, %1057 : i5
          %1058 = sv.read_inout %decWire_imm : !hw.inout<i32>
          sv.passign %decStage_0_imm, %1058 : i32
          %1059 = sv.read_inout %decWire_rs1 : !hw.inout<i5>
          sv.passign %decStage_0_rs1, %1059 : i5
          %1060 = sv.read_inout %decWire_rs2 : !hw.inout<i5>
          sv.passign %decStage_0_rs2, %1060 : i5
          %1061 = sv.read_inout %decWire_rd : !hw.inout<i5>
          sv.passign %decStage_0_rd, %1061 : i5
          %1062 = sv.read_inout %decWire_rs1Data : !hw.inout<i32>
          sv.passign %decStage_0_rs1Data, %1062 : i32
          %1063 = sv.read_inout %decWire_rs2Data : !hw.inout<i32>
          sv.passign %decStage_0_rs2Data, %1063 : i32
          %1064 = sv.read_inout %decWire_memAddr : !hw.inout<i32>
          sv.passign %decStage_0_memAddr, %1064 : i32
          %1065 = sv.read_inout %decWire_memWdata : !hw.inout<i32>
          sv.passign %decStage_0_memWdata, %1065 : i32
          %1066 = sv.read_inout %decWire_memRdata : !hw.inout<i32>
          sv.passign %decStage_0_memRdata, %1066 : i32
          %1067 = sv.read_inout %decWire_aluResult : !hw.inout<i32>
          sv.passign %decStage_0_aluResult, %1067 : i32
          %1068 = sv.read_inout %exWire_threadId : !hw.inout<i2>
          sv.passign %exStage_0_threadId, %1068 : i2
          %1069 = sv.read_inout %exWire_valid : !hw.inout<i1>
          sv.passign %exStage_0_valid, %1069 : i1
          %1070 = sv.read_inout %exWire_pc : !hw.inout<i32>
          sv.passign %exStage_0_pc, %1070 : i32
          %1071 = sv.read_inout %exWire_instr : !hw.inout<i32>
          sv.passign %exStage_0_instr, %1071 : i32
          %1072 = sv.read_inout %exWire_isALU : !hw.inout<i1>
          sv.passign %exStage_0_isALU, %1072 : i1
          %1073 = sv.read_inout %exWire_isLoad : !hw.inout<i1>
          sv.passign %exStage_0_isLoad, %1073 : i1
          %1074 = sv.read_inout %exWire_isStore : !hw.inout<i1>
          sv.passign %exStage_0_isStore, %1074 : i1
          %1075 = sv.read_inout %exWire_isBranch : !hw.inout<i1>
          sv.passign %exStage_0_isBranch, %1075 : i1
          %1076 = sv.read_inout %exWire_isJAL : !hw.inout<i1>
          sv.passign %exStage_0_isJAL, %1076 : i1
          %1077 = sv.read_inout %exWire_isJALR : !hw.inout<i1>
          sv.passign %exStage_0_isJALR, %1077 : i1
          %1078 = sv.read_inout %exWire_isLUI : !hw.inout<i1>
          sv.passign %exStage_0_isLUI, %1078 : i1
          %1079 = sv.read_inout %exWire_isAUIPC : !hw.inout<i1>
          sv.passign %exStage_0_isAUIPC, %1079 : i1
          %1080 = sv.read_inout %exWire_isFence : !hw.inout<i1>
          sv.passign %exStage_0_isFence, %1080 : i1
          %1081 = sv.read_inout %exWire_isSystem : !hw.inout<i1>
          sv.passign %exStage_0_isSystem, %1081 : i1
          %1082 = sv.read_inout %exWire_aluOp : !hw.inout<i5>
          sv.passign %exStage_0_aluOp, %1082 : i5
          %1083 = sv.read_inout %exWire_imm : !hw.inout<i32>
          sv.passign %exStage_0_imm, %1083 : i32
          %1084 = sv.read_inout %exWire_rs1 : !hw.inout<i5>
          sv.passign %exStage_0_rs1, %1084 : i5
          %1085 = sv.read_inout %exWire_rs2 : !hw.inout<i5>
          sv.passign %exStage_0_rs2, %1085 : i5
          %1086 = sv.read_inout %exWire_rd : !hw.inout<i5>
          sv.passign %exStage_0_rd, %1086 : i5
          %1087 = sv.read_inout %exWire_rs1Data : !hw.inout<i32>
          sv.passign %exStage_0_rs1Data, %1087 : i32
          %1088 = sv.read_inout %exWire_rs2Data : !hw.inout<i32>
          sv.passign %exStage_0_rs2Data, %1088 : i32
          %1089 = sv.read_inout %exWire_memAddr : !hw.inout<i32>
          sv.passign %exStage_0_memAddr, %1089 : i32
          %1090 = sv.read_inout %exWire_memWdata : !hw.inout<i32>
          sv.passign %exStage_0_memWdata, %1090 : i32
          %1091 = sv.read_inout %exWire_memRdata : !hw.inout<i32>
          sv.passign %exStage_0_memRdata, %1091 : i32
          %1092 = sv.read_inout %exWire_aluResult : !hw.inout<i32>
          sv.passign %exStage_0_aluResult, %1092 : i32
          %1093 = sv.read_inout %memWire_threadId : !hw.inout<i2>
          sv.passign %memStage_0_threadId, %1093 : i2
          %1094 = sv.read_inout %memWire_valid : !hw.inout<i1>
          sv.passign %memStage_0_valid, %1094 : i1
          %1095 = sv.read_inout %memWire_pc : !hw.inout<i32>
          sv.passign %memStage_0_pc, %1095 : i32
          %1096 = sv.read_inout %memWire_instr : !hw.inout<i32>
          sv.passign %memStage_0_instr, %1096 : i32
          %1097 = sv.read_inout %memWire_isALU : !hw.inout<i1>
          sv.passign %memStage_0_isALU, %1097 : i1
          %1098 = sv.read_inout %memWire_isLoad : !hw.inout<i1>
          sv.passign %memStage_0_isLoad, %1098 : i1
          %1099 = sv.read_inout %memWire_isStore : !hw.inout<i1>
          sv.passign %memStage_0_isStore, %1099 : i1
          %1100 = sv.read_inout %memWire_isBranch : !hw.inout<i1>
          sv.passign %memStage_0_isBranch, %1100 : i1
          %1101 = sv.read_inout %memWire_isJAL : !hw.inout<i1>
          sv.passign %memStage_0_isJAL, %1101 : i1
          %1102 = sv.read_inout %memWire_isJALR : !hw.inout<i1>
          sv.passign %memStage_0_isJALR, %1102 : i1
          %1103 = sv.read_inout %memWire_isLUI : !hw.inout<i1>
          sv.passign %memStage_0_isLUI, %1103 : i1
          %1104 = sv.read_inout %memWire_isAUIPC : !hw.inout<i1>
          sv.passign %memStage_0_isAUIPC, %1104 : i1
          %1105 = sv.read_inout %memWire_isFence : !hw.inout<i1>
          sv.passign %memStage_0_isFence, %1105 : i1
          %1106 = sv.read_inout %memWire_isSystem : !hw.inout<i1>
          sv.passign %memStage_0_isSystem, %1106 : i1
          %1107 = sv.read_inout %memWire_aluOp : !hw.inout<i5>
          sv.passign %memStage_0_aluOp, %1107 : i5
          %1108 = sv.read_inout %memWire_imm : !hw.inout<i32>
          sv.passign %memStage_0_imm, %1108 : i32
          %1109 = sv.read_inout %memWire_rs1 : !hw.inout<i5>
          sv.passign %memStage_0_rs1, %1109 : i5
          %1110 = sv.read_inout %memWire_rs2 : !hw.inout<i5>
          sv.passign %memStage_0_rs2, %1110 : i5
          %1111 = sv.read_inout %memWire_rd : !hw.inout<i5>
          sv.passign %memStage_0_rd, %1111 : i5
          %1112 = sv.read_inout %memWire_rs1Data : !hw.inout<i32>
          sv.passign %memStage_0_rs1Data, %1112 : i32
          %1113 = sv.read_inout %memWire_rs2Data : !hw.inout<i32>
          sv.passign %memStage_0_rs2Data, %1113 : i32
          %1114 = sv.read_inout %memWire_memAddr : !hw.inout<i32>
          sv.passign %memStage_0_memAddr, %1114 : i32
          %1115 = sv.read_inout %memWire_memWdata : !hw.inout<i32>
          sv.passign %memStage_0_memWdata, %1115 : i32
          %1116 = sv.read_inout %memWire_memRdata : !hw.inout<i32>
          sv.passign %memStage_0_memRdata, %1116 : i32
          %1117 = sv.read_inout %memWire_aluResult : !hw.inout<i32>
          sv.passign %memStage_0_aluResult, %1117 : i32
        }
        %732 = sv.read_inout %722 : !hw.inout<i1>
        sv.if %732 {
          %1049 = sv.read_inout %_pcRegs_T_1 : !hw.inout<i32>
          sv.passign %pcRegs_1, %1049 : i32
          %1050 = sv.read_inout %ifWire_threadId : !hw.inout<i2>
          sv.passign %ifStage_1_threadId, %1050 : i2
          %1051 = sv.read_inout %ifWire_pc : !hw.inout<i32>
          sv.passign %ifStage_1_pc, %1051 : i32
          %1052 = sv.read_inout %ifWire_instr : !hw.inout<i32>
          sv.passign %ifStage_1_instr, %1052 : i32
          %1053 = sv.read_inout %decWire_threadId : !hw.inout<i2>
          sv.passign %decStage_1_threadId, %1053 : i2
          %1054 = sv.read_inout %decWire_valid : !hw.inout<i1>
          sv.passign %decStage_1_valid, %1054 : i1
          %1055 = sv.read_inout %decWire_pc : !hw.inout<i32>
          sv.passign %decStage_1_pc, %1055 : i32
          %1056 = sv.read_inout %decWire_instr : !hw.inout<i32>
          sv.passign %decStage_1_instr, %1056 : i32
          %1057 = sv.read_inout %decWire_aluOp : !hw.inout<i5>
          sv.passign %decStage_1_aluOp, %1057 : i5
          %1058 = sv.read_inout %decWire_imm : !hw.inout<i32>
          sv.passign %decStage_1_imm, %1058 : i32
          %1059 = sv.read_inout %decWire_rs1 : !hw.inout<i5>
          sv.passign %decStage_1_rs1, %1059 : i5
          %1060 = sv.read_inout %decWire_rs2 : !hw.inout<i5>
          sv.passign %decStage_1_rs2, %1060 : i5
          %1061 = sv.read_inout %decWire_rd : !hw.inout<i5>
          sv.passign %decStage_1_rd, %1061 : i5
          %1062 = sv.read_inout %decWire_rs1Data : !hw.inout<i32>
          sv.passign %decStage_1_rs1Data, %1062 : i32
          %1063 = sv.read_inout %decWire_rs2Data : !hw.inout<i32>
          sv.passign %decStage_1_rs2Data, %1063 : i32
          %1064 = sv.read_inout %decWire_memAddr : !hw.inout<i32>
          sv.passign %decStage_1_memAddr, %1064 : i32
          %1065 = sv.read_inout %decWire_memWdata : !hw.inout<i32>
          sv.passign %decStage_1_memWdata, %1065 : i32
          %1066 = sv.read_inout %decWire_memRdata : !hw.inout<i32>
          sv.passign %decStage_1_memRdata, %1066 : i32
          %1067 = sv.read_inout %decWire_aluResult : !hw.inout<i32>
          sv.passign %decStage_1_aluResult, %1067 : i32
          %1068 = sv.read_inout %exWire_threadId : !hw.inout<i2>
          sv.passign %exStage_1_threadId, %1068 : i2
          %1069 = sv.read_inout %exWire_valid : !hw.inout<i1>
          sv.passign %exStage_1_valid, %1069 : i1
          %1070 = sv.read_inout %exWire_pc : !hw.inout<i32>
          sv.passign %exStage_1_pc, %1070 : i32
          %1071 = sv.read_inout %exWire_instr : !hw.inout<i32>
          sv.passign %exStage_1_instr, %1071 : i32
          %1072 = sv.read_inout %exWire_isALU : !hw.inout<i1>
          sv.passign %exStage_1_isALU, %1072 : i1
          %1073 = sv.read_inout %exWire_isLoad : !hw.inout<i1>
          sv.passign %exStage_1_isLoad, %1073 : i1
          %1074 = sv.read_inout %exWire_isStore : !hw.inout<i1>
          sv.passign %exStage_1_isStore, %1074 : i1
          %1075 = sv.read_inout %exWire_isBranch : !hw.inout<i1>
          sv.passign %exStage_1_isBranch, %1075 : i1
          %1076 = sv.read_inout %exWire_isJAL : !hw.inout<i1>
          sv.passign %exStage_1_isJAL, %1076 : i1
          %1077 = sv.read_inout %exWire_isJALR : !hw.inout<i1>
          sv.passign %exStage_1_isJALR, %1077 : i1
          %1078 = sv.read_inout %exWire_isLUI : !hw.inout<i1>
          sv.passign %exStage_1_isLUI, %1078 : i1
          %1079 = sv.read_inout %exWire_isAUIPC : !hw.inout<i1>
          sv.passign %exStage_1_isAUIPC, %1079 : i1
          %1080 = sv.read_inout %exWire_isFence : !hw.inout<i1>
          sv.passign %exStage_1_isFence, %1080 : i1
          %1081 = sv.read_inout %exWire_isSystem : !hw.inout<i1>
          sv.passign %exStage_1_isSystem, %1081 : i1
          %1082 = sv.read_inout %exWire_aluOp : !hw.inout<i5>
          sv.passign %exStage_1_aluOp, %1082 : i5
          %1083 = sv.read_inout %exWire_imm : !hw.inout<i32>
          sv.passign %exStage_1_imm, %1083 : i32
          %1084 = sv.read_inout %exWire_rs1 : !hw.inout<i5>
          sv.passign %exStage_1_rs1, %1084 : i5
          %1085 = sv.read_inout %exWire_rs2 : !hw.inout<i5>
          sv.passign %exStage_1_rs2, %1085 : i5
          %1086 = sv.read_inout %exWire_rd : !hw.inout<i5>
          sv.passign %exStage_1_rd, %1086 : i5
          %1087 = sv.read_inout %exWire_rs1Data : !hw.inout<i32>
          sv.passign %exStage_1_rs1Data, %1087 : i32
          %1088 = sv.read_inout %exWire_rs2Data : !hw.inout<i32>
          sv.passign %exStage_1_rs2Data, %1088 : i32
          %1089 = sv.read_inout %exWire_memAddr : !hw.inout<i32>
          sv.passign %exStage_1_memAddr, %1089 : i32
          %1090 = sv.read_inout %exWire_memWdata : !hw.inout<i32>
          sv.passign %exStage_1_memWdata, %1090 : i32
          %1091 = sv.read_inout %exWire_memRdata : !hw.inout<i32>
          sv.passign %exStage_1_memRdata, %1091 : i32
          %1092 = sv.read_inout %exWire_aluResult : !hw.inout<i32>
          sv.passign %exStage_1_aluResult, %1092 : i32
          %1093 = sv.read_inout %memWire_threadId : !hw.inout<i2>
          sv.passign %memStage_1_threadId, %1093 : i2
          %1094 = sv.read_inout %memWire_valid : !hw.inout<i1>
          sv.passign %memStage_1_valid, %1094 : i1
          %1095 = sv.read_inout %memWire_pc : !hw.inout<i32>
          sv.passign %memStage_1_pc, %1095 : i32
          %1096 = sv.read_inout %memWire_instr : !hw.inout<i32>
          sv.passign %memStage_1_instr, %1096 : i32
          %1097 = sv.read_inout %memWire_isALU : !hw.inout<i1>
          sv.passign %memStage_1_isALU, %1097 : i1
          %1098 = sv.read_inout %memWire_isLoad : !hw.inout<i1>
          sv.passign %memStage_1_isLoad, %1098 : i1
          %1099 = sv.read_inout %memWire_isStore : !hw.inout<i1>
          sv.passign %memStage_1_isStore, %1099 : i1
          %1100 = sv.read_inout %memWire_isBranch : !hw.inout<i1>
          sv.passign %memStage_1_isBranch, %1100 : i1
          %1101 = sv.read_inout %memWire_isJAL : !hw.inout<i1>
          sv.passign %memStage_1_isJAL, %1101 : i1
          %1102 = sv.read_inout %memWire_isJALR : !hw.inout<i1>
          sv.passign %memStage_1_isJALR, %1102 : i1
          %1103 = sv.read_inout %memWire_isLUI : !hw.inout<i1>
          sv.passign %memStage_1_isLUI, %1103 : i1
          %1104 = sv.read_inout %memWire_isAUIPC : !hw.inout<i1>
          sv.passign %memStage_1_isAUIPC, %1104 : i1
          %1105 = sv.read_inout %memWire_isFence : !hw.inout<i1>
          sv.passign %memStage_1_isFence, %1105 : i1
          %1106 = sv.read_inout %memWire_isSystem : !hw.inout<i1>
          sv.passign %memStage_1_isSystem, %1106 : i1
          %1107 = sv.read_inout %memWire_aluOp : !hw.inout<i5>
          sv.passign %memStage_1_aluOp, %1107 : i5
          %1108 = sv.read_inout %memWire_imm : !hw.inout<i32>
          sv.passign %memStage_1_imm, %1108 : i32
          %1109 = sv.read_inout %memWire_rs1 : !hw.inout<i5>
          sv.passign %memStage_1_rs1, %1109 : i5
          %1110 = sv.read_inout %memWire_rs2 : !hw.inout<i5>
          sv.passign %memStage_1_rs2, %1110 : i5
          %1111 = sv.read_inout %memWire_rd : !hw.inout<i5>
          sv.passign %memStage_1_rd, %1111 : i5
          %1112 = sv.read_inout %memWire_rs1Data : !hw.inout<i32>
          sv.passign %memStage_1_rs1Data, %1112 : i32
          %1113 = sv.read_inout %memWire_rs2Data : !hw.inout<i32>
          sv.passign %memStage_1_rs2Data, %1113 : i32
          %1114 = sv.read_inout %memWire_memAddr : !hw.inout<i32>
          sv.passign %memStage_1_memAddr, %1114 : i32
          %1115 = sv.read_inout %memWire_memWdata : !hw.inout<i32>
          sv.passign %memStage_1_memWdata, %1115 : i32
          %1116 = sv.read_inout %memWire_memRdata : !hw.inout<i32>
          sv.passign %memStage_1_memRdata, %1116 : i32
          %1117 = sv.read_inout %memWire_aluResult : !hw.inout<i32>
          sv.passign %memStage_1_aluResult, %1117 : i32
        }
        %733 = sv.read_inout %723 : !hw.inout<i1>
        sv.if %733 {
          %1049 = sv.read_inout %_pcRegs_T_1 : !hw.inout<i32>
          sv.passign %pcRegs_2, %1049 : i32
          %1050 = sv.read_inout %ifWire_threadId : !hw.inout<i2>
          sv.passign %ifStage_2_threadId, %1050 : i2
          %1051 = sv.read_inout %ifWire_pc : !hw.inout<i32>
          sv.passign %ifStage_2_pc, %1051 : i32
          %1052 = sv.read_inout %ifWire_instr : !hw.inout<i32>
          sv.passign %ifStage_2_instr, %1052 : i32
          %1053 = sv.read_inout %decWire_threadId : !hw.inout<i2>
          sv.passign %decStage_2_threadId, %1053 : i2
          %1054 = sv.read_inout %decWire_valid : !hw.inout<i1>
          sv.passign %decStage_2_valid, %1054 : i1
          %1055 = sv.read_inout %decWire_pc : !hw.inout<i32>
          sv.passign %decStage_2_pc, %1055 : i32
          %1056 = sv.read_inout %decWire_instr : !hw.inout<i32>
          sv.passign %decStage_2_instr, %1056 : i32
          %1057 = sv.read_inout %decWire_aluOp : !hw.inout<i5>
          sv.passign %decStage_2_aluOp, %1057 : i5
          %1058 = sv.read_inout %decWire_imm : !hw.inout<i32>
          sv.passign %decStage_2_imm, %1058 : i32
          %1059 = sv.read_inout %decWire_rs1 : !hw.inout<i5>
          sv.passign %decStage_2_rs1, %1059 : i5
          %1060 = sv.read_inout %decWire_rs2 : !hw.inout<i5>
          sv.passign %decStage_2_rs2, %1060 : i5
          %1061 = sv.read_inout %decWire_rd : !hw.inout<i5>
          sv.passign %decStage_2_rd, %1061 : i5
          %1062 = sv.read_inout %decWire_rs1Data : !hw.inout<i32>
          sv.passign %decStage_2_rs1Data, %1062 : i32
          %1063 = sv.read_inout %decWire_rs2Data : !hw.inout<i32>
          sv.passign %decStage_2_rs2Data, %1063 : i32
          %1064 = sv.read_inout %decWire_memAddr : !hw.inout<i32>
          sv.passign %decStage_2_memAddr, %1064 : i32
          %1065 = sv.read_inout %decWire_memWdata : !hw.inout<i32>
          sv.passign %decStage_2_memWdata, %1065 : i32
          %1066 = sv.read_inout %decWire_memRdata : !hw.inout<i32>
          sv.passign %decStage_2_memRdata, %1066 : i32
          %1067 = sv.read_inout %decWire_aluResult : !hw.inout<i32>
          sv.passign %decStage_2_aluResult, %1067 : i32
          %1068 = sv.read_inout %exWire_threadId : !hw.inout<i2>
          sv.passign %exStage_2_threadId, %1068 : i2
          %1069 = sv.read_inout %exWire_valid : !hw.inout<i1>
          sv.passign %exStage_2_valid, %1069 : i1
          %1070 = sv.read_inout %exWire_pc : !hw.inout<i32>
          sv.passign %exStage_2_pc, %1070 : i32
          %1071 = sv.read_inout %exWire_instr : !hw.inout<i32>
          sv.passign %exStage_2_instr, %1071 : i32
          %1072 = sv.read_inout %exWire_isALU : !hw.inout<i1>
          sv.passign %exStage_2_isALU, %1072 : i1
          %1073 = sv.read_inout %exWire_isLoad : !hw.inout<i1>
          sv.passign %exStage_2_isLoad, %1073 : i1
          %1074 = sv.read_inout %exWire_isStore : !hw.inout<i1>
          sv.passign %exStage_2_isStore, %1074 : i1
          %1075 = sv.read_inout %exWire_isBranch : !hw.inout<i1>
          sv.passign %exStage_2_isBranch, %1075 : i1
          %1076 = sv.read_inout %exWire_isJAL : !hw.inout<i1>
          sv.passign %exStage_2_isJAL, %1076 : i1
          %1077 = sv.read_inout %exWire_isJALR : !hw.inout<i1>
          sv.passign %exStage_2_isJALR, %1077 : i1
          %1078 = sv.read_inout %exWire_isLUI : !hw.inout<i1>
          sv.passign %exStage_2_isLUI, %1078 : i1
          %1079 = sv.read_inout %exWire_isAUIPC : !hw.inout<i1>
          sv.passign %exStage_2_isAUIPC, %1079 : i1
          %1080 = sv.read_inout %exWire_isFence : !hw.inout<i1>
          sv.passign %exStage_2_isFence, %1080 : i1
          %1081 = sv.read_inout %exWire_isSystem : !hw.inout<i1>
          sv.passign %exStage_2_isSystem, %1081 : i1
          %1082 = sv.read_inout %exWire_aluOp : !hw.inout<i5>
          sv.passign %exStage_2_aluOp, %1082 : i5
          %1083 = sv.read_inout %exWire_imm : !hw.inout<i32>
          sv.passign %exStage_2_imm, %1083 : i32
          %1084 = sv.read_inout %exWire_rs1 : !hw.inout<i5>
          sv.passign %exStage_2_rs1, %1084 : i5
          %1085 = sv.read_inout %exWire_rs2 : !hw.inout<i5>
          sv.passign %exStage_2_rs2, %1085 : i5
          %1086 = sv.read_inout %exWire_rd : !hw.inout<i5>
          sv.passign %exStage_2_rd, %1086 : i5
          %1087 = sv.read_inout %exWire_rs1Data : !hw.inout<i32>
          sv.passign %exStage_2_rs1Data, %1087 : i32
          %1088 = sv.read_inout %exWire_rs2Data : !hw.inout<i32>
          sv.passign %exStage_2_rs2Data, %1088 : i32
          %1089 = sv.read_inout %exWire_memAddr : !hw.inout<i32>
          sv.passign %exStage_2_memAddr, %1089 : i32
          %1090 = sv.read_inout %exWire_memWdata : !hw.inout<i32>
          sv.passign %exStage_2_memWdata, %1090 : i32
          %1091 = sv.read_inout %exWire_memRdata : !hw.inout<i32>
          sv.passign %exStage_2_memRdata, %1091 : i32
          %1092 = sv.read_inout %exWire_aluResult : !hw.inout<i32>
          sv.passign %exStage_2_aluResult, %1092 : i32
          %1093 = sv.read_inout %memWire_threadId : !hw.inout<i2>
          sv.passign %memStage_2_threadId, %1093 : i2
          %1094 = sv.read_inout %memWire_valid : !hw.inout<i1>
          sv.passign %memStage_2_valid, %1094 : i1
          %1095 = sv.read_inout %memWire_pc : !hw.inout<i32>
          sv.passign %memStage_2_pc, %1095 : i32
          %1096 = sv.read_inout %memWire_instr : !hw.inout<i32>
          sv.passign %memStage_2_instr, %1096 : i32
          %1097 = sv.read_inout %memWire_isALU : !hw.inout<i1>
          sv.passign %memStage_2_isALU, %1097 : i1
          %1098 = sv.read_inout %memWire_isLoad : !hw.inout<i1>
          sv.passign %memStage_2_isLoad, %1098 : i1
          %1099 = sv.read_inout %memWire_isStore : !hw.inout<i1>
          sv.passign %memStage_2_isStore, %1099 : i1
          %1100 = sv.read_inout %memWire_isBranch : !hw.inout<i1>
          sv.passign %memStage_2_isBranch, %1100 : i1
          %1101 = sv.read_inout %memWire_isJAL : !hw.inout<i1>
          sv.passign %memStage_2_isJAL, %1101 : i1
          %1102 = sv.read_inout %memWire_isJALR : !hw.inout<i1>
          sv.passign %memStage_2_isJALR, %1102 : i1
          %1103 = sv.read_inout %memWire_isLUI : !hw.inout<i1>
          sv.passign %memStage_2_isLUI, %1103 : i1
          %1104 = sv.read_inout %memWire_isAUIPC : !hw.inout<i1>
          sv.passign %memStage_2_isAUIPC, %1104 : i1
          %1105 = sv.read_inout %memWire_isFence : !hw.inout<i1>
          sv.passign %memStage_2_isFence, %1105 : i1
          %1106 = sv.read_inout %memWire_isSystem : !hw.inout<i1>
          sv.passign %memStage_2_isSystem, %1106 : i1
          %1107 = sv.read_inout %memWire_aluOp : !hw.inout<i5>
          sv.passign %memStage_2_aluOp, %1107 : i5
          %1108 = sv.read_inout %memWire_imm : !hw.inout<i32>
          sv.passign %memStage_2_imm, %1108 : i32
          %1109 = sv.read_inout %memWire_rs1 : !hw.inout<i5>
          sv.passign %memStage_2_rs1, %1109 : i5
          %1110 = sv.read_inout %memWire_rs2 : !hw.inout<i5>
          sv.passign %memStage_2_rs2, %1110 : i5
          %1111 = sv.read_inout %memWire_rd : !hw.inout<i5>
          sv.passign %memStage_2_rd, %1111 : i5
          %1112 = sv.read_inout %memWire_rs1Data : !hw.inout<i32>
          sv.passign %memStage_2_rs1Data, %1112 : i32
          %1113 = sv.read_inout %memWire_rs2Data : !hw.inout<i32>
          sv.passign %memStage_2_rs2Data, %1113 : i32
          %1114 = sv.read_inout %memWire_memAddr : !hw.inout<i32>
          sv.passign %memStage_2_memAddr, %1114 : i32
          %1115 = sv.read_inout %memWire_memWdata : !hw.inout<i32>
          sv.passign %memStage_2_memWdata, %1115 : i32
          %1116 = sv.read_inout %memWire_memRdata : !hw.inout<i32>
          sv.passign %memStage_2_memRdata, %1116 : i32
          %1117 = sv.read_inout %memWire_aluResult : !hw.inout<i32>
          sv.passign %memStage_2_aluResult, %1117 : i32
        }
        %c-1_i2 = hw.constant -1 : i2
        %734 = sv.read_inout %currentThread : !hw.inout<i2>
        %735 = comb.icmp bin eq %734, %c-1_i2 : i2
        sv.if %735 {
          %1049 = sv.read_inout %_pcRegs_T_1 : !hw.inout<i32>
          sv.passign %pcRegs_3, %1049 : i32
          %1050 = sv.read_inout %ifWire_threadId : !hw.inout<i2>
          sv.passign %ifStage_3_threadId, %1050 : i2
          %1051 = sv.read_inout %ifWire_pc : !hw.inout<i32>
          sv.passign %ifStage_3_pc, %1051 : i32
          %1052 = sv.read_inout %ifWire_instr : !hw.inout<i32>
          sv.passign %ifStage_3_instr, %1052 : i32
          %1053 = sv.read_inout %decWire_threadId : !hw.inout<i2>
          sv.passign %decStage_3_threadId, %1053 : i2
          %1054 = sv.read_inout %decWire_valid : !hw.inout<i1>
          sv.passign %decStage_3_valid, %1054 : i1
          %1055 = sv.read_inout %decWire_pc : !hw.inout<i32>
          sv.passign %decStage_3_pc, %1055 : i32
          %1056 = sv.read_inout %decWire_instr : !hw.inout<i32>
          sv.passign %decStage_3_instr, %1056 : i32
          %1057 = sv.read_inout %decWire_aluOp : !hw.inout<i5>
          sv.passign %decStage_3_aluOp, %1057 : i5
          %1058 = sv.read_inout %decWire_imm : !hw.inout<i32>
          sv.passign %decStage_3_imm, %1058 : i32
          %1059 = sv.read_inout %decWire_rs1 : !hw.inout<i5>
          sv.passign %decStage_3_rs1, %1059 : i5
          %1060 = sv.read_inout %decWire_rs2 : !hw.inout<i5>
          sv.passign %decStage_3_rs2, %1060 : i5
          %1061 = sv.read_inout %decWire_rd : !hw.inout<i5>
          sv.passign %decStage_3_rd, %1061 : i5
          %1062 = sv.read_inout %decWire_rs1Data : !hw.inout<i32>
          sv.passign %decStage_3_rs1Data, %1062 : i32
          %1063 = sv.read_inout %decWire_rs2Data : !hw.inout<i32>
          sv.passign %decStage_3_rs2Data, %1063 : i32
          %1064 = sv.read_inout %decWire_memAddr : !hw.inout<i32>
          sv.passign %decStage_3_memAddr, %1064 : i32
          %1065 = sv.read_inout %decWire_memWdata : !hw.inout<i32>
          sv.passign %decStage_3_memWdata, %1065 : i32
          %1066 = sv.read_inout %decWire_memRdata : !hw.inout<i32>
          sv.passign %decStage_3_memRdata, %1066 : i32
          %1067 = sv.read_inout %decWire_aluResult : !hw.inout<i32>
          sv.passign %decStage_3_aluResult, %1067 : i32
          %1068 = sv.read_inout %exWire_threadId : !hw.inout<i2>
          sv.passign %exStage_3_threadId, %1068 : i2
          %1069 = sv.read_inout %exWire_valid : !hw.inout<i1>
          sv.passign %exStage_3_valid, %1069 : i1
          %1070 = sv.read_inout %exWire_pc : !hw.inout<i32>
          sv.passign %exStage_3_pc, %1070 : i32
          %1071 = sv.read_inout %exWire_instr : !hw.inout<i32>
          sv.passign %exStage_3_instr, %1071 : i32
          %1072 = sv.read_inout %exWire_isALU : !hw.inout<i1>
          sv.passign %exStage_3_isALU, %1072 : i1
          %1073 = sv.read_inout %exWire_isLoad : !hw.inout<i1>
          sv.passign %exStage_3_isLoad, %1073 : i1
          %1074 = sv.read_inout %exWire_isStore : !hw.inout<i1>
          sv.passign %exStage_3_isStore, %1074 : i1
          %1075 = sv.read_inout %exWire_isBranch : !hw.inout<i1>
          sv.passign %exStage_3_isBranch, %1075 : i1
          %1076 = sv.read_inout %exWire_isJAL : !hw.inout<i1>
          sv.passign %exStage_3_isJAL, %1076 : i1
          %1077 = sv.read_inout %exWire_isJALR : !hw.inout<i1>
          sv.passign %exStage_3_isJALR, %1077 : i1
          %1078 = sv.read_inout %exWire_isLUI : !hw.inout<i1>
          sv.passign %exStage_3_isLUI, %1078 : i1
          %1079 = sv.read_inout %exWire_isAUIPC : !hw.inout<i1>
          sv.passign %exStage_3_isAUIPC, %1079 : i1
          %1080 = sv.read_inout %exWire_isFence : !hw.inout<i1>
          sv.passign %exStage_3_isFence, %1080 : i1
          %1081 = sv.read_inout %exWire_isSystem : !hw.inout<i1>
          sv.passign %exStage_3_isSystem, %1081 : i1
          %1082 = sv.read_inout %exWire_aluOp : !hw.inout<i5>
          sv.passign %exStage_3_aluOp, %1082 : i5
          %1083 = sv.read_inout %exWire_imm : !hw.inout<i32>
          sv.passign %exStage_3_imm, %1083 : i32
          %1084 = sv.read_inout %exWire_rs1 : !hw.inout<i5>
          sv.passign %exStage_3_rs1, %1084 : i5
          %1085 = sv.read_inout %exWire_rs2 : !hw.inout<i5>
          sv.passign %exStage_3_rs2, %1085 : i5
          %1086 = sv.read_inout %exWire_rd : !hw.inout<i5>
          sv.passign %exStage_3_rd, %1086 : i5
          %1087 = sv.read_inout %exWire_rs1Data : !hw.inout<i32>
          sv.passign %exStage_3_rs1Data, %1087 : i32
          %1088 = sv.read_inout %exWire_rs2Data : !hw.inout<i32>
          sv.passign %exStage_3_rs2Data, %1088 : i32
          %1089 = sv.read_inout %exWire_memAddr : !hw.inout<i32>
          sv.passign %exStage_3_memAddr, %1089 : i32
          %1090 = sv.read_inout %exWire_memWdata : !hw.inout<i32>
          sv.passign %exStage_3_memWdata, %1090 : i32
          %1091 = sv.read_inout %exWire_memRdata : !hw.inout<i32>
          sv.passign %exStage_3_memRdata, %1091 : i32
          %1092 = sv.read_inout %exWire_aluResult : !hw.inout<i32>
          sv.passign %exStage_3_aluResult, %1092 : i32
          %1093 = sv.read_inout %memWire_threadId : !hw.inout<i2>
          sv.passign %memStage_3_threadId, %1093 : i2
          %1094 = sv.read_inout %memWire_valid : !hw.inout<i1>
          sv.passign %memStage_3_valid, %1094 : i1
          %1095 = sv.read_inout %memWire_pc : !hw.inout<i32>
          sv.passign %memStage_3_pc, %1095 : i32
          %1096 = sv.read_inout %memWire_instr : !hw.inout<i32>
          sv.passign %memStage_3_instr, %1096 : i32
          %1097 = sv.read_inout %memWire_isALU : !hw.inout<i1>
          sv.passign %memStage_3_isALU, %1097 : i1
          %1098 = sv.read_inout %memWire_isLoad : !hw.inout<i1>
          sv.passign %memStage_3_isLoad, %1098 : i1
          %1099 = sv.read_inout %memWire_isStore : !hw.inout<i1>
          sv.passign %memStage_3_isStore, %1099 : i1
          %1100 = sv.read_inout %memWire_isBranch : !hw.inout<i1>
          sv.passign %memStage_3_isBranch, %1100 : i1
          %1101 = sv.read_inout %memWire_isJAL : !hw.inout<i1>
          sv.passign %memStage_3_isJAL, %1101 : i1
          %1102 = sv.read_inout %memWire_isJALR : !hw.inout<i1>
          sv.passign %memStage_3_isJALR, %1102 : i1
          %1103 = sv.read_inout %memWire_isLUI : !hw.inout<i1>
          sv.passign %memStage_3_isLUI, %1103 : i1
          %1104 = sv.read_inout %memWire_isAUIPC : !hw.inout<i1>
          sv.passign %memStage_3_isAUIPC, %1104 : i1
          %1105 = sv.read_inout %memWire_isFence : !hw.inout<i1>
          sv.passign %memStage_3_isFence, %1105 : i1
          %1106 = sv.read_inout %memWire_isSystem : !hw.inout<i1>
          sv.passign %memStage_3_isSystem, %1106 : i1
          %1107 = sv.read_inout %memWire_aluOp : !hw.inout<i5>
          sv.passign %memStage_3_aluOp, %1107 : i5
          %1108 = sv.read_inout %memWire_imm : !hw.inout<i32>
          sv.passign %memStage_3_imm, %1108 : i32
          %1109 = sv.read_inout %memWire_rs1 : !hw.inout<i5>
          sv.passign %memStage_3_rs1, %1109 : i5
          %1110 = sv.read_inout %memWire_rs2 : !hw.inout<i5>
          sv.passign %memStage_3_rs2, %1110 : i5
          %1111 = sv.read_inout %memWire_rd : !hw.inout<i5>
          sv.passign %memStage_3_rd, %1111 : i5
          %1112 = sv.read_inout %memWire_rs1Data : !hw.inout<i32>
          sv.passign %memStage_3_rs1Data, %1112 : i32
          %1113 = sv.read_inout %memWire_rs2Data : !hw.inout<i32>
          sv.passign %memStage_3_rs2Data, %1113 : i32
          %1114 = sv.read_inout %memWire_memAddr : !hw.inout<i32>
          sv.passign %memStage_3_memAddr, %1114 : i32
          %1115 = sv.read_inout %memWire_memWdata : !hw.inout<i32>
          sv.passign %memStage_3_memWdata, %1115 : i32
          %1116 = sv.read_inout %memWire_memRdata : !hw.inout<i32>
          sv.passign %memStage_3_memRdata, %1116 : i32
          %1117 = sv.read_inout %memWire_aluResult : !hw.inout<i32>
          sv.passign %memStage_3_aluResult, %1117 : i32
        }
        %736 = sv.read_inout %ifStage_0_valid : !hw.inout<i1>
        %737 = sv.read_inout %721 : !hw.inout<i1>
        %738 = comb.or %737, %736 : i1
        sv.passign %ifStage_0_valid, %738 : i1
        %739 = sv.read_inout %ifStage_1_valid : !hw.inout<i1>
        %740 = sv.read_inout %722 : !hw.inout<i1>
        %741 = comb.or %740, %739 : i1
        sv.passign %ifStage_1_valid, %741 : i1
        %742 = sv.read_inout %ifStage_2_valid : !hw.inout<i1>
        %743 = sv.read_inout %723 : !hw.inout<i1>
        %744 = comb.or %743, %742 : i1
        sv.passign %ifStage_2_valid, %744 : i1
        %c-1_i2_6 = hw.constant -1 : i2
        %745 = sv.read_inout %currentThread : !hw.inout<i2>
        %746 = comb.icmp bin eq %745, %c-1_i2_6 : i2
        %747 = sv.read_inout %ifStage_3_valid : !hw.inout<i1>
        %748 = comb.or %746, %747 : i1
        sv.passign %ifStage_3_valid, %748 : i1
        %true_7 = hw.constant true
        %749 = sv.read_inout %721 : !hw.inout<i1>
        %750 = comb.xor %749, %true_7 : i1
        %751 = sv.read_inout %decStage_0_isALU : !hw.inout<i1>
        %752 = comb.and %750, %751 : i1
        %753 = sv.read_inout %721 : !hw.inout<i1>
        %754 = sv.read_inout %decWire_isALU : !hw.inout<i1>
        %755 = comb.mux bin %753, %754, %752 : i1
        sv.passign %decStage_0_isALU, %755 : i1
        %true_8 = hw.constant true
        %756 = sv.read_inout %721 : !hw.inout<i1>
        %757 = comb.xor %756, %true_8 : i1
        %758 = sv.read_inout %decStage_0_isLoad : !hw.inout<i1>
        %759 = comb.and %757, %758 : i1
        %760 = sv.read_inout %721 : !hw.inout<i1>
        %761 = sv.read_inout %decWire_isLoad : !hw.inout<i1>
        %762 = comb.mux bin %760, %761, %759 : i1
        sv.passign %decStage_0_isLoad, %762 : i1
        %true_9 = hw.constant true
        %763 = sv.read_inout %721 : !hw.inout<i1>
        %764 = comb.xor %763, %true_9 : i1
        %765 = sv.read_inout %decStage_0_isStore : !hw.inout<i1>
        %766 = comb.and %764, %765 : i1
        %767 = sv.read_inout %721 : !hw.inout<i1>
        %768 = sv.read_inout %decWire_isStore : !hw.inout<i1>
        %769 = comb.mux bin %767, %768, %766 : i1
        sv.passign %decStage_0_isStore, %769 : i1
        %true_10 = hw.constant true
        %770 = sv.read_inout %721 : !hw.inout<i1>
        %771 = comb.xor %770, %true_10 : i1
        %772 = sv.read_inout %decStage_0_isBranch : !hw.inout<i1>
        %773 = comb.and %771, %772 : i1
        %774 = sv.read_inout %721 : !hw.inout<i1>
        %775 = sv.read_inout %decWire_isBranch : !hw.inout<i1>
        %776 = comb.mux bin %774, %775, %773 : i1
        sv.passign %decStage_0_isBranch, %776 : i1
        %true_11 = hw.constant true
        %777 = sv.read_inout %721 : !hw.inout<i1>
        %778 = comb.xor %777, %true_11 : i1
        %779 = sv.read_inout %decStage_0_isJAL : !hw.inout<i1>
        %780 = comb.and %778, %779 : i1
        %781 = sv.read_inout %721 : !hw.inout<i1>
        %782 = sv.read_inout %decWire_isJAL : !hw.inout<i1>
        %783 = comb.mux bin %781, %782, %780 : i1
        sv.passign %decStage_0_isJAL, %783 : i1
        %true_12 = hw.constant true
        %784 = sv.read_inout %721 : !hw.inout<i1>
        %785 = comb.xor %784, %true_12 : i1
        %786 = sv.read_inout %decStage_0_isJALR : !hw.inout<i1>
        %787 = comb.and %785, %786 : i1
        %788 = sv.read_inout %721 : !hw.inout<i1>
        %789 = sv.read_inout %decWire_isJALR : !hw.inout<i1>
        %790 = comb.mux bin %788, %789, %787 : i1
        sv.passign %decStage_0_isJALR, %790 : i1
        %true_13 = hw.constant true
        %791 = sv.read_inout %721 : !hw.inout<i1>
        %792 = comb.xor %791, %true_13 : i1
        %793 = sv.read_inout %decStage_0_isLUI : !hw.inout<i1>
        %794 = comb.and %792, %793 : i1
        %795 = sv.read_inout %721 : !hw.inout<i1>
        %796 = sv.read_inout %decWire_isLUI : !hw.inout<i1>
        %797 = comb.mux bin %795, %796, %794 : i1
        sv.passign %decStage_0_isLUI, %797 : i1
        %true_14 = hw.constant true
        %798 = sv.read_inout %721 : !hw.inout<i1>
        %799 = comb.xor %798, %true_14 : i1
        %800 = sv.read_inout %decStage_0_isAUIPC : !hw.inout<i1>
        %801 = comb.and %799, %800 : i1
        %802 = sv.read_inout %721 : !hw.inout<i1>
        %803 = sv.read_inout %decWire_isAUIPC : !hw.inout<i1>
        %804 = comb.mux bin %802, %803, %801 : i1
        sv.passign %decStage_0_isAUIPC, %804 : i1
        %true_15 = hw.constant true
        %805 = sv.read_inout %721 : !hw.inout<i1>
        %806 = comb.xor %805, %true_15 : i1
        %807 = sv.read_inout %decStage_0_isFence : !hw.inout<i1>
        %808 = comb.and %806, %807 : i1
        %809 = sv.read_inout %721 : !hw.inout<i1>
        %810 = sv.read_inout %decWire_isFence : !hw.inout<i1>
        %811 = comb.mux bin %809, %810, %808 : i1
        sv.passign %decStage_0_isFence, %811 : i1
        %true_16 = hw.constant true
        %812 = sv.read_inout %721 : !hw.inout<i1>
        %813 = comb.xor %812, %true_16 : i1
        %814 = sv.read_inout %decStage_0_isSystem : !hw.inout<i1>
        %815 = comb.and %813, %814 : i1
        %816 = sv.read_inout %721 : !hw.inout<i1>
        %817 = sv.read_inout %decWire_isSystem : !hw.inout<i1>
        %818 = comb.mux bin %816, %817, %815 : i1
        sv.passign %decStage_0_isSystem, %818 : i1
        %true_17 = hw.constant true
        %819 = sv.read_inout %722 : !hw.inout<i1>
        %820 = comb.xor %819, %true_17 : i1
        %821 = sv.read_inout %decStage_1_isALU : !hw.inout<i1>
        %822 = comb.and %820, %821 : i1
        %823 = sv.read_inout %722 : !hw.inout<i1>
        %824 = sv.read_inout %decWire_isALU : !hw.inout<i1>
        %825 = comb.mux bin %823, %824, %822 : i1
        sv.passign %decStage_1_isALU, %825 : i1
        %true_18 = hw.constant true
        %826 = sv.read_inout %722 : !hw.inout<i1>
        %827 = comb.xor %826, %true_18 : i1
        %828 = sv.read_inout %decStage_1_isLoad : !hw.inout<i1>
        %829 = comb.and %827, %828 : i1
        %830 = sv.read_inout %722 : !hw.inout<i1>
        %831 = sv.read_inout %decWire_isLoad : !hw.inout<i1>
        %832 = comb.mux bin %830, %831, %829 : i1
        sv.passign %decStage_1_isLoad, %832 : i1
        %true_19 = hw.constant true
        %833 = sv.read_inout %722 : !hw.inout<i1>
        %834 = comb.xor %833, %true_19 : i1
        %835 = sv.read_inout %decStage_1_isStore : !hw.inout<i1>
        %836 = comb.and %834, %835 : i1
        %837 = sv.read_inout %722 : !hw.inout<i1>
        %838 = sv.read_inout %decWire_isStore : !hw.inout<i1>
        %839 = comb.mux bin %837, %838, %836 : i1
        sv.passign %decStage_1_isStore, %839 : i1
        %true_20 = hw.constant true
        %840 = sv.read_inout %722 : !hw.inout<i1>
        %841 = comb.xor %840, %true_20 : i1
        %842 = sv.read_inout %decStage_1_isBranch : !hw.inout<i1>
        %843 = comb.and %841, %842 : i1
        %844 = sv.read_inout %722 : !hw.inout<i1>
        %845 = sv.read_inout %decWire_isBranch : !hw.inout<i1>
        %846 = comb.mux bin %844, %845, %843 : i1
        sv.passign %decStage_1_isBranch, %846 : i1
        %true_21 = hw.constant true
        %847 = sv.read_inout %722 : !hw.inout<i1>
        %848 = comb.xor %847, %true_21 : i1
        %849 = sv.read_inout %decStage_1_isJAL : !hw.inout<i1>
        %850 = comb.and %848, %849 : i1
        %851 = sv.read_inout %722 : !hw.inout<i1>
        %852 = sv.read_inout %decWire_isJAL : !hw.inout<i1>
        %853 = comb.mux bin %851, %852, %850 : i1
        sv.passign %decStage_1_isJAL, %853 : i1
        %true_22 = hw.constant true
        %854 = sv.read_inout %722 : !hw.inout<i1>
        %855 = comb.xor %854, %true_22 : i1
        %856 = sv.read_inout %decStage_1_isJALR : !hw.inout<i1>
        %857 = comb.and %855, %856 : i1
        %858 = sv.read_inout %722 : !hw.inout<i1>
        %859 = sv.read_inout %decWire_isJALR : !hw.inout<i1>
        %860 = comb.mux bin %858, %859, %857 : i1
        sv.passign %decStage_1_isJALR, %860 : i1
        %true_23 = hw.constant true
        %861 = sv.read_inout %722 : !hw.inout<i1>
        %862 = comb.xor %861, %true_23 : i1
        %863 = sv.read_inout %decStage_1_isLUI : !hw.inout<i1>
        %864 = comb.and %862, %863 : i1
        %865 = sv.read_inout %722 : !hw.inout<i1>
        %866 = sv.read_inout %decWire_isLUI : !hw.inout<i1>
        %867 = comb.mux bin %865, %866, %864 : i1
        sv.passign %decStage_1_isLUI, %867 : i1
        %true_24 = hw.constant true
        %868 = sv.read_inout %722 : !hw.inout<i1>
        %869 = comb.xor %868, %true_24 : i1
        %870 = sv.read_inout %decStage_1_isAUIPC : !hw.inout<i1>
        %871 = comb.and %869, %870 : i1
        %872 = sv.read_inout %722 : !hw.inout<i1>
        %873 = sv.read_inout %decWire_isAUIPC : !hw.inout<i1>
        %874 = comb.mux bin %872, %873, %871 : i1
        sv.passign %decStage_1_isAUIPC, %874 : i1
        %true_25 = hw.constant true
        %875 = sv.read_inout %722 : !hw.inout<i1>
        %876 = comb.xor %875, %true_25 : i1
        %877 = sv.read_inout %decStage_1_isFence : !hw.inout<i1>
        %878 = comb.and %876, %877 : i1
        %879 = sv.read_inout %722 : !hw.inout<i1>
        %880 = sv.read_inout %decWire_isFence : !hw.inout<i1>
        %881 = comb.mux bin %879, %880, %878 : i1
        sv.passign %decStage_1_isFence, %881 : i1
        %true_26 = hw.constant true
        %882 = sv.read_inout %722 : !hw.inout<i1>
        %883 = comb.xor %882, %true_26 : i1
        %884 = sv.read_inout %decStage_1_isSystem : !hw.inout<i1>
        %885 = comb.and %883, %884 : i1
        %886 = sv.read_inout %722 : !hw.inout<i1>
        %887 = sv.read_inout %decWire_isSystem : !hw.inout<i1>
        %888 = comb.mux bin %886, %887, %885 : i1
        sv.passign %decStage_1_isSystem, %888 : i1
        %true_27 = hw.constant true
        %889 = sv.read_inout %723 : !hw.inout<i1>
        %890 = comb.xor %889, %true_27 : i1
        %891 = sv.read_inout %decStage_2_isALU : !hw.inout<i1>
        %892 = comb.and %890, %891 : i1
        %893 = sv.read_inout %723 : !hw.inout<i1>
        %894 = sv.read_inout %decWire_isALU : !hw.inout<i1>
        %895 = comb.mux bin %893, %894, %892 : i1
        sv.passign %decStage_2_isALU, %895 : i1
        %true_28 = hw.constant true
        %896 = sv.read_inout %723 : !hw.inout<i1>
        %897 = comb.xor %896, %true_28 : i1
        %898 = sv.read_inout %decStage_2_isLoad : !hw.inout<i1>
        %899 = comb.and %897, %898 : i1
        %900 = sv.read_inout %723 : !hw.inout<i1>
        %901 = sv.read_inout %decWire_isLoad : !hw.inout<i1>
        %902 = comb.mux bin %900, %901, %899 : i1
        sv.passign %decStage_2_isLoad, %902 : i1
        %true_29 = hw.constant true
        %903 = sv.read_inout %723 : !hw.inout<i1>
        %904 = comb.xor %903, %true_29 : i1
        %905 = sv.read_inout %decStage_2_isStore : !hw.inout<i1>
        %906 = comb.and %904, %905 : i1
        %907 = sv.read_inout %723 : !hw.inout<i1>
        %908 = sv.read_inout %decWire_isStore : !hw.inout<i1>
        %909 = comb.mux bin %907, %908, %906 : i1
        sv.passign %decStage_2_isStore, %909 : i1
        %true_30 = hw.constant true
        %910 = sv.read_inout %723 : !hw.inout<i1>
        %911 = comb.xor %910, %true_30 : i1
        %912 = sv.read_inout %decStage_2_isBranch : !hw.inout<i1>
        %913 = comb.and %911, %912 : i1
        %914 = sv.read_inout %723 : !hw.inout<i1>
        %915 = sv.read_inout %decWire_isBranch : !hw.inout<i1>
        %916 = comb.mux bin %914, %915, %913 : i1
        sv.passign %decStage_2_isBranch, %916 : i1
        %true_31 = hw.constant true
        %917 = sv.read_inout %723 : !hw.inout<i1>
        %918 = comb.xor %917, %true_31 : i1
        %919 = sv.read_inout %decStage_2_isJAL : !hw.inout<i1>
        %920 = comb.and %918, %919 : i1
        %921 = sv.read_inout %723 : !hw.inout<i1>
        %922 = sv.read_inout %decWire_isJAL : !hw.inout<i1>
        %923 = comb.mux bin %921, %922, %920 : i1
        sv.passign %decStage_2_isJAL, %923 : i1
        %true_32 = hw.constant true
        %924 = sv.read_inout %723 : !hw.inout<i1>
        %925 = comb.xor %924, %true_32 : i1
        %926 = sv.read_inout %decStage_2_isJALR : !hw.inout<i1>
        %927 = comb.and %925, %926 : i1
        %928 = sv.read_inout %723 : !hw.inout<i1>
        %929 = sv.read_inout %decWire_isJALR : !hw.inout<i1>
        %930 = comb.mux bin %928, %929, %927 : i1
        sv.passign %decStage_2_isJALR, %930 : i1
        %true_33 = hw.constant true
        %931 = sv.read_inout %723 : !hw.inout<i1>
        %932 = comb.xor %931, %true_33 : i1
        %933 = sv.read_inout %decStage_2_isLUI : !hw.inout<i1>
        %934 = comb.and %932, %933 : i1
        %935 = sv.read_inout %723 : !hw.inout<i1>
        %936 = sv.read_inout %decWire_isLUI : !hw.inout<i1>
        %937 = comb.mux bin %935, %936, %934 : i1
        sv.passign %decStage_2_isLUI, %937 : i1
        %true_34 = hw.constant true
        %938 = sv.read_inout %723 : !hw.inout<i1>
        %939 = comb.xor %938, %true_34 : i1
        %940 = sv.read_inout %decStage_2_isAUIPC : !hw.inout<i1>
        %941 = comb.and %939, %940 : i1
        %942 = sv.read_inout %723 : !hw.inout<i1>
        %943 = sv.read_inout %decWire_isAUIPC : !hw.inout<i1>
        %944 = comb.mux bin %942, %943, %941 : i1
        sv.passign %decStage_2_isAUIPC, %944 : i1
        %true_35 = hw.constant true
        %945 = sv.read_inout %723 : !hw.inout<i1>
        %946 = comb.xor %945, %true_35 : i1
        %947 = sv.read_inout %decStage_2_isFence : !hw.inout<i1>
        %948 = comb.and %946, %947 : i1
        %949 = sv.read_inout %723 : !hw.inout<i1>
        %950 = sv.read_inout %decWire_isFence : !hw.inout<i1>
        %951 = comb.mux bin %949, %950, %948 : i1
        sv.passign %decStage_2_isFence, %951 : i1
        %true_36 = hw.constant true
        %952 = sv.read_inout %723 : !hw.inout<i1>
        %953 = comb.xor %952, %true_36 : i1
        %954 = sv.read_inout %decStage_2_isSystem : !hw.inout<i1>
        %955 = comb.and %953, %954 : i1
        %956 = sv.read_inout %723 : !hw.inout<i1>
        %957 = sv.read_inout %decWire_isSystem : !hw.inout<i1>
        %958 = comb.mux bin %956, %957, %955 : i1
        sv.passign %decStage_2_isSystem, %958 : i1
        %true_37 = hw.constant true
        %c-1_i2_38 = hw.constant -1 : i2
        %959 = sv.read_inout %currentThread : !hw.inout<i2>
        %960 = comb.icmp bin eq %959, %c-1_i2_38 : i2
        %961 = comb.xor %960, %true_37 : i1
        %962 = sv.read_inout %decStage_3_isALU : !hw.inout<i1>
        %963 = comb.and %961, %962 : i1
        %c-1_i2_39 = hw.constant -1 : i2
        %964 = sv.read_inout %currentThread : !hw.inout<i2>
        %965 = comb.icmp bin eq %964, %c-1_i2_39 : i2
        %966 = sv.read_inout %decWire_isALU : !hw.inout<i1>
        %967 = comb.mux bin %965, %966, %963 : i1
        sv.passign %decStage_3_isALU, %967 : i1
        %true_40 = hw.constant true
        %c-1_i2_41 = hw.constant -1 : i2
        %968 = sv.read_inout %currentThread : !hw.inout<i2>
        %969 = comb.icmp bin eq %968, %c-1_i2_41 : i2
        %970 = comb.xor %969, %true_40 : i1
        %971 = sv.read_inout %decStage_3_isLoad : !hw.inout<i1>
        %972 = comb.and %970, %971 : i1
        %c-1_i2_42 = hw.constant -1 : i2
        %973 = sv.read_inout %currentThread : !hw.inout<i2>
        %974 = comb.icmp bin eq %973, %c-1_i2_42 : i2
        %975 = sv.read_inout %decWire_isLoad : !hw.inout<i1>
        %976 = comb.mux bin %974, %975, %972 : i1
        sv.passign %decStage_3_isLoad, %976 : i1
        %true_43 = hw.constant true
        %c-1_i2_44 = hw.constant -1 : i2
        %977 = sv.read_inout %currentThread : !hw.inout<i2>
        %978 = comb.icmp bin eq %977, %c-1_i2_44 : i2
        %979 = comb.xor %978, %true_43 : i1
        %980 = sv.read_inout %decStage_3_isStore : !hw.inout<i1>
        %981 = comb.and %979, %980 : i1
        %c-1_i2_45 = hw.constant -1 : i2
        %982 = sv.read_inout %currentThread : !hw.inout<i2>
        %983 = comb.icmp bin eq %982, %c-1_i2_45 : i2
        %984 = sv.read_inout %decWire_isStore : !hw.inout<i1>
        %985 = comb.mux bin %983, %984, %981 : i1
        sv.passign %decStage_3_isStore, %985 : i1
        %true_46 = hw.constant true
        %c-1_i2_47 = hw.constant -1 : i2
        %986 = sv.read_inout %currentThread : !hw.inout<i2>
        %987 = comb.icmp bin eq %986, %c-1_i2_47 : i2
        %988 = comb.xor %987, %true_46 : i1
        %989 = sv.read_inout %decStage_3_isBranch : !hw.inout<i1>
        %990 = comb.and %988, %989 : i1
        %c-1_i2_48 = hw.constant -1 : i2
        %991 = sv.read_inout %currentThread : !hw.inout<i2>
        %992 = comb.icmp bin eq %991, %c-1_i2_48 : i2
        %993 = sv.read_inout %decWire_isBranch : !hw.inout<i1>
        %994 = comb.mux bin %992, %993, %990 : i1
        sv.passign %decStage_3_isBranch, %994 : i1
        %true_49 = hw.constant true
        %c-1_i2_50 = hw.constant -1 : i2
        %995 = sv.read_inout %currentThread : !hw.inout<i2>
        %996 = comb.icmp bin eq %995, %c-1_i2_50 : i2
        %997 = comb.xor %996, %true_49 : i1
        %998 = sv.read_inout %decStage_3_isJAL : !hw.inout<i1>
        %999 = comb.and %997, %998 : i1
        %c-1_i2_51 = hw.constant -1 : i2
        %1000 = sv.read_inout %currentThread : !hw.inout<i2>
        %1001 = comb.icmp bin eq %1000, %c-1_i2_51 : i2
        %1002 = sv.read_inout %decWire_isJAL : !hw.inout<i1>
        %1003 = comb.mux bin %1001, %1002, %999 : i1
        sv.passign %decStage_3_isJAL, %1003 : i1
        %true_52 = hw.constant true
        %c-1_i2_53 = hw.constant -1 : i2
        %1004 = sv.read_inout %currentThread : !hw.inout<i2>
        %1005 = comb.icmp bin eq %1004, %c-1_i2_53 : i2
        %1006 = comb.xor %1005, %true_52 : i1
        %1007 = sv.read_inout %decStage_3_isJALR : !hw.inout<i1>
        %1008 = comb.and %1006, %1007 : i1
        %c-1_i2_54 = hw.constant -1 : i2
        %1009 = sv.read_inout %currentThread : !hw.inout<i2>
        %1010 = comb.icmp bin eq %1009, %c-1_i2_54 : i2
        %1011 = sv.read_inout %decWire_isJALR : !hw.inout<i1>
        %1012 = comb.mux bin %1010, %1011, %1008 : i1
        sv.passign %decStage_3_isJALR, %1012 : i1
        %true_55 = hw.constant true
        %c-1_i2_56 = hw.constant -1 : i2
        %1013 = sv.read_inout %currentThread : !hw.inout<i2>
        %1014 = comb.icmp bin eq %1013, %c-1_i2_56 : i2
        %1015 = comb.xor %1014, %true_55 : i1
        %1016 = sv.read_inout %decStage_3_isLUI : !hw.inout<i1>
        %1017 = comb.and %1015, %1016 : i1
        %c-1_i2_57 = hw.constant -1 : i2
        %1018 = sv.read_inout %currentThread : !hw.inout<i2>
        %1019 = comb.icmp bin eq %1018, %c-1_i2_57 : i2
        %1020 = sv.read_inout %decWire_isLUI : !hw.inout<i1>
        %1021 = comb.mux bin %1019, %1020, %1017 : i1
        sv.passign %decStage_3_isLUI, %1021 : i1
        %true_58 = hw.constant true
        %c-1_i2_59 = hw.constant -1 : i2
        %1022 = sv.read_inout %currentThread : !hw.inout<i2>
        %1023 = comb.icmp bin eq %1022, %c-1_i2_59 : i2
        %1024 = comb.xor %1023, %true_58 : i1
        %1025 = sv.read_inout %decStage_3_isAUIPC : !hw.inout<i1>
        %1026 = comb.and %1024, %1025 : i1
        %c-1_i2_60 = hw.constant -1 : i2
        %1027 = sv.read_inout %currentThread : !hw.inout<i2>
        %1028 = comb.icmp bin eq %1027, %c-1_i2_60 : i2
        %1029 = sv.read_inout %decWire_isAUIPC : !hw.inout<i1>
        %1030 = comb.mux bin %1028, %1029, %1026 : i1
        sv.passign %decStage_3_isAUIPC, %1030 : i1
        %true_61 = hw.constant true
        %c-1_i2_62 = hw.constant -1 : i2
        %1031 = sv.read_inout %currentThread : !hw.inout<i2>
        %1032 = comb.icmp bin eq %1031, %c-1_i2_62 : i2
        %1033 = comb.xor %1032, %true_61 : i1
        %1034 = sv.read_inout %decStage_3_isFence : !hw.inout<i1>
        %1035 = comb.and %1033, %1034 : i1
        %c-1_i2_63 = hw.constant -1 : i2
        %1036 = sv.read_inout %currentThread : !hw.inout<i2>
        %1037 = comb.icmp bin eq %1036, %c-1_i2_63 : i2
        %1038 = sv.read_inout %decWire_isFence : !hw.inout<i1>
        %1039 = comb.mux bin %1037, %1038, %1035 : i1
        sv.passign %decStage_3_isFence, %1039 : i1
        %true_64 = hw.constant true
        %c-1_i2_65 = hw.constant -1 : i2
        %1040 = sv.read_inout %currentThread : !hw.inout<i2>
        %1041 = comb.icmp bin eq %1040, %c-1_i2_65 : i2
        %1042 = comb.xor %1041, %true_64 : i1
        %1043 = sv.read_inout %decStage_3_isSystem : !hw.inout<i1>
        %1044 = comb.and %1042, %1043 : i1
        %c-1_i2_66 = hw.constant -1 : i2
        %1045 = sv.read_inout %currentThread : !hw.inout<i2>
        %1046 = comb.icmp bin eq %1045, %c-1_i2_66 : i2
        %1047 = sv.read_inout %decWire_isSystem : !hw.inout<i1>
        %1048 = comb.mux bin %1046, %1047, %1044 : i1
        sv.passign %decStage_3_isSystem, %1048 : i1
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
            %c36_i8 = hw.constant 36 : i8
            %c35_i8 = hw.constant 35 : i8
            %c34_i8 = hw.constant 34 : i8
            %c26_i8 = hw.constant 26 : i8
            %c25_i8 = hw.constant 25 : i8
            %c24_i8 = hw.constant 24 : i8
            %c16_i8 = hw.constant 16 : i8
            %c15_i8 = hw.constant 15 : i8
            %c14_i8 = hw.constant 14 : i8
            %c6_i8 = hw.constant 6 : i8
            %c5_i8 = hw.constant 5 : i8
            %c4_i8 = hw.constant 4 : i8
            %c3_i8 = hw.constant 3 : i8
            %c2_i8 = hw.constant 2 : i8
            %c1_i8 = hw.constant 1 : i8
            %c-91_i8 = hw.constant -91 : i8
            %c0_i8 = hw.constant 0 : i8
            sv.for %i = %c0_i8 to %c-91_i8 step %c1_i8 : i8 {
              %RANDOM = sv.macro.ref.expr.se @RANDOM() : () -> i32
              %2199 = sv.array_index_inout %_RANDOM[%i] : !hw.inout<uarray<165xi32>>, i8
              sv.bpassign %2199, %RANDOM : i32
            } {hw.verilogName = "i"}
            %721 = sv.array_index_inout %_RANDOM[%c0_i8] : !hw.inout<uarray<165xi32>>, i8
            %722 = sv.read_inout %721 : !hw.inout<i32>
            %723 = comb.extract %722 from 0 : (i32) -> i2
            sv.bpassign %currentThread, %723 : i2
            %724 = sv.array_index_inout %_RANDOM[%c0_i8] : !hw.inout<uarray<165xi32>>, i8
            %725 = sv.read_inout %724 : !hw.inout<i32>
            %726 = comb.extract %725 from 2 : (i32) -> i30
            %727 = sv.array_index_inout %_RANDOM[%c1_i8] : !hw.inout<uarray<165xi32>>, i8
            %728 = sv.read_inout %727 : !hw.inout<i32>
            %729 = comb.extract %728 from 0 : (i32) -> i2
            %730 = comb.concat %726, %729 : i30, i2
            sv.bpassign %pcRegs_0, %730 : i32
            %731 = sv.array_index_inout %_RANDOM[%c1_i8] : !hw.inout<uarray<165xi32>>, i8
            %732 = sv.read_inout %731 : !hw.inout<i32>
            %733 = comb.extract %732 from 2 : (i32) -> i30
            %734 = sv.array_index_inout %_RANDOM[%c2_i8] : !hw.inout<uarray<165xi32>>, i8
            %735 = sv.read_inout %734 : !hw.inout<i32>
            %736 = comb.extract %735 from 0 : (i32) -> i2
            %737 = comb.concat %733, %736 : i30, i2
            sv.bpassign %pcRegs_1, %737 : i32
            %738 = sv.array_index_inout %_RANDOM[%c2_i8] : !hw.inout<uarray<165xi32>>, i8
            %739 = sv.read_inout %738 : !hw.inout<i32>
            %740 = comb.extract %739 from 2 : (i32) -> i30
            %741 = sv.array_index_inout %_RANDOM[%c3_i8] : !hw.inout<uarray<165xi32>>, i8
            %742 = sv.read_inout %741 : !hw.inout<i32>
            %743 = comb.extract %742 from 0 : (i32) -> i2
            %744 = comb.concat %740, %743 : i30, i2
            sv.bpassign %pcRegs_2, %744 : i32
            %745 = sv.array_index_inout %_RANDOM[%c3_i8] : !hw.inout<uarray<165xi32>>, i8
            %746 = sv.read_inout %745 : !hw.inout<i32>
            %747 = comb.extract %746 from 2 : (i32) -> i30
            %748 = sv.array_index_inout %_RANDOM[%c4_i8] : !hw.inout<uarray<165xi32>>, i8
            %749 = sv.read_inout %748 : !hw.inout<i32>
            %750 = comb.extract %749 from 0 : (i32) -> i2
            %751 = comb.concat %747, %750 : i30, i2
            sv.bpassign %pcRegs_3, %751 : i32
            %752 = sv.array_index_inout %_RANDOM[%c4_i8] : !hw.inout<uarray<165xi32>>, i8
            %753 = sv.read_inout %752 : !hw.inout<i32>
            %754 = comb.extract %753 from 2 : (i32) -> i2
            sv.bpassign %ifStage_0_threadId, %754 : i2
            %755 = sv.array_index_inout %_RANDOM[%c4_i8] : !hw.inout<uarray<165xi32>>, i8
            %756 = sv.read_inout %755 : !hw.inout<i32>
            %757 = comb.extract %756 from 4 : (i32) -> i1
            sv.bpassign %ifStage_0_valid, %757 : i1
            %758 = sv.array_index_inout %_RANDOM[%c4_i8] : !hw.inout<uarray<165xi32>>, i8
            %759 = sv.read_inout %758 : !hw.inout<i32>
            %760 = comb.extract %759 from 5 : (i32) -> i27
            %761 = sv.array_index_inout %_RANDOM[%c5_i8] : !hw.inout<uarray<165xi32>>, i8
            %762 = sv.read_inout %761 : !hw.inout<i32>
            %763 = comb.extract %762 from 0 : (i32) -> i5
            %764 = comb.concat %760, %763 : i27, i5
            sv.bpassign %ifStage_0_pc, %764 : i32
            %765 = sv.array_index_inout %_RANDOM[%c5_i8] : !hw.inout<uarray<165xi32>>, i8
            %766 = sv.read_inout %765 : !hw.inout<i32>
            %767 = comb.extract %766 from 5 : (i32) -> i27
            %768 = sv.array_index_inout %_RANDOM[%c6_i8] : !hw.inout<uarray<165xi32>>, i8
            %769 = sv.read_inout %768 : !hw.inout<i32>
            %770 = comb.extract %769 from 0 : (i32) -> i5
            %771 = comb.concat %767, %770 : i27, i5
            sv.bpassign %ifStage_0_instr, %771 : i32
            %772 = sv.array_index_inout %_RANDOM[%c14_i8] : !hw.inout<uarray<165xi32>>, i8
            %773 = sv.read_inout %772 : !hw.inout<i32>
            %774 = comb.extract %773 from 3 : (i32) -> i2
            sv.bpassign %ifStage_1_threadId, %774 : i2
            %775 = sv.array_index_inout %_RANDOM[%c14_i8] : !hw.inout<uarray<165xi32>>, i8
            %776 = sv.read_inout %775 : !hw.inout<i32>
            %777 = comb.extract %776 from 5 : (i32) -> i1
            sv.bpassign %ifStage_1_valid, %777 : i1
            %778 = sv.array_index_inout %_RANDOM[%c14_i8] : !hw.inout<uarray<165xi32>>, i8
            %779 = sv.read_inout %778 : !hw.inout<i32>
            %780 = comb.extract %779 from 6 : (i32) -> i26
            %781 = sv.array_index_inout %_RANDOM[%c15_i8] : !hw.inout<uarray<165xi32>>, i8
            %782 = sv.read_inout %781 : !hw.inout<i32>
            %783 = comb.extract %782 from 0 : (i32) -> i6
            %784 = comb.concat %780, %783 : i26, i6
            sv.bpassign %ifStage_1_pc, %784 : i32
            %785 = sv.array_index_inout %_RANDOM[%c15_i8] : !hw.inout<uarray<165xi32>>, i8
            %786 = sv.read_inout %785 : !hw.inout<i32>
            %787 = comb.extract %786 from 6 : (i32) -> i26
            %788 = sv.array_index_inout %_RANDOM[%c16_i8] : !hw.inout<uarray<165xi32>>, i8
            %789 = sv.read_inout %788 : !hw.inout<i32>
            %790 = comb.extract %789 from 0 : (i32) -> i6
            %791 = comb.concat %787, %790 : i26, i6
            sv.bpassign %ifStage_1_instr, %791 : i32
            %792 = sv.array_index_inout %_RANDOM[%c24_i8] : !hw.inout<uarray<165xi32>>, i8
            %793 = sv.read_inout %792 : !hw.inout<i32>
            %794 = comb.extract %793 from 4 : (i32) -> i2
            sv.bpassign %ifStage_2_threadId, %794 : i2
            %795 = sv.array_index_inout %_RANDOM[%c24_i8] : !hw.inout<uarray<165xi32>>, i8
            %796 = sv.read_inout %795 : !hw.inout<i32>
            %797 = comb.extract %796 from 6 : (i32) -> i1
            sv.bpassign %ifStage_2_valid, %797 : i1
            %798 = sv.array_index_inout %_RANDOM[%c24_i8] : !hw.inout<uarray<165xi32>>, i8
            %799 = sv.read_inout %798 : !hw.inout<i32>
            %800 = comb.extract %799 from 7 : (i32) -> i25
            %801 = sv.array_index_inout %_RANDOM[%c25_i8] : !hw.inout<uarray<165xi32>>, i8
            %802 = sv.read_inout %801 : !hw.inout<i32>
            %803 = comb.extract %802 from 0 : (i32) -> i7
            %804 = comb.concat %800, %803 : i25, i7
            sv.bpassign %ifStage_2_pc, %804 : i32
            %805 = sv.array_index_inout %_RANDOM[%c25_i8] : !hw.inout<uarray<165xi32>>, i8
            %806 = sv.read_inout %805 : !hw.inout<i32>
            %807 = comb.extract %806 from 7 : (i32) -> i25
            %808 = sv.array_index_inout %_RANDOM[%c26_i8] : !hw.inout<uarray<165xi32>>, i8
            %809 = sv.read_inout %808 : !hw.inout<i32>
            %810 = comb.extract %809 from 0 : (i32) -> i7
            %811 = comb.concat %807, %810 : i25, i7
            sv.bpassign %ifStage_2_instr, %811 : i32
            %812 = sv.array_index_inout %_RANDOM[%c34_i8] : !hw.inout<uarray<165xi32>>, i8
            %813 = sv.read_inout %812 : !hw.inout<i32>
            %814 = comb.extract %813 from 5 : (i32) -> i2
            sv.bpassign %ifStage_3_threadId, %814 : i2
            %815 = sv.array_index_inout %_RANDOM[%c34_i8] : !hw.inout<uarray<165xi32>>, i8
            %816 = sv.read_inout %815 : !hw.inout<i32>
            %817 = comb.extract %816 from 7 : (i32) -> i1
            sv.bpassign %ifStage_3_valid, %817 : i1
            %818 = sv.array_index_inout %_RANDOM[%c34_i8] : !hw.inout<uarray<165xi32>>, i8
            %819 = sv.read_inout %818 : !hw.inout<i32>
            %820 = comb.extract %819 from 8 : (i32) -> i24
            %821 = sv.array_index_inout %_RANDOM[%c35_i8] : !hw.inout<uarray<165xi32>>, i8
            %822 = sv.read_inout %821 : !hw.inout<i32>
            %823 = comb.extract %822 from 0 : (i32) -> i8
            %824 = comb.concat %820, %823 : i24, i8
            sv.bpassign %ifStage_3_pc, %824 : i32
            %825 = sv.array_index_inout %_RANDOM[%c35_i8] : !hw.inout<uarray<165xi32>>, i8
            %826 = sv.read_inout %825 : !hw.inout<i32>
            %827 = comb.extract %826 from 8 : (i32) -> i24
            %828 = sv.array_index_inout %_RANDOM[%c36_i8] : !hw.inout<uarray<165xi32>>, i8
            %829 = sv.read_inout %828 : !hw.inout<i32>
            %830 = comb.extract %829 from 0 : (i32) -> i8
            %831 = comb.concat %827, %830 : i24, i8
            sv.bpassign %ifStage_3_instr, %831 : i32
            %832 = sv.array_index_inout %_RANDOM[%c44_i8] : !hw.inout<uarray<165xi32>>, i8
            %833 = sv.read_inout %832 : !hw.inout<i32>
            %834 = comb.extract %833 from 6 : (i32) -> i2
            sv.bpassign %decStage_0_threadId, %834 : i2
            %835 = sv.array_index_inout %_RANDOM[%c44_i8] : !hw.inout<uarray<165xi32>>, i8
            %836 = sv.read_inout %835 : !hw.inout<i32>
            %837 = comb.extract %836 from 8 : (i32) -> i1
            sv.bpassign %decStage_0_valid, %837 : i1
            %838 = sv.array_index_inout %_RANDOM[%c44_i8] : !hw.inout<uarray<165xi32>>, i8
            %839 = sv.read_inout %838 : !hw.inout<i32>
            %840 = comb.extract %839 from 9 : (i32) -> i23
            %841 = sv.array_index_inout %_RANDOM[%c45_i8] : !hw.inout<uarray<165xi32>>, i8
            %842 = sv.read_inout %841 : !hw.inout<i32>
            %843 = comb.extract %842 from 0 : (i32) -> i9
            %844 = comb.concat %840, %843 : i23, i9
            sv.bpassign %decStage_0_pc, %844 : i32
            %845 = sv.array_index_inout %_RANDOM[%c45_i8] : !hw.inout<uarray<165xi32>>, i8
            %846 = sv.read_inout %845 : !hw.inout<i32>
            %847 = comb.extract %846 from 9 : (i32) -> i23
            %848 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %849 = sv.read_inout %848 : !hw.inout<i32>
            %850 = comb.extract %849 from 0 : (i32) -> i9
            %851 = comb.concat %847, %850 : i23, i9
            sv.bpassign %decStage_0_instr, %851 : i32
            %852 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %853 = sv.read_inout %852 : !hw.inout<i32>
            %854 = comb.extract %853 from 9 : (i32) -> i1
            sv.bpassign %decStage_0_isALU, %854 : i1
            %855 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %856 = sv.read_inout %855 : !hw.inout<i32>
            %857 = comb.extract %856 from 10 : (i32) -> i1
            sv.bpassign %decStage_0_isLoad, %857 : i1
            %858 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %859 = sv.read_inout %858 : !hw.inout<i32>
            %860 = comb.extract %859 from 11 : (i32) -> i1
            sv.bpassign %decStage_0_isStore, %860 : i1
            %861 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %862 = sv.read_inout %861 : !hw.inout<i32>
            %863 = comb.extract %862 from 12 : (i32) -> i1
            sv.bpassign %decStage_0_isBranch, %863 : i1
            %864 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %865 = sv.read_inout %864 : !hw.inout<i32>
            %866 = comb.extract %865 from 13 : (i32) -> i1
            sv.bpassign %decStage_0_isJAL, %866 : i1
            %867 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %868 = sv.read_inout %867 : !hw.inout<i32>
            %869 = comb.extract %868 from 14 : (i32) -> i1
            sv.bpassign %decStage_0_isJALR, %869 : i1
            %870 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %871 = sv.read_inout %870 : !hw.inout<i32>
            %872 = comb.extract %871 from 15 : (i32) -> i1
            sv.bpassign %decStage_0_isLUI, %872 : i1
            %873 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %874 = sv.read_inout %873 : !hw.inout<i32>
            %875 = comb.extract %874 from 16 : (i32) -> i1
            sv.bpassign %decStage_0_isAUIPC, %875 : i1
            %876 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %877 = sv.read_inout %876 : !hw.inout<i32>
            %878 = comb.extract %877 from 17 : (i32) -> i1
            sv.bpassign %decStage_0_isFence, %878 : i1
            %879 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %880 = sv.read_inout %879 : !hw.inout<i32>
            %881 = comb.extract %880 from 18 : (i32) -> i1
            sv.bpassign %decStage_0_isSystem, %881 : i1
            %882 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %883 = sv.read_inout %882 : !hw.inout<i32>
            %884 = comb.extract %883 from 19 : (i32) -> i5
            sv.bpassign %decStage_0_aluOp, %884 : i5
            %885 = sv.array_index_inout %_RANDOM[%c46_i8] : !hw.inout<uarray<165xi32>>, i8
            %886 = sv.read_inout %885 : !hw.inout<i32>
            %887 = comb.extract %886 from 24 : (i32) -> i8
            %888 = sv.array_index_inout %_RANDOM[%c47_i8] : !hw.inout<uarray<165xi32>>, i8
            %889 = sv.read_inout %888 : !hw.inout<i32>
            %890 = comb.extract %889 from 0 : (i32) -> i24
            %891 = comb.concat %887, %890 : i8, i24
            sv.bpassign %decStage_0_imm, %891 : i32
            %892 = sv.array_index_inout %_RANDOM[%c47_i8] : !hw.inout<uarray<165xi32>>, i8
            %893 = sv.read_inout %892 : !hw.inout<i32>
            %894 = comb.extract %893 from 24 : (i32) -> i5
            sv.bpassign %decStage_0_rs1, %894 : i5
            %895 = sv.array_index_inout %_RANDOM[%c47_i8] : !hw.inout<uarray<165xi32>>, i8
            %896 = sv.read_inout %895 : !hw.inout<i32>
            %897 = comb.extract %896 from 29 : (i32) -> i3
            %898 = sv.array_index_inout %_RANDOM[%c48_i8] : !hw.inout<uarray<165xi32>>, i8
            %899 = sv.read_inout %898 : !hw.inout<i32>
            %900 = comb.extract %899 from 0 : (i32) -> i2
            %901 = comb.concat %897, %900 : i3, i2
            sv.bpassign %decStage_0_rs2, %901 : i5
            %902 = sv.array_index_inout %_RANDOM[%c48_i8] : !hw.inout<uarray<165xi32>>, i8
            %903 = sv.read_inout %902 : !hw.inout<i32>
            %904 = comb.extract %903 from 2 : (i32) -> i5
            sv.bpassign %decStage_0_rd, %904 : i5
            %905 = sv.array_index_inout %_RANDOM[%c48_i8] : !hw.inout<uarray<165xi32>>, i8
            %906 = sv.read_inout %905 : !hw.inout<i32>
            %907 = comb.extract %906 from 7 : (i32) -> i25
            %908 = sv.array_index_inout %_RANDOM[%c49_i8] : !hw.inout<uarray<165xi32>>, i8
            %909 = sv.read_inout %908 : !hw.inout<i32>
            %910 = comb.extract %909 from 0 : (i32) -> i7
            %911 = comb.concat %907, %910 : i25, i7
            sv.bpassign %decStage_0_rs1Data, %911 : i32
            %912 = sv.array_index_inout %_RANDOM[%c49_i8] : !hw.inout<uarray<165xi32>>, i8
            %913 = sv.read_inout %912 : !hw.inout<i32>
            %914 = comb.extract %913 from 7 : (i32) -> i25
            %915 = sv.array_index_inout %_RANDOM[%c50_i8] : !hw.inout<uarray<165xi32>>, i8
            %916 = sv.read_inout %915 : !hw.inout<i32>
            %917 = comb.extract %916 from 0 : (i32) -> i7
            %918 = comb.concat %914, %917 : i25, i7
            sv.bpassign %decStage_0_rs2Data, %918 : i32
            %919 = sv.array_index_inout %_RANDOM[%c50_i8] : !hw.inout<uarray<165xi32>>, i8
            %920 = sv.read_inout %919 : !hw.inout<i32>
            %921 = comb.extract %920 from 7 : (i32) -> i25
            %922 = sv.array_index_inout %_RANDOM[%c51_i8] : !hw.inout<uarray<165xi32>>, i8
            %923 = sv.read_inout %922 : !hw.inout<i32>
            %924 = comb.extract %923 from 0 : (i32) -> i7
            %925 = comb.concat %921, %924 : i25, i7
            sv.bpassign %decStage_0_memAddr, %925 : i32
            %926 = sv.array_index_inout %_RANDOM[%c51_i8] : !hw.inout<uarray<165xi32>>, i8
            %927 = sv.read_inout %926 : !hw.inout<i32>
            %928 = comb.extract %927 from 7 : (i32) -> i25
            %929 = sv.array_index_inout %_RANDOM[%c52_i8] : !hw.inout<uarray<165xi32>>, i8
            %930 = sv.read_inout %929 : !hw.inout<i32>
            %931 = comb.extract %930 from 0 : (i32) -> i7
            %932 = comb.concat %928, %931 : i25, i7
            sv.bpassign %decStage_0_memWdata, %932 : i32
            %933 = sv.array_index_inout %_RANDOM[%c52_i8] : !hw.inout<uarray<165xi32>>, i8
            %934 = sv.read_inout %933 : !hw.inout<i32>
            %935 = comb.extract %934 from 7 : (i32) -> i25
            %936 = sv.array_index_inout %_RANDOM[%c53_i8] : !hw.inout<uarray<165xi32>>, i8
            %937 = sv.read_inout %936 : !hw.inout<i32>
            %938 = comb.extract %937 from 0 : (i32) -> i7
            %939 = comb.concat %935, %938 : i25, i7
            sv.bpassign %decStage_0_memRdata, %939 : i32
            %940 = sv.array_index_inout %_RANDOM[%c53_i8] : !hw.inout<uarray<165xi32>>, i8
            %941 = sv.read_inout %940 : !hw.inout<i32>
            %942 = comb.extract %941 from 7 : (i32) -> i25
            %943 = sv.array_index_inout %_RANDOM[%c54_i8] : !hw.inout<uarray<165xi32>>, i8
            %944 = sv.read_inout %943 : !hw.inout<i32>
            %945 = comb.extract %944 from 0 : (i32) -> i7
            %946 = comb.concat %942, %945 : i25, i7
            sv.bpassign %decStage_0_aluResult, %946 : i32
            %947 = sv.array_index_inout %_RANDOM[%c54_i8] : !hw.inout<uarray<165xi32>>, i8
            %948 = sv.read_inout %947 : !hw.inout<i32>
            %949 = comb.extract %948 from 7 : (i32) -> i2
            sv.bpassign %decStage_1_threadId, %949 : i2
            %950 = sv.array_index_inout %_RANDOM[%c54_i8] : !hw.inout<uarray<165xi32>>, i8
            %951 = sv.read_inout %950 : !hw.inout<i32>
            %952 = comb.extract %951 from 9 : (i32) -> i1
            sv.bpassign %decStage_1_valid, %952 : i1
            %953 = sv.array_index_inout %_RANDOM[%c54_i8] : !hw.inout<uarray<165xi32>>, i8
            %954 = sv.read_inout %953 : !hw.inout<i32>
            %955 = comb.extract %954 from 10 : (i32) -> i22
            %956 = sv.array_index_inout %_RANDOM[%c55_i8] : !hw.inout<uarray<165xi32>>, i8
            %957 = sv.read_inout %956 : !hw.inout<i32>
            %958 = comb.extract %957 from 0 : (i32) -> i10
            %959 = comb.concat %955, %958 : i22, i10
            sv.bpassign %decStage_1_pc, %959 : i32
            %960 = sv.array_index_inout %_RANDOM[%c55_i8] : !hw.inout<uarray<165xi32>>, i8
            %961 = sv.read_inout %960 : !hw.inout<i32>
            %962 = comb.extract %961 from 10 : (i32) -> i22
            %963 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %964 = sv.read_inout %963 : !hw.inout<i32>
            %965 = comb.extract %964 from 0 : (i32) -> i10
            %966 = comb.concat %962, %965 : i22, i10
            sv.bpassign %decStage_1_instr, %966 : i32
            %967 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %968 = sv.read_inout %967 : !hw.inout<i32>
            %969 = comb.extract %968 from 10 : (i32) -> i1
            sv.bpassign %decStage_1_isALU, %969 : i1
            %970 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %971 = sv.read_inout %970 : !hw.inout<i32>
            %972 = comb.extract %971 from 11 : (i32) -> i1
            sv.bpassign %decStage_1_isLoad, %972 : i1
            %973 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %974 = sv.read_inout %973 : !hw.inout<i32>
            %975 = comb.extract %974 from 12 : (i32) -> i1
            sv.bpassign %decStage_1_isStore, %975 : i1
            %976 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %977 = sv.read_inout %976 : !hw.inout<i32>
            %978 = comb.extract %977 from 13 : (i32) -> i1
            sv.bpassign %decStage_1_isBranch, %978 : i1
            %979 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %980 = sv.read_inout %979 : !hw.inout<i32>
            %981 = comb.extract %980 from 14 : (i32) -> i1
            sv.bpassign %decStage_1_isJAL, %981 : i1
            %982 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %983 = sv.read_inout %982 : !hw.inout<i32>
            %984 = comb.extract %983 from 15 : (i32) -> i1
            sv.bpassign %decStage_1_isJALR, %984 : i1
            %985 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %986 = sv.read_inout %985 : !hw.inout<i32>
            %987 = comb.extract %986 from 16 : (i32) -> i1
            sv.bpassign %decStage_1_isLUI, %987 : i1
            %988 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %989 = sv.read_inout %988 : !hw.inout<i32>
            %990 = comb.extract %989 from 17 : (i32) -> i1
            sv.bpassign %decStage_1_isAUIPC, %990 : i1
            %991 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %992 = sv.read_inout %991 : !hw.inout<i32>
            %993 = comb.extract %992 from 18 : (i32) -> i1
            sv.bpassign %decStage_1_isFence, %993 : i1
            %994 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %995 = sv.read_inout %994 : !hw.inout<i32>
            %996 = comb.extract %995 from 19 : (i32) -> i1
            sv.bpassign %decStage_1_isSystem, %996 : i1
            %997 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %998 = sv.read_inout %997 : !hw.inout<i32>
            %999 = comb.extract %998 from 20 : (i32) -> i5
            sv.bpassign %decStage_1_aluOp, %999 : i5
            %1000 = sv.array_index_inout %_RANDOM[%c56_i8] : !hw.inout<uarray<165xi32>>, i8
            %1001 = sv.read_inout %1000 : !hw.inout<i32>
            %1002 = comb.extract %1001 from 25 : (i32) -> i7
            %1003 = sv.array_index_inout %_RANDOM[%c57_i8] : !hw.inout<uarray<165xi32>>, i8
            %1004 = sv.read_inout %1003 : !hw.inout<i32>
            %1005 = comb.extract %1004 from 0 : (i32) -> i25
            %1006 = comb.concat %1002, %1005 : i7, i25
            sv.bpassign %decStage_1_imm, %1006 : i32
            %1007 = sv.array_index_inout %_RANDOM[%c57_i8] : !hw.inout<uarray<165xi32>>, i8
            %1008 = sv.read_inout %1007 : !hw.inout<i32>
            %1009 = comb.extract %1008 from 25 : (i32) -> i5
            sv.bpassign %decStage_1_rs1, %1009 : i5
            %1010 = sv.array_index_inout %_RANDOM[%c57_i8] : !hw.inout<uarray<165xi32>>, i8
            %1011 = sv.read_inout %1010 : !hw.inout<i32>
            %1012 = comb.extract %1011 from 30 : (i32) -> i2
            %1013 = sv.array_index_inout %_RANDOM[%c58_i8] : !hw.inout<uarray<165xi32>>, i8
            %1014 = sv.read_inout %1013 : !hw.inout<i32>
            %1015 = comb.extract %1014 from 0 : (i32) -> i3
            %1016 = comb.concat %1012, %1015 : i2, i3
            sv.bpassign %decStage_1_rs2, %1016 : i5
            %1017 = sv.array_index_inout %_RANDOM[%c58_i8] : !hw.inout<uarray<165xi32>>, i8
            %1018 = sv.read_inout %1017 : !hw.inout<i32>
            %1019 = comb.extract %1018 from 3 : (i32) -> i5
            sv.bpassign %decStage_1_rd, %1019 : i5
            %1020 = sv.array_index_inout %_RANDOM[%c58_i8] : !hw.inout<uarray<165xi32>>, i8
            %1021 = sv.read_inout %1020 : !hw.inout<i32>
            %1022 = comb.extract %1021 from 8 : (i32) -> i24
            %1023 = sv.array_index_inout %_RANDOM[%c59_i8] : !hw.inout<uarray<165xi32>>, i8
            %1024 = sv.read_inout %1023 : !hw.inout<i32>
            %1025 = comb.extract %1024 from 0 : (i32) -> i8
            %1026 = comb.concat %1022, %1025 : i24, i8
            sv.bpassign %decStage_1_rs1Data, %1026 : i32
            %1027 = sv.array_index_inout %_RANDOM[%c59_i8] : !hw.inout<uarray<165xi32>>, i8
            %1028 = sv.read_inout %1027 : !hw.inout<i32>
            %1029 = comb.extract %1028 from 8 : (i32) -> i24
            %1030 = sv.array_index_inout %_RANDOM[%c60_i8] : !hw.inout<uarray<165xi32>>, i8
            %1031 = sv.read_inout %1030 : !hw.inout<i32>
            %1032 = comb.extract %1031 from 0 : (i32) -> i8
            %1033 = comb.concat %1029, %1032 : i24, i8
            sv.bpassign %decStage_1_rs2Data, %1033 : i32
            %1034 = sv.array_index_inout %_RANDOM[%c60_i8] : !hw.inout<uarray<165xi32>>, i8
            %1035 = sv.read_inout %1034 : !hw.inout<i32>
            %1036 = comb.extract %1035 from 8 : (i32) -> i24
            %1037 = sv.array_index_inout %_RANDOM[%c61_i8] : !hw.inout<uarray<165xi32>>, i8
            %1038 = sv.read_inout %1037 : !hw.inout<i32>
            %1039 = comb.extract %1038 from 0 : (i32) -> i8
            %1040 = comb.concat %1036, %1039 : i24, i8
            sv.bpassign %decStage_1_memAddr, %1040 : i32
            %1041 = sv.array_index_inout %_RANDOM[%c61_i8] : !hw.inout<uarray<165xi32>>, i8
            %1042 = sv.read_inout %1041 : !hw.inout<i32>
            %1043 = comb.extract %1042 from 8 : (i32) -> i24
            %1044 = sv.array_index_inout %_RANDOM[%c62_i8] : !hw.inout<uarray<165xi32>>, i8
            %1045 = sv.read_inout %1044 : !hw.inout<i32>
            %1046 = comb.extract %1045 from 0 : (i32) -> i8
            %1047 = comb.concat %1043, %1046 : i24, i8
            sv.bpassign %decStage_1_memWdata, %1047 : i32
            %1048 = sv.array_index_inout %_RANDOM[%c62_i8] : !hw.inout<uarray<165xi32>>, i8
            %1049 = sv.read_inout %1048 : !hw.inout<i32>
            %1050 = comb.extract %1049 from 8 : (i32) -> i24
            %1051 = sv.array_index_inout %_RANDOM[%c63_i8] : !hw.inout<uarray<165xi32>>, i8
            %1052 = sv.read_inout %1051 : !hw.inout<i32>
            %1053 = comb.extract %1052 from 0 : (i32) -> i8
            %1054 = comb.concat %1050, %1053 : i24, i8
            sv.bpassign %decStage_1_memRdata, %1054 : i32
            %1055 = sv.array_index_inout %_RANDOM[%c63_i8] : !hw.inout<uarray<165xi32>>, i8
            %1056 = sv.read_inout %1055 : !hw.inout<i32>
            %1057 = comb.extract %1056 from 8 : (i32) -> i24
            %1058 = sv.array_index_inout %_RANDOM[%c64_i8] : !hw.inout<uarray<165xi32>>, i8
            %1059 = sv.read_inout %1058 : !hw.inout<i32>
            %1060 = comb.extract %1059 from 0 : (i32) -> i8
            %1061 = comb.concat %1057, %1060 : i24, i8
            sv.bpassign %decStage_1_aluResult, %1061 : i32
            %1062 = sv.array_index_inout %_RANDOM[%c64_i8] : !hw.inout<uarray<165xi32>>, i8
            %1063 = sv.read_inout %1062 : !hw.inout<i32>
            %1064 = comb.extract %1063 from 8 : (i32) -> i2
            sv.bpassign %decStage_2_threadId, %1064 : i2
            %1065 = sv.array_index_inout %_RANDOM[%c64_i8] : !hw.inout<uarray<165xi32>>, i8
            %1066 = sv.read_inout %1065 : !hw.inout<i32>
            %1067 = comb.extract %1066 from 10 : (i32) -> i1
            sv.bpassign %decStage_2_valid, %1067 : i1
            %1068 = sv.array_index_inout %_RANDOM[%c64_i8] : !hw.inout<uarray<165xi32>>, i8
            %1069 = sv.read_inout %1068 : !hw.inout<i32>
            %1070 = comb.extract %1069 from 11 : (i32) -> i21
            %1071 = sv.array_index_inout %_RANDOM[%c65_i8] : !hw.inout<uarray<165xi32>>, i8
            %1072 = sv.read_inout %1071 : !hw.inout<i32>
            %1073 = comb.extract %1072 from 0 : (i32) -> i11
            %1074 = comb.concat %1070, %1073 : i21, i11
            sv.bpassign %decStage_2_pc, %1074 : i32
            %1075 = sv.array_index_inout %_RANDOM[%c65_i8] : !hw.inout<uarray<165xi32>>, i8
            %1076 = sv.read_inout %1075 : !hw.inout<i32>
            %1077 = comb.extract %1076 from 11 : (i32) -> i21
            %1078 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1079 = sv.read_inout %1078 : !hw.inout<i32>
            %1080 = comb.extract %1079 from 0 : (i32) -> i11
            %1081 = comb.concat %1077, %1080 : i21, i11
            sv.bpassign %decStage_2_instr, %1081 : i32
            %1082 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1083 = sv.read_inout %1082 : !hw.inout<i32>
            %1084 = comb.extract %1083 from 11 : (i32) -> i1
            sv.bpassign %decStage_2_isALU, %1084 : i1
            %1085 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1086 = sv.read_inout %1085 : !hw.inout<i32>
            %1087 = comb.extract %1086 from 12 : (i32) -> i1
            sv.bpassign %decStage_2_isLoad, %1087 : i1
            %1088 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1089 = sv.read_inout %1088 : !hw.inout<i32>
            %1090 = comb.extract %1089 from 13 : (i32) -> i1
            sv.bpassign %decStage_2_isStore, %1090 : i1
            %1091 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1092 = sv.read_inout %1091 : !hw.inout<i32>
            %1093 = comb.extract %1092 from 14 : (i32) -> i1
            sv.bpassign %decStage_2_isBranch, %1093 : i1
            %1094 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1095 = sv.read_inout %1094 : !hw.inout<i32>
            %1096 = comb.extract %1095 from 15 : (i32) -> i1
            sv.bpassign %decStage_2_isJAL, %1096 : i1
            %1097 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1098 = sv.read_inout %1097 : !hw.inout<i32>
            %1099 = comb.extract %1098 from 16 : (i32) -> i1
            sv.bpassign %decStage_2_isJALR, %1099 : i1
            %1100 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1101 = sv.read_inout %1100 : !hw.inout<i32>
            %1102 = comb.extract %1101 from 17 : (i32) -> i1
            sv.bpassign %decStage_2_isLUI, %1102 : i1
            %1103 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1104 = sv.read_inout %1103 : !hw.inout<i32>
            %1105 = comb.extract %1104 from 18 : (i32) -> i1
            sv.bpassign %decStage_2_isAUIPC, %1105 : i1
            %1106 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1107 = sv.read_inout %1106 : !hw.inout<i32>
            %1108 = comb.extract %1107 from 19 : (i32) -> i1
            sv.bpassign %decStage_2_isFence, %1108 : i1
            %1109 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1110 = sv.read_inout %1109 : !hw.inout<i32>
            %1111 = comb.extract %1110 from 20 : (i32) -> i1
            sv.bpassign %decStage_2_isSystem, %1111 : i1
            %1112 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1113 = sv.read_inout %1112 : !hw.inout<i32>
            %1114 = comb.extract %1113 from 21 : (i32) -> i5
            sv.bpassign %decStage_2_aluOp, %1114 : i5
            %1115 = sv.array_index_inout %_RANDOM[%c66_i8] : !hw.inout<uarray<165xi32>>, i8
            %1116 = sv.read_inout %1115 : !hw.inout<i32>
            %1117 = comb.extract %1116 from 26 : (i32) -> i6
            %1118 = sv.array_index_inout %_RANDOM[%c67_i8] : !hw.inout<uarray<165xi32>>, i8
            %1119 = sv.read_inout %1118 : !hw.inout<i32>
            %1120 = comb.extract %1119 from 0 : (i32) -> i26
            %1121 = comb.concat %1117, %1120 : i6, i26
            sv.bpassign %decStage_2_imm, %1121 : i32
            %1122 = sv.array_index_inout %_RANDOM[%c67_i8] : !hw.inout<uarray<165xi32>>, i8
            %1123 = sv.read_inout %1122 : !hw.inout<i32>
            %1124 = comb.extract %1123 from 26 : (i32) -> i5
            sv.bpassign %decStage_2_rs1, %1124 : i5
            %1125 = sv.array_index_inout %_RANDOM[%c67_i8] : !hw.inout<uarray<165xi32>>, i8
            %1126 = sv.read_inout %1125 : !hw.inout<i32>
            %1127 = comb.extract %1126 from 31 : (i32) -> i1
            %1128 = sv.array_index_inout %_RANDOM[%c68_i8] : !hw.inout<uarray<165xi32>>, i8
            %1129 = sv.read_inout %1128 : !hw.inout<i32>
            %1130 = comb.extract %1129 from 0 : (i32) -> i4
            %1131 = comb.concat %1127, %1130 : i1, i4
            sv.bpassign %decStage_2_rs2, %1131 : i5
            %1132 = sv.array_index_inout %_RANDOM[%c68_i8] : !hw.inout<uarray<165xi32>>, i8
            %1133 = sv.read_inout %1132 : !hw.inout<i32>
            %1134 = comb.extract %1133 from 4 : (i32) -> i5
            sv.bpassign %decStage_2_rd, %1134 : i5
            %1135 = sv.array_index_inout %_RANDOM[%c68_i8] : !hw.inout<uarray<165xi32>>, i8
            %1136 = sv.read_inout %1135 : !hw.inout<i32>
            %1137 = comb.extract %1136 from 9 : (i32) -> i23
            %1138 = sv.array_index_inout %_RANDOM[%c69_i8] : !hw.inout<uarray<165xi32>>, i8
            %1139 = sv.read_inout %1138 : !hw.inout<i32>
            %1140 = comb.extract %1139 from 0 : (i32) -> i9
            %1141 = comb.concat %1137, %1140 : i23, i9
            sv.bpassign %decStage_2_rs1Data, %1141 : i32
            %1142 = sv.array_index_inout %_RANDOM[%c69_i8] : !hw.inout<uarray<165xi32>>, i8
            %1143 = sv.read_inout %1142 : !hw.inout<i32>
            %1144 = comb.extract %1143 from 9 : (i32) -> i23
            %1145 = sv.array_index_inout %_RANDOM[%c70_i8] : !hw.inout<uarray<165xi32>>, i8
            %1146 = sv.read_inout %1145 : !hw.inout<i32>
            %1147 = comb.extract %1146 from 0 : (i32) -> i9
            %1148 = comb.concat %1144, %1147 : i23, i9
            sv.bpassign %decStage_2_rs2Data, %1148 : i32
            %1149 = sv.array_index_inout %_RANDOM[%c70_i8] : !hw.inout<uarray<165xi32>>, i8
            %1150 = sv.read_inout %1149 : !hw.inout<i32>
            %1151 = comb.extract %1150 from 9 : (i32) -> i23
            %1152 = sv.array_index_inout %_RANDOM[%c71_i8] : !hw.inout<uarray<165xi32>>, i8
            %1153 = sv.read_inout %1152 : !hw.inout<i32>
            %1154 = comb.extract %1153 from 0 : (i32) -> i9
            %1155 = comb.concat %1151, %1154 : i23, i9
            sv.bpassign %decStage_2_memAddr, %1155 : i32
            %1156 = sv.array_index_inout %_RANDOM[%c71_i8] : !hw.inout<uarray<165xi32>>, i8
            %1157 = sv.read_inout %1156 : !hw.inout<i32>
            %1158 = comb.extract %1157 from 9 : (i32) -> i23
            %1159 = sv.array_index_inout %_RANDOM[%c72_i8] : !hw.inout<uarray<165xi32>>, i8
            %1160 = sv.read_inout %1159 : !hw.inout<i32>
            %1161 = comb.extract %1160 from 0 : (i32) -> i9
            %1162 = comb.concat %1158, %1161 : i23, i9
            sv.bpassign %decStage_2_memWdata, %1162 : i32
            %1163 = sv.array_index_inout %_RANDOM[%c72_i8] : !hw.inout<uarray<165xi32>>, i8
            %1164 = sv.read_inout %1163 : !hw.inout<i32>
            %1165 = comb.extract %1164 from 9 : (i32) -> i23
            %1166 = sv.array_index_inout %_RANDOM[%c73_i8] : !hw.inout<uarray<165xi32>>, i8
            %1167 = sv.read_inout %1166 : !hw.inout<i32>
            %1168 = comb.extract %1167 from 0 : (i32) -> i9
            %1169 = comb.concat %1165, %1168 : i23, i9
            sv.bpassign %decStage_2_memRdata, %1169 : i32
            %1170 = sv.array_index_inout %_RANDOM[%c73_i8] : !hw.inout<uarray<165xi32>>, i8
            %1171 = sv.read_inout %1170 : !hw.inout<i32>
            %1172 = comb.extract %1171 from 9 : (i32) -> i23
            %1173 = sv.array_index_inout %_RANDOM[%c74_i8] : !hw.inout<uarray<165xi32>>, i8
            %1174 = sv.read_inout %1173 : !hw.inout<i32>
            %1175 = comb.extract %1174 from 0 : (i32) -> i9
            %1176 = comb.concat %1172, %1175 : i23, i9
            sv.bpassign %decStage_2_aluResult, %1176 : i32
            %1177 = sv.array_index_inout %_RANDOM[%c74_i8] : !hw.inout<uarray<165xi32>>, i8
            %1178 = sv.read_inout %1177 : !hw.inout<i32>
            %1179 = comb.extract %1178 from 9 : (i32) -> i2
            sv.bpassign %decStage_3_threadId, %1179 : i2
            %1180 = sv.array_index_inout %_RANDOM[%c74_i8] : !hw.inout<uarray<165xi32>>, i8
            %1181 = sv.read_inout %1180 : !hw.inout<i32>
            %1182 = comb.extract %1181 from 11 : (i32) -> i1
            sv.bpassign %decStage_3_valid, %1182 : i1
            %1183 = sv.array_index_inout %_RANDOM[%c74_i8] : !hw.inout<uarray<165xi32>>, i8
            %1184 = sv.read_inout %1183 : !hw.inout<i32>
            %1185 = comb.extract %1184 from 12 : (i32) -> i20
            %1186 = sv.array_index_inout %_RANDOM[%c75_i8] : !hw.inout<uarray<165xi32>>, i8
            %1187 = sv.read_inout %1186 : !hw.inout<i32>
            %1188 = comb.extract %1187 from 0 : (i32) -> i12
            %1189 = comb.concat %1185, %1188 : i20, i12
            sv.bpassign %decStage_3_pc, %1189 : i32
            %1190 = sv.array_index_inout %_RANDOM[%c75_i8] : !hw.inout<uarray<165xi32>>, i8
            %1191 = sv.read_inout %1190 : !hw.inout<i32>
            %1192 = comb.extract %1191 from 12 : (i32) -> i20
            %1193 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1194 = sv.read_inout %1193 : !hw.inout<i32>
            %1195 = comb.extract %1194 from 0 : (i32) -> i12
            %1196 = comb.concat %1192, %1195 : i20, i12
            sv.bpassign %decStage_3_instr, %1196 : i32
            %1197 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1198 = sv.read_inout %1197 : !hw.inout<i32>
            %1199 = comb.extract %1198 from 12 : (i32) -> i1
            sv.bpassign %decStage_3_isALU, %1199 : i1
            %1200 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1201 = sv.read_inout %1200 : !hw.inout<i32>
            %1202 = comb.extract %1201 from 13 : (i32) -> i1
            sv.bpassign %decStage_3_isLoad, %1202 : i1
            %1203 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1204 = sv.read_inout %1203 : !hw.inout<i32>
            %1205 = comb.extract %1204 from 14 : (i32) -> i1
            sv.bpassign %decStage_3_isStore, %1205 : i1
            %1206 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1207 = sv.read_inout %1206 : !hw.inout<i32>
            %1208 = comb.extract %1207 from 15 : (i32) -> i1
            sv.bpassign %decStage_3_isBranch, %1208 : i1
            %1209 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1210 = sv.read_inout %1209 : !hw.inout<i32>
            %1211 = comb.extract %1210 from 16 : (i32) -> i1
            sv.bpassign %decStage_3_isJAL, %1211 : i1
            %1212 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1213 = sv.read_inout %1212 : !hw.inout<i32>
            %1214 = comb.extract %1213 from 17 : (i32) -> i1
            sv.bpassign %decStage_3_isJALR, %1214 : i1
            %1215 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1216 = sv.read_inout %1215 : !hw.inout<i32>
            %1217 = comb.extract %1216 from 18 : (i32) -> i1
            sv.bpassign %decStage_3_isLUI, %1217 : i1
            %1218 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1219 = sv.read_inout %1218 : !hw.inout<i32>
            %1220 = comb.extract %1219 from 19 : (i32) -> i1
            sv.bpassign %decStage_3_isAUIPC, %1220 : i1
            %1221 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1222 = sv.read_inout %1221 : !hw.inout<i32>
            %1223 = comb.extract %1222 from 20 : (i32) -> i1
            sv.bpassign %decStage_3_isFence, %1223 : i1
            %1224 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1225 = sv.read_inout %1224 : !hw.inout<i32>
            %1226 = comb.extract %1225 from 21 : (i32) -> i1
            sv.bpassign %decStage_3_isSystem, %1226 : i1
            %1227 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1228 = sv.read_inout %1227 : !hw.inout<i32>
            %1229 = comb.extract %1228 from 22 : (i32) -> i5
            sv.bpassign %decStage_3_aluOp, %1229 : i5
            %1230 = sv.array_index_inout %_RANDOM[%c76_i8] : !hw.inout<uarray<165xi32>>, i8
            %1231 = sv.read_inout %1230 : !hw.inout<i32>
            %1232 = comb.extract %1231 from 27 : (i32) -> i5
            %1233 = sv.array_index_inout %_RANDOM[%c77_i8] : !hw.inout<uarray<165xi32>>, i8
            %1234 = sv.read_inout %1233 : !hw.inout<i32>
            %1235 = comb.extract %1234 from 0 : (i32) -> i27
            %1236 = comb.concat %1232, %1235 : i5, i27
            sv.bpassign %decStage_3_imm, %1236 : i32
            %1237 = sv.array_index_inout %_RANDOM[%c77_i8] : !hw.inout<uarray<165xi32>>, i8
            %1238 = sv.read_inout %1237 : !hw.inout<i32>
            %1239 = comb.extract %1238 from 27 : (i32) -> i5
            sv.bpassign %decStage_3_rs1, %1239 : i5
            %1240 = sv.array_index_inout %_RANDOM[%c78_i8] : !hw.inout<uarray<165xi32>>, i8
            %1241 = sv.read_inout %1240 : !hw.inout<i32>
            %1242 = comb.extract %1241 from 0 : (i32) -> i5
            sv.bpassign %decStage_3_rs2, %1242 : i5
            %1243 = sv.array_index_inout %_RANDOM[%c78_i8] : !hw.inout<uarray<165xi32>>, i8
            %1244 = sv.read_inout %1243 : !hw.inout<i32>
            %1245 = comb.extract %1244 from 5 : (i32) -> i5
            sv.bpassign %decStage_3_rd, %1245 : i5
            %1246 = sv.array_index_inout %_RANDOM[%c78_i8] : !hw.inout<uarray<165xi32>>, i8
            %1247 = sv.read_inout %1246 : !hw.inout<i32>
            %1248 = comb.extract %1247 from 10 : (i32) -> i22
            %1249 = sv.array_index_inout %_RANDOM[%c79_i8] : !hw.inout<uarray<165xi32>>, i8
            %1250 = sv.read_inout %1249 : !hw.inout<i32>
            %1251 = comb.extract %1250 from 0 : (i32) -> i10
            %1252 = comb.concat %1248, %1251 : i22, i10
            sv.bpassign %decStage_3_rs1Data, %1252 : i32
            %1253 = sv.array_index_inout %_RANDOM[%c79_i8] : !hw.inout<uarray<165xi32>>, i8
            %1254 = sv.read_inout %1253 : !hw.inout<i32>
            %1255 = comb.extract %1254 from 10 : (i32) -> i22
            %1256 = sv.array_index_inout %_RANDOM[%c80_i8] : !hw.inout<uarray<165xi32>>, i8
            %1257 = sv.read_inout %1256 : !hw.inout<i32>
            %1258 = comb.extract %1257 from 0 : (i32) -> i10
            %1259 = comb.concat %1255, %1258 : i22, i10
            sv.bpassign %decStage_3_rs2Data, %1259 : i32
            %1260 = sv.array_index_inout %_RANDOM[%c80_i8] : !hw.inout<uarray<165xi32>>, i8
            %1261 = sv.read_inout %1260 : !hw.inout<i32>
            %1262 = comb.extract %1261 from 10 : (i32) -> i22
            %1263 = sv.array_index_inout %_RANDOM[%c81_i8] : !hw.inout<uarray<165xi32>>, i8
            %1264 = sv.read_inout %1263 : !hw.inout<i32>
            %1265 = comb.extract %1264 from 0 : (i32) -> i10
            %1266 = comb.concat %1262, %1265 : i22, i10
            sv.bpassign %decStage_3_memAddr, %1266 : i32
            %1267 = sv.array_index_inout %_RANDOM[%c81_i8] : !hw.inout<uarray<165xi32>>, i8
            %1268 = sv.read_inout %1267 : !hw.inout<i32>
            %1269 = comb.extract %1268 from 10 : (i32) -> i22
            %1270 = sv.array_index_inout %_RANDOM[%c82_i8] : !hw.inout<uarray<165xi32>>, i8
            %1271 = sv.read_inout %1270 : !hw.inout<i32>
            %1272 = comb.extract %1271 from 0 : (i32) -> i10
            %1273 = comb.concat %1269, %1272 : i22, i10
            sv.bpassign %decStage_3_memWdata, %1273 : i32
            %1274 = sv.array_index_inout %_RANDOM[%c82_i8] : !hw.inout<uarray<165xi32>>, i8
            %1275 = sv.read_inout %1274 : !hw.inout<i32>
            %1276 = comb.extract %1275 from 10 : (i32) -> i22
            %1277 = sv.array_index_inout %_RANDOM[%c83_i8] : !hw.inout<uarray<165xi32>>, i8
            %1278 = sv.read_inout %1277 : !hw.inout<i32>
            %1279 = comb.extract %1278 from 0 : (i32) -> i10
            %1280 = comb.concat %1276, %1279 : i22, i10
            sv.bpassign %decStage_3_memRdata, %1280 : i32
            %1281 = sv.array_index_inout %_RANDOM[%c83_i8] : !hw.inout<uarray<165xi32>>, i8
            %1282 = sv.read_inout %1281 : !hw.inout<i32>
            %1283 = comb.extract %1282 from 10 : (i32) -> i22
            %1284 = sv.array_index_inout %_RANDOM[%c84_i8] : !hw.inout<uarray<165xi32>>, i8
            %1285 = sv.read_inout %1284 : !hw.inout<i32>
            %1286 = comb.extract %1285 from 0 : (i32) -> i10
            %1287 = comb.concat %1283, %1286 : i22, i10
            sv.bpassign %decStage_3_aluResult, %1287 : i32
            %1288 = sv.array_index_inout %_RANDOM[%c84_i8] : !hw.inout<uarray<165xi32>>, i8
            %1289 = sv.read_inout %1288 : !hw.inout<i32>
            %1290 = comb.extract %1289 from 10 : (i32) -> i2
            sv.bpassign %exStage_0_threadId, %1290 : i2
            %1291 = sv.array_index_inout %_RANDOM[%c84_i8] : !hw.inout<uarray<165xi32>>, i8
            %1292 = sv.read_inout %1291 : !hw.inout<i32>
            %1293 = comb.extract %1292 from 12 : (i32) -> i1
            sv.bpassign %exStage_0_valid, %1293 : i1
            %1294 = sv.array_index_inout %_RANDOM[%c84_i8] : !hw.inout<uarray<165xi32>>, i8
            %1295 = sv.read_inout %1294 : !hw.inout<i32>
            %1296 = comb.extract %1295 from 13 : (i32) -> i19
            %1297 = sv.array_index_inout %_RANDOM[%c85_i8] : !hw.inout<uarray<165xi32>>, i8
            %1298 = sv.read_inout %1297 : !hw.inout<i32>
            %1299 = comb.extract %1298 from 0 : (i32) -> i13
            %1300 = comb.concat %1296, %1299 : i19, i13
            sv.bpassign %exStage_0_pc, %1300 : i32
            %1301 = sv.array_index_inout %_RANDOM[%c85_i8] : !hw.inout<uarray<165xi32>>, i8
            %1302 = sv.read_inout %1301 : !hw.inout<i32>
            %1303 = comb.extract %1302 from 13 : (i32) -> i19
            %1304 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1305 = sv.read_inout %1304 : !hw.inout<i32>
            %1306 = comb.extract %1305 from 0 : (i32) -> i13
            %1307 = comb.concat %1303, %1306 : i19, i13
            sv.bpassign %exStage_0_instr, %1307 : i32
            %1308 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1309 = sv.read_inout %1308 : !hw.inout<i32>
            %1310 = comb.extract %1309 from 13 : (i32) -> i1
            sv.bpassign %exStage_0_isALU, %1310 : i1
            %1311 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1312 = sv.read_inout %1311 : !hw.inout<i32>
            %1313 = comb.extract %1312 from 14 : (i32) -> i1
            sv.bpassign %exStage_0_isLoad, %1313 : i1
            %1314 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1315 = sv.read_inout %1314 : !hw.inout<i32>
            %1316 = comb.extract %1315 from 15 : (i32) -> i1
            sv.bpassign %exStage_0_isStore, %1316 : i1
            %1317 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1318 = sv.read_inout %1317 : !hw.inout<i32>
            %1319 = comb.extract %1318 from 16 : (i32) -> i1
            sv.bpassign %exStage_0_isBranch, %1319 : i1
            %1320 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1321 = sv.read_inout %1320 : !hw.inout<i32>
            %1322 = comb.extract %1321 from 17 : (i32) -> i1
            sv.bpassign %exStage_0_isJAL, %1322 : i1
            %1323 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1324 = sv.read_inout %1323 : !hw.inout<i32>
            %1325 = comb.extract %1324 from 18 : (i32) -> i1
            sv.bpassign %exStage_0_isJALR, %1325 : i1
            %1326 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1327 = sv.read_inout %1326 : !hw.inout<i32>
            %1328 = comb.extract %1327 from 19 : (i32) -> i1
            sv.bpassign %exStage_0_isLUI, %1328 : i1
            %1329 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1330 = sv.read_inout %1329 : !hw.inout<i32>
            %1331 = comb.extract %1330 from 20 : (i32) -> i1
            sv.bpassign %exStage_0_isAUIPC, %1331 : i1
            %1332 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1333 = sv.read_inout %1332 : !hw.inout<i32>
            %1334 = comb.extract %1333 from 21 : (i32) -> i1
            sv.bpassign %exStage_0_isFence, %1334 : i1
            %1335 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1336 = sv.read_inout %1335 : !hw.inout<i32>
            %1337 = comb.extract %1336 from 22 : (i32) -> i1
            sv.bpassign %exStage_0_isSystem, %1337 : i1
            %1338 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1339 = sv.read_inout %1338 : !hw.inout<i32>
            %1340 = comb.extract %1339 from 23 : (i32) -> i5
            sv.bpassign %exStage_0_aluOp, %1340 : i5
            %1341 = sv.array_index_inout %_RANDOM[%c86_i8] : !hw.inout<uarray<165xi32>>, i8
            %1342 = sv.read_inout %1341 : !hw.inout<i32>
            %1343 = comb.extract %1342 from 28 : (i32) -> i4
            %1344 = sv.array_index_inout %_RANDOM[%c87_i8] : !hw.inout<uarray<165xi32>>, i8
            %1345 = sv.read_inout %1344 : !hw.inout<i32>
            %1346 = comb.extract %1345 from 0 : (i32) -> i28
            %1347 = comb.concat %1343, %1346 : i4, i28
            sv.bpassign %exStage_0_imm, %1347 : i32
            %1348 = sv.array_index_inout %_RANDOM[%c87_i8] : !hw.inout<uarray<165xi32>>, i8
            %1349 = sv.read_inout %1348 : !hw.inout<i32>
            %1350 = comb.extract %1349 from 28 : (i32) -> i4
            %1351 = sv.array_index_inout %_RANDOM[%c88_i8] : !hw.inout<uarray<165xi32>>, i8
            %1352 = sv.read_inout %1351 : !hw.inout<i32>
            %1353 = comb.extract %1352 from 0 : (i32) -> i1
            %1354 = comb.concat %1350, %1353 : i4, i1
            sv.bpassign %exStage_0_rs1, %1354 : i5
            %1355 = sv.array_index_inout %_RANDOM[%c88_i8] : !hw.inout<uarray<165xi32>>, i8
            %1356 = sv.read_inout %1355 : !hw.inout<i32>
            %1357 = comb.extract %1356 from 1 : (i32) -> i5
            sv.bpassign %exStage_0_rs2, %1357 : i5
            %1358 = sv.array_index_inout %_RANDOM[%c88_i8] : !hw.inout<uarray<165xi32>>, i8
            %1359 = sv.read_inout %1358 : !hw.inout<i32>
            %1360 = comb.extract %1359 from 6 : (i32) -> i5
            sv.bpassign %exStage_0_rd, %1360 : i5
            %1361 = sv.array_index_inout %_RANDOM[%c88_i8] : !hw.inout<uarray<165xi32>>, i8
            %1362 = sv.read_inout %1361 : !hw.inout<i32>
            %1363 = comb.extract %1362 from 11 : (i32) -> i21
            %1364 = sv.array_index_inout %_RANDOM[%c89_i8] : !hw.inout<uarray<165xi32>>, i8
            %1365 = sv.read_inout %1364 : !hw.inout<i32>
            %1366 = comb.extract %1365 from 0 : (i32) -> i11
            %1367 = comb.concat %1363, %1366 : i21, i11
            sv.bpassign %exStage_0_rs1Data, %1367 : i32
            %1368 = sv.array_index_inout %_RANDOM[%c89_i8] : !hw.inout<uarray<165xi32>>, i8
            %1369 = sv.read_inout %1368 : !hw.inout<i32>
            %1370 = comb.extract %1369 from 11 : (i32) -> i21
            %1371 = sv.array_index_inout %_RANDOM[%c90_i8] : !hw.inout<uarray<165xi32>>, i8
            %1372 = sv.read_inout %1371 : !hw.inout<i32>
            %1373 = comb.extract %1372 from 0 : (i32) -> i11
            %1374 = comb.concat %1370, %1373 : i21, i11
            sv.bpassign %exStage_0_rs2Data, %1374 : i32
            %1375 = sv.array_index_inout %_RANDOM[%c90_i8] : !hw.inout<uarray<165xi32>>, i8
            %1376 = sv.read_inout %1375 : !hw.inout<i32>
            %1377 = comb.extract %1376 from 11 : (i32) -> i21
            %1378 = sv.array_index_inout %_RANDOM[%c91_i8] : !hw.inout<uarray<165xi32>>, i8
            %1379 = sv.read_inout %1378 : !hw.inout<i32>
            %1380 = comb.extract %1379 from 0 : (i32) -> i11
            %1381 = comb.concat %1377, %1380 : i21, i11
            sv.bpassign %exStage_0_memAddr, %1381 : i32
            %1382 = sv.array_index_inout %_RANDOM[%c91_i8] : !hw.inout<uarray<165xi32>>, i8
            %1383 = sv.read_inout %1382 : !hw.inout<i32>
            %1384 = comb.extract %1383 from 11 : (i32) -> i21
            %1385 = sv.array_index_inout %_RANDOM[%c92_i8] : !hw.inout<uarray<165xi32>>, i8
            %1386 = sv.read_inout %1385 : !hw.inout<i32>
            %1387 = comb.extract %1386 from 0 : (i32) -> i11
            %1388 = comb.concat %1384, %1387 : i21, i11
            sv.bpassign %exStage_0_memWdata, %1388 : i32
            %1389 = sv.array_index_inout %_RANDOM[%c92_i8] : !hw.inout<uarray<165xi32>>, i8
            %1390 = sv.read_inout %1389 : !hw.inout<i32>
            %1391 = comb.extract %1390 from 11 : (i32) -> i21
            %1392 = sv.array_index_inout %_RANDOM[%c93_i8] : !hw.inout<uarray<165xi32>>, i8
            %1393 = sv.read_inout %1392 : !hw.inout<i32>
            %1394 = comb.extract %1393 from 0 : (i32) -> i11
            %1395 = comb.concat %1391, %1394 : i21, i11
            sv.bpassign %exStage_0_memRdata, %1395 : i32
            %1396 = sv.array_index_inout %_RANDOM[%c93_i8] : !hw.inout<uarray<165xi32>>, i8
            %1397 = sv.read_inout %1396 : !hw.inout<i32>
            %1398 = comb.extract %1397 from 11 : (i32) -> i21
            %1399 = sv.array_index_inout %_RANDOM[%c94_i8] : !hw.inout<uarray<165xi32>>, i8
            %1400 = sv.read_inout %1399 : !hw.inout<i32>
            %1401 = comb.extract %1400 from 0 : (i32) -> i11
            %1402 = comb.concat %1398, %1401 : i21, i11
            sv.bpassign %exStage_0_aluResult, %1402 : i32
            %1403 = sv.array_index_inout %_RANDOM[%c94_i8] : !hw.inout<uarray<165xi32>>, i8
            %1404 = sv.read_inout %1403 : !hw.inout<i32>
            %1405 = comb.extract %1404 from 11 : (i32) -> i2
            sv.bpassign %exStage_1_threadId, %1405 : i2
            %1406 = sv.array_index_inout %_RANDOM[%c94_i8] : !hw.inout<uarray<165xi32>>, i8
            %1407 = sv.read_inout %1406 : !hw.inout<i32>
            %1408 = comb.extract %1407 from 13 : (i32) -> i1
            sv.bpassign %exStage_1_valid, %1408 : i1
            %1409 = sv.array_index_inout %_RANDOM[%c94_i8] : !hw.inout<uarray<165xi32>>, i8
            %1410 = sv.read_inout %1409 : !hw.inout<i32>
            %1411 = comb.extract %1410 from 14 : (i32) -> i18
            %1412 = sv.array_index_inout %_RANDOM[%c95_i8] : !hw.inout<uarray<165xi32>>, i8
            %1413 = sv.read_inout %1412 : !hw.inout<i32>
            %1414 = comb.extract %1413 from 0 : (i32) -> i14
            %1415 = comb.concat %1411, %1414 : i18, i14
            sv.bpassign %exStage_1_pc, %1415 : i32
            %1416 = sv.array_index_inout %_RANDOM[%c95_i8] : !hw.inout<uarray<165xi32>>, i8
            %1417 = sv.read_inout %1416 : !hw.inout<i32>
            %1418 = comb.extract %1417 from 14 : (i32) -> i18
            %1419 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1420 = sv.read_inout %1419 : !hw.inout<i32>
            %1421 = comb.extract %1420 from 0 : (i32) -> i14
            %1422 = comb.concat %1418, %1421 : i18, i14
            sv.bpassign %exStage_1_instr, %1422 : i32
            %1423 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1424 = sv.read_inout %1423 : !hw.inout<i32>
            %1425 = comb.extract %1424 from 14 : (i32) -> i1
            sv.bpassign %exStage_1_isALU, %1425 : i1
            %1426 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1427 = sv.read_inout %1426 : !hw.inout<i32>
            %1428 = comb.extract %1427 from 15 : (i32) -> i1
            sv.bpassign %exStage_1_isLoad, %1428 : i1
            %1429 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1430 = sv.read_inout %1429 : !hw.inout<i32>
            %1431 = comb.extract %1430 from 16 : (i32) -> i1
            sv.bpassign %exStage_1_isStore, %1431 : i1
            %1432 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1433 = sv.read_inout %1432 : !hw.inout<i32>
            %1434 = comb.extract %1433 from 17 : (i32) -> i1
            sv.bpassign %exStage_1_isBranch, %1434 : i1
            %1435 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1436 = sv.read_inout %1435 : !hw.inout<i32>
            %1437 = comb.extract %1436 from 18 : (i32) -> i1
            sv.bpassign %exStage_1_isJAL, %1437 : i1
            %1438 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1439 = sv.read_inout %1438 : !hw.inout<i32>
            %1440 = comb.extract %1439 from 19 : (i32) -> i1
            sv.bpassign %exStage_1_isJALR, %1440 : i1
            %1441 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1442 = sv.read_inout %1441 : !hw.inout<i32>
            %1443 = comb.extract %1442 from 20 : (i32) -> i1
            sv.bpassign %exStage_1_isLUI, %1443 : i1
            %1444 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1445 = sv.read_inout %1444 : !hw.inout<i32>
            %1446 = comb.extract %1445 from 21 : (i32) -> i1
            sv.bpassign %exStage_1_isAUIPC, %1446 : i1
            %1447 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1448 = sv.read_inout %1447 : !hw.inout<i32>
            %1449 = comb.extract %1448 from 22 : (i32) -> i1
            sv.bpassign %exStage_1_isFence, %1449 : i1
            %1450 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1451 = sv.read_inout %1450 : !hw.inout<i32>
            %1452 = comb.extract %1451 from 23 : (i32) -> i1
            sv.bpassign %exStage_1_isSystem, %1452 : i1
            %1453 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1454 = sv.read_inout %1453 : !hw.inout<i32>
            %1455 = comb.extract %1454 from 24 : (i32) -> i5
            sv.bpassign %exStage_1_aluOp, %1455 : i5
            %1456 = sv.array_index_inout %_RANDOM[%c96_i8] : !hw.inout<uarray<165xi32>>, i8
            %1457 = sv.read_inout %1456 : !hw.inout<i32>
            %1458 = comb.extract %1457 from 29 : (i32) -> i3
            %1459 = sv.array_index_inout %_RANDOM[%c97_i8] : !hw.inout<uarray<165xi32>>, i8
            %1460 = sv.read_inout %1459 : !hw.inout<i32>
            %1461 = comb.extract %1460 from 0 : (i32) -> i29
            %1462 = comb.concat %1458, %1461 : i3, i29
            sv.bpassign %exStage_1_imm, %1462 : i32
            %1463 = sv.array_index_inout %_RANDOM[%c97_i8] : !hw.inout<uarray<165xi32>>, i8
            %1464 = sv.read_inout %1463 : !hw.inout<i32>
            %1465 = comb.extract %1464 from 29 : (i32) -> i3
            %1466 = sv.array_index_inout %_RANDOM[%c98_i8] : !hw.inout<uarray<165xi32>>, i8
            %1467 = sv.read_inout %1466 : !hw.inout<i32>
            %1468 = comb.extract %1467 from 0 : (i32) -> i2
            %1469 = comb.concat %1465, %1468 : i3, i2
            sv.bpassign %exStage_1_rs1, %1469 : i5
            %1470 = sv.array_index_inout %_RANDOM[%c98_i8] : !hw.inout<uarray<165xi32>>, i8
            %1471 = sv.read_inout %1470 : !hw.inout<i32>
            %1472 = comb.extract %1471 from 2 : (i32) -> i5
            sv.bpassign %exStage_1_rs2, %1472 : i5
            %1473 = sv.array_index_inout %_RANDOM[%c98_i8] : !hw.inout<uarray<165xi32>>, i8
            %1474 = sv.read_inout %1473 : !hw.inout<i32>
            %1475 = comb.extract %1474 from 7 : (i32) -> i5
            sv.bpassign %exStage_1_rd, %1475 : i5
            %1476 = sv.array_index_inout %_RANDOM[%c98_i8] : !hw.inout<uarray<165xi32>>, i8
            %1477 = sv.read_inout %1476 : !hw.inout<i32>
            %1478 = comb.extract %1477 from 12 : (i32) -> i20
            %1479 = sv.array_index_inout %_RANDOM[%c99_i8] : !hw.inout<uarray<165xi32>>, i8
            %1480 = sv.read_inout %1479 : !hw.inout<i32>
            %1481 = comb.extract %1480 from 0 : (i32) -> i12
            %1482 = comb.concat %1478, %1481 : i20, i12
            sv.bpassign %exStage_1_rs1Data, %1482 : i32
            %1483 = sv.array_index_inout %_RANDOM[%c99_i8] : !hw.inout<uarray<165xi32>>, i8
            %1484 = sv.read_inout %1483 : !hw.inout<i32>
            %1485 = comb.extract %1484 from 12 : (i32) -> i20
            %1486 = sv.array_index_inout %_RANDOM[%c100_i8] : !hw.inout<uarray<165xi32>>, i8
            %1487 = sv.read_inout %1486 : !hw.inout<i32>
            %1488 = comb.extract %1487 from 0 : (i32) -> i12
            %1489 = comb.concat %1485, %1488 : i20, i12
            sv.bpassign %exStage_1_rs2Data, %1489 : i32
            %1490 = sv.array_index_inout %_RANDOM[%c100_i8] : !hw.inout<uarray<165xi32>>, i8
            %1491 = sv.read_inout %1490 : !hw.inout<i32>
            %1492 = comb.extract %1491 from 12 : (i32) -> i20
            %1493 = sv.array_index_inout %_RANDOM[%c101_i8] : !hw.inout<uarray<165xi32>>, i8
            %1494 = sv.read_inout %1493 : !hw.inout<i32>
            %1495 = comb.extract %1494 from 0 : (i32) -> i12
            %1496 = comb.concat %1492, %1495 : i20, i12
            sv.bpassign %exStage_1_memAddr, %1496 : i32
            %1497 = sv.array_index_inout %_RANDOM[%c101_i8] : !hw.inout<uarray<165xi32>>, i8
            %1498 = sv.read_inout %1497 : !hw.inout<i32>
            %1499 = comb.extract %1498 from 12 : (i32) -> i20
            %1500 = sv.array_index_inout %_RANDOM[%c102_i8] : !hw.inout<uarray<165xi32>>, i8
            %1501 = sv.read_inout %1500 : !hw.inout<i32>
            %1502 = comb.extract %1501 from 0 : (i32) -> i12
            %1503 = comb.concat %1499, %1502 : i20, i12
            sv.bpassign %exStage_1_memWdata, %1503 : i32
            %1504 = sv.array_index_inout %_RANDOM[%c102_i8] : !hw.inout<uarray<165xi32>>, i8
            %1505 = sv.read_inout %1504 : !hw.inout<i32>
            %1506 = comb.extract %1505 from 12 : (i32) -> i20
            %1507 = sv.array_index_inout %_RANDOM[%c103_i8] : !hw.inout<uarray<165xi32>>, i8
            %1508 = sv.read_inout %1507 : !hw.inout<i32>
            %1509 = comb.extract %1508 from 0 : (i32) -> i12
            %1510 = comb.concat %1506, %1509 : i20, i12
            sv.bpassign %exStage_1_memRdata, %1510 : i32
            %1511 = sv.array_index_inout %_RANDOM[%c103_i8] : !hw.inout<uarray<165xi32>>, i8
            %1512 = sv.read_inout %1511 : !hw.inout<i32>
            %1513 = comb.extract %1512 from 12 : (i32) -> i20
            %1514 = sv.array_index_inout %_RANDOM[%c104_i8] : !hw.inout<uarray<165xi32>>, i8
            %1515 = sv.read_inout %1514 : !hw.inout<i32>
            %1516 = comb.extract %1515 from 0 : (i32) -> i12
            %1517 = comb.concat %1513, %1516 : i20, i12
            sv.bpassign %exStage_1_aluResult, %1517 : i32
            %1518 = sv.array_index_inout %_RANDOM[%c104_i8] : !hw.inout<uarray<165xi32>>, i8
            %1519 = sv.read_inout %1518 : !hw.inout<i32>
            %1520 = comb.extract %1519 from 12 : (i32) -> i2
            sv.bpassign %exStage_2_threadId, %1520 : i2
            %1521 = sv.array_index_inout %_RANDOM[%c104_i8] : !hw.inout<uarray<165xi32>>, i8
            %1522 = sv.read_inout %1521 : !hw.inout<i32>
            %1523 = comb.extract %1522 from 14 : (i32) -> i1
            sv.bpassign %exStage_2_valid, %1523 : i1
            %1524 = sv.array_index_inout %_RANDOM[%c104_i8] : !hw.inout<uarray<165xi32>>, i8
            %1525 = sv.read_inout %1524 : !hw.inout<i32>
            %1526 = comb.extract %1525 from 15 : (i32) -> i17
            %1527 = sv.array_index_inout %_RANDOM[%c105_i8] : !hw.inout<uarray<165xi32>>, i8
            %1528 = sv.read_inout %1527 : !hw.inout<i32>
            %1529 = comb.extract %1528 from 0 : (i32) -> i15
            %1530 = comb.concat %1526, %1529 : i17, i15
            sv.bpassign %exStage_2_pc, %1530 : i32
            %1531 = sv.array_index_inout %_RANDOM[%c105_i8] : !hw.inout<uarray<165xi32>>, i8
            %1532 = sv.read_inout %1531 : !hw.inout<i32>
            %1533 = comb.extract %1532 from 15 : (i32) -> i17
            %1534 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1535 = sv.read_inout %1534 : !hw.inout<i32>
            %1536 = comb.extract %1535 from 0 : (i32) -> i15
            %1537 = comb.concat %1533, %1536 : i17, i15
            sv.bpassign %exStage_2_instr, %1537 : i32
            %1538 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1539 = sv.read_inout %1538 : !hw.inout<i32>
            %1540 = comb.extract %1539 from 15 : (i32) -> i1
            sv.bpassign %exStage_2_isALU, %1540 : i1
            %1541 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1542 = sv.read_inout %1541 : !hw.inout<i32>
            %1543 = comb.extract %1542 from 16 : (i32) -> i1
            sv.bpassign %exStage_2_isLoad, %1543 : i1
            %1544 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1545 = sv.read_inout %1544 : !hw.inout<i32>
            %1546 = comb.extract %1545 from 17 : (i32) -> i1
            sv.bpassign %exStage_2_isStore, %1546 : i1
            %1547 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1548 = sv.read_inout %1547 : !hw.inout<i32>
            %1549 = comb.extract %1548 from 18 : (i32) -> i1
            sv.bpassign %exStage_2_isBranch, %1549 : i1
            %1550 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1551 = sv.read_inout %1550 : !hw.inout<i32>
            %1552 = comb.extract %1551 from 19 : (i32) -> i1
            sv.bpassign %exStage_2_isJAL, %1552 : i1
            %1553 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1554 = sv.read_inout %1553 : !hw.inout<i32>
            %1555 = comb.extract %1554 from 20 : (i32) -> i1
            sv.bpassign %exStage_2_isJALR, %1555 : i1
            %1556 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1557 = sv.read_inout %1556 : !hw.inout<i32>
            %1558 = comb.extract %1557 from 21 : (i32) -> i1
            sv.bpassign %exStage_2_isLUI, %1558 : i1
            %1559 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1560 = sv.read_inout %1559 : !hw.inout<i32>
            %1561 = comb.extract %1560 from 22 : (i32) -> i1
            sv.bpassign %exStage_2_isAUIPC, %1561 : i1
            %1562 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1563 = sv.read_inout %1562 : !hw.inout<i32>
            %1564 = comb.extract %1563 from 23 : (i32) -> i1
            sv.bpassign %exStage_2_isFence, %1564 : i1
            %1565 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1566 = sv.read_inout %1565 : !hw.inout<i32>
            %1567 = comb.extract %1566 from 24 : (i32) -> i1
            sv.bpassign %exStage_2_isSystem, %1567 : i1
            %1568 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1569 = sv.read_inout %1568 : !hw.inout<i32>
            %1570 = comb.extract %1569 from 25 : (i32) -> i5
            sv.bpassign %exStage_2_aluOp, %1570 : i5
            %1571 = sv.array_index_inout %_RANDOM[%c106_i8] : !hw.inout<uarray<165xi32>>, i8
            %1572 = sv.read_inout %1571 : !hw.inout<i32>
            %1573 = comb.extract %1572 from 30 : (i32) -> i2
            %1574 = sv.array_index_inout %_RANDOM[%c107_i8] : !hw.inout<uarray<165xi32>>, i8
            %1575 = sv.read_inout %1574 : !hw.inout<i32>
            %1576 = comb.extract %1575 from 0 : (i32) -> i30
            %1577 = comb.concat %1573, %1576 : i2, i30
            sv.bpassign %exStage_2_imm, %1577 : i32
            %1578 = sv.array_index_inout %_RANDOM[%c107_i8] : !hw.inout<uarray<165xi32>>, i8
            %1579 = sv.read_inout %1578 : !hw.inout<i32>
            %1580 = comb.extract %1579 from 30 : (i32) -> i2
            %1581 = sv.array_index_inout %_RANDOM[%c108_i8] : !hw.inout<uarray<165xi32>>, i8
            %1582 = sv.read_inout %1581 : !hw.inout<i32>
            %1583 = comb.extract %1582 from 0 : (i32) -> i3
            %1584 = comb.concat %1580, %1583 : i2, i3
            sv.bpassign %exStage_2_rs1, %1584 : i5
            %1585 = sv.array_index_inout %_RANDOM[%c108_i8] : !hw.inout<uarray<165xi32>>, i8
            %1586 = sv.read_inout %1585 : !hw.inout<i32>
            %1587 = comb.extract %1586 from 3 : (i32) -> i5
            sv.bpassign %exStage_2_rs2, %1587 : i5
            %1588 = sv.array_index_inout %_RANDOM[%c108_i8] : !hw.inout<uarray<165xi32>>, i8
            %1589 = sv.read_inout %1588 : !hw.inout<i32>
            %1590 = comb.extract %1589 from 8 : (i32) -> i5
            sv.bpassign %exStage_2_rd, %1590 : i5
            %1591 = sv.array_index_inout %_RANDOM[%c108_i8] : !hw.inout<uarray<165xi32>>, i8
            %1592 = sv.read_inout %1591 : !hw.inout<i32>
            %1593 = comb.extract %1592 from 13 : (i32) -> i19
            %1594 = sv.array_index_inout %_RANDOM[%c109_i8] : !hw.inout<uarray<165xi32>>, i8
            %1595 = sv.read_inout %1594 : !hw.inout<i32>
            %1596 = comb.extract %1595 from 0 : (i32) -> i13
            %1597 = comb.concat %1593, %1596 : i19, i13
            sv.bpassign %exStage_2_rs1Data, %1597 : i32
            %1598 = sv.array_index_inout %_RANDOM[%c109_i8] : !hw.inout<uarray<165xi32>>, i8
            %1599 = sv.read_inout %1598 : !hw.inout<i32>
            %1600 = comb.extract %1599 from 13 : (i32) -> i19
            %1601 = sv.array_index_inout %_RANDOM[%c110_i8] : !hw.inout<uarray<165xi32>>, i8
            %1602 = sv.read_inout %1601 : !hw.inout<i32>
            %1603 = comb.extract %1602 from 0 : (i32) -> i13
            %1604 = comb.concat %1600, %1603 : i19, i13
            sv.bpassign %exStage_2_rs2Data, %1604 : i32
            %1605 = sv.array_index_inout %_RANDOM[%c110_i8] : !hw.inout<uarray<165xi32>>, i8
            %1606 = sv.read_inout %1605 : !hw.inout<i32>
            %1607 = comb.extract %1606 from 13 : (i32) -> i19
            %1608 = sv.array_index_inout %_RANDOM[%c111_i8] : !hw.inout<uarray<165xi32>>, i8
            %1609 = sv.read_inout %1608 : !hw.inout<i32>
            %1610 = comb.extract %1609 from 0 : (i32) -> i13
            %1611 = comb.concat %1607, %1610 : i19, i13
            sv.bpassign %exStage_2_memAddr, %1611 : i32
            %1612 = sv.array_index_inout %_RANDOM[%c111_i8] : !hw.inout<uarray<165xi32>>, i8
            %1613 = sv.read_inout %1612 : !hw.inout<i32>
            %1614 = comb.extract %1613 from 13 : (i32) -> i19
            %1615 = sv.array_index_inout %_RANDOM[%c112_i8] : !hw.inout<uarray<165xi32>>, i8
            %1616 = sv.read_inout %1615 : !hw.inout<i32>
            %1617 = comb.extract %1616 from 0 : (i32) -> i13
            %1618 = comb.concat %1614, %1617 : i19, i13
            sv.bpassign %exStage_2_memWdata, %1618 : i32
            %1619 = sv.array_index_inout %_RANDOM[%c112_i8] : !hw.inout<uarray<165xi32>>, i8
            %1620 = sv.read_inout %1619 : !hw.inout<i32>
            %1621 = comb.extract %1620 from 13 : (i32) -> i19
            %1622 = sv.array_index_inout %_RANDOM[%c113_i8] : !hw.inout<uarray<165xi32>>, i8
            %1623 = sv.read_inout %1622 : !hw.inout<i32>
            %1624 = comb.extract %1623 from 0 : (i32) -> i13
            %1625 = comb.concat %1621, %1624 : i19, i13
            sv.bpassign %exStage_2_memRdata, %1625 : i32
            %1626 = sv.array_index_inout %_RANDOM[%c113_i8] : !hw.inout<uarray<165xi32>>, i8
            %1627 = sv.read_inout %1626 : !hw.inout<i32>
            %1628 = comb.extract %1627 from 13 : (i32) -> i19
            %1629 = sv.array_index_inout %_RANDOM[%c114_i8] : !hw.inout<uarray<165xi32>>, i8
            %1630 = sv.read_inout %1629 : !hw.inout<i32>
            %1631 = comb.extract %1630 from 0 : (i32) -> i13
            %1632 = comb.concat %1628, %1631 : i19, i13
            sv.bpassign %exStage_2_aluResult, %1632 : i32
            %1633 = sv.array_index_inout %_RANDOM[%c114_i8] : !hw.inout<uarray<165xi32>>, i8
            %1634 = sv.read_inout %1633 : !hw.inout<i32>
            %1635 = comb.extract %1634 from 13 : (i32) -> i2
            sv.bpassign %exStage_3_threadId, %1635 : i2
            %1636 = sv.array_index_inout %_RANDOM[%c114_i8] : !hw.inout<uarray<165xi32>>, i8
            %1637 = sv.read_inout %1636 : !hw.inout<i32>
            %1638 = comb.extract %1637 from 15 : (i32) -> i1
            sv.bpassign %exStage_3_valid, %1638 : i1
            %1639 = sv.array_index_inout %_RANDOM[%c114_i8] : !hw.inout<uarray<165xi32>>, i8
            %1640 = sv.read_inout %1639 : !hw.inout<i32>
            %1641 = comb.extract %1640 from 16 : (i32) -> i16
            %1642 = sv.array_index_inout %_RANDOM[%c115_i8] : !hw.inout<uarray<165xi32>>, i8
            %1643 = sv.read_inout %1642 : !hw.inout<i32>
            %1644 = comb.extract %1643 from 0 : (i32) -> i16
            %1645 = comb.concat %1641, %1644 : i16, i16
            sv.bpassign %exStage_3_pc, %1645 : i32
            %1646 = sv.array_index_inout %_RANDOM[%c115_i8] : !hw.inout<uarray<165xi32>>, i8
            %1647 = sv.read_inout %1646 : !hw.inout<i32>
            %1648 = comb.extract %1647 from 16 : (i32) -> i16
            %1649 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1650 = sv.read_inout %1649 : !hw.inout<i32>
            %1651 = comb.extract %1650 from 0 : (i32) -> i16
            %1652 = comb.concat %1648, %1651 : i16, i16
            sv.bpassign %exStage_3_instr, %1652 : i32
            %1653 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1654 = sv.read_inout %1653 : !hw.inout<i32>
            %1655 = comb.extract %1654 from 16 : (i32) -> i1
            sv.bpassign %exStage_3_isALU, %1655 : i1
            %1656 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1657 = sv.read_inout %1656 : !hw.inout<i32>
            %1658 = comb.extract %1657 from 17 : (i32) -> i1
            sv.bpassign %exStage_3_isLoad, %1658 : i1
            %1659 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1660 = sv.read_inout %1659 : !hw.inout<i32>
            %1661 = comb.extract %1660 from 18 : (i32) -> i1
            sv.bpassign %exStage_3_isStore, %1661 : i1
            %1662 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1663 = sv.read_inout %1662 : !hw.inout<i32>
            %1664 = comb.extract %1663 from 19 : (i32) -> i1
            sv.bpassign %exStage_3_isBranch, %1664 : i1
            %1665 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1666 = sv.read_inout %1665 : !hw.inout<i32>
            %1667 = comb.extract %1666 from 20 : (i32) -> i1
            sv.bpassign %exStage_3_isJAL, %1667 : i1
            %1668 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1669 = sv.read_inout %1668 : !hw.inout<i32>
            %1670 = comb.extract %1669 from 21 : (i32) -> i1
            sv.bpassign %exStage_3_isJALR, %1670 : i1
            %1671 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1672 = sv.read_inout %1671 : !hw.inout<i32>
            %1673 = comb.extract %1672 from 22 : (i32) -> i1
            sv.bpassign %exStage_3_isLUI, %1673 : i1
            %1674 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1675 = sv.read_inout %1674 : !hw.inout<i32>
            %1676 = comb.extract %1675 from 23 : (i32) -> i1
            sv.bpassign %exStage_3_isAUIPC, %1676 : i1
            %1677 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1678 = sv.read_inout %1677 : !hw.inout<i32>
            %1679 = comb.extract %1678 from 24 : (i32) -> i1
            sv.bpassign %exStage_3_isFence, %1679 : i1
            %1680 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1681 = sv.read_inout %1680 : !hw.inout<i32>
            %1682 = comb.extract %1681 from 25 : (i32) -> i1
            sv.bpassign %exStage_3_isSystem, %1682 : i1
            %1683 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1684 = sv.read_inout %1683 : !hw.inout<i32>
            %1685 = comb.extract %1684 from 26 : (i32) -> i5
            sv.bpassign %exStage_3_aluOp, %1685 : i5
            %1686 = sv.array_index_inout %_RANDOM[%c116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1687 = sv.read_inout %1686 : !hw.inout<i32>
            %1688 = comb.extract %1687 from 31 : (i32) -> i1
            %1689 = sv.array_index_inout %_RANDOM[%c117_i8] : !hw.inout<uarray<165xi32>>, i8
            %1690 = sv.read_inout %1689 : !hw.inout<i32>
            %1691 = comb.extract %1690 from 0 : (i32) -> i31
            %1692 = comb.concat %1688, %1691 : i1, i31
            sv.bpassign %exStage_3_imm, %1692 : i32
            %1693 = sv.array_index_inout %_RANDOM[%c117_i8] : !hw.inout<uarray<165xi32>>, i8
            %1694 = sv.read_inout %1693 : !hw.inout<i32>
            %1695 = comb.extract %1694 from 31 : (i32) -> i1
            %1696 = sv.array_index_inout %_RANDOM[%c118_i8] : !hw.inout<uarray<165xi32>>, i8
            %1697 = sv.read_inout %1696 : !hw.inout<i32>
            %1698 = comb.extract %1697 from 0 : (i32) -> i4
            %1699 = comb.concat %1695, %1698 : i1, i4
            sv.bpassign %exStage_3_rs1, %1699 : i5
            %1700 = sv.array_index_inout %_RANDOM[%c118_i8] : !hw.inout<uarray<165xi32>>, i8
            %1701 = sv.read_inout %1700 : !hw.inout<i32>
            %1702 = comb.extract %1701 from 4 : (i32) -> i5
            sv.bpassign %exStage_3_rs2, %1702 : i5
            %1703 = sv.array_index_inout %_RANDOM[%c118_i8] : !hw.inout<uarray<165xi32>>, i8
            %1704 = sv.read_inout %1703 : !hw.inout<i32>
            %1705 = comb.extract %1704 from 9 : (i32) -> i5
            sv.bpassign %exStage_3_rd, %1705 : i5
            %1706 = sv.array_index_inout %_RANDOM[%c118_i8] : !hw.inout<uarray<165xi32>>, i8
            %1707 = sv.read_inout %1706 : !hw.inout<i32>
            %1708 = comb.extract %1707 from 14 : (i32) -> i18
            %1709 = sv.array_index_inout %_RANDOM[%c119_i8] : !hw.inout<uarray<165xi32>>, i8
            %1710 = sv.read_inout %1709 : !hw.inout<i32>
            %1711 = comb.extract %1710 from 0 : (i32) -> i14
            %1712 = comb.concat %1708, %1711 : i18, i14
            sv.bpassign %exStage_3_rs1Data, %1712 : i32
            %1713 = sv.array_index_inout %_RANDOM[%c119_i8] : !hw.inout<uarray<165xi32>>, i8
            %1714 = sv.read_inout %1713 : !hw.inout<i32>
            %1715 = comb.extract %1714 from 14 : (i32) -> i18
            %1716 = sv.array_index_inout %_RANDOM[%c120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1717 = sv.read_inout %1716 : !hw.inout<i32>
            %1718 = comb.extract %1717 from 0 : (i32) -> i14
            %1719 = comb.concat %1715, %1718 : i18, i14
            sv.bpassign %exStage_3_rs2Data, %1719 : i32
            %1720 = sv.array_index_inout %_RANDOM[%c120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1721 = sv.read_inout %1720 : !hw.inout<i32>
            %1722 = comb.extract %1721 from 14 : (i32) -> i18
            %1723 = sv.array_index_inout %_RANDOM[%c121_i8] : !hw.inout<uarray<165xi32>>, i8
            %1724 = sv.read_inout %1723 : !hw.inout<i32>
            %1725 = comb.extract %1724 from 0 : (i32) -> i14
            %1726 = comb.concat %1722, %1725 : i18, i14
            sv.bpassign %exStage_3_memAddr, %1726 : i32
            %1727 = sv.array_index_inout %_RANDOM[%c121_i8] : !hw.inout<uarray<165xi32>>, i8
            %1728 = sv.read_inout %1727 : !hw.inout<i32>
            %1729 = comb.extract %1728 from 14 : (i32) -> i18
            %1730 = sv.array_index_inout %_RANDOM[%c122_i8] : !hw.inout<uarray<165xi32>>, i8
            %1731 = sv.read_inout %1730 : !hw.inout<i32>
            %1732 = comb.extract %1731 from 0 : (i32) -> i14
            %1733 = comb.concat %1729, %1732 : i18, i14
            sv.bpassign %exStage_3_memWdata, %1733 : i32
            %1734 = sv.array_index_inout %_RANDOM[%c122_i8] : !hw.inout<uarray<165xi32>>, i8
            %1735 = sv.read_inout %1734 : !hw.inout<i32>
            %1736 = comb.extract %1735 from 14 : (i32) -> i18
            %1737 = sv.array_index_inout %_RANDOM[%c123_i8] : !hw.inout<uarray<165xi32>>, i8
            %1738 = sv.read_inout %1737 : !hw.inout<i32>
            %1739 = comb.extract %1738 from 0 : (i32) -> i14
            %1740 = comb.concat %1736, %1739 : i18, i14
            sv.bpassign %exStage_3_memRdata, %1740 : i32
            %1741 = sv.array_index_inout %_RANDOM[%c123_i8] : !hw.inout<uarray<165xi32>>, i8
            %1742 = sv.read_inout %1741 : !hw.inout<i32>
            %1743 = comb.extract %1742 from 14 : (i32) -> i18
            %1744 = sv.array_index_inout %_RANDOM[%c124_i8] : !hw.inout<uarray<165xi32>>, i8
            %1745 = sv.read_inout %1744 : !hw.inout<i32>
            %1746 = comb.extract %1745 from 0 : (i32) -> i14
            %1747 = comb.concat %1743, %1746 : i18, i14
            sv.bpassign %exStage_3_aluResult, %1747 : i32
            %1748 = sv.array_index_inout %_RANDOM[%c124_i8] : !hw.inout<uarray<165xi32>>, i8
            %1749 = sv.read_inout %1748 : !hw.inout<i32>
            %1750 = comb.extract %1749 from 14 : (i32) -> i2
            sv.bpassign %memStage_0_threadId, %1750 : i2
            %1751 = sv.array_index_inout %_RANDOM[%c124_i8] : !hw.inout<uarray<165xi32>>, i8
            %1752 = sv.read_inout %1751 : !hw.inout<i32>
            %1753 = comb.extract %1752 from 16 : (i32) -> i1
            sv.bpassign %memStage_0_valid, %1753 : i1
            %1754 = sv.array_index_inout %_RANDOM[%c124_i8] : !hw.inout<uarray<165xi32>>, i8
            %1755 = sv.read_inout %1754 : !hw.inout<i32>
            %1756 = comb.extract %1755 from 17 : (i32) -> i15
            %1757 = sv.array_index_inout %_RANDOM[%c125_i8] : !hw.inout<uarray<165xi32>>, i8
            %1758 = sv.read_inout %1757 : !hw.inout<i32>
            %1759 = comb.extract %1758 from 0 : (i32) -> i17
            %1760 = comb.concat %1756, %1759 : i15, i17
            sv.bpassign %memStage_0_pc, %1760 : i32
            %1761 = sv.array_index_inout %_RANDOM[%c125_i8] : !hw.inout<uarray<165xi32>>, i8
            %1762 = sv.read_inout %1761 : !hw.inout<i32>
            %1763 = comb.extract %1762 from 17 : (i32) -> i15
            %1764 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1765 = sv.read_inout %1764 : !hw.inout<i32>
            %1766 = comb.extract %1765 from 0 : (i32) -> i17
            %1767 = comb.concat %1763, %1766 : i15, i17
            sv.bpassign %memStage_0_instr, %1767 : i32
            %1768 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1769 = sv.read_inout %1768 : !hw.inout<i32>
            %1770 = comb.extract %1769 from 17 : (i32) -> i1
            sv.bpassign %memStage_0_isALU, %1770 : i1
            %1771 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1772 = sv.read_inout %1771 : !hw.inout<i32>
            %1773 = comb.extract %1772 from 18 : (i32) -> i1
            sv.bpassign %memStage_0_isLoad, %1773 : i1
            %1774 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1775 = sv.read_inout %1774 : !hw.inout<i32>
            %1776 = comb.extract %1775 from 19 : (i32) -> i1
            sv.bpassign %memStage_0_isStore, %1776 : i1
            %1777 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1778 = sv.read_inout %1777 : !hw.inout<i32>
            %1779 = comb.extract %1778 from 20 : (i32) -> i1
            sv.bpassign %memStage_0_isBranch, %1779 : i1
            %1780 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1781 = sv.read_inout %1780 : !hw.inout<i32>
            %1782 = comb.extract %1781 from 21 : (i32) -> i1
            sv.bpassign %memStage_0_isJAL, %1782 : i1
            %1783 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1784 = sv.read_inout %1783 : !hw.inout<i32>
            %1785 = comb.extract %1784 from 22 : (i32) -> i1
            sv.bpassign %memStage_0_isJALR, %1785 : i1
            %1786 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1787 = sv.read_inout %1786 : !hw.inout<i32>
            %1788 = comb.extract %1787 from 23 : (i32) -> i1
            sv.bpassign %memStage_0_isLUI, %1788 : i1
            %1789 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1790 = sv.read_inout %1789 : !hw.inout<i32>
            %1791 = comb.extract %1790 from 24 : (i32) -> i1
            sv.bpassign %memStage_0_isAUIPC, %1791 : i1
            %1792 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1793 = sv.read_inout %1792 : !hw.inout<i32>
            %1794 = comb.extract %1793 from 25 : (i32) -> i1
            sv.bpassign %memStage_0_isFence, %1794 : i1
            %1795 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1796 = sv.read_inout %1795 : !hw.inout<i32>
            %1797 = comb.extract %1796 from 26 : (i32) -> i1
            sv.bpassign %memStage_0_isSystem, %1797 : i1
            %1798 = sv.array_index_inout %_RANDOM[%c126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1799 = sv.read_inout %1798 : !hw.inout<i32>
            %1800 = comb.extract %1799 from 27 : (i32) -> i5
            sv.bpassign %memStage_0_aluOp, %1800 : i5
            %1801 = sv.array_index_inout %_RANDOM[%c127_i8] : !hw.inout<uarray<165xi32>>, i8
            %1802 = sv.read_inout %1801 : !hw.inout<i32>
            sv.bpassign %memStage_0_imm, %1802 : i32
            %1803 = sv.array_index_inout %_RANDOM[%c-128_i8] : !hw.inout<uarray<165xi32>>, i8
            %1804 = sv.read_inout %1803 : !hw.inout<i32>
            %1805 = comb.extract %1804 from 0 : (i32) -> i5
            sv.bpassign %memStage_0_rs1, %1805 : i5
            %1806 = sv.array_index_inout %_RANDOM[%c-128_i8] : !hw.inout<uarray<165xi32>>, i8
            %1807 = sv.read_inout %1806 : !hw.inout<i32>
            %1808 = comb.extract %1807 from 5 : (i32) -> i5
            sv.bpassign %memStage_0_rs2, %1808 : i5
            %1809 = sv.array_index_inout %_RANDOM[%c-128_i8] : !hw.inout<uarray<165xi32>>, i8
            %1810 = sv.read_inout %1809 : !hw.inout<i32>
            %1811 = comb.extract %1810 from 10 : (i32) -> i5
            sv.bpassign %memStage_0_rd, %1811 : i5
            %1812 = sv.array_index_inout %_RANDOM[%c-128_i8] : !hw.inout<uarray<165xi32>>, i8
            %1813 = sv.read_inout %1812 : !hw.inout<i32>
            %1814 = comb.extract %1813 from 15 : (i32) -> i17
            %1815 = sv.array_index_inout %_RANDOM[%c-127_i8] : !hw.inout<uarray<165xi32>>, i8
            %1816 = sv.read_inout %1815 : !hw.inout<i32>
            %1817 = comb.extract %1816 from 0 : (i32) -> i15
            %1818 = comb.concat %1814, %1817 : i17, i15
            sv.bpassign %memStage_0_rs1Data, %1818 : i32
            %1819 = sv.array_index_inout %_RANDOM[%c-127_i8] : !hw.inout<uarray<165xi32>>, i8
            %1820 = sv.read_inout %1819 : !hw.inout<i32>
            %1821 = comb.extract %1820 from 15 : (i32) -> i17
            %1822 = sv.array_index_inout %_RANDOM[%c-126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1823 = sv.read_inout %1822 : !hw.inout<i32>
            %1824 = comb.extract %1823 from 0 : (i32) -> i15
            %1825 = comb.concat %1821, %1824 : i17, i15
            sv.bpassign %memStage_0_rs2Data, %1825 : i32
            %1826 = sv.array_index_inout %_RANDOM[%c-126_i8] : !hw.inout<uarray<165xi32>>, i8
            %1827 = sv.read_inout %1826 : !hw.inout<i32>
            %1828 = comb.extract %1827 from 15 : (i32) -> i17
            %1829 = sv.array_index_inout %_RANDOM[%c-125_i8] : !hw.inout<uarray<165xi32>>, i8
            %1830 = sv.read_inout %1829 : !hw.inout<i32>
            %1831 = comb.extract %1830 from 0 : (i32) -> i15
            %1832 = comb.concat %1828, %1831 : i17, i15
            sv.bpassign %memStage_0_memAddr, %1832 : i32
            %1833 = sv.array_index_inout %_RANDOM[%c-125_i8] : !hw.inout<uarray<165xi32>>, i8
            %1834 = sv.read_inout %1833 : !hw.inout<i32>
            %1835 = comb.extract %1834 from 15 : (i32) -> i17
            %1836 = sv.array_index_inout %_RANDOM[%c-124_i8] : !hw.inout<uarray<165xi32>>, i8
            %1837 = sv.read_inout %1836 : !hw.inout<i32>
            %1838 = comb.extract %1837 from 0 : (i32) -> i15
            %1839 = comb.concat %1835, %1838 : i17, i15
            sv.bpassign %memStage_0_memWdata, %1839 : i32
            %1840 = sv.array_index_inout %_RANDOM[%c-124_i8] : !hw.inout<uarray<165xi32>>, i8
            %1841 = sv.read_inout %1840 : !hw.inout<i32>
            %1842 = comb.extract %1841 from 15 : (i32) -> i17
            %1843 = sv.array_index_inout %_RANDOM[%c-123_i8] : !hw.inout<uarray<165xi32>>, i8
            %1844 = sv.read_inout %1843 : !hw.inout<i32>
            %1845 = comb.extract %1844 from 0 : (i32) -> i15
            %1846 = comb.concat %1842, %1845 : i17, i15
            sv.bpassign %memStage_0_memRdata, %1846 : i32
            %1847 = sv.array_index_inout %_RANDOM[%c-123_i8] : !hw.inout<uarray<165xi32>>, i8
            %1848 = sv.read_inout %1847 : !hw.inout<i32>
            %1849 = comb.extract %1848 from 15 : (i32) -> i17
            %1850 = sv.array_index_inout %_RANDOM[%c-122_i8] : !hw.inout<uarray<165xi32>>, i8
            %1851 = sv.read_inout %1850 : !hw.inout<i32>
            %1852 = comb.extract %1851 from 0 : (i32) -> i15
            %1853 = comb.concat %1849, %1852 : i17, i15
            sv.bpassign %memStage_0_aluResult, %1853 : i32
            %1854 = sv.array_index_inout %_RANDOM[%c-122_i8] : !hw.inout<uarray<165xi32>>, i8
            %1855 = sv.read_inout %1854 : !hw.inout<i32>
            %1856 = comb.extract %1855 from 15 : (i32) -> i2
            sv.bpassign %memStage_1_threadId, %1856 : i2
            %1857 = sv.array_index_inout %_RANDOM[%c-122_i8] : !hw.inout<uarray<165xi32>>, i8
            %1858 = sv.read_inout %1857 : !hw.inout<i32>
            %1859 = comb.extract %1858 from 17 : (i32) -> i1
            sv.bpassign %memStage_1_valid, %1859 : i1
            %1860 = sv.array_index_inout %_RANDOM[%c-122_i8] : !hw.inout<uarray<165xi32>>, i8
            %1861 = sv.read_inout %1860 : !hw.inout<i32>
            %1862 = comb.extract %1861 from 18 : (i32) -> i14
            %1863 = sv.array_index_inout %_RANDOM[%c-121_i8] : !hw.inout<uarray<165xi32>>, i8
            %1864 = sv.read_inout %1863 : !hw.inout<i32>
            %1865 = comb.extract %1864 from 0 : (i32) -> i18
            %1866 = comb.concat %1862, %1865 : i14, i18
            sv.bpassign %memStage_1_pc, %1866 : i32
            %1867 = sv.array_index_inout %_RANDOM[%c-121_i8] : !hw.inout<uarray<165xi32>>, i8
            %1868 = sv.read_inout %1867 : !hw.inout<i32>
            %1869 = comb.extract %1868 from 18 : (i32) -> i14
            %1870 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1871 = sv.read_inout %1870 : !hw.inout<i32>
            %1872 = comb.extract %1871 from 0 : (i32) -> i18
            %1873 = comb.concat %1869, %1872 : i14, i18
            sv.bpassign %memStage_1_instr, %1873 : i32
            %1874 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1875 = sv.read_inout %1874 : !hw.inout<i32>
            %1876 = comb.extract %1875 from 18 : (i32) -> i1
            sv.bpassign %memStage_1_isALU, %1876 : i1
            %1877 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1878 = sv.read_inout %1877 : !hw.inout<i32>
            %1879 = comb.extract %1878 from 19 : (i32) -> i1
            sv.bpassign %memStage_1_isLoad, %1879 : i1
            %1880 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1881 = sv.read_inout %1880 : !hw.inout<i32>
            %1882 = comb.extract %1881 from 20 : (i32) -> i1
            sv.bpassign %memStage_1_isStore, %1882 : i1
            %1883 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1884 = sv.read_inout %1883 : !hw.inout<i32>
            %1885 = comb.extract %1884 from 21 : (i32) -> i1
            sv.bpassign %memStage_1_isBranch, %1885 : i1
            %1886 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1887 = sv.read_inout %1886 : !hw.inout<i32>
            %1888 = comb.extract %1887 from 22 : (i32) -> i1
            sv.bpassign %memStage_1_isJAL, %1888 : i1
            %1889 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1890 = sv.read_inout %1889 : !hw.inout<i32>
            %1891 = comb.extract %1890 from 23 : (i32) -> i1
            sv.bpassign %memStage_1_isJALR, %1891 : i1
            %1892 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1893 = sv.read_inout %1892 : !hw.inout<i32>
            %1894 = comb.extract %1893 from 24 : (i32) -> i1
            sv.bpassign %memStage_1_isLUI, %1894 : i1
            %1895 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1896 = sv.read_inout %1895 : !hw.inout<i32>
            %1897 = comb.extract %1896 from 25 : (i32) -> i1
            sv.bpassign %memStage_1_isAUIPC, %1897 : i1
            %1898 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1899 = sv.read_inout %1898 : !hw.inout<i32>
            %1900 = comb.extract %1899 from 26 : (i32) -> i1
            sv.bpassign %memStage_1_isFence, %1900 : i1
            %1901 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1902 = sv.read_inout %1901 : !hw.inout<i32>
            %1903 = comb.extract %1902 from 27 : (i32) -> i1
            sv.bpassign %memStage_1_isSystem, %1903 : i1
            %1904 = sv.array_index_inout %_RANDOM[%c-120_i8] : !hw.inout<uarray<165xi32>>, i8
            %1905 = sv.read_inout %1904 : !hw.inout<i32>
            %1906 = comb.extract %1905 from 28 : (i32) -> i4
            %1907 = sv.array_index_inout %_RANDOM[%c-119_i8] : !hw.inout<uarray<165xi32>>, i8
            %1908 = sv.read_inout %1907 : !hw.inout<i32>
            %1909 = comb.extract %1908 from 0 : (i32) -> i1
            %1910 = comb.concat %1906, %1909 : i4, i1
            sv.bpassign %memStage_1_aluOp, %1910 : i5
            %1911 = sv.array_index_inout %_RANDOM[%c-119_i8] : !hw.inout<uarray<165xi32>>, i8
            %1912 = sv.read_inout %1911 : !hw.inout<i32>
            %1913 = comb.extract %1912 from 1 : (i32) -> i31
            %1914 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %1915 = sv.read_inout %1914 : !hw.inout<i32>
            %1916 = comb.extract %1915 from 0 : (i32) -> i1
            %1917 = comb.concat %1913, %1916 : i31, i1
            sv.bpassign %memStage_1_imm, %1917 : i32
            %1918 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %1919 = sv.read_inout %1918 : !hw.inout<i32>
            %1920 = comb.extract %1919 from 1 : (i32) -> i5
            sv.bpassign %memStage_1_rs1, %1920 : i5
            %1921 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %1922 = sv.read_inout %1921 : !hw.inout<i32>
            %1923 = comb.extract %1922 from 6 : (i32) -> i5
            sv.bpassign %memStage_1_rs2, %1923 : i5
            %1924 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %1925 = sv.read_inout %1924 : !hw.inout<i32>
            %1926 = comb.extract %1925 from 11 : (i32) -> i5
            sv.bpassign %memStage_1_rd, %1926 : i5
            %1927 = sv.array_index_inout %_RANDOM[%c-118_i8] : !hw.inout<uarray<165xi32>>, i8
            %1928 = sv.read_inout %1927 : !hw.inout<i32>
            %1929 = comb.extract %1928 from 16 : (i32) -> i16
            %1930 = sv.array_index_inout %_RANDOM[%c-117_i8] : !hw.inout<uarray<165xi32>>, i8
            %1931 = sv.read_inout %1930 : !hw.inout<i32>
            %1932 = comb.extract %1931 from 0 : (i32) -> i16
            %1933 = comb.concat %1929, %1932 : i16, i16
            sv.bpassign %memStage_1_rs1Data, %1933 : i32
            %1934 = sv.array_index_inout %_RANDOM[%c-117_i8] : !hw.inout<uarray<165xi32>>, i8
            %1935 = sv.read_inout %1934 : !hw.inout<i32>
            %1936 = comb.extract %1935 from 16 : (i32) -> i16
            %1937 = sv.array_index_inout %_RANDOM[%c-116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1938 = sv.read_inout %1937 : !hw.inout<i32>
            %1939 = comb.extract %1938 from 0 : (i32) -> i16
            %1940 = comb.concat %1936, %1939 : i16, i16
            sv.bpassign %memStage_1_rs2Data, %1940 : i32
            %1941 = sv.array_index_inout %_RANDOM[%c-116_i8] : !hw.inout<uarray<165xi32>>, i8
            %1942 = sv.read_inout %1941 : !hw.inout<i32>
            %1943 = comb.extract %1942 from 16 : (i32) -> i16
            %1944 = sv.array_index_inout %_RANDOM[%c-115_i8] : !hw.inout<uarray<165xi32>>, i8
            %1945 = sv.read_inout %1944 : !hw.inout<i32>
            %1946 = comb.extract %1945 from 0 : (i32) -> i16
            %1947 = comb.concat %1943, %1946 : i16, i16
            sv.bpassign %memStage_1_memAddr, %1947 : i32
            %1948 = sv.array_index_inout %_RANDOM[%c-115_i8] : !hw.inout<uarray<165xi32>>, i8
            %1949 = sv.read_inout %1948 : !hw.inout<i32>
            %1950 = comb.extract %1949 from 16 : (i32) -> i16
            %1951 = sv.array_index_inout %_RANDOM[%c-114_i8] : !hw.inout<uarray<165xi32>>, i8
            %1952 = sv.read_inout %1951 : !hw.inout<i32>
            %1953 = comb.extract %1952 from 0 : (i32) -> i16
            %1954 = comb.concat %1950, %1953 : i16, i16
            sv.bpassign %memStage_1_memWdata, %1954 : i32
            %1955 = sv.array_index_inout %_RANDOM[%c-114_i8] : !hw.inout<uarray<165xi32>>, i8
            %1956 = sv.read_inout %1955 : !hw.inout<i32>
            %1957 = comb.extract %1956 from 16 : (i32) -> i16
            %1958 = sv.array_index_inout %_RANDOM[%c-113_i8] : !hw.inout<uarray<165xi32>>, i8
            %1959 = sv.read_inout %1958 : !hw.inout<i32>
            %1960 = comb.extract %1959 from 0 : (i32) -> i16
            %1961 = comb.concat %1957, %1960 : i16, i16
            sv.bpassign %memStage_1_memRdata, %1961 : i32
            %1962 = sv.array_index_inout %_RANDOM[%c-113_i8] : !hw.inout<uarray<165xi32>>, i8
            %1963 = sv.read_inout %1962 : !hw.inout<i32>
            %1964 = comb.extract %1963 from 16 : (i32) -> i16
            %1965 = sv.array_index_inout %_RANDOM[%c-112_i8] : !hw.inout<uarray<165xi32>>, i8
            %1966 = sv.read_inout %1965 : !hw.inout<i32>
            %1967 = comb.extract %1966 from 0 : (i32) -> i16
            %1968 = comb.concat %1964, %1967 : i16, i16
            sv.bpassign %memStage_1_aluResult, %1968 : i32
            %1969 = sv.array_index_inout %_RANDOM[%c-112_i8] : !hw.inout<uarray<165xi32>>, i8
            %1970 = sv.read_inout %1969 : !hw.inout<i32>
            %1971 = comb.extract %1970 from 16 : (i32) -> i2
            sv.bpassign %memStage_2_threadId, %1971 : i2
            %1972 = sv.array_index_inout %_RANDOM[%c-112_i8] : !hw.inout<uarray<165xi32>>, i8
            %1973 = sv.read_inout %1972 : !hw.inout<i32>
            %1974 = comb.extract %1973 from 18 : (i32) -> i1
            sv.bpassign %memStage_2_valid, %1974 : i1
            %1975 = sv.array_index_inout %_RANDOM[%c-112_i8] : !hw.inout<uarray<165xi32>>, i8
            %1976 = sv.read_inout %1975 : !hw.inout<i32>
            %1977 = comb.extract %1976 from 19 : (i32) -> i13
            %1978 = sv.array_index_inout %_RANDOM[%c-111_i8] : !hw.inout<uarray<165xi32>>, i8
            %1979 = sv.read_inout %1978 : !hw.inout<i32>
            %1980 = comb.extract %1979 from 0 : (i32) -> i19
            %1981 = comb.concat %1977, %1980 : i13, i19
            sv.bpassign %memStage_2_pc, %1981 : i32
            %1982 = sv.array_index_inout %_RANDOM[%c-111_i8] : !hw.inout<uarray<165xi32>>, i8
            %1983 = sv.read_inout %1982 : !hw.inout<i32>
            %1984 = comb.extract %1983 from 19 : (i32) -> i13
            %1985 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %1986 = sv.read_inout %1985 : !hw.inout<i32>
            %1987 = comb.extract %1986 from 0 : (i32) -> i19
            %1988 = comb.concat %1984, %1987 : i13, i19
            sv.bpassign %memStage_2_instr, %1988 : i32
            %1989 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %1990 = sv.read_inout %1989 : !hw.inout<i32>
            %1991 = comb.extract %1990 from 19 : (i32) -> i1
            sv.bpassign %memStage_2_isALU, %1991 : i1
            %1992 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %1993 = sv.read_inout %1992 : !hw.inout<i32>
            %1994 = comb.extract %1993 from 20 : (i32) -> i1
            sv.bpassign %memStage_2_isLoad, %1994 : i1
            %1995 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %1996 = sv.read_inout %1995 : !hw.inout<i32>
            %1997 = comb.extract %1996 from 21 : (i32) -> i1
            sv.bpassign %memStage_2_isStore, %1997 : i1
            %1998 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %1999 = sv.read_inout %1998 : !hw.inout<i32>
            %2000 = comb.extract %1999 from 22 : (i32) -> i1
            sv.bpassign %memStage_2_isBranch, %2000 : i1
            %2001 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2002 = sv.read_inout %2001 : !hw.inout<i32>
            %2003 = comb.extract %2002 from 23 : (i32) -> i1
            sv.bpassign %memStage_2_isJAL, %2003 : i1
            %2004 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2005 = sv.read_inout %2004 : !hw.inout<i32>
            %2006 = comb.extract %2005 from 24 : (i32) -> i1
            sv.bpassign %memStage_2_isJALR, %2006 : i1
            %2007 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2008 = sv.read_inout %2007 : !hw.inout<i32>
            %2009 = comb.extract %2008 from 25 : (i32) -> i1
            sv.bpassign %memStage_2_isLUI, %2009 : i1
            %2010 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2011 = sv.read_inout %2010 : !hw.inout<i32>
            %2012 = comb.extract %2011 from 26 : (i32) -> i1
            sv.bpassign %memStage_2_isAUIPC, %2012 : i1
            %2013 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2014 = sv.read_inout %2013 : !hw.inout<i32>
            %2015 = comb.extract %2014 from 27 : (i32) -> i1
            sv.bpassign %memStage_2_isFence, %2015 : i1
            %2016 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2017 = sv.read_inout %2016 : !hw.inout<i32>
            %2018 = comb.extract %2017 from 28 : (i32) -> i1
            sv.bpassign %memStage_2_isSystem, %2018 : i1
            %2019 = sv.array_index_inout %_RANDOM[%c-110_i8] : !hw.inout<uarray<165xi32>>, i8
            %2020 = sv.read_inout %2019 : !hw.inout<i32>
            %2021 = comb.extract %2020 from 29 : (i32) -> i3
            %2022 = sv.array_index_inout %_RANDOM[%c-109_i8] : !hw.inout<uarray<165xi32>>, i8
            %2023 = sv.read_inout %2022 : !hw.inout<i32>
            %2024 = comb.extract %2023 from 0 : (i32) -> i2
            %2025 = comb.concat %2021, %2024 : i3, i2
            sv.bpassign %memStage_2_aluOp, %2025 : i5
            %2026 = sv.array_index_inout %_RANDOM[%c-109_i8] : !hw.inout<uarray<165xi32>>, i8
            %2027 = sv.read_inout %2026 : !hw.inout<i32>
            %2028 = comb.extract %2027 from 2 : (i32) -> i30
            %2029 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2030 = sv.read_inout %2029 : !hw.inout<i32>
            %2031 = comb.extract %2030 from 0 : (i32) -> i2
            %2032 = comb.concat %2028, %2031 : i30, i2
            sv.bpassign %memStage_2_imm, %2032 : i32
            %2033 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2034 = sv.read_inout %2033 : !hw.inout<i32>
            %2035 = comb.extract %2034 from 2 : (i32) -> i5
            sv.bpassign %memStage_2_rs1, %2035 : i5
            %2036 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2037 = sv.read_inout %2036 : !hw.inout<i32>
            %2038 = comb.extract %2037 from 7 : (i32) -> i5
            sv.bpassign %memStage_2_rs2, %2038 : i5
            %2039 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2040 = sv.read_inout %2039 : !hw.inout<i32>
            %2041 = comb.extract %2040 from 12 : (i32) -> i5
            sv.bpassign %memStage_2_rd, %2041 : i5
            %2042 = sv.array_index_inout %_RANDOM[%c-108_i8] : !hw.inout<uarray<165xi32>>, i8
            %2043 = sv.read_inout %2042 : !hw.inout<i32>
            %2044 = comb.extract %2043 from 17 : (i32) -> i15
            %2045 = sv.array_index_inout %_RANDOM[%c-107_i8] : !hw.inout<uarray<165xi32>>, i8
            %2046 = sv.read_inout %2045 : !hw.inout<i32>
            %2047 = comb.extract %2046 from 0 : (i32) -> i17
            %2048 = comb.concat %2044, %2047 : i15, i17
            sv.bpassign %memStage_2_rs1Data, %2048 : i32
            %2049 = sv.array_index_inout %_RANDOM[%c-107_i8] : !hw.inout<uarray<165xi32>>, i8
            %2050 = sv.read_inout %2049 : !hw.inout<i32>
            %2051 = comb.extract %2050 from 17 : (i32) -> i15
            %2052 = sv.array_index_inout %_RANDOM[%c-106_i8] : !hw.inout<uarray<165xi32>>, i8
            %2053 = sv.read_inout %2052 : !hw.inout<i32>
            %2054 = comb.extract %2053 from 0 : (i32) -> i17
            %2055 = comb.concat %2051, %2054 : i15, i17
            sv.bpassign %memStage_2_rs2Data, %2055 : i32
            %2056 = sv.array_index_inout %_RANDOM[%c-106_i8] : !hw.inout<uarray<165xi32>>, i8
            %2057 = sv.read_inout %2056 : !hw.inout<i32>
            %2058 = comb.extract %2057 from 17 : (i32) -> i15
            %2059 = sv.array_index_inout %_RANDOM[%c-105_i8] : !hw.inout<uarray<165xi32>>, i8
            %2060 = sv.read_inout %2059 : !hw.inout<i32>
            %2061 = comb.extract %2060 from 0 : (i32) -> i17
            %2062 = comb.concat %2058, %2061 : i15, i17
            sv.bpassign %memStage_2_memAddr, %2062 : i32
            %2063 = sv.array_index_inout %_RANDOM[%c-105_i8] : !hw.inout<uarray<165xi32>>, i8
            %2064 = sv.read_inout %2063 : !hw.inout<i32>
            %2065 = comb.extract %2064 from 17 : (i32) -> i15
            %2066 = sv.array_index_inout %_RANDOM[%c-104_i8] : !hw.inout<uarray<165xi32>>, i8
            %2067 = sv.read_inout %2066 : !hw.inout<i32>
            %2068 = comb.extract %2067 from 0 : (i32) -> i17
            %2069 = comb.concat %2065, %2068 : i15, i17
            sv.bpassign %memStage_2_memWdata, %2069 : i32
            %2070 = sv.array_index_inout %_RANDOM[%c-104_i8] : !hw.inout<uarray<165xi32>>, i8
            %2071 = sv.read_inout %2070 : !hw.inout<i32>
            %2072 = comb.extract %2071 from 17 : (i32) -> i15
            %2073 = sv.array_index_inout %_RANDOM[%c-103_i8] : !hw.inout<uarray<165xi32>>, i8
            %2074 = sv.read_inout %2073 : !hw.inout<i32>
            %2075 = comb.extract %2074 from 0 : (i32) -> i17
            %2076 = comb.concat %2072, %2075 : i15, i17
            sv.bpassign %memStage_2_memRdata, %2076 : i32
            %2077 = sv.array_index_inout %_RANDOM[%c-103_i8] : !hw.inout<uarray<165xi32>>, i8
            %2078 = sv.read_inout %2077 : !hw.inout<i32>
            %2079 = comb.extract %2078 from 17 : (i32) -> i15
            %2080 = sv.array_index_inout %_RANDOM[%c-102_i8] : !hw.inout<uarray<165xi32>>, i8
            %2081 = sv.read_inout %2080 : !hw.inout<i32>
            %2082 = comb.extract %2081 from 0 : (i32) -> i17
            %2083 = comb.concat %2079, %2082 : i15, i17
            sv.bpassign %memStage_2_aluResult, %2083 : i32
            %2084 = sv.array_index_inout %_RANDOM[%c-102_i8] : !hw.inout<uarray<165xi32>>, i8
            %2085 = sv.read_inout %2084 : !hw.inout<i32>
            %2086 = comb.extract %2085 from 17 : (i32) -> i2
            sv.bpassign %memStage_3_threadId, %2086 : i2
            %2087 = sv.array_index_inout %_RANDOM[%c-102_i8] : !hw.inout<uarray<165xi32>>, i8
            %2088 = sv.read_inout %2087 : !hw.inout<i32>
            %2089 = comb.extract %2088 from 19 : (i32) -> i1
            sv.bpassign %memStage_3_valid, %2089 : i1
            %2090 = sv.array_index_inout %_RANDOM[%c-102_i8] : !hw.inout<uarray<165xi32>>, i8
            %2091 = sv.read_inout %2090 : !hw.inout<i32>
            %2092 = comb.extract %2091 from 20 : (i32) -> i12
            %2093 = sv.array_index_inout %_RANDOM[%c-101_i8] : !hw.inout<uarray<165xi32>>, i8
            %2094 = sv.read_inout %2093 : !hw.inout<i32>
            %2095 = comb.extract %2094 from 0 : (i32) -> i20
            %2096 = comb.concat %2092, %2095 : i12, i20
            sv.bpassign %memStage_3_pc, %2096 : i32
            %2097 = sv.array_index_inout %_RANDOM[%c-101_i8] : !hw.inout<uarray<165xi32>>, i8
            %2098 = sv.read_inout %2097 : !hw.inout<i32>
            %2099 = comb.extract %2098 from 20 : (i32) -> i12
            %2100 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2101 = sv.read_inout %2100 : !hw.inout<i32>
            %2102 = comb.extract %2101 from 0 : (i32) -> i20
            %2103 = comb.concat %2099, %2102 : i12, i20
            sv.bpassign %memStage_3_instr, %2103 : i32
            %2104 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2105 = sv.read_inout %2104 : !hw.inout<i32>
            %2106 = comb.extract %2105 from 20 : (i32) -> i1
            sv.bpassign %memStage_3_isALU, %2106 : i1
            %2107 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2108 = sv.read_inout %2107 : !hw.inout<i32>
            %2109 = comb.extract %2108 from 21 : (i32) -> i1
            sv.bpassign %memStage_3_isLoad, %2109 : i1
            %2110 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2111 = sv.read_inout %2110 : !hw.inout<i32>
            %2112 = comb.extract %2111 from 22 : (i32) -> i1
            sv.bpassign %memStage_3_isStore, %2112 : i1
            %2113 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2114 = sv.read_inout %2113 : !hw.inout<i32>
            %2115 = comb.extract %2114 from 23 : (i32) -> i1
            sv.bpassign %memStage_3_isBranch, %2115 : i1
            %2116 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2117 = sv.read_inout %2116 : !hw.inout<i32>
            %2118 = comb.extract %2117 from 24 : (i32) -> i1
            sv.bpassign %memStage_3_isJAL, %2118 : i1
            %2119 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2120 = sv.read_inout %2119 : !hw.inout<i32>
            %2121 = comb.extract %2120 from 25 : (i32) -> i1
            sv.bpassign %memStage_3_isJALR, %2121 : i1
            %2122 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2123 = sv.read_inout %2122 : !hw.inout<i32>
            %2124 = comb.extract %2123 from 26 : (i32) -> i1
            sv.bpassign %memStage_3_isLUI, %2124 : i1
            %2125 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2126 = sv.read_inout %2125 : !hw.inout<i32>
            %2127 = comb.extract %2126 from 27 : (i32) -> i1
            sv.bpassign %memStage_3_isAUIPC, %2127 : i1
            %2128 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2129 = sv.read_inout %2128 : !hw.inout<i32>
            %2130 = comb.extract %2129 from 28 : (i32) -> i1
            sv.bpassign %memStage_3_isFence, %2130 : i1
            %2131 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2132 = sv.read_inout %2131 : !hw.inout<i32>
            %2133 = comb.extract %2132 from 29 : (i32) -> i1
            sv.bpassign %memStage_3_isSystem, %2133 : i1
            %2134 = sv.array_index_inout %_RANDOM[%c-100_i8] : !hw.inout<uarray<165xi32>>, i8
            %2135 = sv.read_inout %2134 : !hw.inout<i32>
            %2136 = comb.extract %2135 from 30 : (i32) -> i2
            %2137 = sv.array_index_inout %_RANDOM[%c-99_i8] : !hw.inout<uarray<165xi32>>, i8
            %2138 = sv.read_inout %2137 : !hw.inout<i32>
            %2139 = comb.extract %2138 from 0 : (i32) -> i3
            %2140 = comb.concat %2136, %2139 : i2, i3
            sv.bpassign %memStage_3_aluOp, %2140 : i5
            %2141 = sv.array_index_inout %_RANDOM[%c-99_i8] : !hw.inout<uarray<165xi32>>, i8
            %2142 = sv.read_inout %2141 : !hw.inout<i32>
            %2143 = comb.extract %2142 from 3 : (i32) -> i29
            %2144 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2145 = sv.read_inout %2144 : !hw.inout<i32>
            %2146 = comb.extract %2145 from 0 : (i32) -> i3
            %2147 = comb.concat %2143, %2146 : i29, i3
            sv.bpassign %memStage_3_imm, %2147 : i32
            %2148 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2149 = sv.read_inout %2148 : !hw.inout<i32>
            %2150 = comb.extract %2149 from 3 : (i32) -> i5
            sv.bpassign %memStage_3_rs1, %2150 : i5
            %2151 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2152 = sv.read_inout %2151 : !hw.inout<i32>
            %2153 = comb.extract %2152 from 8 : (i32) -> i5
            sv.bpassign %memStage_3_rs2, %2153 : i5
            %2154 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2155 = sv.read_inout %2154 : !hw.inout<i32>
            %2156 = comb.extract %2155 from 13 : (i32) -> i5
            sv.bpassign %memStage_3_rd, %2156 : i5
            %2157 = sv.array_index_inout %_RANDOM[%c-98_i8] : !hw.inout<uarray<165xi32>>, i8
            %2158 = sv.read_inout %2157 : !hw.inout<i32>
            %2159 = comb.extract %2158 from 18 : (i32) -> i14
            %2160 = sv.array_index_inout %_RANDOM[%c-97_i8] : !hw.inout<uarray<165xi32>>, i8
            %2161 = sv.read_inout %2160 : !hw.inout<i32>
            %2162 = comb.extract %2161 from 0 : (i32) -> i18
            %2163 = comb.concat %2159, %2162 : i14, i18
            sv.bpassign %memStage_3_rs1Data, %2163 : i32
            %2164 = sv.array_index_inout %_RANDOM[%c-97_i8] : !hw.inout<uarray<165xi32>>, i8
            %2165 = sv.read_inout %2164 : !hw.inout<i32>
            %2166 = comb.extract %2165 from 18 : (i32) -> i14
            %2167 = sv.array_index_inout %_RANDOM[%c-96_i8] : !hw.inout<uarray<165xi32>>, i8
            %2168 = sv.read_inout %2167 : !hw.inout<i32>
            %2169 = comb.extract %2168 from 0 : (i32) -> i18
            %2170 = comb.concat %2166, %2169 : i14, i18
            sv.bpassign %memStage_3_rs2Data, %2170 : i32
            %2171 = sv.array_index_inout %_RANDOM[%c-96_i8] : !hw.inout<uarray<165xi32>>, i8
            %2172 = sv.read_inout %2171 : !hw.inout<i32>
            %2173 = comb.extract %2172 from 18 : (i32) -> i14
            %2174 = sv.array_index_inout %_RANDOM[%c-95_i8] : !hw.inout<uarray<165xi32>>, i8
            %2175 = sv.read_inout %2174 : !hw.inout<i32>
            %2176 = comb.extract %2175 from 0 : (i32) -> i18
            %2177 = comb.concat %2173, %2176 : i14, i18
            sv.bpassign %memStage_3_memAddr, %2177 : i32
            %2178 = sv.array_index_inout %_RANDOM[%c-95_i8] : !hw.inout<uarray<165xi32>>, i8
            %2179 = sv.read_inout %2178 : !hw.inout<i32>
            %2180 = comb.extract %2179 from 18 : (i32) -> i14
            %2181 = sv.array_index_inout %_RANDOM[%c-94_i8] : !hw.inout<uarray<165xi32>>, i8
            %2182 = sv.read_inout %2181 : !hw.inout<i32>
            %2183 = comb.extract %2182 from 0 : (i32) -> i18
            %2184 = comb.concat %2180, %2183 : i14, i18
            sv.bpassign %memStage_3_memWdata, %2184 : i32
            %2185 = sv.array_index_inout %_RANDOM[%c-94_i8] : !hw.inout<uarray<165xi32>>, i8
            %2186 = sv.read_inout %2185 : !hw.inout<i32>
            %2187 = comb.extract %2186 from 18 : (i32) -> i14
            %2188 = sv.array_index_inout %_RANDOM[%c-93_i8] : !hw.inout<uarray<165xi32>>, i8
            %2189 = sv.read_inout %2188 : !hw.inout<i32>
            %2190 = comb.extract %2189 from 0 : (i32) -> i18
            %2191 = comb.concat %2187, %2190 : i14, i18
            sv.bpassign %memStage_3_memRdata, %2191 : i32
            %2192 = sv.array_index_inout %_RANDOM[%c-93_i8] : !hw.inout<uarray<165xi32>>, i8
            %2193 = sv.read_inout %2192 : !hw.inout<i32>
            %2194 = comb.extract %2193 from 18 : (i32) -> i14
            %2195 = sv.array_index_inout %_RANDOM[%c-92_i8] : !hw.inout<uarray<165xi32>>, i8
            %2196 = sv.read_inout %2195 : !hw.inout<i32>
            %2197 = comb.extract %2196 from 0 : (i32) -> i18
            %2198 = comb.concat %2194, %2197 : i14, i18
            sv.bpassign %memStage_3_aluResult, %2198 : i32
          }
        }
        sv.ifdef  @FIRRTL_AFTER_INITIAL {
          sv.verbatim "`FIRRTL_AFTER_INITIAL"
        }
      }
    }
    %705 = sv.read_inout %io_instrWriteEnable_1 : !hw.inout<i1>
    %706 = sv.read_inout %io_instrWriteAddr_2 : !hw.inout<i10>
    %707 = sv.read_inout %io_instrWriteData_3 : !hw.inout<i32>
    %708 = sv.read_inout %_ifWire_instr_T_1 : !hw.inout<i10>
    %instrMem_ext.R0_data = hw.instance "instrMem_ext" @instrMem_1024x32(R0_addr: %708: i10, R0_en: %true: i1, R0_clk: %clock: i1, W0_addr: %706: i10, W0_en: %705: i1, W0_clk: %clock: i1, W0_data: %707: i32) -> (R0_data: i32) {hw.verilogName = "instrMem_ext"}
    sv.assign %ifWire_instr, %instrMem_ext.R0_data : i32
    %709 = sv.read_inout %decWire_rs1 : !hw.inout<i5>
    %710 = sv.read_inout %decWire_rs2 : !hw.inout<i5>
    %711 = sv.read_inout %memWire_rd : !hw.inout<i5>
    %712 = sv.read_inout %wbData : !hw.inout<i32>
    %713 = sv.read_inout %_regFile_io_wen_T_3 : !hw.inout<i1>
    %714 = sv.read_inout %currentThread : !hw.inout<i2>
    %regFile.io_src1data, %regFile.io_src2data = hw.instance "regFile" @RegFileMT2R1WVec(clock: %clock: i1, reset: %reset: i1, io_threadID: %714: i2, io_src1: %709: i5, io_src2: %710: i5, io_dst1: %711: i5, io_wen: %713: i1, io_dst1data: %712: i32) -> (io_src1data: i32, io_src2data: i32) {hw.verilogName = "regFile", sv.namehint = "regFile.io_src2data"}
    sv.assign %decWire_rs2Data, %regFile.io_src2data : i32
    sv.assign %decWire_rs1Data, %regFile.io_src1data : i32
    %715 = sv.read_inout %exWire_aluOp : !hw.inout<i5>
    %716 = sv.read_inout %exWire_rs1Data : !hw.inout<i32>
    %717 = sv.read_inout %exWire_rs2Data : !hw.inout<i32>
    %alu.io_out = hw.instance "alu" @TetraNyteCore_Anon(io_a: %716: i32, io_b: %717: i32, io_fn: %715: i5) -> (io_out: i32) {hw.verilogName = "alu", sv.namehint = "alu.io_out"}
    sv.assign %exWire_aluResult, %alu.io_out : i32
    %718 = sv.read_inout %io_memAddr : !hw.inout<i32>
    %719 = sv.read_inout %io_memWdata : !hw.inout<i32>
    %720 = sv.read_inout %io_memWe : !hw.inout<i1>
    hw.output %718, %719, %720 : i32, i32, i1
  }
  om.class @TetraNyteCore_Class(%basepath: !om.frozenbasepath) {
    om.class.fields
  }
}
