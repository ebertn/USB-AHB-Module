# Step 1:  Read in the source file
analyze -format sverilog -lib WORK {control_fsm.sv timer.sv flex_counter.sv flex_stp_sr.sv sr_8bit.sv decoder.sv crc_checker_5bit.sv crc_checker_16bit.sv  usb_rx.sv}
elaborate usb_rx -lib WORK
uniquify
# Step 2: Set design constraints
# Uncomment below to set timing, area, power, etc. constraints
# set_max_delay <delay> -from "<input>" -to "<output>"
# set_max_area <area>
# set_max_total_power <power> mW
 create_clock "clk" -name "clk" -period 10

# Step 3: Compile the design
compile -map_effort medium

# Step 4: Output reports
report_timing -path full -delay max -max_paths 1 -nworst 1 > reports/usb_rx.rep
report_area >> reports/usb_rx.rep
report_power -hier >> reports/usb_rx.rep

# Step 5: Output final VHDL and Verilog files
write_file -format verilog -hierarchy -output "mapped/usb_rx.v"
echo "\nScript Done\n"
echo "\nChecking Design\n"
check_design
quit
