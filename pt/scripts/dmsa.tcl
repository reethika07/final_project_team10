# start pt_shell -multi_scenario
# Then source this script
#set topdir /u/$env(USER)/PSU_RTL2GDS
set topdir [lindex [ regexp -inline "(.*)pt" [pwd] ] 1 ]

#set multi_scenario_working_directory "./ms_session_1"
#set multi_scenario_merged_error_log  "merged_errors.log"
# set dmsa = 1 for no reports inside, or dmsa = 2 for reports at each corner
set dmsa 2 
set search_path "/home/reethika/Documents/ECE510-2023-SPRING/final_prj-team_10/"
 set_host_options -name my_opts1 -num_processes 14 mo -submit ssh
start_hosts
report_host_usage
#puts "executed till now"
create_scenario -name func_max -specific_data ../scripts/pt_max.tcl -common_variable {top_design dmsa}
create_scenario -name func_min -specific_data ../scripts/pt_min.tcl -common_variable {top_design dmsa}
create_scenario -name test_best -specific_data ../scripts/test_min.tcl -common_variable {top_design dmsa}
create_scenario -name test_worst -specific_data ../scripts/test_max.tcl -common_variable {top_design dmsa}
create_scenario -name func_slowfast -specific_data ../scripts/func_slowfast.tcl -common_variable {top_design dmsa}
create_scenario -name func_fastslow -specific_data ../scripts/func_fastslow.tcl -common_variable {top_design dmsa}
create_scenario -name test_slowfast -specific_data ../scripts/test_slowfast.tcl -common_variable {top_design dmsa}
create_scenario -name test_fastslow -specific_data ../scripts/test_fastslow.tcl -common_variable {top_design dmsa}
create_scenario -name func_worstc -specific_data ../scripts/func_worstc.tcl -common_variable {top_design dmsa} 
create_scenario -name func_bestc -specific_data ../scripts/func_bestc.tcl -common_variable {top_design dmsa}
create_scenario -name stuck_at_shift -specific_data ../scripts/stuck_at_shift.tcl -common_variable {top_design dmsa}
create_scenario -name stuck_at_capture -specific_data ../scripts/stuck_at_capture.tcl -common_variable {top_design dmsa}
create_scenario -name at_speed_shift -specific_data ../scripts/at_speed_shift.tcl -common_variable {top_design dmsa}
create_scenario -name at_speed_capture -specific_data ../scripts/at_speed_capture.tcl -common_variable {top_design dmsa}
current_session {func_max func_min test_best test_worst func_slowfast func_fastslow test_slowfast test_fastslow func_worstc func_bestc stuck_at_shift stuck_at_capture at_speed_shift at_speed_capture}
#report_constraints -all_viol -nosplit > $topdir/pt/reports/${top_design}.constraints.dmsa.rpt
#remote_execute {  }

