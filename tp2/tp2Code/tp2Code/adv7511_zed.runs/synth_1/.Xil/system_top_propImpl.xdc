set_property SRC_FILE_INFO {cfile:x:/Bureau/A15/INF3995/tp2/tp2Code/tp2Code/adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_ps7_0/system_sys_ps7_0.xdc rfile:../../../adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_ps7_0/system_sys_ps7_0.xdc id:1 order:EARLY scoped_inst:i_system_wrapper/system_i/sys_ps7/inst} [current_design]
set_property SRC_FILE_INFO {cfile:x:/Bureau/A15/INF3995/tp2/tp2Code/tp2Code/adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_audio_clkgen_0/system_sys_audio_clkgen_0.xdc rfile:../../../adv7511_zed.srcs/sources_1/bd/system/ip/system_sys_audio_clkgen_0/system_sys_audio_clkgen_0.xdc id:2 order:EARLY scoped_inst:i_system_wrapper/system_i/sys_audio_clkgen/inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:21 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter clk_fpga_0 0.3
set_property src_info {type:SCOPED_XDC file:1 line:24 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter clk_fpga_1 0.15
set_property src_info {type:SCOPED_XDC file:2 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.05
