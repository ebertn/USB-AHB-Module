onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider tb_data_buffer
add wave -noupdate /tb_data_buffer/CLK_PERIOD
add wave -noupdate -color Cyan /tb_data_buffer/tb_clk
add wave -noupdate -color Cyan /tb_data_buffer/tb_n_rst
add wave -noupdate -expand -group tb_outputs -color {Orange Red} /tb_data_buffer/tb_rx_data
add wave -noupdate -expand -group tb_outputs -color {Orange Red} /tb_data_buffer/tb_tx_packet_data
add wave -noupdate -expand -group tb_outputs -color {Orange Red} /tb_data_buffer/tb_buffer_occupancy
add wave -noupdate -expand -group tb_outputs -color {Orange Red} /tb_data_buffer/tb_lock_error
add wave -noupdate -expand -group tb_inputs /tb_data_buffer/tb_get_rx_data
add wave -noupdate -expand -group tb_inputs /tb_data_buffer/tb_store_tx_data
add wave -noupdate -expand -group tb_inputs /tb_data_buffer/tb_tx_data
add wave -noupdate -expand -group tb_inputs /tb_data_buffer/tb_data_size
add wave -noupdate -expand -group tb_inputs /tb_data_buffer/tb_get_tx_packet_data
add wave -noupdate -expand -group tb_inputs /tb_data_buffer/tb_rx_packet_data
add wave -noupdate -expand -group tb_inputs /tb_data_buffer/tb_store_rx_packet_data
add wave -noupdate -expand -group tb_inputs /tb_data_buffer/tb_clear
add wave -noupdate -expand -group tb_inputs /tb_data_buffer/tb_lock_db
add wave -noupdate -expand -group tb_internal_signals -color Gold /tb_data_buffer/tb_test_num
add wave -noupdate -expand -group tb_internal_signals -color Gold /tb_data_buffer/tb_test_case
add wave -noupdate -expand -group tb_internal_signals -color Gold /tb_data_buffer/expected_buffer_occupancy
add wave -noupdate -expand -group tb_internal_signals -color Gold /tb_data_buffer/x
add wave -noupdate -divider data_buffer
add wave -noupdate -color Cyan /tb_data_buffer/data_buffer/clk
add wave -noupdate -color Cyan /tb_data_buffer/data_buffer/n_rst
add wave -noupdate -expand -group db_inputs /tb_data_buffer/data_buffer/clear
add wave -noupdate -expand -group db_inputs /tb_data_buffer/data_buffer/get_rx_data
add wave -noupdate -expand -group db_inputs /tb_data_buffer/data_buffer/store_tx_data
add wave -noupdate -expand -group db_inputs /tb_data_buffer/data_buffer/tx_data
add wave -noupdate -expand -group db_inputs /tb_data_buffer/data_buffer/data_size
add wave -noupdate -expand -group db_inputs /tb_data_buffer/data_buffer/get_tx_packet_data
add wave -noupdate -expand -group db_inputs /tb_data_buffer/data_buffer/rx_packet_data
add wave -noupdate -expand -group db_inputs /tb_data_buffer/data_buffer/store_rx_packet_data
add wave -noupdate -expand -group db_inputs /tb_data_buffer/data_buffer/lock_db
add wave -noupdate -expand -group db_outputs -color {Orange Red} -radix decimal /tb_data_buffer/data_buffer/buffer_occupancy
add wave -noupdate -expand -group db_outputs -color {Orange Red} /tb_data_buffer/data_buffer/rx_data
add wave -noupdate -expand -group db_outputs -color {Orange Red} /tb_data_buffer/data_buffer/tx_packet_data
add wave -noupdate -expand -group db_outputs -color {Orange Red} /tb_data_buffer/data_buffer/lock_error
add wave -noupdate -expand -group db_states -color {Medium Violet Red} /tb_data_buffer/data_buffer/state
add wave -noupdate -expand -group db_states -color {Medium Violet Red} /tb_data_buffer/data_buffer/next_state
add wave -noupdate -expand -group db_internal_signals -color Gold /tb_data_buffer/data_buffer/count1
add wave -noupdate -expand -group db_internal_signals -color Gold /tb_data_buffer/data_buffer/count2
add wave -noupdate -expand -group db_internal_signals -color Gold /tb_data_buffer/data_buffer/next_count1
add wave -noupdate -expand -group db_internal_signals -color Gold /tb_data_buffer/data_buffer/next_count2
add wave -noupdate -expand -group db_internal_signals -color Gold /tb_data_buffer/data_buffer/data
add wave -noupdate -expand -group db_internal_signals -color Gold /tb_data_buffer/data_buffer/new_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50332 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {272122 ps}
