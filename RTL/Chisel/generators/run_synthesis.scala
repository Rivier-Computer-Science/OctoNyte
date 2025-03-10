// Run from RTL/Chisel sbt 'runMain generators.RunSynthesis'

// Licensed under the BSD 3-Clause License. 
// See https://opensource.org/licenses/BSD-3-Clause for details.

package generators

import circt.stage.ChiselStage 
import sys.process._  
import java.io.File   
import java.nio.file.{Files, Paths, StandardCopyOption, NoSuchFileException} 

import java.io.IOException
import java.io.PrintStream
import java.io.OutputStream

object RunSynthesis extends App {
  


  // Default paths when running from toplevel RTL/Chisel

  val generatedSv2vPath = "generators/generated/verilog_sv2v"
  val generatedVerilogElaboratedPath =     "generators/generated/verilog_tetranyte_asic_timed"
  val generatedVerilogElaboratedFlatPath = "generators/generated/verilog_tetranyte_asic_timed"

  val skywaterPdkLib = "../../synthesis/pdk/sky130_fd_sc_hd/timing/sky130_fd_sc_hd__tt_025C_1v80.lib"
  val optimizeForASIC = true

    // Modules to Generate
  val modulesToGenerate = Seq(
    //  (() => new OctoNyte.ExecutionUnits.RISCVAdderSubtractor32, "RISCVAdderSubtractor32"),
    //  (() => new TetraNyte.RegFileMT2R1WVec, "RegFileMT2R1WVec"),
    (() => new TetraNyte.TetraNyteCore, "TetraNyteCore"),
   )

  modulesToGenerate.foreach { case (module, moduleName) => 
    try {
      println("  ")
      println("###########################################################################")
      println(s"Processing module ${moduleName}")
      println("###########################################################################")
      println("  ")


      //run yosys
      synthesizeNetlist(module, moduleName, optimizeForASIC)
    
    } catch {
      case e: Exception =>
        println(s"Error generating hardware ${e.getMessage}")
        throw e
    }
  }


  def synthesizeNetlist(chiselModule: () => chisel3.Module, moduleName: String, optimizeForASIC: Boolean): Unit = {
    println(s"${moduleName}: generateNetlist")
    if ( isCmdInstalled("yosys")) {      
      val systemVerilogInFile = new File( generatedSv2vPath + "/" + moduleName + ".v")
      val verilogOutFile = new File( generatedVerilogElaboratedPath + "/" + moduleName + ".v")
      val verilogOutFileFlat = new File( generatedVerilogElaboratedFlatPath + "/" + moduleName + "_flat" + ".v")

      val verilogOutSynthFile = new File( generatedVerilogElaboratedPath + "/" + moduleName + "_synth" + ".v")
      val verilogOutSynthFileFlat = new File( generatedVerilogElaboratedFlatPath + "/" + moduleName + "_synth_flat" + ".v")

  
      // Generate synthesized (elaborated) verilog file
      //Aggressive flags: "read_verilog your_design.v; synth -flatten -abc2; opt -purge; abc -script +resyn2;  opt_clean; write_verilog optimized_design.v;"
      val yosysVerilogcommand =
        if (optimizeForASIC) {
          Seq(
            "yosys",
            "-p",
            s"""
            read_liberty -lib $skywaterPdkLib; 
            read_verilog -sv $systemVerilogInFile; 
            prep -top $moduleName;             
            synth -top $moduleName; 
            abc -liberty $skywaterPdkLib; 
            techmap;  
            opt_clean
            write_verilog -noattr $verilogOutSynthFile
            """
          )
          // Use this Seq to generate exact library mappings
          // Seq(
          //   "yosys",
          //   "-p",
          //   s"""
          //   read_liberty -lib $skywaterPdkLib; 
          //   read_verilog -sv $systemVerilogInFile; 
          //   prep -top $moduleName; 
          //   synth -top $moduleName; 
          //   dfflibmap -liberty $skywaterPdkLib; 
          //   abc -liberty $skywaterPdkLib; 
          //   opt_clean; 
          //   write_verilog -noattr $verilogOutSynthFile
          //   """
          // )
        } else {
          Seq(
            "yosys",
            "-p",
            s" read_verilog -sv $systemVerilogInFile; synth -top $moduleName; write_verilog $verilogOutFile"
          )
        }

      println(s"Yosys command= ${yosysVerilogcommand.mkString(" ")}")
      
      val yosysVerilogResult = yosysVerilogcommand.!  
      if (yosysVerilogResult != 0) {
        println(s"Error: yosys execution failed with code $yosysVerilogResult")
      } else {
        println("yosys synthesized (elaborated) verilog file generated successfully!")
      }

      // Synthesize flattened verilog
      //Aggressive flags: "read_verilog your_design.v; synth -flatten -abc2; opt -purge; abc -script +resyn2;  opt_clean; write_verilog optimized_design.v;"
      val yosysVerilogCommandFlat = 
        if (optimizeForASIC) {
            Seq(
            "yosys",
            "-p",
            s"""
            read_liberty -lib $skywaterPdkLib; 
            read_verilog -sv $systemVerilogInFile;   
            flatten;         
            rename $moduleName ${moduleName}_flat; 
            prep -top ${moduleName}_flat; 
            synth -top ${moduleName}_flat; 
            opt_clean; 
            techmap;
            write_verilog -noattr $verilogOutSynthFileFlat; 
            """
          )
          // show -format svg -prefix /home/jglossner/${moduleName}_flat.svg

          // Use this Seq to generate exact library mappings
          //           Seq(
          //   "yosys",
          //   "-p",
          //   s"""
          //   read_liberty -lib $skywaterPdkLib; 
          //   read_verilog -sv $systemVerilogInFile;   
          //   flatten;         
          //   rename $moduleName ${moduleName}_flat; 
          //   prep -top ${moduleName}_flat; 
          //   synth -top ${moduleName}_flat; 
          //   dfflibmap -liberty $skywaterPdkLib; 
          //   abc -liberty $skywaterPdkLib; 
          //   opt_clean; 
          //   write_verilog -noattr $verilogOutSynthFileFlat
          //   """
          // )
        } else {
            Seq(
            "yosys",
            "-p",
            s"""
            read_verilog -sv $systemVerilogInFile; 
            flatten -top $moduleName; 
            rename $moduleName ${moduleName}_flat"; 
            synth -top $moduleName;             
            write_verilog $verilogOutFileFlat"
            """
          )
        }
        
      
      val yosysVerilogFlatResult = yosysVerilogCommandFlat.!  
      if (yosysVerilogFlatResult != 0) {
        println(s"Error: yosys execution failed with code $yosysVerilogFlatResult")
      } else {
        println("yosys synthesized (elaborated) verilog file generated successfully!")
      }


    } else {
      println("yosys not installed. See: https://github.com/YosysHQ/yosys and install it from https://github.com/YosysHQ/oss-cad-suite-build/releases")
    }    
  }

  
  // Helper function to see if a command is installed (firtool, yosys, etc.)
  def isCmdInstalled(command: String): Boolean = {
      try {      
      
      // Disable errors during test because netlistsvg doesn't support --version
      val originalErr = System.err
      System.setErr(new PrintStream(new OutputStream() {
        override def write(b: Int): Unit = {} // Do nothing
      }))
      
      // Run the command with a test argument to verify installation
      Seq(command, "--version").! == 0

      //Turn error logging back on
      System.setErr(originalErr)

      println(s"$command installed")
      return true
      } catch {
      case _: Exception =>
          return false
      }
  }

  def getCmdPath(command: String): String = {
    try {
      val path = Seq("which", command).!!.trim
      if (path.nonEmpty) path
      else throw new IOException(s"Command '$command' not found in PATH")
    } catch {
      case _: Exception => "NOT FOUND" 
    }
  }

}
