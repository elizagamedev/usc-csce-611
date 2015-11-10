onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/cpu/fetch/clk
add wave -noupdate /testbench/cpu/fetch/rst
add wave -noupdate /testbench/cpu/fetch/PC_FETCH
add wave -noupdate /testbench/cpu/fetch/instruction_EX
add wave -noupdate /testbench/cpu/fetch/pc_src_EX
add wave -noupdate /testbench/cpu/fetch/stall_EX
add wave -noupdate /testbench/cpu/execute/lo_EX
add wave -noupdate /testbench/cpu/execute/hi_EX
add wave -noupdate /testbench/cpu/execute/enhilo_EX
add wave -noupdate /testbench/cpu/execute/op_EX
add wave -noupdate /testbench/cpu/execute/shamt_EX
add wave -noupdate /testbench/cpu/execute/readdata1_EX
add wave -noupdate /testbench/cpu/execute/readdata2_EX
add wave -noupdate /testbench/cpu/execute/regsel_EX
add wave -noupdate /testbench/cpu/execute/regwrite_EX
add wave -noupdate /testbench/cpu/execute/hi_WB
add wave -noupdate /testbench/cpu/execute/lo_WB
add wave -noupdate /testbench/cpu/execute/r_WB
add wave -noupdate /testbench/cpu/execute/regdata_WB
add wave -noupdate /testbench/cpu/execute/regdest_WB
add wave -noupdate /testbench/cpu/execute/regsel_WB
add wave -noupdate /testbench/cpu/execute/regwrite_WB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {110 ns}
