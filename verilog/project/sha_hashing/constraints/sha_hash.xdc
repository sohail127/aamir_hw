# project constraint files

## Timing Assertions Section
# Primary clocks
# Virtual clocks
# Generated clocks
# Delay for external MMCM/PLL feedback loop
# Clock Uncertainty and Jitter
# Input and output delay constraints
# Clock Groups and Clock False Paths
## Timing Exceptions Section
# False Paths
# Max Delay / Min Delay
# Multicycle Paths
# Case Analysis
# Disable Timing


	create_clock 		 -name clk -period 8.00  -waveform {0 5} [get_ports usr_clk]
# Input constraints
	set_input_delay  -clock clk -clock_rise 0.0 [all_inputs]
	set_clock_uncertainty -setup 0.1 [get_clocks clk]
	#set_clock_uncertainty -hold 0.167  [get_clocks clk]
# Output constraints
	set_output_delay  -clock [get_clocks clk] [all_outputs] 