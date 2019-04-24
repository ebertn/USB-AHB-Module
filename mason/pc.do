onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider tb_protocol_controller
add wave -noupdate /tb_protocol_controller/CLK_PERIOD
add wave -noupdate /tb_protocol_controller/BUS_DELAY
add wave -noupdate /tb_protocol_controller/tb_test_case
add wave -noupdate /tb_protocol_controller/tb_test_case_num
add wave -noupdate -expand -group tb_clk/n_rst -color Cyan /tb_protocol_controller/tb_clk
add wave -noupdate -expand -group tb_clk/n_rst -color Cyan /tb_protocol_controller/tb_n_rst
add wave -noupdate -expand -group tb_input_signals -color {Orange Red} /tb_protocol_controller/tb_rx_packet
add wave -noupdate -expand -group tb_input_signals -color {Orange Red} /tb_protocol_controller/tb_buffer_reserved
add wave -noupdate -expand -group tb_input_signals -color {Orange Red} /tb_protocol_controller/tb_buffer_occupancy
add wave -noupdate -expand -group tb_input_signals -expand -group {from data buffer} -color {Orange Red} /tb_protocol_controller/tb_tx_status
add wave -noupdate -expand -group tb_input_signals -expand -group {from data buffer} -color {Orange Red} /tb_protocol_controller/tb_lock_error
add wave -noupdate -expand -group tb_output_signals -group tb_output_signals /tb_protocol_controller/tb_rx_data_ready
add wave -noupdate -expand -group tb_output_signals -group tb_output_signals /tb_protocol_controller/tb_rx_transfer_active
add wave -noupdate -expand -group tb_output_signals -group tb_output_signals /tb_protocol_controller/tb_rx_error
add wave -noupdate -expand -group tb_output_signals -group tb_output_signals /tb_protocol_controller/tb_tx_transfer_active
add wave -noupdate -expand -group tb_output_signals -group tb_output_signals /tb_protocol_controller/tb_tx_error
add wave -noupdate -expand -group tb_output_signals /tb_protocol_controller/tb_d_mode
add wave -noupdate -expand -group tb_output_signals /tb_protocol_controller/tb_tx_packet
add wave -noupdate -expand -group tb_output_signals -expand -group {to data buffer} /tb_protocol_controller/tb_clear
add wave -noupdate -expand -group tb_output_signals -expand -group {to data buffer} /tb_protocol_controller/tb_lock_db
add wave -noupdate -divider protocol_controller
add wave -noupdate -expand -group pc_clk/n_rst -color Cyan /tb_protocol_controller/DUT/clk
add wave -noupdate -expand -group pc_clk/n_rst -color Cyan /tb_protocol_controller/DUT/n_rst
add wave -noupdate -expand -group pc_inputs -color {Orange Red} -subitemconfig {{/tb_protocol_controller/DUT/rx_packet[2]} {-color {Orange Red}} {/tb_protocol_controller/DUT/rx_packet[1]} {-color {Orange Red}} {/tb_protocol_controller/DUT/rx_packet[0]} {-color {Orange Red}}} /tb_protocol_controller/DUT/rx_packet
add wave -noupdate -expand -group pc_inputs -color {Orange Red} /tb_protocol_controller/DUT/buffer_reserved
add wave -noupdate -expand -group pc_inputs -color {Orange Red} /tb_protocol_controller/DUT/buffer_occupancy
add wave -noupdate -expand -group pc_inputs -expand -group {from data buffer} -color {Orange Red} /tb_protocol_controller/DUT/tx_status
add wave -noupdate -expand -group pc_inputs -expand -group {from data buffer} -color {Orange Red} /tb_protocol_controller/DUT/lock_error
add wave -noupdate -expand -group pc_outputs -expand -group pc_outputs /tb_protocol_controller/DUT/rx_data_ready
add wave -noupdate -expand -group pc_outputs -expand -group pc_outputs /tb_protocol_controller/DUT/rx_transfer_active
add wave -noupdate -expand -group pc_outputs -expand -group pc_outputs /tb_protocol_controller/DUT/rx_error
add wave -noupdate -expand -group pc_outputs -expand -group pc_outputs /tb_protocol_controller/DUT/tx_transfer_active
add wave -noupdate -expand -group pc_outputs -expand -group pc_outputs /tb_protocol_controller/DUT/tx_error
add wave -noupdate -expand -group pc_outputs /tb_protocol_controller/DUT/d_mode
add wave -noupdate -expand -group pc_outputs /tb_protocol_controller/DUT/tx_packet
add wave -noupdate -expand -group pc_outputs -expand -group {to data buffer} /tb_protocol_controller/DUT/clear
add wave -noupdate -expand -group pc_outputs -expand -group {to data buffer} /tb_protocol_controller/DUT/lock_db
add wave -noupdate -expand -group pc_state -color {Violet Red} /tb_protocol_controller/DUT/state
add wave -noupdate -expand -group pc_state -color {Violet Red} /tb_protocol_controller/DUT/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17680 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 184
configure wave -valuecolwidth 79
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
WaveRestoreZoom {277662 ps} {514064 ps}
