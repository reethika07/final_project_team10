################################################################################
#
# Created by icc2 split_constraints on Wed May 17 12:55:01 2023
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


# Virtual clock prefixes:
#   virtual_:  Instance 'I_CLOCKING' (top mode 'test')

set old_sup ""
redirect -variable old_sup {print_suppressed_messages}
suppress_message UIC-021


#
# Boundary constraints for instance 'I_CLOCKING' (top mode 'test')
#

# Clocks
create_clock -add -name {PCI_CLK} -period 7.50000  \
	-waveform {0.00000 3.75000} [get_ports {pclk_in}]
create_clock -name {v_PCI_CLK} -period 7.50000 -waveform {0.00000 3.75000} 
create_clock -add -name {SYS_2x_CLK/sys_2x_clk_in} -period 2.40000  \
	-waveform {0.00000 1.20000} [get_ports {sys_2x_clk_in}]
group_path -priority -1 -name {SYS_2x_CLK} -to [get_clock  \
	{SYS_2x_CLK/sys_2x_clk_in}]
create_clock -add -name {SYS_2x_CLK/in} -period 2.40000  \
	-waveform {0.00000 1.20000} [get_ports {in}]
group_path -priority -1 -name {SYS_2x_CLK} -to [get_clock {SYS_2x_CLK/in}]
create_clock -name {SYS_2x_CLK} -period 2.40000 -waveform {0.00000 1.20000} 
create_generated_clock -name SYS_CLK -divide_by 2 -source [get_ports {in}]  \
	-add -master_clock {SYS_2x_CLK/in} [get_pins {sys_clk_in_reg/Q}]
create_clock -add -name {SDRAM_CLK} -period 4.10000  \
	-waveform {0.00000 2.05000} [get_ports {sdram_clk_in}]
create_clock -name {v_SDRAM_CLK} -period 4.10000 -waveform {0.00000 2.05000} 
create_clock -name {SD_DDR_CLK} -period 4.10000 -waveform {0.00000 2.05000} 
create_clock -name {SD_DDR_CLKn} -period 4.10000 -waveform {2.05000 4.10000} 
create_clock -add -name {ate_clk/pclk_in} -period 30.00000  \
	-waveform {0.00000 15.00000} [get_ports {pclk_in}]
group_path -priority -1 -name {ate_clk} -to [get_clock {ate_clk/pclk_in}]
create_clock -add -name {ate_clk/sdram_clk_in} -period 30.00000  \
	-waveform {0.00000 15.00000} [get_ports {sdram_clk_in}]
group_path -priority -1 -name {ate_clk} -to [get_clock  \
	{ate_clk/sdram_clk_in}]
create_clock -add -name {ate_clk/sys_2x_clk_in} -period 30.00000  \
	-waveform {0.00000 15.00000} [get_ports {sys_2x_clk_in}]
group_path -priority -1 -name {ate_clk} -to [get_clock  \
	{ate_clk/sys_2x_clk_in}]
create_clock -add -name {ate_clk/ate_clk} -period 30.00000  \
	-waveform {0.00000 15.00000} [get_ports {ate_clk}]
group_path -priority -1 -name {ate_clk} -to [get_clock {ate_clk/ate_clk}]
create_clock -name {ate_clk} -period 30.00000 -waveform {0.00000 15.00000} 

# Virtual clocks

# Virtual clock virtual_ate_clk.top_r based on original clock ate_clk 
create_clock -name {virtual_ate_clk.top_r} -period 30.00000  \
	-waveform {0.00000 15.00000} 
group_path -priority -1 -name {ate_clk} -to [get_clock  \
	{virtual_ate_clk.top_r}]
# Virtual clock virtual_ate_clk.top_f based on original clock ate_clk 
create_clock -name {virtual_ate_clk.top_f} -period 30.00000  \
	-waveform {0.00000 15.00000} 
group_path -priority -1 -name {ate_clk} -to [get_clock  \
	{virtual_ate_clk.top_f}]
# Virtual clock virtual_PCI_CLK.top_r based on original clock PCI_CLK 
create_clock -name {virtual_PCI_CLK.top_r} -period 7.50000  \
	-waveform {0.00000 3.75000} 
group_path -priority -1 -name {PCI_CLK} -to [get_clock  \
	{virtual_PCI_CLK.top_r}]
# Virtual clock virtual_PCI_CLK.top_f based on original clock PCI_CLK 
create_clock -name {virtual_PCI_CLK.top_f} -period 7.50000  \
	-waveform {0.00000 3.75000} 
group_path -priority -1 -name {PCI_CLK} -to [get_clock  \
	{virtual_PCI_CLK.top_f}]
# Virtual clock virtual_SDRAM_CLK.top_r based on original clock SDRAM_CLK 
create_clock -name {virtual_SDRAM_CLK.top_r} -period 4.10000  \
	-waveform {0.00000 2.05000} 
group_path -priority -1 -name {SDRAM_CLK} -to [get_clock  \
	{virtual_SDRAM_CLK.top_r}]
# Virtual clock virtual_SDRAM_CLK.top_f based on original clock SDRAM_CLK 
create_clock -name {virtual_SDRAM_CLK.top_f} -period 4.10000  \
	-waveform {0.00000 2.05000} 
group_path -priority -1 -name {SDRAM_CLK} -to [get_clock  \
	{virtual_SDRAM_CLK.top_f}]
# Virtual clock virtual_SYS_2x_CLK.top_r based on original clock SYS_2x_CLK 
create_clock -name {virtual_SYS_2x_CLK.top_r} -period 2.40000  \
	-waveform {0.00000 1.20000} 
group_path -priority -1 -name {SYS_2x_CLK} -to [get_clock  \
	{virtual_SYS_2x_CLK.top_r}]
# Virtual clock virtual_SYS_2x_CLK.top_f based on original clock SYS_2x_CLK 
create_clock -name {virtual_SYS_2x_CLK.top_f} -period 2.40000  \
	-waveform {0.00000 1.20000} 
group_path -priority -1 -name {SYS_2x_CLK} -to [get_clock  \
	{virtual_SYS_2x_CLK.top_f}]
# Virtual clock virtual_ate_clk_r based on original clock ate_clk 
create_clock -name {virtual_ate_clk_r} -period 30.00000  \
	-waveform {0.00000 15.00000} 
group_path -priority -1 -name {ate_clk} -to [get_clock {virtual_ate_clk_r}]
# Virtual clock virtual__no_clock_ based on original clock <no original clock>
create_clock -name {virtual__no_clock_} -period 1000.00000
set_max_delay 1000.00000 -from {virtual__no_clock_}
set_max_delay 1000.00000 -to {virtual__no_clock_}

# Exceptions outside of the budget area

# Exceptions that straddle the budget boundary

# Exceptions inside of the budget area

# Boundary constants
set_case_analysis 0 [get_ports {shutdown}]
set_case_analysis 1 [get_ports {test_mode}]
set_case_analysis 1 [get_ports {test_se}]
if {[string first UIC-021 $old_sup] == -1} {unsuppress_message UIC-021}


# Other constraints
# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP_test_worst.sdc, \
#   line 829
set_clock_groups -name func_async -asynchronous -group [get_clocks \
    {SYS_2x_CLK/sys_2x_clk_in SYS_2x_CLK/in SYS_CLK}] -group [get_clocks \
    {PCI_CLK v_PCI_CLK}] -group [get_clocks {SDRAM_CLK v_SDRAM_CLK SD_DDR_CLK \
    SD_DDR_CLKn}]
# /home/ramadugu/common/Documents/fresh'/final_prj-team_10-master/constraints/ORCA_TOP_test_worst.sdc, \
#   line 830
set_clock_groups -name my_occ_clock_groups -asynchronous -group [get_clocks \
    {ate_clk/pclk_in ate_clk/sdram_clk_in ate_clk/sys_2x_clk_in \
    ate_clk/ate_clk}] -group [get_clocks {SYS_2x_CLK/sys_2x_clk_in \
    SYS_2x_CLK/in SYS_CLK SDRAM_CLK v_SDRAM_CLK SD_DDR_CLK SD_DDR_CLKn PCI_CLK \
    v_PCI_CLK}]
# MD5_SIGNATURE: 94D48732D3EC29760669630AFD4B6329 
