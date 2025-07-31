# Synopsys Design Constraints file for 100MHz operation
#
# This file sets up a 100MHz clock (period = 10.0 ns) with typical input/output delays,
# clock uncertainty, and false path constraints for asynchronous reset.
#

create_clock -name clk -period 10.0 [get_ports clk]
set_clock_uncertainty 0.1 [get_ports clk]

# Mark the async reset as a false path if rst_n is truly asynchronous
#set_false_path -from [get_ports rst_n] -to [all_registers]

# End of spm.sdc

