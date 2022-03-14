
######################################
## Constraints file-ac701           ##
######################################


set_property IOSTANDARD LVDS_25 [get_ports clk_p]
set_property PACKAGE_PIN R3 [get_ports clk_p]
set_property PACKAGE_PIN P3 [get_ports clk_n]
set_property IOSTANDARD LVDS_25 [get_ports clk_n]

create_clock -period 8.000 -name ref_clk_clk_p -waveform {0.000 4.000} [get_ports clk_p]

## outputs
set_property PACKAGE_PIN M26 [get_ports {flag_count}]
set_property IOSTANDARD LVCMOS33 [get_ports {flag_count}]

## inputs
set_property PACKAGE_PIN U4 [get_ports {rst_n}]
set_property IOSTANDARD LVCMOS15 [get_ports {rst_n}]
set_property PACKAGE_PIN U5 [get_ports {enable}]
set_property IOSTANDARD SSTL15 [get_ports {enable}]