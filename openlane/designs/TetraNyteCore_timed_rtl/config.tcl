# config.tcl - OpenLane design configuration for TetraNyteCore_synth

# Set the design name and top module
set ::env(DESIGN_NAME) "TetraNyteCore"
set ::env(DESIGN_TOP) "TetraNyteCore"  ;# Change this to match your top module name

# List of Verilog source files (use full paths if needed)
set ::env(VERILOG_FILES) {
    "designs/TetraNyteCore_timed_rtl/src/TetraNyteCore.v"
    "designs/ALU32/src/ALU32.v"
    "designs/LoadUnit/src/LoadUnit.v"
}

# (Optional) Clock and timing information if your design requires it
set ::env(CLOCK_PORT) "clock"
set ::env(CLOCK_PERIOD) 5

# Override PDN pitch to avoid a too-small grid (minimum required is 6.6)
set ::env(PDN_PITCH) 7.0

# Adjust floorplan parameters to force a larger core area
set ::env(FP_CORE_UTIL) 0.3

# (Optional) Constraint files if you have them, to avoid warnings.
set constraint_dir "common_constraints"
set sdc_file [file join $constraint_dir "design.sdc"]

set ::env(PNR_SDC_FILE) $sdc_file
set ::env(SIGNOFF_SDC_FILE) $sdc_file

# If you have any special flags for Verilator (e.g., to enable SystemVerilog)
set ::env(VERILATOR_FLAGS) "-sv"