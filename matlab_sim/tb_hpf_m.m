sig = load('E:\design\QUARTUS\plc_design_final.git\tb_tx_data_tranceiver3.txt');
sig = [zeros(20,1);sig];

sig_out = hpf_flt(sig);


save2file('e:\design\QUARTUS\plc_design_final.git\tb_hpf_dout_m.txt',sig_out);