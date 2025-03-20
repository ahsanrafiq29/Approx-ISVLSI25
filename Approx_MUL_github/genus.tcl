
#/-------------------------------------------------------------------------
#/ -- settings to access directories, libraries and design (rtl) files
#/-------------------------------------------------------------------------
#set directories path
set init_lib  { //home/ahsan/frontend/freepdk-45nm-master/stdcells.lib \ }

#set design name (or) top module name
set DESIGN 			"mul8"

#/-------------------------------------------------------------------------
#/ -- list of design (rtl) files
#/-------------------------------------------------------------------------
set RTL_LIST_1 { \
				../rtl/fi.v
}

#set RTL_LIST_2 { \
				../rtl/.vhd		..


#/-------------------------------------------------------------------------
#/ -- list of commands to be executed to finish synthesis
#/-------------------------------------------------------------------------

#set_db hdl_error_on_latch true
#set_db lp_insert_clock_gating true

read_libs ${init_lib}

#read_hdl ${RTL_LIST}
read_hdl ${RTL_LIST_1}
#read_hdl -vhdl ${RTL_LIST_2} -library work 

#set_dont_use *SDF*
#set_dont_use *SEDF*
#set_dont_use LH*
#set_dont_use LN*

# Elaborate the top level
elaborate $DESIGN

#suspend

#suspend

# Read the constraint file
#read_sdc ../constraints/

# GENERIC SYNTHESIS
# Report erros 
check_design -unresolved

report timing -lint

#suspend
#*Synthesis
#
# GENERIC SYNTHESIS ###
set_db syn_generic_effort high
syn_generic

# MAPPING ###
set_db syn_map_effort high
syn_map

# OPT ###
set_db syn_opt_effort high
syn_opt
syn_opt -incr
#/-------------------------------------------------------------------------
#/ -- list of commands to generate reports after finishing synthesis
#/-------------------------------------------------------------------------
report timing > ../report/timing_opt_${DESIGN}.rep
report area	  > ../report/area_opt_${DESIGN}.rep
report gates  > ../report/gates_opt_${DESIGN}.rep
report power  > ../report/power_opt_${DESIGN}.rep
report power -flat > ../report/power_flat_opt_${DESIGN}.rep
check_design > ../report/check_design_opt_${DESIGN}.rep 

#/-------------------------------------------------------------------------
#/ -- IOPT - Incremental timing optimizations
#/-------------------------------------------------------------------------
#set_attribute syn_opt_effort extreme
#syn_opt -incremental
#/-------------------------------------------------------------------------
#/ -- list of commands to generate reports after finishing synthesis
#/-------------------------------------------------------------------------
#report timing > ../reports/timing_inc_${DESIGN}.rep
#report area	  > ../reports/area_inc_${DESIGN}.rep
#report gates  > ../reports/cell_inc_${DESIGN}.rep
#report power  > ../reports/power_inc_${DESIGN}.rep

 report power -flat > ../reports/power_flat_inc_${DESIGN}.rep

#/-------------------------------------------------------------------------
#/ -- Generate the netlist and constraint files to be input to INNOVUS 
#/-------------------------------------------------------------------------
write_hdl -mapped >  ../netlist/${DESIGN}.v
# write_sdc         >  ../constraints/${DESIGN}_genus.sdc

#/-------------------------------------------------------------------------
#/ -- Synthesis finished after generating reports
#/-------------------------------------------------------------------------
# Synthesis Finished
puts \n 
puts "Synthesis Finished!         "
puts \n
puts "Check timing.rep, area.rep, gate.rep and power.rep for synthesis results"
puts \n
