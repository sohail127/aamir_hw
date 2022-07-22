#define virtual clock for timing analysis

# create_clock -name clk_virt -period 4

create_clock 		 -name clk -period 4.00  -waveform {0 2.0} [get_ports clk]
set_input_delay  -clock [get_clocks {clk}] -rise 0.1 [get_ports i_en]
set_input_delay  -clock [get_clocks {clk}] -rise 0.1 [get_ports rst_n]
set_output_delay -clock [get_clocks {clk}] -rise 0.2 [get_ports o_valid] 
set_output_delay -clock [get_clocks {clk}] -rise 0.2 [get_ports o_count] 
set_output_delay -clock [get_clocks {clk}] -rise 0.2 [get_ports o_count_set] 
