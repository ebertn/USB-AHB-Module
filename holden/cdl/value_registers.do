onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_value_registers/tb_mismatch
add wave -noupdate /tb_value_registers/tb_check
add wave -noupdate -radix decimal /tb_value_registers/tb_test_case_num
add wave -noupdate /tb_value_registers/tb_clk
add wave -noupdate /tb_value_registers/tb_nRst
add wave -noupdate /tb_value_registers/tb_rxDataReady
add wave -noupdate /tb_value_registers/tb_rxTransferActive
add wave -noupdate /tb_value_registers/tb_txTransferActive
add wave -noupdate /tb_value_registers/tb_nextEHTSData
add wave -noupdate /tb_value_registers/tb_statusData
add wave -noupdate /tb_value_registers/tb_expected_statusData
add wave -noupdate /tb_value_registers/tb_txError
add wave -noupdate /tb_value_registers/tb_rxError
add wave -noupdate /tb_value_registers/tb_errorData
add wave -noupdate /tb_value_registers/tb_expected_errorData
add wave -noupdate /tb_value_registers/tb_bufferOccupancy
add wave -noupdate /tb_value_registers/tb_boData
add wave -noupdate /tb_value_registers/tb_expected_boData
add wave -noupdate /tb_value_registers/tb_ehtsData
add wave -noupdate /tb_value_registers/tb_expected_ehtsData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {180278 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 310
configure wave -valuecolwidth 69
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
WaveRestoreZoom {0 ps} {367500 ps}
