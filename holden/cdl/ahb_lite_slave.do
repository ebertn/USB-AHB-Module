onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {Test Signals} -color Magenta -radix decimal /tb_ahb_lite_slave/tb_test_case_num
add wave -noupdate -group {Test Signals} -color Magenta -radix binary /tb_ahb_lite_slave/tb_mismatch
add wave -noupdate -group {Test Signals} -color Magenta -radix binary /tb_ahb_lite_slave/tb_check
add wave -noupdate -group {Test Signals} -color Magenta -radix decimal /tb_ahb_lite_slave/tb_i
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix binary /tb_ahb_lite_slave/tb_enqueue_transaction
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix binary /tb_ahb_lite_slave/tb_transaction_write
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix binary /tb_ahb_lite_slave/tb_transaction_fake
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} /tb_ahb_lite_slave/tb_transaction_addr
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} /tb_ahb_lite_slave/tb_transaction_burst
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix binary /tb_ahb_lite_slave/tb_transaction_error
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} /tb_ahb_lite_slave/tb_transaction_size
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix binary /tb_ahb_lite_slave/tb_model_reset
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix binary /tb_ahb_lite_slave/tb_enable_transactions
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix decimal /tb_ahb_lite_slave/tb_current_addr_transaction_num
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix decimal /tb_ahb_lite_slave/tb_current_addr_beat_num
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix binary /tb_ahb_lite_slave/tb_current_addr_transaction_error
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix decimal /tb_ahb_lite_slave/tb_current_data_transaction_num
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix decimal /tb_ahb_lite_slave/tb_current_data_beat_num
add wave -noupdate -group {Bus Signals} -color {Cornflower Blue} -radix binary /tb_ahb_lite_slave/tb_current_data_transaction_error
add wave -noupdate -expand -group {System Signals} -radix binary /tb_ahb_lite_slave/DUT/clk
add wave -noupdate -expand -group {System Signals} -radix binary /tb_ahb_lite_slave/DUT/nRst
add wave -noupdate -expand -group {AHB-Lite Signals} -color {Sea Green} -radix binary /tb_ahb_lite_slave/DUT/hsel
add wave -noupdate -expand -group {AHB-Lite Signals} -color {Sea Green} /tb_ahb_lite_slave/DUT/haddr
add wave -noupdate -expand -group {AHB-Lite Signals} -color {Sea Green} /tb_ahb_lite_slave/DUT/htrans
add wave -noupdate -expand -group {AHB-Lite Signals} -color {Sea Green} /tb_ahb_lite_slave/DUT/hsize
add wave -noupdate -expand -group {AHB-Lite Signals} -color {Sea Green} -radix binary /tb_ahb_lite_slave/DUT/hwrite
add wave -noupdate -expand -group {AHB-Lite Signals} -color {Sea Green} /tb_ahb_lite_slave/DUT/hwdata
add wave -noupdate -expand -group {AHB-Lite Signals} -color {Sea Green} /tb_ahb_lite_slave/DUT/hburst
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Inputs -color {Medium Slate Blue} -radix binary /tb_ahb_lite_slave/DUT/rxDataReady
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Inputs -color {Medium Slate Blue} -radix binary /tb_ahb_lite_slave/DUT/rxTransferActive
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Inputs -color {Medium Slate Blue} -radix binary /tb_ahb_lite_slave/DUT/rxError
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Inputs -color {Medium Slate Blue} -radix binary /tb_ahb_lite_slave/DUT/txTransferActive
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Inputs -color {Medium Slate Blue} -radix binary /tb_ahb_lite_slave/DUT/txError
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Inputs -color {Medium Slate Blue} /tb_ahb_lite_slave/DUT/bufferOccupancy
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Inputs -color {Medium Slate Blue} /tb_ahb_lite_slave/DUT/rxData
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Outputs -color Cyan /tb_ahb_lite_slave/DUT/hrdata
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Outputs -color Cyan -radix binary /tb_ahb_lite_slave/DUT/hresp
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Outputs -color Cyan -radix binary /tb_ahb_lite_slave/DUT/hready
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Outputs -color Cyan -radix binary /tb_ahb_lite_slave/DUT/bufferReserved
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Outputs -color Cyan -radix binary /tb_ahb_lite_slave/DUT/getRxData
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Outputs -color Cyan -radix binary /tb_ahb_lite_slave/DUT/storeTxData
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Outputs -color Cyan /tb_ahb_lite_slave/DUT/txData
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Outputs -color Cyan /tb_ahb_lite_slave/DUT/dataSize
add wave -noupdate -expand -group {Internal USB Signals} -expand -group Outputs -color Cyan /tb_ahb_lite_slave/DUT/txPacketDataSize
add wave -noupdate -group {Expected Internal Signals} -color Maroon -radix binary /tb_ahb_lite_slave/tb_expected_bufferReserved
add wave -noupdate -group {Expected Internal Signals} -color Maroon -radix binary /tb_ahb_lite_slave/tb_expected_getRxData
add wave -noupdate -group {Expected Internal Signals} -color Maroon -radix binary /tb_ahb_lite_slave/tb_expected_storeTxData
add wave -noupdate -group {Expected Internal Signals} -color Maroon /tb_ahb_lite_slave/tb_expected_txData
add wave -noupdate -group {Expected Internal Signals} -color Maroon /tb_ahb_lite_slave/tb_expected_dataSize
add wave -noupdate -group {Expected Internal Signals} -color Maroon /tb_ahb_lite_slave/tb_expected_txPacketDataSize
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1643275 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 278
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
WaveRestoreZoom {0 ps} {2493102 ps}
