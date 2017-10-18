onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_tranceiver/cnt_1
add wave -noupdate -radix unsigned /tb_tranceiver/tmp
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_tx_data
add wave -noupdate -radix unsigned /tb_tranceiver/cpu_rx_data
add wave -noupdate /tb_tranceiver/d_t
add wave -noupdate /tb_tranceiver/rst_n
add wave -noupdate /tb_tranceiver/clk
add wave -noupdate -radix decimal /tb_tranceiver/plc_channal_data
add wave -noupdate /tb_tranceiver/cpu_tx_data_valid
add wave -noupdate /tb_tranceiver/tx_data_valid
add wave -noupdate /tb_tranceiver/ISL_C1
add wave -noupdate /tb_tranceiver/ISL_C0
add wave -noupdate /tb_tranceiver/tx_en
add wave -noupdate /tb_tranceiver/rx_en
add wave -noupdate /tb_tranceiver/u1/m_s
add wave -noupdate /tb_tranceiver/u1/state
add wave -noupdate /tb_tranceiver/u1/delay_cnt
add wave -noupdate /tb_tranceiver/u1/delay_cnt_en
add wave -noupdate /tb_tranceiver/cpu_rx_data_valid
add wave -noupdate -radix decimal /tb_tranceiver/rx_data_from_file
add wave -noupdate -radix decimal /tb_tranceiver/rx_data_from_file_int_signal
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/rst
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/clk
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/rcv_en
add wave -noupdate -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/data_in
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_sink_ready
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_sop
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_eop
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_valid
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/demap_sink_sop
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/demap_sink_eop
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/demap_sink_valid
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_sop
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_eop
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_data_valid
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/cnt_o
add wave -noupdate -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/demap_dout
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_error
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_exp
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_imag
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_imag_delay
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_real
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_real_delay
add wave -noupdate -format Analog-Step -height 100 -max 623.99999999999989 -min -640.0 -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/rcv_data
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/rt_i
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/rt_r
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_imag_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_real_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_sop_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_valid_t
add wave -noupdate -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/rcv_data_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/rcv_data_delay_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/rst_n
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/rt_i_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/rt_r_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_imag_delay_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_imag_delay_n
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_source_real_delay_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/demap_sink_v
add wave -noupdate -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/demap_d
add wave -noupdate -format Analog-Step -height 100 -max 108785000.0 -radix decimal -childformat {{/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(31) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(30) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(29) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(28) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(27) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(26) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(25) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(24) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(23) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(22) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(21) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(20) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(19) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(18) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(17) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(16) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(15) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(14) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(13) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(12) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(11) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(10) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(9) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(8) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(7) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(6) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(5) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(4) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(3) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(2) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(1) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(0) -radix decimal}} -subitemconfig {/tb_tranceiver/u1/rx_inst/b2v_inst/dout1(31) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(30) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(29) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(28) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(27) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(26) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(25) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(24) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(23) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(22) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(21) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(20) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(19) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(18) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(17) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(16) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(15) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(14) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(13) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(12) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(11) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(10) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(9) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(8) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(7) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(6) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(5) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(4) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(3) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(2) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(1) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1(0) {-height 15 -radix decimal}} /tb_tranceiver/u1/rx_inst/b2v_inst/dout1
add wave -noupdate -format Analog-Step -height 100 -max 54392600.0 -min -54392600.0 -radix decimal -childformat {{/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(31) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(30) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(29) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(28) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(27) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(26) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(25) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(24) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(23) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(22) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(21) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(20) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(19) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(18) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(17) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(16) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(15) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(14) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(13) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(12) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(11) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(10) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(9) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(8) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(7) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(6) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(5) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(4) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(3) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(2) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(1) -radix decimal} {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(0) -radix decimal}} -subitemconfig {/tb_tranceiver/u1/rx_inst/b2v_inst/dout2(31) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(30) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(29) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(28) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(27) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(26) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(25) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(24) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(23) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(22) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(21) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(20) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(19) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(18) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(17) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(16) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(15) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(14) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(13) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(12) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(11) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(10) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(9) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(8) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(7) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(6) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(5) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(4) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(3) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(2) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(1) {-height 15 -radix decimal} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2(0) {-height 15 -radix decimal}} /tb_tranceiver/u1/rx_inst/b2v_inst/dout2
add wave -noupdate -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/dout1_reg
add wave -noupdate -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/dout2_reg
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/reg_flush
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/fft_data_valid_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/sink_sop_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/sink_eop_t
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/payload_data_valid
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_rcv_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_rcv_timeout_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_find_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_find_timeout_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_fft_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {334320000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 397
configure wave -valuecolwidth 58
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
WaveRestoreZoom {0 ps} {746046 ns}
