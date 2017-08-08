#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting SOF File: D:\design\fpga\hardware_test\tx_rx_design_git\output_files\plc_design.sof to: "..\flash/plc_design_epcs_flash_controller_0.flash"
#
sof2flash --input="D:/design/fpga/hardware_test/tx_rx_design_git/output_files/plc_design.sof" --output="../flash/plc_design_epcs_flash_controller_0.flash" --epcs --verbose 

#
# Programming File: "..\flash/plc_design_epcs_flash_controller_0.flash" To Device: epcs_flash_controller_0
#
nios2-flash-programmer "../flash/plc_design_epcs_flash_controller_0.flash" --base=0x41000 --epcs --sidp=0x42080 --id=0x1 --timestamp=1502094451 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program --verbose 

#
# Converting ELF File: D:\design\fpga\hardware_test\tx_rx_design_git\software\uart_rcv\uart_rcv.elf to: "..\flash/uart_rcv_epcs_flash_controller_0.flash"
#
elf2flash --input="D:/design/fpga/hardware_test/tx_rx_design_git/software/uart_rcv/uart_rcv.elf" --output="../flash/uart_rcv_epcs_flash_controller_0.flash" --epcs --after="../flash/plc_design_epcs_flash_controller_0.flash" --verbose 

#
# Programming File: "..\flash/uart_rcv_epcs_flash_controller_0.flash" To Device: epcs_flash_controller_0
#
nios2-flash-programmer "../flash/uart_rcv_epcs_flash_controller_0.flash" --base=0x41000 --epcs --sidp=0x42080 --id=0x1 --timestamp=1502094451 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program --verbose 

