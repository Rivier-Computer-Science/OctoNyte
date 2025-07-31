# Place macros at specific positions and lock them

# -origin {X Y}	Sets the bottom-left corner of the macro
# -halo {left bottom right top}	Optional. Adds routing keep-out margin around macro

# -orient is given as an orientation code:
# R0	Rotate 0° (no rotation)
# R90	Rotate 90° clockwise
# R180	Rotate 180°
# R270	Rotate 270° clockwise
# MX	Mirror horizontally (X-axis)
# MY	Mirror vertically (Y-axis)
# MXR90	Mirror X-axis, then rotate 90°
# MYR90	Mirror Y-axis, then rotate 90°

# Ensure macros start with no pre-existing placement
set_placement_status lane0 UNPLACED
set_placement_status lane1 UNPLACED

place_macro lane0 -origin {10 10} -orient R90 -halo {50 50 50 50}
place_macro lane1 -origin {400 10} -orient R90 -halo {50 50 50 50}

# Lock their placement so they do not get moved
set_placement_status lane0 FIXED
set_placement_status lane1 FIXED

# Other commands

# create_placement_blockage -box {llx lly urx ury}

# globalNetConnect can go here

# place_pins -ports {port_name1 port_name2 ...} -layer met3 -side left

# initialize_floorplan -die_area {0 0 700 700} -core_area {10 10 690 690} -site unithd

# Set PDN rails
#    define_pdn_grid -name core_grid \
#    -starts_with POWER \
#    -rails \
#        {met4 width 2 offset 5 pitch 50} \
#        {met5 width 2 offset 5 pitch 50}

# Custom global routing constraints
#     set_global_routing_layer_adjustment met4 0.8
