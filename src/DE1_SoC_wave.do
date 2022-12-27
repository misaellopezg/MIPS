onerror {resume}
quietly virtual function -install /DE1_SoC_testbench -env /DE1_SoC_testbench { &{/DE1_SoC_testbench/SW[9], /DE1_SoC_testbench/SW[8], /DE1_SoC_testbench/SW[7], /DE1_SoC_testbench/SW[0] }} UPCM
quietly virtual function -install /DE1_SoC_testbench/dut -env /DE1_SoC_testbench/dut { &{/DE1_SoC_testbench/dut/SW[3], /DE1_SoC_testbench/dut/SW[2], /DE1_SoC_testbench/dut/SW[1], /DE1_SoC_testbench/dut/SW[0] }} d0in
quietly virtual function -install /DE1_SoC_testbench/dut -env /DE1_SoC_testbench/dut { &{/DE1_SoC_testbench/dut/SW[7], /DE1_SoC_testbench/dut/SW[6], /DE1_SoC_testbench/dut/SW[5], /DE1_SoC_testbench/dut/SW[4] }} d1in
quietly virtual function -install /DE1_SoC_testbench -env /DE1_SoC_testbench { &{/DE1_SoC_testbench/SW[9], /DE1_SoC_testbench/SW[8], /DE1_SoC_testbench/SW[7], /DE1_SoC_testbench/SW[0] }} SWIN
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate /DE1_SoC_testbench/dut/RAM/address
add wave -noupdate /DE1_SoC_testbench/dut/RAM/data
add wave -noupdate /DE1_SoC_testbench/dut/RAM/wren
add wave -noupdate /DE1_SoC_testbench/dut/RAM/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {525 ps}
