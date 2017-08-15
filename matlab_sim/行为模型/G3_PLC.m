clear
clc
SNR=-3;
payload_num=6; %payload的symbol个数

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%发送机代码%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
send_data_ifft_r=[];
valid_data_tx=[];
for k1=1:payload_num
  [load_data,valid_data]=data_gen;
  data_gen_ifft_r=real(ifft(load_data,256));
  cp=data_gen_ifft_r(227:256);
  send_data_ifft_r=[send_data_ifft_r cp data_gen_ifft_r];%6个payload数据，每个payload数据包含一个cp，
                                                        %一个cp为30个采样点，共6*286=1716个采样点
  valid_data_tx=[valid_data_tx valid_data];
end
[pre_data,p]=preamble;%生成前导序列，包含8个p符号和2个m符号，2560个采样点
tx_data=[pre_data send_data_ifft_r]; %发送到电力线上的数据， 共4276个采样点
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%电力线信道%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %    rcv_data=tx_data;%理想信道
%   [rcv_data,NOISE] = noisegen(tx_data,SNR);
  [rcv_data,ht,trms,t_max]=PLC_channel(tx_data,1,0,SNR);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%接收机代码%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[X1,Z1,c,syn_point,start_point,fft_window,fft_point,fft_data,h]=syn_self(rcv_data,p);
[frame_syn,symbol_syn,syn_point,start_point,fft_window,fft_point,fft_data,h]=syn_cox(rcv_data,p);
%h1=fft(fft_data,256)./fft(tx_data(syn_point+2207:syn_point+2462),256);
valid_data_rcv=data_rcv(fft_data,h,payload_num);


figure(1);
subplot(4,1,1)
plot(tx_data);
subplot(4,1,2)
%plot(Z1);
plot(frame_syn);
subplot(4,1,3)
%plot(c);
plot(symbol_syn);
subplot(4,1,4)
plot(fft_window);
figure(2)
plot(valid_data_rcv-valid_data_tx);
figure(3)
plot(abs(h(34:69)));
% figure(4)
% plot(h1,'r');

  



 