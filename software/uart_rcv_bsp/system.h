/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'CPU' in SOPC Builder design 'NIOS2'
 * SOPC Builder design path: D:/design/fpga/hardware_test/tx_rx_design_git/NIOS2.sopcinfo
 *
 * Generated: Tue Aug 08 14:33:00 CST 2017
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x41820
#define ALT_CPU_CPU_FREQ 25000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x13
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x20020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 25000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x13
#define ALT_CPU_NAME "CPU"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0x41000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x41820
#define NIOS2_CPU_FREQ 25000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x13
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x20020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x13
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0x41000


/*
 * DATA_H configuration
 *
 */

#define ALT_MODULE_CLASS_DATA_H altera_avalon_pio
#define DATA_H_BASE 0x42070
#define DATA_H_BIT_CLEARING_EDGE_REGISTER 0
#define DATA_H_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATA_H_CAPTURE 0
#define DATA_H_DATA_WIDTH 4
#define DATA_H_DO_TEST_BENCH_WIRING 0
#define DATA_H_DRIVEN_SIM_VALUE 0x0
#define DATA_H_EDGE_TYPE "NONE"
#define DATA_H_FREQ 25000000u
#define DATA_H_HAS_IN 1
#define DATA_H_HAS_OUT 0
#define DATA_H_HAS_TRI 0
#define DATA_H_IRQ -1
#define DATA_H_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DATA_H_IRQ_TYPE "NONE"
#define DATA_H_NAME "/dev/DATA_H"
#define DATA_H_RESET_VALUE 0x0
#define DATA_H_SPAN 16
#define DATA_H_TYPE "altera_avalon_pio"


/*
 * DATA_L configuration
 *
 */

#define ALT_MODULE_CLASS_DATA_L altera_avalon_pio
#define DATA_L_BASE 0x42060
#define DATA_L_BIT_CLEARING_EDGE_REGISTER 0
#define DATA_L_BIT_MODIFYING_OUTPUT_REGISTER 0
#define DATA_L_CAPTURE 0
#define DATA_L_DATA_WIDTH 32
#define DATA_L_DO_TEST_BENCH_WIRING 0
#define DATA_L_DRIVEN_SIM_VALUE 0x0
#define DATA_L_EDGE_TYPE "NONE"
#define DATA_L_FREQ 25000000u
#define DATA_L_HAS_IN 1
#define DATA_L_HAS_OUT 0
#define DATA_L_HAS_TRI 0
#define DATA_L_IRQ -1
#define DATA_L_IRQ_INTERRUPT_CONTROLLER_ID -1
#define DATA_L_IRQ_TYPE "NONE"
#define DATA_L_NAME "/dev/DATA_L"
#define DATA_L_RESET_VALUE 0x0
#define DATA_L_SPAN 16
#define DATA_L_TYPE "altera_avalon_pio"


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_EPCS_FLASH_CONTROLLER
#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_UART
#define __ALTERA_NIOS2_QSYS


/*
 * RAM configuration
 *
 */

#define ALT_MODULE_CLASS_RAM altera_avalon_onchip_memory2
#define RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_BASE 0x20000
#define RAM_CONTENTS_INFO ""
#define RAM_DUAL_PORT 0
#define RAM_GUI_RAM_BLOCK_TYPE "Automatic"
#define RAM_INIT_CONTENTS_FILE "RAM"
#define RAM_INIT_MEM_CONTENT 1
#define RAM_INSTANCE_ID "NONE"
#define RAM_IRQ -1
#define RAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RAM_NAME "/dev/RAM"
#define RAM_NON_DEFAULT_INIT_FILE_ENABLED 0
#define RAM_RAM_BLOCK_TYPE "Auto"
#define RAM_READ_DURING_WRITE_MODE "DONT_CARE"
#define RAM_SINGLE_CLOCK_OP 0
#define RAM_SIZE_MULTIPLE 1
#define RAM_SIZE_VALUE 81920u
#define RAM_SPAN 81920
#define RAM_TYPE "altera_avalon_onchip_memory2"
#define RAM_WRITABLE 1


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x42088
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x42088
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x42088
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "NIOS2"


/*
 * TX_DATA_H configuration
 *
 */

#define ALT_MODULE_CLASS_TX_DATA_H altera_avalon_pio
#define TX_DATA_H_BASE 0x42030
#define TX_DATA_H_BIT_CLEARING_EDGE_REGISTER 0
#define TX_DATA_H_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TX_DATA_H_CAPTURE 0
#define TX_DATA_H_DATA_WIDTH 4
#define TX_DATA_H_DO_TEST_BENCH_WIRING 0
#define TX_DATA_H_DRIVEN_SIM_VALUE 0x0
#define TX_DATA_H_EDGE_TYPE "NONE"
#define TX_DATA_H_FREQ 25000000u
#define TX_DATA_H_HAS_IN 0
#define TX_DATA_H_HAS_OUT 1
#define TX_DATA_H_HAS_TRI 0
#define TX_DATA_H_IRQ -1
#define TX_DATA_H_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TX_DATA_H_IRQ_TYPE "NONE"
#define TX_DATA_H_NAME "/dev/TX_DATA_H"
#define TX_DATA_H_RESET_VALUE 0x0
#define TX_DATA_H_SPAN 16
#define TX_DATA_H_TYPE "altera_avalon_pio"


/*
 * TX_DATA_L configuration
 *
 */

#define ALT_MODULE_CLASS_TX_DATA_L altera_avalon_pio
#define TX_DATA_L_BASE 0x42040
#define TX_DATA_L_BIT_CLEARING_EDGE_REGISTER 0
#define TX_DATA_L_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TX_DATA_L_CAPTURE 0
#define TX_DATA_L_DATA_WIDTH 32
#define TX_DATA_L_DO_TEST_BENCH_WIRING 0
#define TX_DATA_L_DRIVEN_SIM_VALUE 0x0
#define TX_DATA_L_EDGE_TYPE "NONE"
#define TX_DATA_L_FREQ 25000000u
#define TX_DATA_L_HAS_IN 0
#define TX_DATA_L_HAS_OUT 1
#define TX_DATA_L_HAS_TRI 0
#define TX_DATA_L_IRQ -1
#define TX_DATA_L_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TX_DATA_L_IRQ_TYPE "NONE"
#define TX_DATA_L_NAME "/dev/TX_DATA_L"
#define TX_DATA_L_RESET_VALUE 0x0
#define TX_DATA_L_SPAN 16
#define TX_DATA_L_TYPE "altera_avalon_pio"


/*
 * TX_DATA_VALID configuration
 *
 */

#define ALT_MODULE_CLASS_TX_DATA_VALID altera_avalon_pio
#define TX_DATA_VALID_BASE 0x42020
#define TX_DATA_VALID_BIT_CLEARING_EDGE_REGISTER 0
#define TX_DATA_VALID_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TX_DATA_VALID_CAPTURE 0
#define TX_DATA_VALID_DATA_WIDTH 1
#define TX_DATA_VALID_DO_TEST_BENCH_WIRING 0
#define TX_DATA_VALID_DRIVEN_SIM_VALUE 0x0
#define TX_DATA_VALID_EDGE_TYPE "NONE"
#define TX_DATA_VALID_FREQ 25000000u
#define TX_DATA_VALID_HAS_IN 0
#define TX_DATA_VALID_HAS_OUT 1
#define TX_DATA_VALID_HAS_TRI 0
#define TX_DATA_VALID_IRQ -1
#define TX_DATA_VALID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TX_DATA_VALID_IRQ_TYPE "NONE"
#define TX_DATA_VALID_NAME "/dev/TX_DATA_VALID"
#define TX_DATA_VALID_RESET_VALUE 0x0
#define TX_DATA_VALID_SPAN 16
#define TX_DATA_VALID_TYPE "altera_avalon_pio"


/*
 * epcs_flash_controller_0 configuration
 *
 */

#define ALT_MODULE_CLASS_epcs_flash_controller_0 altera_avalon_epcs_flash_controller
#define EPCS_FLASH_CONTROLLER_0_BASE 0x41000
#define EPCS_FLASH_CONTROLLER_0_IRQ 1
#define EPCS_FLASH_CONTROLLER_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define EPCS_FLASH_CONTROLLER_0_NAME "/dev/epcs_flash_controller_0"
#define EPCS_FLASH_CONTROLLER_0_REGISTER_OFFSET 1024
#define EPCS_FLASH_CONTROLLER_0_SPAN 2048
#define EPCS_FLASH_CONTROLLER_0_TYPE "altera_avalon_epcs_flash_controller"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x42088
#define JTAG_UART_IRQ 0
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * pre_come configuration
 *
 */

#define ALT_MODULE_CLASS_pre_come altera_avalon_pio
#define PRE_COME_BASE 0x42050
#define PRE_COME_BIT_CLEARING_EDGE_REGISTER 0
#define PRE_COME_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PRE_COME_CAPTURE 1
#define PRE_COME_DATA_WIDTH 1
#define PRE_COME_DO_TEST_BENCH_WIRING 0
#define PRE_COME_DRIVEN_SIM_VALUE 0x0
#define PRE_COME_EDGE_TYPE "RISING"
#define PRE_COME_FREQ 25000000u
#define PRE_COME_HAS_IN 1
#define PRE_COME_HAS_OUT 0
#define PRE_COME_HAS_TRI 0
#define PRE_COME_IRQ 2
#define PRE_COME_IRQ_INTERRUPT_CONTROLLER_ID 0
#define PRE_COME_IRQ_TYPE "EDGE"
#define PRE_COME_NAME "/dev/pre_come"
#define PRE_COME_RESET_VALUE 0x0
#define PRE_COME_SPAN 16
#define PRE_COME_TYPE "altera_avalon_pio"


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid_qsys
#define SYSID_BASE 0x42080
#define SYSID_ID 1
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1502173379
#define SYSID_TYPE "altera_avalon_sysid_qsys"


/*
 * uart configuration
 *
 */

#define ALT_MODULE_CLASS_uart altera_avalon_uart
#define UART_BASE 0x42000
#define UART_BAUD 9600
#define UART_DATA_BITS 8
#define UART_FIXED_BAUD 1
#define UART_FREQ 25000000u
#define UART_IRQ 3
#define UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define UART_NAME "/dev/uart"
#define UART_PARITY 'N'
#define UART_SIM_CHAR_STREAM ""
#define UART_SIM_TRUE_BAUD 0
#define UART_SPAN 32
#define UART_STOP_BITS 1
#define UART_SYNC_REG_DEPTH 2
#define UART_TYPE "altera_avalon_uart"
#define UART_USE_CTS_RTS 0
#define UART_USE_EOP_REGISTER 0

#endif /* __SYSTEM_H_ */
