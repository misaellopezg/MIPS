# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./DE1_SoC.sv"
vlog "./seg7.sv"
vlog "./reg_file.sv"
vlog "./programcounter.sv"
vlog "./imem.sv"
vlog "./dmem.sv"
vlog "./signextend.sv"
vlog "./alu.sv"
vlog "./mux2.sv"
vlog "./maindecoder.sv"
vlog "./aludecoder.sv"
vlog "./controlunit.sv"
vlog "./datapath.sv"
vlog "./mips.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
#vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench
vsim -voptargs="+acc" -t 1ps -lib work mips_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
#do DE1_SoC_wave.do
do wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
