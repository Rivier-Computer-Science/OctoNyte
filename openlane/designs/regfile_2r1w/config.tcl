# config.tcl

# -----------------------------------------------------------------------------
# Design Basics
# -----------------------------------------------------------------------------
set ::env(DESIGN_NAME) "regfile_2r1w"

# Expand your Verilog files
set ::env(VERILOG_FILES) [list \
    "$::env(DESIGN_DIR)/src/regfile_2r1w.v" \
    "$::env(DESIGN_DIR)/src/mem_1r1w_blackbox.v"]

set ::env(TOP_MODULE) "regfile_2r1w"

# -----------------------------------------------------------------------------
# Timing
# -----------------------------------------------------------------------------
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) 2.0

# -----------------------------------------------------------------------------
# Floorplan
# -----------------------------------------------------------------------------
set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 700 700"
set ::env(FP_CORE_AREA) "0 0 700 700"

# Disable Parquet-based auto macro placement
set ::env(RUN_BASIC_MP) 0
set ::env(FP_PDN_MACRO_HOOK) "$::env(DESIGN_DIR)/scripts/regfile_2r1w_floorplan.tcl"

# -----------------------------------------------------------------------------
# Hard Macro (mem_1r1w) LEF/GDS
# -----------------------------------------------------------------------------
set ::env(EXTRA_LEFS) "/openlane/designs/mem_1r1w/runs/output/results/final/lef/mem_1r1w.lef"
set ::env(EXTRA_GDS_FILES) "/openlane/designs/mem_1r1w/runs/output/results/final/gds/mem_1r1w.gds"

# -----------------------------------------------------------------------------
# Power and Ground Nets
# -----------------------------------------------------------------------------
# Top-level rails
set ::env(VDD_NETS) "vccd1"
set ::env(GND_NETS) "vssd1"
set ::env(FP_PDN_VDD_NET) "vccd1"
set ::env(FP_PDN_GND_NET) "vssd1"

# Macro pin names
set ::env(POWER_PINS) "VPWR"
set ::env(GROUND_PINS) "VGND"

# -----------------------------------------------------------------------------
# Global Net Connect
# -----------------------------------------------------------------------------
# Ties macro pins (VPWR/VGND) to top-level vccd1/vssd1
#set ::env(GLB_CFG_FILE) "$::env(DESIGN_DIR)/scripts/global_connect.tcl"
set ::env(FP_PDN_ENABLE_GLOBAL_CONNECTION) 0
set ::env(FP_PDN_ENABLE_MACRO_HOOKS) 1
set ::env(FP_PDN_CUSTOM_SCRIPT) "$::env(DESIGN_DIR)/scripts/pdn.tcl"

# -----------------------------------------------------------------------------
# SDC Files
# -----------------------------------------------------------------------------
set ::env(PNR_SDC_FILE) "$::env(DESIGN_DIR)/src/regfile_2r1w.sdc"
set ::env(SIGNOFF_SDC_FILE) "$::env(DESIGN_DIR)/src/regfile_2r1w.sdc"
# -----------------------------------------------------------------------------
# PDN and Routing
# -----------------------------------------------------------------------------
set ::env(FP_PDN_MULTILAYER) 1
set ::env(FP_PDN_CORE_RING) 0
set ::env(RT_MAX_LAYER) "met4"