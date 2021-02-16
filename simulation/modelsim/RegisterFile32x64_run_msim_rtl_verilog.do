transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/gdona/OneDrive/Documents/GitHub/CompArc {C:/Users/gdona/OneDrive/Documents/GitHub/CompArc/RegisterFile32x64a.v}

