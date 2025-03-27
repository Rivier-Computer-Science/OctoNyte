# Design Info
set ::env(DESIGN_NAME) "mem_1r1w"
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) 2.0

# Floorplan and Die Area
set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 260 280"
set ::env(FP_CORE_AREA) "0 0 260 280"
set ::env(FP_IO_MODE) "macro"

# PDN Settings
set ::env(FP_PDN_MULTILAYER) 1
set ::env(FP_PDN_CORE_RING) 0
set ::env(RT_MAX_LAYER) "met4"

set ::env(FP_PDN_VOFFSET) 5
set ::env(FP_PDN_HOFFSET) 5
set ::env(FP_PDN_VWIDTH) 2
set ::env(FP_PDN_HWIDTH) 2
set ::env(FP_PDN_VPITCH) 30
set ::env(FP_PDN_HPITCH) 30
set ::env(FP_PDN_SKIPTRIM) 1

# Power/Ground Net Names
set ::env(VDD_NETS) "vccd1"
set ::env(GND_NETS) "vssd1"
set ::env(FP_PDN_VDD_NET) "vccd1"
set ::env(FP_PDN_GND_NET) "vssd1"
set ::env(POWER_PINS) "VPWR"
set ::env(GROUND_PINS) "VGND"

# SDC
set ::env(PNR_SDC_FILE) "$::env(DESIGN_DIR)/src/mem_1r1w.sdc"
set ::env(SIGNOFF_SDC_FILE) "$::env(DESIGN_DIR)/src/mem_1r1w.sdc"

# Technology-Specific Settings
set ::env(pdk::sky130*) [dict create \
    FP_CORE_UTIL 45 \
    CLOCK_PERIOD 2 \
    scl::sky130_fd_sc_hs [dict create CLOCK_PERIOD 8] \
    scl::sky130_fd_sc_ls [dict create MAX_FANOUT_CONSTRAINT 5]
]