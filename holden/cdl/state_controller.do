onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_state_controller/tb_mismatch
add wave -noupdate /tb_state_controller/tb_check
add wave -noupdate -radix decimal /tb_state_controller/tb_test_case_num
add wave -noupdate /tb_state_controller/tb_clk
add wave -noupdate /tb_state_controller/tb_nRst
add wave -noupdate /tb_state_controller/tb_haddr
add wave -noupdate /tb_state_controller/tb_htrans
add wave -noupdate /tb_state_controller/tb_hsize
add wave -noupdate /tb_state_controller/tb_dataSize
add wave -noupdate /tb_state_controller/tb_hwrite
add wave -noupdate /tb_state_controller/tb_hsel
add wave -noupdate /tb_state_controller/tb_state
add wave -noupdate /tb_state_controller/tb_expected_state
add wave -noupdate /tb_state_controller/tb_storeTxData
add wave -noupdate /tb_state_controller/tb_expected_storeTxData
add wave -noupdate /tb_state_controller/tb_getRxData
add wave -noupdate /tb_state_controller/tb_expected_getRxData
add wave -noupdate /tb_state_controller/tb_hresp
add wave -noupdate /tb_state_controller/tb_expected_hresp
add wave -noupdate /tb_state_controller/tb_hready
add wave -noupdate /tb_state_controller/tb_expected_hready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {90052 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 321
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
