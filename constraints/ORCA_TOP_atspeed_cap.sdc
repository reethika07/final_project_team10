set sdc_version 2.0
if { [info exists synopsys_program_name] == 1} {
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
}

create_clock [get_ports pclk]  -name PCI_CLK  -period 7.5  -waveform {0 3.75}
set_clock_uncertainty -setup 0.1  [get_clocks PCI_CLK]
set_clock_uncertainty -hold 0  [get_clocks PCI_CLK]
set_clock_transition -min -fall 0.2 [get_clocks PCI_CLK]
set_clock_transition -min -rise 0.2 [get_clocks PCI_CLK]
set_clock_transition -max -fall 0.2 [get_clocks PCI_CLK]
set_clock_transition -max -rise 0.2 [get_clocks PCI_CLK]
set_clock_latency 0.5 [get_clocks PCI_CLK]

create_clock [get_ports sys_2x_clk]  -name SYS_2x_CLK  -period 2.4  -waveform {0 1.2}
set_clock_uncertainty -setup 0.1  [get_clocks SYS_2x_CLK]
set_clock_uncertainty -hold 0  [get_clocks SYS_2x_CLK]
set_clock_transition -min -fall 0.2 [get_clocks SYS_2x_CLK]
set_clock_transition -min -rise 0.2 [get_clocks SYS_2x_CLK]
set_clock_transition -max -fall 0.2 [get_clocks SYS_2x_CLK]
set_clock_transition -max -rise 0.2 [get_clocks SYS_2x_CLK]
set_clock_latency 0.5 [get_clocks SYS_2x_CLK]

create_clock [get_ports sdram_clk]  -name SDRAM_CLK  -period 4.1  -waveform {0 2.05}
set_clock_uncertainty -setup 0.1  [get_clocks SDRAM_CLK]
set_clock_uncertainty -hold 0  [get_clocks SDRAM_CLK]
set_clock_transition -min -fall 0.2 [get_clocks SDRAM_CLK]
set_clock_transition -min -rise 0.2 [get_clocks SDRAM_CLK]
set_clock_transition -max -fall 0.2 [get_clocks SDRAM_CLK]
set_clock_transition -max -rise 0.2 [get_clocks SDRAM_CLK]
set_clock_latency 0.5 [get_clocks SDRAM_CLK]

# Generated clock
create_generated_clock [get_pins I_CLOCKING/sys_clk_in_reg/Q]  -name SYS_CLK  -source [get_ports sys_2x_clk]  -divide_by 2
set_clock_uncertainty -setup 0.1  [get_clocks SYS_CLK]
set_clock_uncertainty -hold 0  [get_clocks SYS_CLK]
set_clock_transition -min -fall 0.2 [get_clocks SYS_CLK]
set_clock_transition -min -rise 0.2 [get_clocks SYS_CLK]
set_clock_transition -max -fall 0.2 [get_clocks SYS_CLK]
set_clock_transition -max -rise 0.2 [get_clocks SYS_CLK]
set_clock_latency 0.5 [get_clocks SYS_CLK]

# Scan clock
create_clock [get_ports ate_clk]  -period 20  -waveform {0 10}
set_clock_uncertainty -setup 0.1  [get_clocks ate_clk]
set_clock_uncertainty -hold 0  [get_clocks ate_clk]
set_clock_transition -max -rise 0.2 [get_clocks ate_clk]
set_clock_transition -max -fall 0.2 [get_clocks ate_clk]
set_clock_transition -min -rise 0.2 [get_clocks ate_clk]
set_clock_transition -min -fall 0.2 [get_clocks ate_clk]

## Need to check other generated clock

# Virtual clock
create_clock -name v_PCI_CLK  -period 7.5  -waveform {0 3.75}
set_clock_latency 0.5  [get_clocks v_PCI_CLK]
set_clock_uncertainty -setup 0.1  [get_clocks v_PCI_CLK]
set_clock_uncertainty -hold 0  [get_clocks v_PCI_CLK]

create_clock -name v_SDRAM_CLK  -period 4.1  -waveform {0 2.05}
set_clock_latency 0.5  [get_clocks v_SDRAM_CLK]
set_clock_uncertainty -setup 0.1  [get_clocks v_SDRAM_CLK]
set_clock_uncertainty -hold 0  [get_clocks v_SDRAM_CLK]

#adding generated clock on output ports - Need to check!
 #create_generated_clock [get_ports sd_CK] -name SD_DDR_CLK -source [get_ports sdram_clk] -combinational
 #set_clock_uncertainty -setup 0.1  [get_clocks SD_DDR_CLK]
 #set_clock_uncertainty -hold 0  [get_clocks SD_DDR_CLK]
 #set_clock_transition -min -fall 0.2 [get_clocks SD_DDR_CLK]
 #set_clock_transition -min -rise 0.2 [get_clocks SD_DDR_CLK]
 #set_clock_transition -max -fall 0.2 [get_clocks SD_DDR_CLK]
 #set_clock_transition -max -rise 0.2 [get_clocks SD_DDR_CLK]
 #set_clock_latency 0.5 [get_clocks SD_DDR_CLK]
#
 #create_generated_clock [get_ports sd_CKn] -name SD_DDR_CLKn -source [get_ports sdram_clk] -invert -combinational
 #set_clock_uncertainty -setup 0.1  [get_clocks SD_DDR_CLKn]
 #set_clock_uncertainty -hold 0  [get_clocks SD_DDR_CLKn]
 #set_clock_transition -min -fall 0.2 [get_clocks SD_DDR_CLKn]
 #set_clock_transition -min -rise 0.2 [get_clocks SD_DDR_CLKn]
 #set_clock_transition -max -fall 0.2 [get_clocks SD_DDR_CLKn]
 #set_clock_transition -max -rise 0.2 [get_clocks SD_DDR_CLKn]
 #set_clock_latency 0.5 [get_clocks SD_DDR_CLKn]

# set_ideal_network [get_ports {pclk sys_2x_clk sdram_clk}]

#Input delay
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[31]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[30]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[29]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[28]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[27]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[26]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[25]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[24]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[23]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[22]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[21]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[20]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[19]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[18]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[17]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[16]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[15]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[14]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[13]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[12]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[11]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[10]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[9]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[8]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[7]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[6]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[5]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[4]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[3]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[2]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[1]}]
set_input_delay 0.6 -clock v_SDRAM_CLK [get_ports {sd_DQ_in[0]}]

#output delay
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[0]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[1]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[2]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[3]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[4]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[5]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[6]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[7]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[8]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[9]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[10]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[11]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[12]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[13]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[14]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[15]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[16]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[17]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[18]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[19]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[20]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[21]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[22]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[23]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[24]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[25]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[26]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[27]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[28]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[29]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[30]}]
set_output_delay 1.1 -clock v_PCI_CLK [get_ports {pad_out[31]}]
###
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[0]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[1]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[2]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[3]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[4]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[5]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[6]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[7]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[8]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_A[9]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_BWS[0]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_BWS[1]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_CK}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_CKn}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[0]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[1]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[2]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[3]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[4]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[5]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[6]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[7]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[8]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[9]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[10]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[11]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[12]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[13]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[14]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[15]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[16]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[17]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[18]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[19]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[20]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[21]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[22]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[23]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[24]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[25]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[26]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[27]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[28]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[29]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[30]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_en[31]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[0]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[1]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[2]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[3]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[4]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[5]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[6]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[7]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[8]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[9]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[10]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[11]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[12]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[13]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[14]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[15]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[16]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[17]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[18]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[19]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[20]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[21]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[22]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[23]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[24]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[25]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[26]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[27]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[28]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[29]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[30]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_DQ_out[31]}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_LD}]
set_output_delay 1.1 -clock v_SDRAM_CLK [get_ports {sd_RW}]

# input delay for IO ports
set_input_delay 4.0 -clock ate_clk [get_ports scan_enable]
set_input_delay 4.0 -clock ate_clk [get_ports {test_si[5]}]
set_input_delay 4.0 -clock ate_clk [get_ports {test_si[4]}]
set_input_delay 4.0 -clock ate_clk [get_ports {test_si[3]}]
set_input_delay 4.0 -clock ate_clk [get_ports {test_si[2]}]
set_input_delay 4.0 -clock ate_clk [get_ports {test_si[1]}]
set_input_delay 4.0 -clock ate_clk [get_ports {test_si[0]}]
set_input_delay 4.0 -clock ate_clk [get_ports test_mode]
set_input_delay 4.0 -clock ate_clk [get_ports occ_bypass]
set_input_delay 4.0 -clock ate_clk [get_ports occ_reset]

# set_drive
# set_driving_cell
set_driving_cell -lib_cell INVX2_HVT -library saed32hvt_ss0p75vn40c [all_inputs]
set_driving_cell -lib_cell INVX8_HVT -library saed32hvt_ss0p75vn40c [all_inputs]

# set_load 
set_load -pin_load 10 [get_ports -filter "direction==out"]

# Group paths
group_path -name group_pclk -from [get_clocks PCI_CLK] -to [get_clocks PCI_CLK]
group_path -name group_sdram -from [get_clocks SDRAM_CLK] -to [get_clocks SDRAM_CLK]
group_path -name group_sys2x -from [get_clocks SYS_2x_CLK] -to [get_clocks SYS_2x_CLK]
group_path -name group_sys -from [get_clocks SYS_CLK] -to [get_clocks SYS_CLK]
# group_path -name group_ddr -from [get_clocks SD_DDR_CLK] -to [get_clocks SD_DDR_CLK]
 #group_path -name group_ddrn -from [get_clocks SD_DDR_CLKn] -to [get_clocks SD_DDR_CLKn]
# IO
group_path -name INPUTS -from [ get_ports -filter "direction==in&&full_name!~*clk*" ]
group_path -name OUTPUTS -to [ get_ports -filter "direction==out" ]

#Exceptions
set_false_path -from [get_clocks SYS_2x_CLK] -to [get_clocks SDRAM_CLK]
set_false_path -from [get_clocks SDRAM_CLK] -to [get_clocks SYS_2x_CLK]
set_false_path -from [get_clocks SDRAM_CLK] -to [get_clocks SYS_CLK]
set_false_path -from [get_clocks SYS_CLK] -to [get_clocks SDRAM_CLK]

set_case_analysis 1 [get_ports test_mode]
set_case_analysis 0 [get_ports pll_bypass]
set_case_analysis 0 [get_ports scan_enable]
set_case_analysis 0 [get_ports pll_reset]

# To shut off slow clk
set_clock_sense -stop_propagation occ_int2/slow_clk_1_clkgt/u_icg/GCLK
set_clock_sense -stop_propagation occ_int2/slow_clk_2_clkgt/u_icg/GCLK
set_clock_sense -stop_propagation occ_int2/slow_clk_0_clkgt/u_icg/GCLK
set_clock_sense -stop_propagation I_CLOCKING/occ_int1/slow_clk_clkgt/u_icg/GCLK

set_false_path -from [get_ports scan_enable] -to [get_clocks SYS_2x_CLK]
set_false_path -from [get_ports scan_enable] -to [get_clocks SYS_CLK]
set_false_path -from [get_ports scan_enable] -to [get_clocks SDRAM_CLK]
set_false_path -from [get_ports scan_enable] -to [get_clocks PCI_CLK]

set_false_path -from [list [get_ports {test_si[5]}] [get_ports {test_si[4]}] [get_ports {test_si[3]}] [get_ports {test_si[2]}] [get_ports {test_si[1]}] [get_ports {test_si[0]}]]  -to [list [get_clocks SYS_2x_CLK] [get_clocks SYS_CLK] [get_clocks SDRAM_CLK] [get_clocks PCI_CLK]]
set_false_path   -from [get_ports scan_enable]  -to [list [get_clocks SYS_2x_CLK] [get_clocks SYS_CLK] [get_clocks SDRAM_CLK] [get_clocks SD_DDR_CLK] [get_clocks SD_DDR_CLKn] [get_clocks PCI_CLK]]
set_false_path   -from [list [get_ports {test_si[5]}] [get_ports {test_si[4]}] [get_ports {test_si[3]}] [get_ports {test_si[2]}] [get_ports {test_si[1]}] [get_ports {test_si[0]}]]  -to [list [get_clocks SYS_2x_CLK] [get_clocks SYS_CLK] [get_clocks SDRAM_CLK] [get_clocks SD_DDR_CLK] [get_clocks SD_DDR_CLKn] [get_clocks PCI_CLK]]

#Added MCP for div clk
set_multicycle_path -setup 2 -from [get_clocks SYS_CLK] -to [get_clocks SYS_CLK]
set_multicycle_path -hold 1 -from [get_clocks SYS_CLK] -to [get_clocks SYS_CLK]


if { [info exists synopsys_program_name] == 1} {
set_timing_derate -early -net_delay 0.95
set_timing_derate -early -cell_delay 0.95
set_voltage 0  -min 0  -object_list VSS
set_voltage 0.75  -min 0.75  -object_list VDD
set_voltage 0.95  -min 0.95  -object_list VDDH
}

set_clock_groups -asynchronous -name func_async -group [list [get_clocks SYS_2x_CLK] [get_clocks SYS_CLK]] -group [list [get_clocks PCI_CLK] [get_clocks v_PCI_CLK]] -group [list [get_clocks SDRAM_CLK] [get_clocks v_SDRAM_CLK]]
set_clock_groups -asynchronous -name my_occ_clock_groups -group [get_clocks ate_clk] -group [list [get_clocks SYS_2x_CLK] [get_clocks SYS_CLK] [get_clocks SDRAM_CLK] [get_clocks v_SDRAM_CLK] [get_clocks PCI_CLK] [get_clocks v_PCI_CLK]]
