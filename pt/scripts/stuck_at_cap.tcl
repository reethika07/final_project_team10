#set topdir /u/$env(USER)/PSU_RTL2GDS
set topdir [lindex [ regexp -inline "(.*)pt" [pwd] ] 1 ]

#set topdir /u/$env(USER)/Desktop/final_prj-team_10-final
source $topdir/$top_design.design_config.tcl

set corners $fast_corner

source -echo -verbose $topdir/pt/scripts/pt-get-timlibs.tcl

read_verilog $topdir/apr/outputs/${top_design}.route2.vg.gz
#read_verilog ../../apr/outputs/${top_design}.route2.vg
current_design ${top_design}
set link_path {* saed32hvt_ff1p16vn40c.db saed32hvt_ulvl_ff1p16vn40c_i1p16v.db saed32hvt_dlvl_ff1p16vn40c_i1p16v.db saed32lvt_ff1p16vn40c.db saed32lvt_ulvl_ff1p16vn40c_i1p16v.db saed32lvt_dlvl_ff1p16vn40c_i1p16v.db saed32rvt_ff1p16vn40c.db saed32rvt_ulvl_ff1p16vn40c_i1p16v.db saed32rvt_dlvl_ff1p16vn40c_i1p16v.db saed32sram_ff1p16vn40c.db}
set link_path_per_instance [list [list {I_RISC_CORE} {* saed32hvt_ff0p95vn40c.db saed32hvt_dlvl_ff0p95vn40c_i0p95v.db saed32hvt_ulvl_ff0p95vn40c_i0p95v.db saed32lvt_ff0p95vn40c.db saed32lvt_dlvl_ff0p95vn40c_i0p95v.db saed32lvt_ulvl_ff0p95vn40c_i0p95v.db saed32rvt_ff0p95vn40c.db saed32rvt_dlvl_ff0p95vn40c_i0p95v.db saed32rvt_ulvl_ff0p95vn40c_i0p95v.db saed32sram_ff1p16vn40c.db}] ]
link
set_app_var si_enable_analysis true
#read_parasitics -keep_capacitive_coupling $topdir/apr/outputs/${top_design}.route2.$fast_metal.spef.gz
read_parasitics -keep_capacitive_coupling $topdir/apr/outputs/${top_design}.route2.Cmax.spef.gz

set corner_name min_capture
set power_enable_analysis "true"
source -echo -verbose $topdir/constraints/${top_design}.sdc


set report_default_significant_digits 3


set_propagated_clock [ all_clocks ]

# set flat timing derate?
#set_timing_derate -early 0.95
#set_timing_derate -late 1.05
set timing_remove_clock_reconvergence_pessimism true
set timing_crpr_threshold_ps 1

set_false_path -setup -from [get_clock * ]
set_false_path -setup -to [get_clock * ]

update_timing -full
#

if { ![info exists dmsa ] || ( $dmsa == 2 ) } {
    report_qor > $topdir/pt/reports/${top_design}.qor.$corner_name.rpt
    report_constraints -all_viol > $topdir/pt/reports/${top_design}.constraints.$corner_name.rpt
    report_timing -delay min -input -tran -cross -sig 4 -derate -net -cap  -path full_clock_expanded -max_path 10000 -slack_less 0 > $topdir/pt/reports/${top_design}.timing.full_clock.$corner_name.rpt
    report_timing -delay min -input -tran -cross -sig 4 -derate -net -cap  -max_path 10000 -slack_less 0 > $topdir/pt/reports/${top_design}.timing.$corner_name.rpt
    check_timing -verbose > $topdir/pt/reports/${top_design}.check_timing.$corner_name.rpt
    check_noise -verbose > $topdir/pt/reports/${top_design}.check_noise.$corner_name.rpt
    report_analysis_coverage > $topdir/pt/reports/${top_design}.coverage.$corner_name.rpt
    report_annotated_parasitics > $topdir/pt/reports/${top_design}.parasitics.$corner_name.rpt
}
