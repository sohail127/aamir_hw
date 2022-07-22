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


create_clock -period 10.000 -name i_src_clk -waveform {0.000 5.000} [get_ports i_src_clk]
create_clock -period 5.000 	-name i_dst_clk -waveform {0.000 2.500} [get_ports i_dst_clk]

# Input constraints
# set_input_delay  -rise -clock usr_clk  0.0 [all_inputs]
# set_clock_uncertainty -setup 0.1 [get_clocks usr_clk]
# Output constraints
# set_output_delay  -clock [get_clocks usr_clk] [all_outputs]
# set_output_delay 5.0 -clock [get_clocks cpuClk] [get_ports]
