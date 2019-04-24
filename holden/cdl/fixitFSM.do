onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fixitFSM/tb_mismatch
add wave -noupdate /tb_fixitFSM/tb_check
add wave -noupdate -radix decimal /tb_fixitFSM/tb_test_case_num
add wave -noupdate /tb_fixitFSM/tb_clk
add wave -noupdate /tb_fixitFSM/tb_nRst
add wave -noupdate /tb_fixitFSM/tb_txPacketSizeChanged
add wave -noupdate /tb_fixitFSM/tb_rxDataReady
add wave -noupdate /tb_fixitFSM/tb_bufferOccupancy
add wave -noupdate /tb_fixitFSM/tb_txPacketDataSize
add wave -noupdate /tb_fixitFSM/tb_bufferReserved
add wave -noupdate /tb_fixitFSM/tb_expected_bufferReserved
add wave -noupdate -radix binary /tb_fixitFSM/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {80000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 294
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {525 ns}
