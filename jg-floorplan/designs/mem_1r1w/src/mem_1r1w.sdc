# Synopsys Design Constraints file for 100MHz operation
#
# This file sets up a 100MHz clock (period = 10.0 ns) with typical input/output delays,
# clock uncertainty, and false path constraints for asynchronous reset.
#

# Create primary clock on port "clk" with a period of 10.0 ns (500MHz)
create_clock -name clk -period 10.0 [get_ports clk]

# Set clock uncertainty to account for clock jitter (adjust as needed)
set_clock_uncertainty 0.1 [get_ports clk]

# (Optional) Define input/output delays if you want to model how signals arrive at or leave the block.
#    For instance, if you assume external logic driving read_addr/write_addr/write_data:
#
set_input_delay  -clock clk 0.2 [get_ports {read_addr* write_addr* write_data* read write}]
set_output_delay -clock clk 0.2 [get_ports {read_data}]



# Set maximum transition (slew) constraints on I/O to ensure signal integrity
set_max_transition 0.15 [get_ports {read_addr* write_addr* write_data* read write}]
set_max_transition 0.15 [get_ports {read_data}]

# Set load constraints on the input ports (example: 0.033 F). Adjust if needed.
set_load 0.033 [get_ports {read_addr* write_addr* write_data* read write}]

# Mark asynchronous reset as a false path so it is not included in timing analysis.
#set_false_path -from [get_ports rst_n] -to [all_registers]

# End of spm.sdc




