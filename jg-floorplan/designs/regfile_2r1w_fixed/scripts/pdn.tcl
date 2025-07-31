# Connect hard macro pins explicitly before PDN generation
globalNetConnect vccd1 -type pgpin -pin VPWR -inst_pattern *lane0*
globalNetConnect vccd1 -type pgpin -pin VPWR -inst_pattern *lane1*
globalNetConnect vssd1 -type pgpin -pin VGND -inst_pattern *lane0*
globalNetConnect vssd1 -type pgpin -pin VGND -inst_pattern *lane1*


define_pdn_grid \
  -name core_grid \
  -power_nets {vccd1} \
  -ground_nets {vssd1} \
  -horizontal_layer met4 \
  -vertical_layer met5 \
  -horizontal_pitch 50 \
  -vertical_pitch 50 \
  -offset {5 5} \
  -width 2

# Generate PDN explicitly
generate_pdn