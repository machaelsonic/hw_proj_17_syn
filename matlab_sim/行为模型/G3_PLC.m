clear
clc
SNR=-10;
payload_num=6; %payload��symbol����
m_phase=[10,9,8,7,6,4,2,15,11,7,3,14,9,3,13,6,15,7,15,7,14,5,10,0,5,10,14,2,5,8,10,11,13,14,15,15];
pre_phase=m_phase;%���ɵ�һ��payload symbol�Ĳο���λ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ͻ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
send_data_ifft_r=[];
valid_data_tx=[];
for k1=1:payload_num
  %[load_data,valid_data]=data_gen;
  [load_data,valid_data,pre_phase_next]=data_gen(pre_phase);
  data_gen_ifft_r=real(ifft(load_data,256));
  cp=data_gen_ifft_r(227:256);
  send_data_ifft_r=[send_data_ifft_r cp data_gen_ifft_r];%6��payload���ݣ�ÿ��payload���ݰ���һ��cp��
                                                        %һ��cpΪ30�������㣬��6*286=1716��������
  valid_data_tx=[valid_data_tx valid_data];
  pre_phase=pre_phase_next;%�����¸�payload symbol�Ĳο���λ
end
[pre_data,p]=preamble;%����ǰ�����У�����8��p���ź�2��m���ţ�2560��������
tx_data=[pre_data send_data_ifft_r]; %���͵��������ϵ����ݣ� ��4276��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%�������ŵ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %  rcv_data=tx_data;%�����ŵ�
%   [rcv_data,NOISE] = noisegen(tx_data,SNR);
  [rcv_data,ht,trms,t_max]=PLC_channel(tx_data,1,0,SNR);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ջ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[X1,Z1,c,syn_point,start_point,fft_window,fft_point,fft_data,h]=syn_self(rcv_data,p);
[frame_syn,symbol_syn,syn_point,start_point,fft_window,fft_point,fft_data,h,m_rcv_fft]=syn_cox(rcv_data,p);
%h1=fft(fft_data,256)./fft(tx_data(syn_point+2207:syn_point+2462),256);
%valid_data_rcv=data_rcv(fft_data,h,payload_num);
valid_data_rcv=data_rcv(fft_data,h,payload_num,m_rcv_fft);

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

  



 