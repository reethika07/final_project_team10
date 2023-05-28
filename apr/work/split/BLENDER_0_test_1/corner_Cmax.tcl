################################################################################
#
# Created by icc2 split_constraints on Wed May 17 12:54:48 2023
#
################################################################################

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################



# set_timing_derate for corner Cmax
set_timing_derate -early 0.95 -cell_delay -clock [current_design]
set_timing_derate -early 0.95 -cell_delay -data [current_design]
set_timing_derate -early 0.95 -net_delay -clock [current_design]
set_timing_derate -early 0.95 -net_delay -data [current_design]
set_timing_derate -early 0.95 -net_delay -clock -dynamic [current_design]
set_timing_derate -early 0.95 -net_delay -data -dynamic [current_design]

# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP_test_worst.sdc, \
#   line 9
set_operating_conditions -library saed32lvt_ss0p75vn40c -analysis_type \
    on_chip_variation ss0p75vn40c
# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP_test_worst.sdc, \
#   line 833
set_voltage 0 -object_list {VSS}
# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP_test_worst.sdc, \
#   line 834
set_voltage 0.75 -object_list {VDD}
# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP_test_worst.sdc, \
#   line 835
set_voltage 0.95 -object_list {VDDH}
set_scaling_lib_group -all
set_parasitic_parameters -early_spec Cmax.tlup -early_temperature -40 \
    -late_spec Cmax.tlup -late_temperature -40
# MD5_SIGNATURE: 2759FE6BA67D9B09AEC94D2D13743DDF 
