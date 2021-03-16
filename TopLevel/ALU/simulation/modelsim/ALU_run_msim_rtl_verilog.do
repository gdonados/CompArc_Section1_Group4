transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/and64.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/xor64.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/or64.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/invert64.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/shiftLeft1.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/shiftRight1.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/carry_look_ahead4bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/carry_look_ahead16bit.v}
vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/carry_look_ahead64bit.v}

vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/ALU/ALU_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  ALU_tb

add wave *
view structure
view signals
run -all
