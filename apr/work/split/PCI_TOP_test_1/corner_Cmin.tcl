################################################################################
#
# Created by icc2 split_constraints on Wed May 17 12:54:56 2023
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



# set_timing_derate for corner Cmin
set_timing_derate -late 1.05 -cell_delay -clock [current_design]
set_timing_derate -late 1.05 -cell_delay -data [current_design]
set_timing_derate -late 1.05 -net_delay -clock [current_design]
set_timing_derate -late 1.05 -net_delay -data [current_design]
set_timing_derate -late 1.05 -net_delay -clock -dynamic [current_design]
set_timing_derate -late 1.05 -net_delay -data -dynamic [current_design]

# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP.sdc, \
#   line 111
set_operating_conditions -library \
    saed32lvt_ff0p95vn40c.db:saed32lvt_ff0p95vn40c -analysis_type \
    on_chip_variation ff0p95vn40c
# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP_test_best.sdc, \
#   line 824
set_voltage 0 -object_list {VSS}
# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP_test_best.sdc, \
#   line 825
set_voltage 0.95 -object_list {VDD}
# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP_test_best.sdc, \
#   line 826
set_voltage 1.16 -object_list {VDDH}
set_scaling_lib_group -all
set_parasitic_parameters -early_spec Cmin.tlup -early_temperature -40 \
    -late_spec Cmin.tlup -late_temperature -40
# MD5_SIGNATURE: 32720DC09C4BD012E29D1DFBA0AE957B 
