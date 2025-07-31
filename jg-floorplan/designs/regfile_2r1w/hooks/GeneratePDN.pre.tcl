# hooks/GeneratePDN.pre.tcl

puts "\n---> Running global connect prior to PDN generation..."

# If your macro's LEF pins are named 'vccd1'/'vssd1' and
# you want them connected to top-level nets also named 'vccd1'/'vssd1':
globalNetConnect vccd1 -type pgpin -macroPin vccd1
globalNetConnect vssd1 -type pgpin -macroPin vssd1

puts "---> Done global connect.\n"
