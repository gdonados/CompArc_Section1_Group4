transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/RAM {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/RAM/RAM256x64.v}

vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/RAM {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/RAM/RAM256x64_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  RAM256x64_tb

add wave *
view structure
view signals
run -all
