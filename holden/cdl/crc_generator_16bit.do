onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_crc_generator_16bit/tb_mismatch
add wave -noupdate /tb_crc_generator_16bit/tb_check
add wave -noupdate -radix decimal /tb_crc_generator_16bit/tb_test_case_num
add wave -noupdate /tb_crc_generator_16bit/tb_clk
add wave -noupdate /tb_crc_generator_16bit/tb_n_rst
add wave -noupdate /tb_crc_generator_16bit/tb_test_data
add wave -noupdate /tb_crc_generator_16bit/tb_din
add wave -noupdate /tb_crc_generator_16bit/tb_clear
add wave -noupdate /tb_crc_generator_16bit/tb_crc
add wave -noupdate /tb_crc_generator_16bit/tb_expected_crc
add wave -noupdate /tb_crc_generator_16bit/tb_shiftEn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5999489 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 308
configure wave -valuecolwidth 164
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
WaveRestoreZoom {0 ps} {4725 ns}
