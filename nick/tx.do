onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color {Dark Orchid} /tb_usb_tx/tb_clk
add wave -noupdate -color {Dark Orchid} /tb_usb_tx/tb_n_rst
add wave -noupdate -color Salmon /tb_usb_tx/tb_get_tx_packet_data
add wave -noupdate -color Salmon /tb_usb_tx/tb_tx_packet_data
add wave -noupdate -color Salmon /tb_usb_tx/tb_tx_packet_data_size
add wave -noupdate -color Salmon /tb_usb_tx/tb_tx_packet
add wave -noupdate -color Salmon /tb_usb_tx/tb_tx_status
add wave -noupdate -color Cyan /tb_usb_tx/tb_d_plus_out
add wave -noupdate -color Cyan /tb_usb_tx/tb_d_minus_out
add wave -noupdate /tb_usb_tx/DUT/encoder/serial_in
add wave -noupdate /tb_usb_tx/DUT/fsm/data_out
add wave -noupdate /tb_usb_tx/DUT/pts_shift/pts/out_state
add wave -noupdate /tb_usb_tx/DUT/pts_shift/pts/load_enable
add wave -noupdate /tb_usb_tx/tb_test_num
add wave -noupdate /tb_usb_tx/data_to_send
add wave -noupdate /tb_usb_tx/sync_byte
add wave -noupdate /tb_usb_tx/tb_tx_packet_data
add wave -noupdate /tb_usb_tx/encode_output/serial_in
add wave -noupdate /tb_usb_tx/encode_output/encoded_out
add wave -noupdate /tb_usb_tx/expected_tb_d_plus_out
add wave -noupdate /tb_usb_tx/expected_tb_d_minus_out
add wave -noupdate /tb_usb_tx/crc
add wave -noupdate /tb_usb_tx/data_for_crc
add wave -noupdate -color Yellow /tb_usb_tx/DUT/rollover_flag8
add wave -noupdate -color Yellow /tb_usb_tx/DUT/rollover_flag64
add wave -noupdate -color Pink /tb_usb_tx/DUT/fsm/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {160733 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 214
configure wave -valuecolwidth 100
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {630 ns}
