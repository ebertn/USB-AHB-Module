onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_encoder/tb_clk
add wave -noupdate /tb_encoder/tb_n_rst
add wave -noupdate /tb_encoder/DUT/state
add wave -noupdate /tb_encoder/tb_serial_in
add wave -noupdate /tb_encoder/tb_dplus
add wave -noupdate /tb_encoder/tb_dminus
add wave -noupdate /tb_encoder/tb_EOP
add wave -noupdate /tb_encoder/tb_test_num
add wave -noupdate /tb_encoder/tb_rollover_flag64
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {43779 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 142
configure wave -valuecolwidth 143
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
WaveRestoreZoom {0 ps} {189479 ps}
