onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_tranceiver/u1/rst
add wave -noupdate /tb_tranceiver/u1/clk
add wave -noupdate /tb_tranceiver/u1/m_s
add wave -noupdate /tb_tranceiver/u1/cpu_rd_ram
add wave -noupdate /tb_tranceiver/u1/plc_channal_data
add wave -noupdate /tb_tranceiver/u1/cpu_tx_triger
add wave -noupdate /tb_tranceiver/u1/cpu_xmt_ram_wr_clk
add wave -noupdate /tb_tranceiver/u1/cpu_xmt_ram_wr_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/cpu_xmt_ram_wr_adr
add wave -noupdate -radix unsigned /tb_tranceiver/u1/cpu_xmt_ram_wr_data
add wave -noupdate /tb_tranceiver/u1/cpu_xmt_ram_rd_clk
add wave -noupdate /tb_tranceiver/u1/cpu_xmt_ram_rd_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/cpu_xmt_ram_rd_adr
add wave -noupdate -radix unsigned /tb_tranceiver/u1/cpu_xmt_ram_rd_data
add wave -noupdate /tb_tranceiver/u1/cpu_rx_ram_rd_clk
add wave -noupdate /tb_tranceiver/u1/cpu_rx_ram_rd_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/cpu_rx_ram_rd_adr
add wave -noupdate -radix hexadecimal /tb_tranceiver/u1/cpu_rx_ram_rd_data
add wave -noupdate /tb_tranceiver/u1/cpu_rx_ram_rd_triger
add wave -noupdate /tb_tranceiver/u1/tx_data_valid
add wave -noupdate /tb_tranceiver/u1/ISL_C1
add wave -noupdate /tb_tranceiver/u1/ISL_C0
add wave -noupdate /tb_tranceiver/u1/tx_en
add wave -noupdate /tb_tranceiver/u1/rx_en
add wave -noupdate /tb_tranceiver/u1/rcv_data_delay
add wave -noupdate /tb_tranceiver/u1/dma_wr_en
add wave -noupdate /tb_tranceiver/u1/tx_data_valid_t
add wave -noupdate /tb_tranceiver/u1/tx_data_o
add wave -noupdate /tb_tranceiver/u1/rx_datain
add wave -noupdate /tb_tranceiver/u1/rcv_en
add wave -noupdate /tb_tranceiver/u1/tx_cnt
add wave -noupdate /tb_tranceiver/u1/rx_cnt
add wave -noupdate /tb_tranceiver/u1/tx_en_t
add wave -noupdate /tb_tranceiver/u1/rx_en_t
add wave -noupdate /tb_tranceiver/u1/cpu_tx_data_t
add wave -noupdate /tb_tranceiver/u1/cpu_rx_data_t
add wave -noupdate /tb_tranceiver/u1/state
add wave -noupdate /tb_tranceiver/u1/next_state
add wave -noupdate /tb_tranceiver/u1/delay_cnt
add wave -noupdate /tb_tranceiver/u1/delay_cnt_en
add wave -noupdate /tb_tranceiver/u1/xmt_ram_rd_clk
add wave -noupdate /tb_tranceiver/u1/xmt_ram_rd_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/xmt_ram_rd_adr
add wave -noupdate -radix unsigned /tb_tranceiver/u1/xmt_ram_rd_data
add wave -noupdate /tb_tranceiver/u1/xmt_ram_wr_clk
add wave -noupdate /tb_tranceiver/u1/xmt_ram_wr_en
add wave -noupdate /tb_tranceiver/u1/xmt_ram_wr_adr
add wave -noupdate /tb_tranceiver/u1/xmt_ram_wr_data
add wave -noupdate /tb_tranceiver/u1/rx_ram_rd_clk
add wave -noupdate /tb_tranceiver/u1/rx_ram_rd_en
add wave -noupdate /tb_tranceiver/u1/rx_ram_rd_adr
add wave -noupdate /tb_tranceiver/u1/rx_ram_rd_data
add wave -noupdate /tb_tranceiver/u1/rx_ram_wr_clk
add wave -noupdate /tb_tranceiver/u1/rx_ram_wr_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/rx_ram_wr_adr
add wave -noupdate -radix hexadecimal /tb_tranceiver/u1/rx_ram_wr_data
add wave -noupdate /tb_tranceiver/u1/ram_rd_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/ram_rd_adr
add wave -noupdate -radix unsigned /tb_tranceiver/u1/ram_rd_data
add wave -noupdate /tb_tranceiver/u1/rx_ram_rd_triger
add wave -noupdate /tb_tranceiver/u1/cpu_rx_data_valid
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_tranceiver/u1/xmt_rcv_ram_inst/rst
add wave -noupdate /tb_tranceiver/u1/xmt_rcv_ram_inst/rd_clk
add wave -noupdate /tb_tranceiver/u1/xmt_rcv_ram_inst/rd_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/xmt_rcv_ram_inst/rd_adr
add wave -noupdate -radix unsigned /tb_tranceiver/u1/xmt_rcv_ram_inst/rd_data
add wave -noupdate /tb_tranceiver/u1/xmt_rcv_ram_inst/wr_clk
add wave -noupdate /tb_tranceiver/u1/xmt_rcv_ram_inst/wr_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/xmt_rcv_ram_inst/wr_adr
add wave -noupdate -radix unsigned /tb_tranceiver/u1/xmt_rcv_ram_inst/wr_data
add wave -noupdate /tb_tranceiver/u1/rx_inst/rx_ram_rd_triger
add wave -noupdate -radix unsigned -childformat {{/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(0) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(1) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(2) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(3) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(4) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(5) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(6) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(7) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(8) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(9) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(10) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(11) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(12) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(13) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(14) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(15) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(16) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(17) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(18) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(19) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(20) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(21) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(22) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(23) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(24) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(25) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(26) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(27) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(28) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(29) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(30) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(31) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(32) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(33) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(34) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(35) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(36) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(37) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(38) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(39) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(40) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(41) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(42) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(43) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(44) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(45) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(46) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(47) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(48) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(49) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(50) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(51) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(52) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(53) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(54) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(55) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(56) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(57) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(58) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(59) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(60) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(61) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(62) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(63) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(64) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(65) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(66) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(67) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(68) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(69) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(70) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(71) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(72) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(73) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(74) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(75) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(76) -radix unsigned} {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(77) -radix unsigned}} -subitemconfig {/tb_tranceiver/u1/xmt_rcv_ram_inst/mem(0) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(1) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(2) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(3) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(4) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(5) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(6) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(7) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(8) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(9) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(10) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(11) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(12) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(13) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(14) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(15) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(16) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(17) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(18) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(19) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(20) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(21) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(22) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(23) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(24) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(25) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(26) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(27) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(28) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(29) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(30) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(31) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(32) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(33) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(34) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(35) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(36) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(37) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(38) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(39) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(40) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(41) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(42) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(43) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(44) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(45) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(46) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(47) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(48) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(49) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(50) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(51) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(52) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(53) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(54) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(55) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(56) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(57) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(58) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(59) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(60) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(61) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(62) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(63) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(64) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(65) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(66) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(67) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(68) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(69) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(70) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(71) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(72) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(73) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(74) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(75) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(76) {-height 15 -radix unsigned} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem(77) {-height 15 -radix unsigned}} /tb_tranceiver/u1/xmt_rcv_ram_inst/mem
add wave -noupdate /tb_tranceiver/u1/xmt_rcv_ram_inst/wr_adr_int
add wave -noupdate /tb_tranceiver/u1/xmt_rcv_ram_inst/rd_adr_int
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_tranceiver/u1/rx_rcv_ram_inst/rst
add wave -noupdate /tb_tranceiver/u1/rx_rcv_ram_inst/rd_clk
add wave -noupdate /tb_tranceiver/u1/rx_rcv_ram_inst/wr_clk
add wave -noupdate /tb_tranceiver/u1/rx_rcv_ram_inst/wr_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/rx_rcv_ram_inst/wr_adr
add wave -noupdate -radix hexadecimal /tb_tranceiver/u1/rx_rcv_ram_inst/wr_data
add wave -noupdate /tb_tranceiver/u1/rx_rcv_ram_inst/rd_en
add wave -noupdate -radix unsigned /tb_tranceiver/u1/rx_rcv_ram_inst/rd_adr
add wave -noupdate -radix unsigned /tb_tranceiver/u1/rx_rcv_ram_inst/rd_data
add wave -noupdate -radix hexadecimal -childformat {{/tb_tranceiver/u1/rx_rcv_ram_inst/mem(0) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(1) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(2) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(3) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(4) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(5) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(6) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(7) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(8) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(9) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(10) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(11) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(12) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(13) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(14) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(15) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(16) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(17) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(18) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(19) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(20) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(21) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(22) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(23) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(24) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(25) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(26) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(27) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(28) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(29) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(30) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(31) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(32) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(33) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(34) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(35) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(36) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(37) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(38) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(39) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(40) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(41) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(42) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(43) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(44) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(45) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(46) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(47) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(48) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(49) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(50) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(51) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(52) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(53) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(54) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(55) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(56) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(57) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(58) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(59) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(60) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(61) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(62) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(63) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(64) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(65) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(66) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(67) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(68) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(69) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(70) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(71) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(72) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(73) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(74) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(75) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(76) -radix hexadecimal} {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(77) -radix hexadecimal}} -subitemconfig {/tb_tranceiver/u1/rx_rcv_ram_inst/mem(0) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(1) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(2) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(3) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(4) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(5) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(6) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(7) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(8) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(9) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(10) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(11) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(12) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(13) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(14) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(15) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(16) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(17) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(18) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(19) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(20) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(21) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(22) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(23) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(24) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(25) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(26) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(27) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(28) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(29) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(30) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(31) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(32) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(33) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(34) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(35) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(36) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(37) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(38) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(39) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(40) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(41) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(42) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(43) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(44) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(45) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(46) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(47) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(48) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(49) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(50) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(51) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(52) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(53) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(54) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(55) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(56) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(57) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(58) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(59) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(60) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(61) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(62) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(63) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(64) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(65) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(66) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(67) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(68) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(69) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(70) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(71) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(72) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(73) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(74) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(75) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(76) {-height 15 -radix hexadecimal} /tb_tranceiver/u1/rx_rcv_ram_inst/mem(77) {-height 15 -radix hexadecimal}} /tb_tranceiver/u1/rx_rcv_ram_inst/mem
add wave -noupdate /tb_tranceiver/u1/rx_rcv_ram_inst/wr_adr_int
add wave -noupdate /tb_tranceiver/u1/rx_rcv_ram_inst/rd_adr_int
add wave -noupdate -divider {New Divider}
add wave -noupdate /tb_tranceiver/u1/rx_inst/clk_20M
add wave -noupdate /tb_tranceiver/u1/rx_inst/rst_rx_syn
add wave -noupdate /tb_tranceiver/u1/rx_inst/rcv_en
add wave -noupdate /tb_tranceiver/u1/rx_inst/rx_data
add wave -noupdate /tb_tranceiver/u1/rx_inst/rx_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/demap_sink_sop
add wave -noupdate /tb_tranceiver/u1/rx_inst/demap_sink_eop
add wave -noupdate /tb_tranceiver/u1/rx_inst/demap_sink_valid
add wave -noupdate /tb_tranceiver/u1/rx_inst/pre_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/rcv_data_valid
add wave -noupdate -radix hexadecimal /tb_tranceiver/u1/rx_inst/demap_dout
add wave -noupdate /tb_tranceiver/u1/rx_inst/rcv_data_delay
add wave -noupdate /tb_tranceiver/u1/rx_inst/dma_wr_en
add wave -noupdate /tb_tranceiver/u1/rx_inst/rx_ram_wr_en
add wave -noupdate /tb_tranceiver/u1/rx_inst/rx_ram_wr_clk
add wave -noupdate -radix unsigned /tb_tranceiver/u1/rx_inst/rx_ram_wr_adr
add wave -noupdate -radix hexadecimal /tb_tranceiver/u1/rx_inst/rx_ram_wr_data
add wave -noupdate /tb_tranceiver/u1/rx_inst/demap_sink_valid_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/tmp7
add wave -noupdate /tb_tranceiver/u1/rx_inst/tmp1
add wave -noupdate /tb_tranceiver/u1/rx_inst/tmp2
add wave -noupdate /tb_tranceiver/u1/rx_inst/tmp3
add wave -noupdate /tb_tranceiver/u1/rx_inst/tmp4
add wave -noupdate /tb_tranceiver/u1/rx_inst/tmp5
add wave -noupdate /tb_tranceiver/u1/rx_inst/tmp6
add wave -noupdate -divider {new divider}
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/rst_n
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/clk
add wave -noupdate -format Analog-Step -height 100 -max 20558800.0 -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/dout1
add wave -noupdate -format Analog-Step -height 100 -max 10134999.999999998 -min -9961810.0 -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/dout2
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/cnt_o
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/fft_data_valid
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/sink_sop
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/sink_eop
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/payload_data_valid
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/reg_flush
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/dma_wr_en
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_fft_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_rcv_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_idle_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_rcv_timeout_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_find_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_find_timeout_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/min_frame_syn
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/state
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/next_state
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/dout1_reg
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/dout2_reg
add wave -noupdate -divider tb_tranceiver
add wave -noupdate /tb_tranceiver/cnt_1
add wave -noupdate /tb_tranceiver/tmp
add wave -noupdate /tb_tranceiver/d_t
add wave -noupdate /tb_tranceiver/rst_n
add wave -noupdate /tb_tranceiver/clk
add wave -noupdate /tb_tranceiver/plc_channal_data
add wave -noupdate /tb_tranceiver/cpu_tx_triger
add wave -noupdate /tb_tranceiver/cpu_tx_triger1
add wave -noupdate /tb_tranceiver/tx_data_valid
add wave -noupdate /tb_tranceiver/ISL_C1
add wave -noupdate /tb_tranceiver/ISL_C0
add wave -noupdate /tb_tranceiver/tx_en
add wave -noupdate /tb_tranceiver/rx_en
add wave -noupdate /tb_tranceiver/rx_ram_rd_triger
add wave -noupdate /tb_tranceiver/rx_data_from_file
add wave -noupdate /tb_tranceiver/rx_data_from_file_int_signal
add wave -noupdate /tb_tranceiver/rx_en_t
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_xmt_ram_wr_data
add wave -noupdate /tb_tranceiver/cpu_xmt_ram_wr_en
add wave -noupdate /tb_tranceiver/cpu_xmt_ram_wr_clk
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_xmt_ram_wr_cnt
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_xmt_ram_wr_adr
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_xmt_ram_rd_data
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_xmt_ram_rd_cnt
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_xmt_ram_rd_adr
add wave -noupdate /tb_tranceiver/cpu_xmt_ram_rd_clk
add wave -noupdate /tb_tranceiver/cpu_xmt_ram_rd_en
add wave -noupdate -radix hexadecimal /tb_tranceiver/cpu_rx_ram_rd_data
add wave -noupdate /tb_tranceiver/cpu_rx_ram_rd_en
add wave -noupdate /tb_tranceiver/cpu_rx_ram_rd_clk
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_rx_ram_rd_adr
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_rx_ram_rd_cnt
add wave -noupdate /tb_tranceiver/m_s
add wave -noupdate /tb_tranceiver/cpu_rd_ram
add wave -noupdate /tb_tranceiver/cpu_rd_en
add wave -noupdate /tb_tranceiver/cpu_wr_en
add wave -noupdate /tb_tranceiver/cpu_rx_ram_rd_triger
add wave -noupdate /tb_tranceiver/state
add wave -noupdate /tb_tranceiver/next_state
add wave -noupdate -divider timer
add wave -noupdate -radix unsigned /tb_tranceiver/u1/timer_cnt
add wave -noupdate -radix unsigned /tb_tranceiver/reg_demap_end_time
add wave -noupdate -radix unsigned /tb_tranceiver/reg_syn_err_time
add wave -noupdate -radix unsigned /tb_tranceiver/reg_syn_start_time
add wave -noupdate -radix unsigned /tb_tranceiver/reg_syn_true_time
add wave -noupdate -radix unsigned /tb_tranceiver/u1/reg_tx_end_time
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1956138148 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 368
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {24150 ns}
