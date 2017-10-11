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
add wave -noupdate /tb_tranceiver/u1/slave_tx_data_valid
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
add wave -noupdate -format Analog-Step -height 100 -max 108785000.0 -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/dout1
add wave -noupdate -format Analog-Step -height 100 -max 54392600.0 -min -54392600.0 -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/dout2
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
add wave -noupdate -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/reg1
add wave -noupdate -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/reg2
add wave -noupdate -radix decimal /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/reg3
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_idle2_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_idle2_timeout_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_idle3_cnt
add wave -noupdate /tb_tranceiver/u1/rx_inst/b2v_inst/b2v_fft_ctr/s_idle3_timeout_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {890200000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 397
configure wave -valuecolwidth 173
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
WaveRestoreZoom {889182048 ps} {891255094 ps}
