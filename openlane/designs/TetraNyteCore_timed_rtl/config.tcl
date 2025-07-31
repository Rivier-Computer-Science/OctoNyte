# Modern OpenLane2 configuration
set ::env(DESIGN_NAME) "TetraNyteCore"

# Use absolute paths with DESIGN_DIR
set ::env(VERILOG_FILES) [list \
    "$::env(DESIGN_DIR)/TetraNyteCore.v" \
    "$::env(DESIGN_DIR)/../ALU32/ALU32.v" \
    "$::env(DESIGN_DIR)/../LoadUnit/LoadUnit.v" \
]

# Clock configuration
set ::env(CLOCK_PORT) "clock"
set ::env(CLOCK_PERIOD) 5

# Floorplan and PDN
set ::env(FP_CORE_UTIL) 0.3
set ::env(FP_PDN_VPITCH) 7.0
set ::env(FP_PDN_HPITCH) 7.0

# Constraints
set ::env(PNR_SDC_FILE) "$::env(DESIGN_DIR)/common_constraints/design.sdc"
set ::env(SIGNOFF_SDC_FILE) "$::env(DESIGN_DIR)/common_constraints/design.sdc"

# Synthesis
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
