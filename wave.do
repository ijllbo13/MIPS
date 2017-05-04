onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_Processor_TB/clk
add wave -noupdate /MIPS_Processor_TB/reset
add wave -noupdate -color {Dark Orchid} /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/A
add wave -noupdate -color {Dark Orchid} /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/B
add wave -noupdate /MIPS_Processor_TB/ALUResultOut
add wave -noupdate /MIPS_Processor_TB/DUV/ArithmeticLogicUnit/Zero
add wave -noupdate -color Gold /MIPS_Processor_TB/DUV/ProgramCounter/PCValue
add wave -noupdate -color {Medium Blue} /MIPS_Processor_TB/DUV/ControlUnit/ALUOp
add wave -noupdate -divider RAM
add wave -noupdate -radix decimal /MIPS_Processor_TB/DUV/RAMProgramMemory/Address
add wave -noupdate /MIPS_Processor_TB/DUV/RAMProgramMemory/WriteData
add wave -noupdate -radix decimal /MIPS_Processor_TB/DUV/RAMProgramMemory/ReadData
add wave -noupdate /MIPS_Processor_TB/DUV/RAMProgramMemory/ram
add wave -noupdate /MIPS_Processor_TB/DUV/RAMProgramMemory/ReadDataAux
add wave -noupdate -divider REGISTER
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/WriteRegister
add wave -noupdate -color {Orange Red} /MIPS_Processor_TB/DUV/Register_File/ReadRegister1
add wave -noupdate -color {Orange Red} /MIPS_Processor_TB/DUV/Register_File/ReadRegister2
add wave -noupdate /MIPS_Processor_TB/DUV/Register_File/WriteData
add wave -noupdate -color {Sky Blue} /MIPS_Processor_TB/DUV/Register_File/ReadData1
add wave -noupdate -color {Sky Blue} /MIPS_Processor_TB/DUV/Register_File/ReadData2
add wave -noupdate -divider IF_ID
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID/clk
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID/reset
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID/DataInput
add wave -noupdate /MIPS_Processor_TB/DUV/IF_ID/DataOutput
add wave -noupdate -divider ID_EX
add wave -noupdate /MIPS_Processor_TB/DUV/ID_EX/clk
add wave -noupdate /MIPS_Processor_TB/DUV/ID_EX/reset
add wave -noupdate /MIPS_Processor_TB/DUV/ID_EX/DataInput
add wave -noupdate /MIPS_Processor_TB/DUV/ID_EX/DataOutput
add wave -noupdate -divider EX_M
add wave -noupdate /MIPS_Processor_TB/DUV/EX_M/clk
add wave -noupdate /MIPS_Processor_TB/DUV/EX_M/reset
add wave -noupdate /MIPS_Processor_TB/DUV/EX_M/DataInput
add wave -noupdate /MIPS_Processor_TB/DUV/EX_M/DataOutput
add wave -noupdate -divider M_WB
add wave -noupdate /MIPS_Processor_TB/DUV/M_WB/clk
add wave -noupdate /MIPS_Processor_TB/DUV/M_WB/reset
add wave -noupdate /MIPS_Processor_TB/DUV/M_WB/DataInput
add wave -noupdate /MIPS_Processor_TB/DUV/M_WB/DataOutput
add wave -noupdate -divider T1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 55
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
WaveRestoreZoom {0 ps} {30 ps}
