onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mips_testbench/CLOCK_PERIOD
add wave -noupdate /mips_testbench/clk
add wave -noupdate /mips_testbench/reset
add wave -noupdate /mips_testbench/dut/d_path/clk
add wave -noupdate /mips_testbench/dut/d_path/reset
add wave -noupdate /mips_testbench/dut/d_path/regwrite
add wave -noupdate /mips_testbench/dut/d_path/memwrite
add wave -noupdate /mips_testbench/dut/d_path/alusrc
add wave -noupdate /mips_testbench/dut/d_path/memtoreg
add wave -noupdate /mips_testbench/dut/d_path/regdst
add wave -noupdate /mips_testbench/dut/d_path/branch
add wave -noupdate /mips_testbench/dut/d_path/jump
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/pc
add wave -noupdate /mips_testbench/dut/d_path/alucontrol
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/pc_next
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/result
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/signext_imm
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/alu_srcb
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/im_instr
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/rfile_rd1
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/rfile_rd2
add wave -noupdate /mips_testbench/dut/d_path/writereg
add wave -noupdate /mips_testbench/dut/d_path/alu_cout
add wave -noupdate /mips_testbench/dut/d_path/alu_zero
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/alu_result
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/dmem_readdata
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/pc_plus4
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/pc_branch
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/pc_src
add wave -noupdate -radix hexadecimal /mips_testbench/dut/d_path/pc_jump
add wave -noupdate /mips_testbench/sw_in
add wave -noupdate /mips_testbench/rfile_rd3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7343 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 241
configure wave -valuecolwidth 241
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
WaveRestoreZoom {7218 ps} {7568 ps}
