onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_receiver/rst
add wave -noupdate /tb_receiver/clk
add wave -noupdate /tb_receiver/rst_delay
add wave -noupdate /tb_receiver/rx_data_from_file
add wave -noupdate /tb_receiver/rx_data_from_file_int_signal
add wave -noupdate /tb_receiver/i1/rst
add wave -noupdate /tb_receiver/i1/clk
add wave -noupdate /tb_receiver/i1/rcv_en
add wave -noupdate -format Analog-Step -height 200 -max 649.0 -min -625.0 -radix decimal /tb_receiver/i1/data_in
add wave -noupdate /tb_receiver/i1/fft_sink_ready
add wave -noupdate /tb_receiver/i1/fft_source_sop
add wave -noupdate /tb_receiver/i1/fft_source_eop
add wave -noupdate /tb_receiver/i1/fft_source_valid
add wave -noupdate /tb_receiver/i1/demap_sink_sop
add wave -noupdate /tb_receiver/i1/demap_sink_eop
add wave -noupdate /tb_receiver/i1/demap_sink_valid
add wave -noupdate /tb_receiver/i1/fft_sop
add wave -noupdate /tb_receiver/i1/fft_eop
add wave -noupdate /tb_receiver/i1/fft_data_valid
add wave -noupdate /tb_receiver/i1/cnt_o
add wave -noupdate /tb_receiver/i1/demap_dout
add wave -noupdate /tb_receiver/i1/fft_source_error
add wave -noupdate /tb_receiver/i1/fft_source_exp
add wave -noupdate /tb_receiver/i1/fft_source_imag
add wave -noupdate /tb_receiver/i1/fft_source_imag_delay
add wave -noupdate /tb_receiver/i1/fft_source_real
add wave -noupdate /tb_receiver/i1/fft_source_real_delay
add wave -noupdate /tb_receiver/i1/rcv_data
add wave -noupdate /tb_receiver/i1/rt_i
add wave -noupdate /tb_receiver/i1/rt_r
add wave -noupdate /tb_receiver/i1/syn_point
add wave -noupdate /tb_receiver/i1/dma_wr_en
add wave -noupdate /tb_receiver/i1/fft_source_imag_t
add wave -noupdate /tb_receiver/i1/fft_source_real_t
add wave -noupdate /tb_receiver/i1/fft_source_sop_t
add wave -noupdate /tb_receiver/i1/fft_source_valid_t
add wave -noupdate /tb_receiver/i1/rcv_data_t
add wave -noupdate /tb_receiver/i1/rcv_data_delay_t
add wave -noupdate /tb_receiver/i1/rst_n
add wave -noupdate /tb_receiver/i1/rt_i_t
add wave -noupdate /tb_receiver/i1/rt_r_t
add wave -noupdate /tb_receiver/i1/fft_source_imag_delay_t
add wave -noupdate /tb_receiver/i1/fft_source_imag_delay_n
add wave -noupdate /tb_receiver/i1/fft_source_real_delay_t
add wave -noupdate /tb_receiver/i1/demap_sink_v
add wave -noupdate /tb_receiver/i1/demap_d
add wave -noupdate /tb_receiver/i1/dout1
add wave -noupdate /tb_receiver/i1/dout2
add wave -noupdate /tb_receiver/i1/symbol_syn
add wave -noupdate /tb_receiver/i1/fft_data_valid_t
add wave -noupdate /tb_receiver/i1/sink_sop_t
add wave -noupdate /tb_receiver/i1/sink_eop_t
add wave -noupdate /tb_receiver/i1/payload_data_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1560000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 319
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {162351 ns}
