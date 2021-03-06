# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: new/mesContraintes.xdc

# Block Designs: bd/essai1/essai1.bd
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1 || ORIG_REF_NAME==essai1}]

# IP: bd/essai1/ip/essai1_axi_gpio_0_0/essai1_axi_gpio_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_axi_gpio_0_0 || ORIG_REF_NAME==essai1_axi_gpio_0_0}]

# IP: bd/essai1/ip/essai1_axi_gpio_1_0/essai1_axi_gpio_1_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_axi_gpio_1_0 || ORIG_REF_NAME==essai1_axi_gpio_1_0}]

# IP: bd/essai1/ip/essai1_blk_mem_gen_0_0/essai1_blk_mem_gen_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_blk_mem_gen_0_0 || ORIG_REF_NAME==essai1_blk_mem_gen_0_0}]

# IP: bd/essai1/ip/essai1_axi_interconnect_0_0/essai1_axi_interconnect_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_axi_interconnect_0_0 || ORIG_REF_NAME==essai1_axi_interconnect_0_0}]

# IP: bd/essai1/ip/essai1_xbar_0/essai1_xbar_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_xbar_0 || ORIG_REF_NAME==essai1_xbar_0}]

# IP: bd/essai1/ip/essai1_lmb_bram_if_cntlr_0_0/essai1_lmb_bram_if_cntlr_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_lmb_bram_if_cntlr_0_0 || ORIG_REF_NAME==essai1_lmb_bram_if_cntlr_0_0}]

# IP: bd/essai1/ip/essai1_microblaze_0_0/essai1_microblaze_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_microblaze_0_0 || ORIG_REF_NAME==essai1_microblaze_0_0}]

# IP: bd/essai1/ip/essai1_mdm_0_0/essai1_mdm_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_mdm_0_0 || ORIG_REF_NAME==essai1_mdm_0_0}]

# IP: bd/essai1/ip/essai1_proc_sys_reset_0_0/essai1_proc_sys_reset_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_proc_sys_reset_0_0 || ORIG_REF_NAME==essai1_proc_sys_reset_0_0}]

# IP: bd/essai1/ip/essai1_xlconstant_0_0/essai1_xlconstant_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_xlconstant_0_0 || ORIG_REF_NAME==essai1_xlconstant_0_0}]

# XDC: bd/essai1/ip/essai1_axi_gpio_0_0/essai1_axi_gpio_0_0_board.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==essai1_axi_gpio_0_0 || ORIG_REF_NAME==essai1_axi_gpio_0_0}] {/U0 }]/U0 ]]

# XDC: bd/essai1/ip/essai1_axi_gpio_0_0/essai1_axi_gpio_0_0_ooc.xdc

# XDC: bd/essai1/ip/essai1_axi_gpio_0_0/essai1_axi_gpio_0_0.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==essai1_axi_gpio_0_0 || ORIG_REF_NAME==essai1_axi_gpio_0_0}] {/U0 }]/U0 ]]

# XDC: bd/essai1/ip/essai1_axi_gpio_1_0/essai1_axi_gpio_1_0_board.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==essai1_axi_gpio_1_0 || ORIG_REF_NAME==essai1_axi_gpio_1_0}] {/U0 }]/U0 ]]

# XDC: bd/essai1/ip/essai1_axi_gpio_1_0/essai1_axi_gpio_1_0_ooc.xdc

# XDC: bd/essai1/ip/essai1_axi_gpio_1_0/essai1_axi_gpio_1_0.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==essai1_axi_gpio_1_0 || ORIG_REF_NAME==essai1_axi_gpio_1_0}] {/U0 }]/U0 ]]

# XDC: bd/essai1/ip/essai1_blk_mem_gen_0_0/essai1_blk_mem_gen_0_0_ooc.xdc

# XDC: bd/essai1/ip/essai1_xbar_0/essai1_xbar_0_ooc.xdc

# XDC: bd/essai1/ip/essai1_lmb_bram_if_cntlr_0_0/essai1_lmb_bram_if_cntlr_0_0_ooc.xdc

# XDC: bd/essai1/ip/essai1_microblaze_0_0/essai1_microblaze_0_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==essai1_microblaze_0_0 || ORIG_REF_NAME==essai1_microblaze_0_0}] {/U0 }]/U0 ]]

# XDC: bd/essai1/ip/essai1_microblaze_0_0/essai1_microblaze_0_0_ooc_debug.xdc

# XDC: bd/essai1/ip/essai1_microblaze_0_0/essai1_microblaze_0_0_ooc.xdc

# XDC: bd/essai1/ip/essai1_mdm_0_0/essai1_mdm_0_0.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==essai1_mdm_0_0 || ORIG_REF_NAME==essai1_mdm_0_0}] {/U0 }]/U0 ]]

# XDC: bd/essai1/ip/essai1_mdm_0_0/essai1_mdm_0_0_ooc_trace.xdc

# XDC: bd/essai1/ip/essai1_proc_sys_reset_0_0/essai1_proc_sys_reset_0_0_board.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_proc_sys_reset_0_0 || ORIG_REF_NAME==essai1_proc_sys_reset_0_0}]

# XDC: bd/essai1/ip/essai1_proc_sys_reset_0_0/essai1_proc_sys_reset_0_0.xdc
#dup# set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==essai1_proc_sys_reset_0_0 || ORIG_REF_NAME==essai1_proc_sys_reset_0_0}]

# XDC: bd/essai1/ip/essai1_proc_sys_reset_0_0/essai1_proc_sys_reset_0_0_ooc.xdc

# XDC: bd/essai1/essai1_ooc.xdc
