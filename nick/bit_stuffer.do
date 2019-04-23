onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_bit_stuffer/tb_clk
add wave -noupdate /tb_bit_stuffer/tb_n_rst
add wave -noupdate /tb_bit_stuffer/tb_serial_in
add wave -noupdate /tb_bit_stuffer/tb_rollover_flag64
add wave -noupdate /tb_bit_stuffer/DUT/state
add wave -noupdate /tb_bit_stuffer/tb_stuffing
add wave -noupdate /tb_bit_stuffer/tb_stuffed_serial_out
add wave -noupdate /tb_bit_stuffer/tb_test_num
add wave -noupdate /tb_bit_stuffer/tb_test_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {221250 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 169
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
WaveRestoreZoom {0 ps} {1050 ns}
