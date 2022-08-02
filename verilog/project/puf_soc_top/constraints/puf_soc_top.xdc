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


create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]
# Input constraints
 set_input_delay 	-clock clk -max 0.2 [get_ports * -filter {DIRECTION == IN && NAME !~ "*clk*" && NAME !~ "*rst_n*" }]
 set_input_delay  -clock clk -min 1   [get_ports * -filter {DIRECTION == IN && NAME !~ "*clk*" && NAME !~ "*rst_n*" }]
 set_clock_uncertainty 0.3 [get_clocks clk]
# Output constraints
# set_output_delay  -clock [get_clocks usr_clk] [all_outputs]
# set_output_delay 5.0 -clock [get_clocks cpuClk] [get_ports]
# set_property DONT_TOUCH TRUE [get_cells inst_puf_soc_dp/inst_puf_soc_dp]

