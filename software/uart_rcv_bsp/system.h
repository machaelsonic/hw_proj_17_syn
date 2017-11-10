/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'CPU' in SOPC Builder design 'NIOS2'
 * SOPC Builder design path: E:/design/QUARTUS/plc_design_final.git/NIOS2.sopcinfo
 *
 * Generated: Fri Nov 10 16:55:07 CST 2017
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
#define ALT_CPU_BREAK_ADDR 0x21820
#define ALT_CPU_CPU_FREQ 25000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x12
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x10020
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
#define ALT_CPU_INST_ADDR_WIDTH 0x12
#define ALT_CPU_NAME "CPU"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0x21000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x21820
#define NIOS2_CPU_FREQ 25000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x12
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x10020
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
#define NIOS2_INST_ADDR_WIDTH 0x12
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0x21000


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
 * LED_FOR_TEST configuration
 *
 */

#define ALT_MODULE_CLASS_LED_FOR_TEST altera_avalon_pio
#define LED_FOR_TEST_BASE 0x221b0
#define LED_FOR_TEST_BIT_CLEARING_EDGE_REGISTER 0
#define LED_FOR_TEST_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LED_FOR_TEST_CAPTURE 0
#define LED_FOR_TEST_DATA_WIDTH 1
#define LED_FOR_TEST_DO_TEST_BENCH_WIRING 0
#define LED_FOR_TEST_DRIVEN_SIM_VALUE 0x0
#define LED_FOR_TEST_EDGE_TYPE "NONE"
#define LED_FOR_TEST_FREQ 25000000u
#define LED_FOR_TEST_HAS_IN 0
#define LED_FOR_TEST_HAS_OUT 1
#define LED_FOR_TEST_HAS_TRI 0
#define LED_FOR_TEST_IRQ -1
#define LED_FOR_TEST_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LED_FOR_TEST_IRQ_TYPE "NONE"
#define LED_FOR_TEST_NAME "/dev/LED_FOR_TEST"
#define LED_FOR_TEST_RESET_VALUE 0x0
#define LED_FOR_TEST_SPAN 16
#define LED_FOR_TEST_TYPE "altera_avalon_pio"


/*
 * RAM configuration
 *
 */

#define ALT_MODULE_CLASS_RAM altera_avalon_onchip_memory2
#define RAM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define RAM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define RAM_BASE 0x10000
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
#define RAM_SIZE_VALUE 40960u
#define RAM_SPAN 40960
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
#define ALT_STDERR_BASE 0x221f8
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x221f8
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x221f8
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "NIOS2"


/*
 * cpu_9866_recfg configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_9866_recfg altera_avalon_pio
#define CPU_9866_RECFG_BASE 0x22090
#define CPU_9866_RECFG_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_9866_RECFG_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_9866_RECFG_CAPTURE 0
#define CPU_9866_RECFG_DATA_WIDTH 1
#define CPU_9866_RECFG_DO_TEST_BENCH_WIRING 0
#define CPU_9866_RECFG_DRIVEN_SIM_VALUE 0x0
#define CPU_9866_RECFG_EDGE_TYPE "NONE"
#define CPU_9866_RECFG_FREQ 25000000u
#define CPU_9866_RECFG_HAS_IN 0
#define CPU_9866_RECFG_HAS_OUT 1
#define CPU_9866_RECFG_HAS_TRI 0
#define CPU_9866_RECFG_IRQ -1
#define CPU_9866_RECFG_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_9866_RECFG_IRQ_TYPE "NONE"
#define CPU_9866_RECFG_NAME "/dev/cpu_9866_recfg"
#define CPU_9866_RECFG_RESET_VALUE 0x0
#define CPU_9866_RECFG_SPAN 16
#define CPU_9866_RECFG_TYPE "altera_avalon_pio"


/*
 * cpu_rd_end configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_rd_end altera_avalon_pio
#define CPU_RD_END_BASE 0x22020
#define CPU_RD_END_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_RD_END_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_RD_END_CAPTURE 0
#define CPU_RD_END_DATA_WIDTH 1
#define CPU_RD_END_DO_TEST_BENCH_WIRING 0
#define CPU_RD_END_DRIVEN_SIM_VALUE 0x0
#define CPU_RD_END_EDGE_TYPE "NONE"
#define CPU_RD_END_FREQ 25000000u
#define CPU_RD_END_HAS_IN 0
#define CPU_RD_END_HAS_OUT 1
#define CPU_RD_END_HAS_TRI 0
#define CPU_RD_END_IRQ -1
#define CPU_RD_END_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_RD_END_IRQ_TYPE "NONE"
#define CPU_RD_END_NAME "/dev/cpu_rd_end"
#define CPU_RD_END_RESET_VALUE 0x0
#define CPU_RD_END_SPAN 16
#define CPU_RD_END_TYPE "altera_avalon_pio"


/*
 * cpu_rd_ram configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_rd_ram altera_avalon_pio
#define CPU_RD_RAM_BASE 0x22130
#define CPU_RD_RAM_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_RD_RAM_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_RD_RAM_CAPTURE 0
#define CPU_RD_RAM_DATA_WIDTH 1
#define CPU_RD_RAM_DO_TEST_BENCH_WIRING 0
#define CPU_RD_RAM_DRIVEN_SIM_VALUE 0x0
#define CPU_RD_RAM_EDGE_TYPE "NONE"
#define CPU_RD_RAM_FREQ 25000000u
#define CPU_RD_RAM_HAS_IN 0
#define CPU_RD_RAM_HAS_OUT 1
#define CPU_RD_RAM_HAS_TRI 0
#define CPU_RD_RAM_IRQ -1
#define CPU_RD_RAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_RD_RAM_IRQ_TYPE "NONE"
#define CPU_RD_RAM_NAME "/dev/cpu_rd_ram"
#define CPU_RD_RAM_RESET_VALUE 0x0
#define CPU_RD_RAM_SPAN 16
#define CPU_RD_RAM_TYPE "altera_avalon_pio"


/*
 * cpu_rx_ram_rd_adr configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_rx_ram_rd_adr altera_avalon_pio
#define CPU_RX_RAM_RD_ADR_BASE 0x220b0
#define CPU_RX_RAM_RD_ADR_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_RX_RAM_RD_ADR_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_RX_RAM_RD_ADR_CAPTURE 0
#define CPU_RX_RAM_RD_ADR_DATA_WIDTH 7
#define CPU_RX_RAM_RD_ADR_DO_TEST_BENCH_WIRING 0
#define CPU_RX_RAM_RD_ADR_DRIVEN_SIM_VALUE 0x0
#define CPU_RX_RAM_RD_ADR_EDGE_TYPE "NONE"
#define CPU_RX_RAM_RD_ADR_FREQ 25000000u
#define CPU_RX_RAM_RD_ADR_HAS_IN 0
#define CPU_RX_RAM_RD_ADR_HAS_OUT 1
#define CPU_RX_RAM_RD_ADR_HAS_TRI 0
#define CPU_RX_RAM_RD_ADR_IRQ -1
#define CPU_RX_RAM_RD_ADR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_RX_RAM_RD_ADR_IRQ_TYPE "NONE"
#define CPU_RX_RAM_RD_ADR_NAME "/dev/cpu_rx_ram_rd_adr"
#define CPU_RX_RAM_RD_ADR_RESET_VALUE 0x0
#define CPU_RX_RAM_RD_ADR_SPAN 16
#define CPU_RX_RAM_RD_ADR_TYPE "altera_avalon_pio"


/*
 * cpu_rx_ram_rd_clk configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_rx_ram_rd_clk altera_avalon_pio
#define CPU_RX_RAM_RD_CLK_BASE 0x220d0
#define CPU_RX_RAM_RD_CLK_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_RX_RAM_RD_CLK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_RX_RAM_RD_CLK_CAPTURE 0
#define CPU_RX_RAM_RD_CLK_DATA_WIDTH 1
#define CPU_RX_RAM_RD_CLK_DO_TEST_BENCH_WIRING 0
#define CPU_RX_RAM_RD_CLK_DRIVEN_SIM_VALUE 0x0
#define CPU_RX_RAM_RD_CLK_EDGE_TYPE "NONE"
#define CPU_RX_RAM_RD_CLK_FREQ 25000000u
#define CPU_RX_RAM_RD_CLK_HAS_IN 0
#define CPU_RX_RAM_RD_CLK_HAS_OUT 1
#define CPU_RX_RAM_RD_CLK_HAS_TRI 0
#define CPU_RX_RAM_RD_CLK_IRQ -1
#define CPU_RX_RAM_RD_CLK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_RX_RAM_RD_CLK_IRQ_TYPE "NONE"
#define CPU_RX_RAM_RD_CLK_NAME "/dev/cpu_rx_ram_rd_clk"
#define CPU_RX_RAM_RD_CLK_RESET_VALUE 0x0
#define CPU_RX_RAM_RD_CLK_SPAN 16
#define CPU_RX_RAM_RD_CLK_TYPE "altera_avalon_pio"


/*
 * cpu_rx_ram_rd_data configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_rx_ram_rd_data altera_avalon_pio
#define CPU_RX_RAM_RD_DATA_BASE 0x221e0
#define CPU_RX_RAM_RD_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_RX_RAM_RD_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_RX_RAM_RD_DATA_CAPTURE 0
#define CPU_RX_RAM_RD_DATA_DATA_WIDTH 32
#define CPU_RX_RAM_RD_DATA_DO_TEST_BENCH_WIRING 0
#define CPU_RX_RAM_RD_DATA_DRIVEN_SIM_VALUE 0x0
#define CPU_RX_RAM_RD_DATA_EDGE_TYPE "NONE"
#define CPU_RX_RAM_RD_DATA_FREQ 25000000u
#define CPU_RX_RAM_RD_DATA_HAS_IN 1
#define CPU_RX_RAM_RD_DATA_HAS_OUT 0
#define CPU_RX_RAM_RD_DATA_HAS_TRI 0
#define CPU_RX_RAM_RD_DATA_IRQ -1
#define CPU_RX_RAM_RD_DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_RX_RAM_RD_DATA_IRQ_TYPE "NONE"
#define CPU_RX_RAM_RD_DATA_NAME "/dev/cpu_rx_ram_rd_data"
#define CPU_RX_RAM_RD_DATA_RESET_VALUE 0x0
#define CPU_RX_RAM_RD_DATA_SPAN 16
#define CPU_RX_RAM_RD_DATA_TYPE "altera_avalon_pio"


/*
 * cpu_rx_ram_rd_en configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_rx_ram_rd_en altera_avalon_pio
#define CPU_RX_RAM_RD_EN_BASE 0x220c0
#define CPU_RX_RAM_RD_EN_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_RX_RAM_RD_EN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_RX_RAM_RD_EN_CAPTURE 0
#define CPU_RX_RAM_RD_EN_DATA_WIDTH 1
#define CPU_RX_RAM_RD_EN_DO_TEST_BENCH_WIRING 0
#define CPU_RX_RAM_RD_EN_DRIVEN_SIM_VALUE 0x0
#define CPU_RX_RAM_RD_EN_EDGE_TYPE "NONE"
#define CPU_RX_RAM_RD_EN_FREQ 25000000u
#define CPU_RX_RAM_RD_EN_HAS_IN 0
#define CPU_RX_RAM_RD_EN_HAS_OUT 1
#define CPU_RX_RAM_RD_EN_HAS_TRI 0
#define CPU_RX_RAM_RD_EN_IRQ -1
#define CPU_RX_RAM_RD_EN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_RX_RAM_RD_EN_IRQ_TYPE "NONE"
#define CPU_RX_RAM_RD_EN_NAME "/dev/cpu_rx_ram_rd_en"
#define CPU_RX_RAM_RD_EN_RESET_VALUE 0x0
#define CPU_RX_RAM_RD_EN_SPAN 16
#define CPU_RX_RAM_RD_EN_TYPE "altera_avalon_pio"


/*
 * cpu_rx_ram_rd_triger configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_rx_ram_rd_triger altera_avalon_pio
#define CPU_RX_RAM_RD_TRIGER_BASE 0x221d0
#define CPU_RX_RAM_RD_TRIGER_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_RX_RAM_RD_TRIGER_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_RX_RAM_RD_TRIGER_CAPTURE 1
#define CPU_RX_RAM_RD_TRIGER_DATA_WIDTH 1
#define CPU_RX_RAM_RD_TRIGER_DO_TEST_BENCH_WIRING 0
#define CPU_RX_RAM_RD_TRIGER_DRIVEN_SIM_VALUE 0x0
#define CPU_RX_RAM_RD_TRIGER_EDGE_TYPE "RISING"
#define CPU_RX_RAM_RD_TRIGER_FREQ 25000000u
#define CPU_RX_RAM_RD_TRIGER_HAS_IN 1
#define CPU_RX_RAM_RD_TRIGER_HAS_OUT 0
#define CPU_RX_RAM_RD_TRIGER_HAS_TRI 0
#define CPU_RX_RAM_RD_TRIGER_IRQ 2
#define CPU_RX_RAM_RD_TRIGER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define CPU_RX_RAM_RD_TRIGER_IRQ_TYPE "EDGE"
#define CPU_RX_RAM_RD_TRIGER_NAME "/dev/cpu_rx_ram_rd_triger"
#define CPU_RX_RAM_RD_TRIGER_RESET_VALUE 0x0
#define CPU_RX_RAM_RD_TRIGER_SPAN 16
#define CPU_RX_RAM_RD_TRIGER_TYPE "altera_avalon_pio"


/*
 * cpu_tx_triger configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_tx_triger altera_avalon_pio
#define CPU_TX_TRIGER_BASE 0x221c0
#define CPU_TX_TRIGER_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_TX_TRIGER_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_TX_TRIGER_CAPTURE 0
#define CPU_TX_TRIGER_DATA_WIDTH 1
#define CPU_TX_TRIGER_DO_TEST_BENCH_WIRING 0
#define CPU_TX_TRIGER_DRIVEN_SIM_VALUE 0x0
#define CPU_TX_TRIGER_EDGE_TYPE "NONE"
#define CPU_TX_TRIGER_FREQ 25000000u
#define CPU_TX_TRIGER_HAS_IN 0
#define CPU_TX_TRIGER_HAS_OUT 1
#define CPU_TX_TRIGER_HAS_TRI 0
#define CPU_TX_TRIGER_IRQ -1
#define CPU_TX_TRIGER_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_TX_TRIGER_IRQ_TYPE "NONE"
#define CPU_TX_TRIGER_NAME "/dev/cpu_tx_triger"
#define CPU_TX_TRIGER_RESET_VALUE 0x0
#define CPU_TX_TRIGER_SPAN 16
#define CPU_TX_TRIGER_TYPE "altera_avalon_pio"


/*
 * cpu_xmt_ram_rd_adr configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_xmt_ram_rd_adr altera_avalon_pio
#define CPU_XMT_RAM_RD_ADR_BASE 0x220a0
#define CPU_XMT_RAM_RD_ADR_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_XMT_RAM_RD_ADR_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_XMT_RAM_RD_ADR_CAPTURE 0
#define CPU_XMT_RAM_RD_ADR_DATA_WIDTH 7
#define CPU_XMT_RAM_RD_ADR_DO_TEST_BENCH_WIRING 0
#define CPU_XMT_RAM_RD_ADR_DRIVEN_SIM_VALUE 0x0
#define CPU_XMT_RAM_RD_ADR_EDGE_TYPE "NONE"
#define CPU_XMT_RAM_RD_ADR_FREQ 25000000u
#define CPU_XMT_RAM_RD_ADR_HAS_IN 0
#define CPU_XMT_RAM_RD_ADR_HAS_OUT 1
#define CPU_XMT_RAM_RD_ADR_HAS_TRI 0
#define CPU_XMT_RAM_RD_ADR_IRQ -1
#define CPU_XMT_RAM_RD_ADR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_XMT_RAM_RD_ADR_IRQ_TYPE "NONE"
#define CPU_XMT_RAM_RD_ADR_NAME "/dev/cpu_xmt_ram_rd_adr"
#define CPU_XMT_RAM_RD_ADR_RESET_VALUE 0x0
#define CPU_XMT_RAM_RD_ADR_SPAN 16
#define CPU_XMT_RAM_RD_ADR_TYPE "altera_avalon_pio"


/*
 * cpu_xmt_ram_rd_clk configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_xmt_ram_rd_clk altera_avalon_pio
#define CPU_XMT_RAM_RD_CLK_BASE 0x22100
#define CPU_XMT_RAM_RD_CLK_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_XMT_RAM_RD_CLK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_XMT_RAM_RD_CLK_CAPTURE 0
#define CPU_XMT_RAM_RD_CLK_DATA_WIDTH 1
#define CPU_XMT_RAM_RD_CLK_DO_TEST_BENCH_WIRING 0
#define CPU_XMT_RAM_RD_CLK_DRIVEN_SIM_VALUE 0x0
#define CPU_XMT_RAM_RD_CLK_EDGE_TYPE "NONE"
#define CPU_XMT_RAM_RD_CLK_FREQ 25000000u
#define CPU_XMT_RAM_RD_CLK_HAS_IN 0
#define CPU_XMT_RAM_RD_CLK_HAS_OUT 1
#define CPU_XMT_RAM_RD_CLK_HAS_TRI 0
#define CPU_XMT_RAM_RD_CLK_IRQ -1
#define CPU_XMT_RAM_RD_CLK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_XMT_RAM_RD_CLK_IRQ_TYPE "NONE"
#define CPU_XMT_RAM_RD_CLK_NAME "/dev/cpu_xmt_ram_rd_clk"
#define CPU_XMT_RAM_RD_CLK_RESET_VALUE 0x0
#define CPU_XMT_RAM_RD_CLK_SPAN 16
#define CPU_XMT_RAM_RD_CLK_TYPE "altera_avalon_pio"


/*
 * cpu_xmt_ram_rd_data configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_xmt_ram_rd_data altera_avalon_pio
#define CPU_XMT_RAM_RD_DATA_BASE 0x22140
#define CPU_XMT_RAM_RD_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_XMT_RAM_RD_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_XMT_RAM_RD_DATA_CAPTURE 0
#define CPU_XMT_RAM_RD_DATA_DATA_WIDTH 32
#define CPU_XMT_RAM_RD_DATA_DO_TEST_BENCH_WIRING 0
#define CPU_XMT_RAM_RD_DATA_DRIVEN_SIM_VALUE 0x0
#define CPU_XMT_RAM_RD_DATA_EDGE_TYPE "NONE"
#define CPU_XMT_RAM_RD_DATA_FREQ 25000000u
#define CPU_XMT_RAM_RD_DATA_HAS_IN 1
#define CPU_XMT_RAM_RD_DATA_HAS_OUT 0
#define CPU_XMT_RAM_RD_DATA_HAS_TRI 0
#define CPU_XMT_RAM_RD_DATA_IRQ -1
#define CPU_XMT_RAM_RD_DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_XMT_RAM_RD_DATA_IRQ_TYPE "NONE"
#define CPU_XMT_RAM_RD_DATA_NAME "/dev/cpu_xmt_ram_rd_data"
#define CPU_XMT_RAM_RD_DATA_RESET_VALUE 0x0
#define CPU_XMT_RAM_RD_DATA_SPAN 16
#define CPU_XMT_RAM_RD_DATA_TYPE "altera_avalon_pio"


/*
 * cpu_xmt_ram_rd_en configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_xmt_ram_rd_en altera_avalon_pio
#define CPU_XMT_RAM_RD_EN_BASE 0x220f0
#define CPU_XMT_RAM_RD_EN_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_XMT_RAM_RD_EN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_XMT_RAM_RD_EN_CAPTURE 0
#define CPU_XMT_RAM_RD_EN_DATA_WIDTH 1
#define CPU_XMT_RAM_RD_EN_DO_TEST_BENCH_WIRING 0
#define CPU_XMT_RAM_RD_EN_DRIVEN_SIM_VALUE 0x0
#define CPU_XMT_RAM_RD_EN_EDGE_TYPE "NONE"
#define CPU_XMT_RAM_RD_EN_FREQ 25000000u
#define CPU_XMT_RAM_RD_EN_HAS_IN 0
#define CPU_XMT_RAM_RD_EN_HAS_OUT 1
#define CPU_XMT_RAM_RD_EN_HAS_TRI 0
#define CPU_XMT_RAM_RD_EN_IRQ -1
#define CPU_XMT_RAM_RD_EN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_XMT_RAM_RD_EN_IRQ_TYPE "NONE"
#define CPU_XMT_RAM_RD_EN_NAME "/dev/cpu_xmt_ram_rd_en"
#define CPU_XMT_RAM_RD_EN_RESET_VALUE 0x0
#define CPU_XMT_RAM_RD_EN_SPAN 16
#define CPU_XMT_RAM_RD_EN_TYPE "altera_avalon_pio"


/*
 * cpu_xmt_ram_wr_adr configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_xmt_ram_wr_adr altera_avalon_pio
#define CPU_XMT_RAM_WR_ADR_BASE 0x22110
#define CPU_XMT_RAM_WR_ADR_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_XMT_RAM_WR_ADR_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_XMT_RAM_WR_ADR_CAPTURE 0
#define CPU_XMT_RAM_WR_ADR_DATA_WIDTH 7
#define CPU_XMT_RAM_WR_ADR_DO_TEST_BENCH_WIRING 0
#define CPU_XMT_RAM_WR_ADR_DRIVEN_SIM_VALUE 0x0
#define CPU_XMT_RAM_WR_ADR_EDGE_TYPE "NONE"
#define CPU_XMT_RAM_WR_ADR_FREQ 25000000u
#define CPU_XMT_RAM_WR_ADR_HAS_IN 0
#define CPU_XMT_RAM_WR_ADR_HAS_OUT 1
#define CPU_XMT_RAM_WR_ADR_HAS_TRI 0
#define CPU_XMT_RAM_WR_ADR_IRQ -1
#define CPU_XMT_RAM_WR_ADR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_XMT_RAM_WR_ADR_IRQ_TYPE "NONE"
#define CPU_XMT_RAM_WR_ADR_NAME "/dev/cpu_xmt_ram_wr_adr"
#define CPU_XMT_RAM_WR_ADR_RESET_VALUE 0x0
#define CPU_XMT_RAM_WR_ADR_SPAN 16
#define CPU_XMT_RAM_WR_ADR_TYPE "altera_avalon_pio"


/*
 * cpu_xmt_ram_wr_clk configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_xmt_ram_wr_clk altera_avalon_pio
#define CPU_XMT_RAM_WR_CLK_BASE 0x22150
#define CPU_XMT_RAM_WR_CLK_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_XMT_RAM_WR_CLK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_XMT_RAM_WR_CLK_CAPTURE 0
#define CPU_XMT_RAM_WR_CLK_DATA_WIDTH 1
#define CPU_XMT_RAM_WR_CLK_DO_TEST_BENCH_WIRING 0
#define CPU_XMT_RAM_WR_CLK_DRIVEN_SIM_VALUE 0x0
#define CPU_XMT_RAM_WR_CLK_EDGE_TYPE "NONE"
#define CPU_XMT_RAM_WR_CLK_FREQ 25000000u
#define CPU_XMT_RAM_WR_CLK_HAS_IN 0
#define CPU_XMT_RAM_WR_CLK_HAS_OUT 1
#define CPU_XMT_RAM_WR_CLK_HAS_TRI 0
#define CPU_XMT_RAM_WR_CLK_IRQ -1
#define CPU_XMT_RAM_WR_CLK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_XMT_RAM_WR_CLK_IRQ_TYPE "NONE"
#define CPU_XMT_RAM_WR_CLK_NAME "/dev/cpu_xmt_ram_wr_clk"
#define CPU_XMT_RAM_WR_CLK_RESET_VALUE 0x0
#define CPU_XMT_RAM_WR_CLK_SPAN 16
#define CPU_XMT_RAM_WR_CLK_TYPE "altera_avalon_pio"


/*
 * cpu_xmt_ram_wr_data configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_xmt_ram_wr_data altera_avalon_pio
#define CPU_XMT_RAM_WR_DATA_BASE 0x220e0
#define CPU_XMT_RAM_WR_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_XMT_RAM_WR_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_XMT_RAM_WR_DATA_CAPTURE 0
#define CPU_XMT_RAM_WR_DATA_DATA_WIDTH 32
#define CPU_XMT_RAM_WR_DATA_DO_TEST_BENCH_WIRING 0
#define CPU_XMT_RAM_WR_DATA_DRIVEN_SIM_VALUE 0x0
#define CPU_XMT_RAM_WR_DATA_EDGE_TYPE "NONE"
#define CPU_XMT_RAM_WR_DATA_FREQ 25000000u
#define CPU_XMT_RAM_WR_DATA_HAS_IN 0
#define CPU_XMT_RAM_WR_DATA_HAS_OUT 1
#define CPU_XMT_RAM_WR_DATA_HAS_TRI 0
#define CPU_XMT_RAM_WR_DATA_IRQ -1
#define CPU_XMT_RAM_WR_DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_XMT_RAM_WR_DATA_IRQ_TYPE "NONE"
#define CPU_XMT_RAM_WR_DATA_NAME "/dev/cpu_xmt_ram_wr_data"
#define CPU_XMT_RAM_WR_DATA_RESET_VALUE 0x0
#define CPU_XMT_RAM_WR_DATA_SPAN 16
#define CPU_XMT_RAM_WR_DATA_TYPE "altera_avalon_pio"


/*
 * cpu_xmt_ram_wr_en configuration
 *
 */

#define ALT_MODULE_CLASS_cpu_xmt_ram_wr_en altera_avalon_pio
#define CPU_XMT_RAM_WR_EN_BASE 0x22120
#define CPU_XMT_RAM_WR_EN_BIT_CLEARING_EDGE_REGISTER 0
#define CPU_XMT_RAM_WR_EN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define CPU_XMT_RAM_WR_EN_CAPTURE 0
#define CPU_XMT_RAM_WR_EN_DATA_WIDTH 1
#define CPU_XMT_RAM_WR_EN_DO_TEST_BENCH_WIRING 0
#define CPU_XMT_RAM_WR_EN_DRIVEN_SIM_VALUE 0x0
#define CPU_XMT_RAM_WR_EN_EDGE_TYPE "NONE"
#define CPU_XMT_RAM_WR_EN_FREQ 25000000u
#define CPU_XMT_RAM_WR_EN_HAS_IN 0
#define CPU_XMT_RAM_WR_EN_HAS_OUT 1
#define CPU_XMT_RAM_WR_EN_HAS_TRI 0
#define CPU_XMT_RAM_WR_EN_IRQ -1
#define CPU_XMT_RAM_WR_EN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define CPU_XMT_RAM_WR_EN_IRQ_TYPE "NONE"
#define CPU_XMT_RAM_WR_EN_NAME "/dev/cpu_xmt_ram_wr_en"
#define CPU_XMT_RAM_WR_EN_RESET_VALUE 0x0
#define CPU_XMT_RAM_WR_EN_SPAN 16
#define CPU_XMT_RAM_WR_EN_TYPE "altera_avalon_pio"


/*
 * epcs_flash_controller_0 configuration
 *
 */

#define ALT_MODULE_CLASS_epcs_flash_controller_0 altera_avalon_epcs_flash_controller
#define EPCS_FLASH_CONTROLLER_0_BASE 0x21000
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
#define JTAG_UART_BASE 0x221f8
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
 * master_slave configuration
 *
 */

#define ALT_MODULE_CLASS_master_slave altera_avalon_pio
#define MASTER_SLAVE_BASE 0x221a0
#define MASTER_SLAVE_BIT_CLEARING_EDGE_REGISTER 0
#define MASTER_SLAVE_BIT_MODIFYING_OUTPUT_REGISTER 0
#define MASTER_SLAVE_CAPTURE 0
#define MASTER_SLAVE_DATA_WIDTH 1
#define MASTER_SLAVE_DO_TEST_BENCH_WIRING 0
#define MASTER_SLAVE_DRIVEN_SIM_VALUE 0x0
#define MASTER_SLAVE_EDGE_TYPE "NONE"
#define MASTER_SLAVE_FREQ 25000000u
#define MASTER_SLAVE_HAS_IN 0
#define MASTER_SLAVE_HAS_OUT 1
#define MASTER_SLAVE_HAS_TRI 0
#define MASTER_SLAVE_IRQ -1
#define MASTER_SLAVE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define MASTER_SLAVE_IRQ_TYPE "NONE"
#define MASTER_SLAVE_NAME "/dev/master_slave"
#define MASTER_SLAVE_RESET_VALUE 0x0
#define MASTER_SLAVE_SPAN 16
#define MASTER_SLAVE_TYPE "altera_avalon_pio"


/*
 * rcv_ram_data configuration
 *
 */

#define ALT_MODULE_CLASS_rcv_ram_data altera_avalon_pio
#define RCV_RAM_DATA_BASE 0x22180
#define RCV_RAM_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define RCV_RAM_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RCV_RAM_DATA_CAPTURE 0
#define RCV_RAM_DATA_DATA_WIDTH 16
#define RCV_RAM_DATA_DO_TEST_BENCH_WIRING 0
#define RCV_RAM_DATA_DRIVEN_SIM_VALUE 0x0
#define RCV_RAM_DATA_EDGE_TYPE "NONE"
#define RCV_RAM_DATA_FREQ 25000000u
#define RCV_RAM_DATA_HAS_IN 1
#define RCV_RAM_DATA_HAS_OUT 0
#define RCV_RAM_DATA_HAS_TRI 0
#define RCV_RAM_DATA_IRQ -1
#define RCV_RAM_DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RCV_RAM_DATA_IRQ_TYPE "NONE"
#define RCV_RAM_DATA_NAME "/dev/rcv_ram_data"
#define RCV_RAM_DATA_RESET_VALUE 0x0
#define RCV_RAM_DATA_SPAN 16
#define RCV_RAM_DATA_TYPE "altera_avalon_pio"


/*
 * rcv_ram_wr_end configuration
 *
 */

#define ALT_MODULE_CLASS_rcv_ram_wr_end altera_avalon_pio
#define RCV_RAM_WR_END_BASE 0x22190
#define RCV_RAM_WR_END_BIT_CLEARING_EDGE_REGISTER 0
#define RCV_RAM_WR_END_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RCV_RAM_WR_END_CAPTURE 1
#define RCV_RAM_WR_END_DATA_WIDTH 1
#define RCV_RAM_WR_END_DO_TEST_BENCH_WIRING 0
#define RCV_RAM_WR_END_DRIVEN_SIM_VALUE 0x0
#define RCV_RAM_WR_END_EDGE_TYPE "RISING"
#define RCV_RAM_WR_END_FREQ 25000000u
#define RCV_RAM_WR_END_HAS_IN 1
#define RCV_RAM_WR_END_HAS_OUT 0
#define RCV_RAM_WR_END_HAS_TRI 0
#define RCV_RAM_WR_END_IRQ 3
#define RCV_RAM_WR_END_IRQ_INTERRUPT_CONTROLLER_ID 0
#define RCV_RAM_WR_END_IRQ_TYPE "EDGE"
#define RCV_RAM_WR_END_NAME "/dev/rcv_ram_wr_end"
#define RCV_RAM_WR_END_RESET_VALUE 0x0
#define RCV_RAM_WR_END_SPAN 16
#define RCV_RAM_WR_END_TYPE "altera_avalon_pio"


/*
 * rd_adr configuration
 *
 */

#define ALT_MODULE_CLASS_rd_adr altera_avalon_pio
#define RD_ADR_BASE 0x22170
#define RD_ADR_BIT_CLEARING_EDGE_REGISTER 0
#define RD_ADR_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RD_ADR_CAPTURE 0
#define RD_ADR_DATA_WIDTH 10
#define RD_ADR_DO_TEST_BENCH_WIRING 0
#define RD_ADR_DRIVEN_SIM_VALUE 0x0
#define RD_ADR_EDGE_TYPE "NONE"
#define RD_ADR_FREQ 25000000u
#define RD_ADR_HAS_IN 0
#define RD_ADR_HAS_OUT 1
#define RD_ADR_HAS_TRI 0
#define RD_ADR_IRQ -1
#define RD_ADR_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RD_ADR_IRQ_TYPE "NONE"
#define RD_ADR_NAME "/dev/rd_adr"
#define RD_ADR_RESET_VALUE 0x0
#define RD_ADR_SPAN 16
#define RD_ADR_TYPE "altera_avalon_pio"


/*
 * rd_clk configuration
 *
 */

#define ALT_MODULE_CLASS_rd_clk altera_avalon_pio
#define RD_CLK_BASE 0x22160
#define RD_CLK_BIT_CLEARING_EDGE_REGISTER 0
#define RD_CLK_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RD_CLK_CAPTURE 0
#define RD_CLK_DATA_WIDTH 1
#define RD_CLK_DO_TEST_BENCH_WIRING 0
#define RD_CLK_DRIVEN_SIM_VALUE 0x0
#define RD_CLK_EDGE_TYPE "NONE"
#define RD_CLK_FREQ 25000000u
#define RD_CLK_HAS_IN 0
#define RD_CLK_HAS_OUT 1
#define RD_CLK_HAS_TRI 0
#define RD_CLK_IRQ -1
#define RD_CLK_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RD_CLK_IRQ_TYPE "NONE"
#define RD_CLK_NAME "/dev/rd_clk"
#define RD_CLK_RESET_VALUE 0x0
#define RD_CLK_SPAN 16
#define RD_CLK_TYPE "altera_avalon_pio"


/*
 * reg_demap_end_time configuration
 *
 */

#define ALT_MODULE_CLASS_reg_demap_end_time altera_avalon_pio
#define REG_DEMAP_END_TIME_BASE 0x22030
#define REG_DEMAP_END_TIME_BIT_CLEARING_EDGE_REGISTER 0
#define REG_DEMAP_END_TIME_BIT_MODIFYING_OUTPUT_REGISTER 0
#define REG_DEMAP_END_TIME_CAPTURE 0
#define REG_DEMAP_END_TIME_DATA_WIDTH 32
#define REG_DEMAP_END_TIME_DO_TEST_BENCH_WIRING 0
#define REG_DEMAP_END_TIME_DRIVEN_SIM_VALUE 0x0
#define REG_DEMAP_END_TIME_EDGE_TYPE "NONE"
#define REG_DEMAP_END_TIME_FREQ 25000000u
#define REG_DEMAP_END_TIME_HAS_IN 1
#define REG_DEMAP_END_TIME_HAS_OUT 0
#define REG_DEMAP_END_TIME_HAS_TRI 0
#define REG_DEMAP_END_TIME_IRQ -1
#define REG_DEMAP_END_TIME_IRQ_INTERRUPT_CONTROLLER_ID -1
#define REG_DEMAP_END_TIME_IRQ_TYPE "NONE"
#define REG_DEMAP_END_TIME_NAME "/dev/reg_demap_end_time"
#define REG_DEMAP_END_TIME_RESET_VALUE 0x0
#define REG_DEMAP_END_TIME_SPAN 16
#define REG_DEMAP_END_TIME_TYPE "altera_avalon_pio"


/*
 * reg_syn_err_time configuration
 *
 */

#define ALT_MODULE_CLASS_reg_syn_err_time altera_avalon_pio
#define REG_SYN_ERR_TIME_BASE 0x22050
#define REG_SYN_ERR_TIME_BIT_CLEARING_EDGE_REGISTER 0
#define REG_SYN_ERR_TIME_BIT_MODIFYING_OUTPUT_REGISTER 0
#define REG_SYN_ERR_TIME_CAPTURE 0
#define REG_SYN_ERR_TIME_DATA_WIDTH 32
#define REG_SYN_ERR_TIME_DO_TEST_BENCH_WIRING 0
#define REG_SYN_ERR_TIME_DRIVEN_SIM_VALUE 0x0
#define REG_SYN_ERR_TIME_EDGE_TYPE "NONE"
#define REG_SYN_ERR_TIME_FREQ 25000000u
#define REG_SYN_ERR_TIME_HAS_IN 1
#define REG_SYN_ERR_TIME_HAS_OUT 0
#define REG_SYN_ERR_TIME_HAS_TRI 0
#define REG_SYN_ERR_TIME_IRQ -1
#define REG_SYN_ERR_TIME_IRQ_INTERRUPT_CONTROLLER_ID -1
#define REG_SYN_ERR_TIME_IRQ_TYPE "NONE"
#define REG_SYN_ERR_TIME_NAME "/dev/reg_syn_err_time"
#define REG_SYN_ERR_TIME_RESET_VALUE 0x0
#define REG_SYN_ERR_TIME_SPAN 16
#define REG_SYN_ERR_TIME_TYPE "altera_avalon_pio"


/*
 * reg_syn_start_time configuration
 *
 */

#define ALT_MODULE_CLASS_reg_syn_start_time altera_avalon_pio
#define REG_SYN_START_TIME_BASE 0x22060
#define REG_SYN_START_TIME_BIT_CLEARING_EDGE_REGISTER 0
#define REG_SYN_START_TIME_BIT_MODIFYING_OUTPUT_REGISTER 0
#define REG_SYN_START_TIME_CAPTURE 0
#define REG_SYN_START_TIME_DATA_WIDTH 32
#define REG_SYN_START_TIME_DO_TEST_BENCH_WIRING 0
#define REG_SYN_START_TIME_DRIVEN_SIM_VALUE 0x0
#define REG_SYN_START_TIME_EDGE_TYPE "NONE"
#define REG_SYN_START_TIME_FREQ 25000000u
#define REG_SYN_START_TIME_HAS_IN 1
#define REG_SYN_START_TIME_HAS_OUT 0
#define REG_SYN_START_TIME_HAS_TRI 0
#define REG_SYN_START_TIME_IRQ -1
#define REG_SYN_START_TIME_IRQ_INTERRUPT_CONTROLLER_ID -1
#define REG_SYN_START_TIME_IRQ_TYPE "NONE"
#define REG_SYN_START_TIME_NAME "/dev/reg_syn_start_time"
#define REG_SYN_START_TIME_RESET_VALUE 0x0
#define REG_SYN_START_TIME_SPAN 16
#define REG_SYN_START_TIME_TYPE "altera_avalon_pio"


/*
 * reg_syn_true_time configuration
 *
 */

#define ALT_MODULE_CLASS_reg_syn_true_time altera_avalon_pio
#define REG_SYN_TRUE_TIME_BASE 0x22040
#define REG_SYN_TRUE_TIME_BIT_CLEARING_EDGE_REGISTER 0
#define REG_SYN_TRUE_TIME_BIT_MODIFYING_OUTPUT_REGISTER 0
#define REG_SYN_TRUE_TIME_CAPTURE 0
#define REG_SYN_TRUE_TIME_DATA_WIDTH 32
#define REG_SYN_TRUE_TIME_DO_TEST_BENCH_WIRING 0
#define REG_SYN_TRUE_TIME_DRIVEN_SIM_VALUE 0x0
#define REG_SYN_TRUE_TIME_EDGE_TYPE "NONE"
#define REG_SYN_TRUE_TIME_FREQ 25000000u
#define REG_SYN_TRUE_TIME_HAS_IN 1
#define REG_SYN_TRUE_TIME_HAS_OUT 0
#define REG_SYN_TRUE_TIME_HAS_TRI 0
#define REG_SYN_TRUE_TIME_IRQ -1
#define REG_SYN_TRUE_TIME_IRQ_INTERRUPT_CONTROLLER_ID -1
#define REG_SYN_TRUE_TIME_IRQ_TYPE "NONE"
#define REG_SYN_TRUE_TIME_NAME "/dev/reg_syn_true_time"
#define REG_SYN_TRUE_TIME_RESET_VALUE 0x0
#define REG_SYN_TRUE_TIME_SPAN 16
#define REG_SYN_TRUE_TIME_TYPE "altera_avalon_pio"


/*
 * reg_tx_end_time configuration
 *
 */

#define ALT_MODULE_CLASS_reg_tx_end_time altera_avalon_pio
#define REG_TX_END_TIME_BASE 0x22070
#define REG_TX_END_TIME_BIT_CLEARING_EDGE_REGISTER 0
#define REG_TX_END_TIME_BIT_MODIFYING_OUTPUT_REGISTER 0
#define REG_TX_END_TIME_CAPTURE 0
#define REG_TX_END_TIME_DATA_WIDTH 32
#define REG_TX_END_TIME_DO_TEST_BENCH_WIRING 0
#define REG_TX_END_TIME_DRIVEN_SIM_VALUE 0x0
#define REG_TX_END_TIME_EDGE_TYPE "NONE"
#define REG_TX_END_TIME_FREQ 25000000u
#define REG_TX_END_TIME_HAS_IN 1
#define REG_TX_END_TIME_HAS_OUT 0
#define REG_TX_END_TIME_HAS_TRI 0
#define REG_TX_END_TIME_IRQ -1
#define REG_TX_END_TIME_IRQ_INTERRUPT_CONTROLLER_ID -1
#define REG_TX_END_TIME_IRQ_TYPE "NONE"
#define REG_TX_END_TIME_NAME "/dev/reg_tx_end_time"
#define REG_TX_END_TIME_RESET_VALUE 0x0
#define REG_TX_END_TIME_SPAN 16
#define REG_TX_END_TIME_TYPE "altera_avalon_pio"


/*
 * rx_gain configuration
 *
 */

#define ALT_MODULE_CLASS_rx_gain altera_avalon_pio
#define RX_GAIN_BASE 0x22080
#define RX_GAIN_BIT_CLEARING_EDGE_REGISTER 0
#define RX_GAIN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define RX_GAIN_CAPTURE 0
#define RX_GAIN_DATA_WIDTH 6
#define RX_GAIN_DO_TEST_BENCH_WIRING 0
#define RX_GAIN_DRIVEN_SIM_VALUE 0x0
#define RX_GAIN_EDGE_TYPE "NONE"
#define RX_GAIN_FREQ 25000000u
#define RX_GAIN_HAS_IN 0
#define RX_GAIN_HAS_OUT 1
#define RX_GAIN_HAS_TRI 0
#define RX_GAIN_IRQ -1
#define RX_GAIN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define RX_GAIN_IRQ_TYPE "NONE"
#define RX_GAIN_NAME "/dev/rx_gain"
#define RX_GAIN_RESET_VALUE 0x0
#define RX_GAIN_SPAN 16
#define RX_GAIN_TYPE "altera_avalon_pio"


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid_qsys
#define SYSID_BASE 0x221f0
#define SYSID_ID 1
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1510303593
#define SYSID_TYPE "altera_avalon_sysid_qsys"


/*
 * uart configuration
 *
 */

#define ALT_MODULE_CLASS_uart altera_avalon_uart
#define UART_BASE 0x22000
#define UART_BAUD 115200
#define UART_DATA_BITS 8
#define UART_FIXED_BAUD 1
#define UART_FREQ 25000000u
#define UART_IRQ 4
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
