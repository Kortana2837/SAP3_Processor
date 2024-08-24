onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /top_tb/i
add wave -noupdate /top_tb/rst
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/address_bus
add wave -noupdate /top_tb/data_bus
add wave -noupdate -radix unsigned /top_tb/top/memory/mar
add wave -noupdate /top_tb/top/memory/out
add wave -noupdate /top_tb/top/mem_mar_we
add wave -noupdate -radix unsigned /top_tb/top/alu/Acc
add wave -noupdate {/top_tb/top/reg_file/data[0]}
add wave -noupdate /top_tb/top/ir/ir
add wave -noupdate /top_tb/top/i_o_ctrl/out_address_reg
add wave -noupdate /top_tb/top/i_o_ctrl/out_data_reg
add wave -noupdate /top_tb/top/i_o_ctrl/reg_we
add wave -noupdate /top_tb/top/i_o_ctrl/reg_sel
add wave -noupdate {/top_tb/top/reg_file/data[9]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {594 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
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
configure wave -timelineunits ns
update
WaveRestoreZoom {353 ps} {648 ps}
