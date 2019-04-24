onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_address_decoder/tb_mismatch
add wave -noupdate /tb_address_decoder/tb_check
add wave -noupdate -radix decimal /tb_address_decoder/tb_test_case_num
add wave -noupdate /tb_address_decoder/tb_clk
add wave -noupdate /tb_address_decoder/tb_nRst
add wave -noupdate /tb_address_decoder/tb_haddr
add wave -noupdate /tb_address_decoder/tb_hsize
add wave -noupdate -radix binary /tb_address_decoder/tb_state
add wave -noupdate /tb_address_decoder/tb_hwdata
add wave -noupdate /tb_address_decoder/tb_rdata
add wave -noupdate /tb_address_decoder/tb_statusData
add wave -noupdate /tb_address_decoder/tb_errorData
add wave -noupdate /tb_address_decoder/tb_boData
add wave -noupdate /tb_address_decoder/tb_ehtsData
add wave -noupdate /tb_address_decoder/tb_nextEHTSData
add wave -noupdate /tb_address_decoder/tb_expected_nextEHTSData
add wave -noupdate /tb_address_decoder/tb_hrdata
add wave -noupdate /tb_address_decoder/tb_expected_hrdata
add wave -noupdate /tb_address_decoder/tb_txData
add wave -noupdate /tb_address_decoder/tb_expected_txData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1138049 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 346
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
WaveRestoreZoom {0 ps} {1470 ns}
