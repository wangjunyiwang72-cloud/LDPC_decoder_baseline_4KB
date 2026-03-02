###########################################################
remove_design -all
###########################################################
### 1. set std cell lib
###########################################################

set target_library "/home21/longyang/common/share/tsmc22/tcbn22ullbwp30p140_110b/tcbn22ullbwp30p140_110b/AN61001_20201222/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn22ullbwp30p140_110b/tcbn22ullbwp30p140tt0p9v25c.db"
set link_library "* /home21/longyang/common/share/tsmc22/tcbn22ullbwp30p140_110b/tcbn22ullbwp30p140_110b/AN61001_20201222/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tcbn22ullbwp30p140_110b/tcbn22ullbwp30p140tt0p9v25c.db"
###########################################################
### 2. analyze RTL files e.g., verilog, vhdl, sverilog
########################################################### 
set TOP Baseline_4KB
#read_file -format verilog vn6.v
analyze -format verilog -vcs "-f /data1/linhome/wangjunyi/Desktop/LDPC_decoder_baseline_4KB/rtl/file.list"
elaborate -architecture verilog Baseline_4KB
current_design Baseline_4KB
link
uniquify
check_design
check_timing

###########################################################
### 3. set design constraints
########################################################### 
create_clock "sys_clk" -period 10
set delay 1
set port_load 0.005
set FO4 0.05
set uncertainty 0.12
set input_slew [expr 2*$FO4]
set_max_delay $delay -from [all_inputs] -to [all_outputs]
set_input_transition $input_slew  [all_inputs]
set_max_transition 0.5 [all_outputs]
set_load $port_load [all_outputs]
set_fix_multiple_port_nets -all -exclude_clock_network -buffer_constants [get_designs *]
###########################################################
### 4. compile design
########################################################### 

compile
#compile_ultra -no_autoungroup
# compile_ultra -no_autoungroup -incremental
report_timing
report_constraint -all
report_timing -delay_type max
report_area
report_area -hierarchical
report_power

#part5 is a choice
###########################################################
### 5. write out files
########################################################### 
#remove_unconnected_ports -blast_buses [get_cells "*" -hier]
#change_name -hierarchy -rules verilog
write -format verilog -hierarchy -output /data1/linhome/wangjunyi/Desktop/LDPC_decoder_baseline_4KB/netlist/1_netlist.v
write_sdf /data1/linhome/wangjunyi/Desktop/LDPC_decoder_baseline_4KB/netlist/1.sdf
write_sdc /data1/linhome/wangjunyi/Desktop/LDPC_decoder_baseline_4KB/netlist/1.sdc
write -hierarchy /data1/linhome/wangjunyi/Desktop/LDPC_decoder_baseline_4KB/netlist/1.ddc

#file mkdir ../report/${target}
#file mkdir ../report/${target}/${delay}ns
set REPORT_PATH /data1/linhome/wangjunyi/Desktop/LDPC_decoder_baseline_4KB/report
redirect -tee -file ${REPORT_PATH}/check_design.log {check_design };
redirect -tee -file ${REPORT_PATH}/check_timing.log {check_timing };
redirect -tee -file ${REPORT_PATH}/report_constraint.log {report_constraint -all_violators};
redirect -tee -file ${REPORT_PATH}/check_setup.log {report_timing -delay_type max };
redirect -tee -file ${REPORT_PATH}/check_hold.log {report_timing -delay_type min };
redirect -tee -file ${REPORT_PATH}/report_area.log {report_area };
redirect -tee -file ${REPORT_PATH}/report_power.log {report_power };
redirect -tee -file ${REPORT_PATH}/report_area_hier.log {report_area -hier -nosplit};
###########################################################
### 6. use dc.tcl
########################################################### 
#dc_shell -f dc_wjy.tcl
