transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/Control\ Unit {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/Control Unit/ControlUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ProgramCounter {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ProgramCounter/Program_Counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ROM {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ROM/ROM.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/xor64.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/shiftRight1.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/shiftLeft1.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/or64.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/invert64.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/carry_look_ahead64bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/carry_look_ahead16bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/carry_look_ahead4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/and64.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/RAM {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/RAM/RAM256x64.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/ALU/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/Register\ File {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/Register File/RegisterFile32x64bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/TopLevel.v}

vlog -vlog01compat -work work +incdir+C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel {C:/Users/rlkmi/Documents/4_2021_Sophomore_Spring/CompArch/Labs/Processor/TopLevel/TopLevel_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  TopLevel_tb

add wave *
view structure
view signals
run -all
