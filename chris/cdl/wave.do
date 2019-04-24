onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider CLK
add wave -noupdate -radix binary /tb_usb_rx/DUT/clk
add wave -noupdate -radix binary /tb_usb_rx/DUT/n_rst
add wave -noupdate -divider Inputs
add wave -noupdate -radix binary /tb_usb_rx/DUT/dplus_in
add wave -noupdate -radix binary /tb_usb_rx/DUT/dminus_in
add wave -noupdate -divider Outputs
add wave -noupdate -radix binary /tb_usb_rx/DUT/rx_packet
add wave -noupdate -radix binary /tb_usb_rx/DUT/store_rx_packet
add wave -noupdate -radix binary /tb_usb_rx/DUT/rx_packet_data
add wave -noupdate -divider Other
add wave -noupdate -radix binary /tb_usb_rx/DUT/d_decoded
add wave -noupdate -radix binary /tb_usb_rx/DUT/eop
add wave -noupdate -radix binary /tb_usb_rx/DUT/shift_enable
add wave -noupdate -radix binary /tb_usb_rx/DUT/byte_count
add wave -noupdate -radix binary /tb_usb_rx/DUT/sync_byte
add wave -noupdate -radix binary /tb_usb_rx/DUT/bit_period
add wave -noupdate -radix binary /tb_usb_rx/DUT/packet_in
add wave -noupdate -radix binary /tb_usb_rx/DUT/DECODE/state
add wave -noupdate /tb_usb_rx/DUT/DECODE/next_state
add wave -noupdate -radix binary /tb_usb_rx/DUT/SR/shift_strobe
add wave -noupdate -radix binary /tb_usb_rx/DUT/SR/serial_in
add wave -noupdate -radix binary /tb_usb_rx/DUT/SR/byte_done
add wave -noupdate -radix binary /tb_usb_rx/DUT/SR/packet_data
add wave -noupdate -radix binary /tb_usb_rx/DUT/SR/sync_byte_detected
add wave -noupdate -radix binary /tb_usb_rx/DUT/SR/temp_packet_data
add wave -noupdate -radix binary /tb_usb_rx/DUT/DECODE/start
add wave -noupdate -radix symbolic /tb_usb_rx/DUT/TIME/byte_count
add wave -noupdate -radix binary /tb_usb_rx/DUT/TIME/sr_count
add wave -noupdate -radix binary /tb_usb_rx/DUT/TIME/byte_c
add wave -noupdate -divider FSM
add wave -noupdate -radix binary /tb_usb_rx/DUT/FSM/sync_byte
add wave -noupdate -radix binary /tb_usb_rx/DUT/FSM/packet_in
add wave -noupdate -radix binary /tb_usb_rx/DUT/FSM/eop
add wave -noupdate -radix binary /tb_usb_rx/DUT/FSM/packet_data
add wave -noupdate -radix binary /tb_usb_rx/DUT/FSM/rx_packet
add wave -noupdate -radix binary /tb_usb_rx/DUT/FSM/temp_holding
add wave -noupdate -radix binary /tb_usb_rx/DUT/FSM/next_temp_holding
add wave -noupdate -radix binary /tb_usb_rx/DUT/FSM/store_rx_data
add wave -noupdate /tb_usb_rx/DUT/FSM/state
add wave -noupdate /tb_usb_rx/DUT/FSM/next_state
add wave -noupdate -divider {CRC BUllSHIT}
add wave -noupdate -radix binary /tb_usb_rx/DUT/CHECK/din
add wave -noupdate -radix binary /tb_usb_rx/DUT/CHECK/clear
add wave -noupdate -radix binary /tb_usb_rx/DUT/CHECK/crcError
add wave -noupdate -radix binary /tb_usb_rx/DUT/CHECK/q
add wave -noupdate -radix binary /tb_usb_rx/DUT/CHECK/xor1
add wave -noupdate -radix binary /tb_usb_rx/DUT/CHECK/xor2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1118354 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 204
configure wave -valuecolwidth 190
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2625 ns}
