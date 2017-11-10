#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting SOF File: E:\design\QUARTUS\plc_design_final.git\output_files\plc_design.sof to: "..\flash/plc_design_epcs_flash_controller_0.flash"
#
sof2flash --input="E:/design/QUARTUS/plc_design_final.git/output_files/plc_design.sof" --output="../flash/plc_design_epcs_flash_controller_0.flash" --epcs 

#
# Programming File: "..\flash/plc_design_epcs_flash_controller_0.flash" To Device: epcs_flash_controller_0
#
nios2-flash-programmer "../flash/plc_design_epcs_flash_controller_0.flash" --base=0x21000 --epcs --sidp=0x221F0 --id=0x1 --timestamp=1510303593 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program 

#
# Converting ELF File: E:\design\QUARTUS\plc_design_final.git\software\uart_rcv\uart_rcv.elf to: "..\flash/uart_rcv_epcs_flash_controller_0.flash"
#
elf2flash --input="E:/design/QUARTUS/plc_design_final.git/software/uart_rcv/uart_rcv.elf" --output="../flash/uart_rcv_epcs_flash_controller_0.flash" --epcs --after="../flash/plc_design_epcs_flash_controller_0.flash" 

#
# Programming File: "..\flash/uart_rcv_epcs_flash_controller_0.flash" To Device: epcs_flash_controller_0
#
nios2-flash-programmer "../flash/uart_rcv_epcs_flash_controller_0.flash" --base=0x21000 --epcs --sidp=0x221F0 --id=0x1 --timestamp=1510303593 --device=1 --instance=0 '--cable=USB-Blaster on localhost [USB-0]' --program 

