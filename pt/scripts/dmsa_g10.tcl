# start pt_shell -multi_scenario
# Then source this script
#set topdir /u/$env(USER)/PSU_RTL2GDS
#set topdir [lindex [ regexp -inline "(.*)pt" [pwd] ] 1 ]
set topdir /u/$env(USER)/Documents/ECE510-2023-SPRING/final_prj-team_10

set multi_scenario_working_directory "./ms_session_1"
set multi_scenario_merged_error_log  "merged_errors.log"
# set dmsa = 1 for no reports inside, or dmsa = 2 for reports at each corner
set dmsa 2 
set search_path $topdir/pt/scripts
 set_host_options -name my_opts1 -num_processes 8 mo -submit ssh
start_hosts
report_host_usage
create_scenario -name func_max -specific_data pt_max.tcl -common_variable {top_design dmsa}
create_scenario -name func_min -specific_data pt_min.tcl -common_variable {top_design dmsa}
create_scenario -name test_best -specific_data test_min.tcl -common_variable {top_design dmsa}
create_scenario -name test_worst -specific_data test_max.tcl -common_variable {top_design dmsa}
create_scenario -name func_slowfast -specific_data func_slowfast.tcl -common_variable {top_design dmsa}
create_scenario -name func_fastslow -specific_data func_fastslow.tcl -common_variable {top_design dmsa}
create_scenario -name test_slowfast -specific_data test_slowfast.tcl -common_variable {top_design dmsa}
create_scenario -name test_fastslow -specific_data test_fastslow.tcl -common_variable {top_design dmsa}

# added by group 10
# added by group 10
#create_scenario -name func_worstc -specific_data func_worstc.tcl -common_variable {top_design dmsa} 
#create_scenario -name func_bestc -specific_data func_bestc.tcl -common_variable {top_design dmsa}
create_scenario -name stuck_at_shift -specific_data stuck_at_shift.tcl -common_variable {top_design dmsa}
create_scenario -name stuck_at_cap -specific_data stuck_at_cap.tcl -common_variable {top_design dmsa}
create_scenario -name at_speed_shift -specific_data at_speed_shift.tcl -common_variable {top_design dmsa}
create_scenario -name at_speed_cap -specific_data at_speed_cap.tcl -common_variable {top_design dmsa}

#current_session {func_max func_min test_best test_worst func_slowfast func_fastslow test_slowfast test_fastslow func_worstc func_bestc stuck_at_shift stuck_at_cap at_speed_shift at_speed_cap}
current_session {func_max func_min test_best test_worst func_slowfast func_fastslow test_slowfast test_fastslow stuck_at_shift stuck_at_cap at_speed_shift at_speed_cap}
# added by group 10
report_constraints -all_viol -nosplit > $topdir/pt/reports/${top_design}.constraints.dmsa.rpt
remote_execute { set_input_delay 0 [all_inputs] ; set_output_delay 0 [all_outputs] }
