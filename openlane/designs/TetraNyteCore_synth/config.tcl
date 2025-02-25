# config.tcl - OpenLane design configuration for TetraNyteCore_synth

# Set the design name and top module
set ::env(DESIGN_NAME) "TetraNyteCore_flat"
set ::env(DESIGN_TOP) "TetraNyteCore_flat"  ;# Change this to match your top module name

# List of Verilog source files (use full paths if needed)
set ::env(VERILOG_FILES) {
    "designs/TetraNyteCore_synth/src/TetraNyteCore_synth_flat.v"
}

# (Optional) Clock and timing information if your design requires it
set ::env(CLOCK_PORT) "clock"
set ::env(CLOCK_PERIOD) 10

# Override PDN pitch to avoid a too-small grid (minimum required is 6.6)
#set ::env(PDN_PITCH) 7.0

# Adjust floorplan parameters to force a larger core area
#set ::env(FP_CORE_UTIL) 0.2

# (Optional) Constraint files if you have them, to avoid warnings.
set constraint_dir "common_constraints"
set sdc_file [file join $constraint_dir "design.sdc"]

set ::env(PNR_SDC_FILE) $sdc_file
set ::env(SIGNOFF_SDC_FILE) $sdc_file
set ::env(CONSTRAINTS) $sdc_file
