# hooks/Synthesize.pre.tcl
puts "\n--- Synthesize.pre.tcl: Forcing mem_1r1w as blackbox in Yosys ---\n"

# The 'add_yosys_command' is an OpenLane2 helper that queues Yosys commands
# for the Synthesize step.
add_yosys_command "setattr -mod mem_1r1w blackbox 1"

puts "\n--- Done forcing mem_1r1w as blackbox ---\n"
