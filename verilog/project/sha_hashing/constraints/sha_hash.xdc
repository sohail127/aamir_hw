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


	create_clock 		 -name usr_clk -period 10.00  -waveform {0 1.5} [get_ports usr_clk]
# Input constraints
	# set_input_delay  -rise -clock usr_clk  0.0 [all_inputs]
	# set_clock_uncertainty -setup 0.1 [get_clocks usr_clk]
# Output constraints
	# set_output_delay  -clock [get_clocks usr_clk] [all_outputs] 
	# set_output_delay 5.0 -clock [get_clocks cpuClk] [get_ports]  