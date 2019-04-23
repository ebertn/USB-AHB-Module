onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_crc_checker_5bit/tb_mismatch
add wave -noupdate /tb_crc_checker_5bit/tb_check
add wave -noupdate /tb_crc_checker_5bit/tb_expected_crcError
add wave -noupdate -radix decimal /tb_crc_checker_5bit/tb_test_case_num
add wave -noupdate /tb_crc_checker_5bit/tb_test_data
add wave -noupdate /tb_crc_checker_5bit/tb_test_crc
add wave -noupdate /tb_crc_checker_5bit/tb_clk
add wave -noupdate /tb_crc_checker_5bit/tb_n_rst
add wave -noupdate /tb_crc_checker_5bit/tb_din
add wave -noupdate /tb_crc_checker_5bit/tb_clear
add wave -noupdate /tb_crc_checker_5bit/tb_crcError
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {202340 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 308
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
WaveRestoreZoom {0 ps} {2100 ns}
