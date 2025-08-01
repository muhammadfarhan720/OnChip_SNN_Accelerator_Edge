# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 4
create_project -in_memory -part xc7z020clg484-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir E:/advanced_analog_IC_Spring2024/Gauri_design.cache/wt [current_project]
set_property parent.project_path E:/advanced_analog_IC_Spring2024/Gauri_design.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part em.avnet.com:zed:part0:1.4 [current_project]
set_property ip_output_repo e:/advanced_analog_IC_Spring2024/Gauri_design.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib -sv {
  E:/advanced_analog_IC_Spring2024/Gauri_design.srcs/sources_1/imports/imports/new/LSM_OE_STDP.sv
  E:/advanced_analog_IC_Spring2024/Gauri_design.srcs/sources_1/imports/imports/new/OE_layer.sv
  E:/advanced_analog_IC_Spring2024/Gauri_design.srcs/sources_1/imports/imports/new/SRU_EP_EN_IP_IN.v
  E:/advanced_analog_IC_Spring2024/Gauri_design.srcs/sources_1/imports/imports/new/SRU_EP_EN_IP_IN_OE.sv
  E:/advanced_analog_IC_Spring2024/Gauri_design.srcs/sources_1/imports/imports/new/Synaptic_Input_Processor.sv
  E:/advanced_analog_IC_Spring2024/Gauri_design.srcs/sources_1/imports/imports/new/Synaptic_Input_Processor_OE.sv
  E:/advanced_analog_IC_Spring2024/Gauri_design.srcs/sources_1/imports/imports/new/Updated_calcium_concentration.sv
  E:/advanced_analog_IC_Spring2024/Gauri_design.srcs/sources_1/imports/new/new_square_root.v
  E:/advanced_analog_IC_Spring2024/Gauri_design.srcs/sources_1/imports/imports/new/LSM_reservoir.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top LSM_reservoir -part xc7z020clg484-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef LSM_reservoir.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file LSM_reservoir_utilization_synth.rpt -pb LSM_reservoir_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
