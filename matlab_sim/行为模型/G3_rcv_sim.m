% G3_rcv_sim.m

snr = 40;   %db
dir = 'f:\lhf\hw_proj_17_syn\sim_data\';
tx_data = load([dir,'tx_data_m.txt']).';
p = load([dir,'preamble.txt']).';


payload_num=6; %payload的symbol个数

first_carrier_id=81;%起始子载波编号
last_carrier_id=496;%终止子载波编号

carrier_num=416;%使用的子载波个数
fft_point=1024;% FFT点数
cp_num=458;%循环前缀的点数
ofdm_window_offset=50;%定义ofdm窗口的提前量


% for k=1:frame_length
%     if tx_data(k)>1023
%         tx_data(k)=1023;
%     end
%     if tx_data(k)<-1023
%         tx_data(k)=-1023;
%     end
% end
tx_data(tx_data>1023) = 1023;
tx_data(tx_data<-1023) = -1023;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     tx_data_matlab=[tx_data_matlab tx_data];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%电力线信道%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   [rcv_data,NOISE] = noisegen(tx_data,SNR);
%     if channel_sel==0
%        rcv_data=tx_data;%理想信道
%     else
%       [rcv_data,ht,trms,t_max]=PLC_channel(tx_data,1,noise_ctr,SNR);
%     end

power_sig = mean(tx_data.^2);
power_noise = power_sig/(10^(snr/10));
noise = sqrt(power_noise)*randn(size(tx_data))+dc_offset;
pre_noise = sqrt(power_noise)*randn(1,10000)+dc_offset;

% h = randn(1,128);
h = 1;
tx_data = filter(h,1,tx_data);

alpha = 0.05;
dc_offset = -25;

rcv_data = round(alpha*([pre_noise,tx_data + noise]))+dc_offset;

% high-pass iir %
% dc_reg = 0;
% alpha = 1/16;
% rcv_data_out = zeros(size(rcv_data));
% for i = 1:1:length(rcv_data)
%     rcv_data_out(i) = rcv_data(i) - floor(dc_reg/16);
%     dc_reg = rcv_data(i) + dc_reg * 15; 
% end

rcv_data_out = high_flt(rcv_data);

figure;
plot(rcv_data);
hold on;
plot(rcv_data_out,'r');

rcv_data = rcv_data_out;



rcv_data(rcv_data>1023) = 1023;
rcv_data(rcv_data<-1023) = -1023;


rcv_data_ex=[rcv_data zeros(1,20000)]; %扩展接收数据,防止定位点后移导致数据数组索引超范围

save2file([dir,'rcv_sig_in.txt'],rcv_data_ex);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%接收机代码%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[X1,Z1,c,syn_point,start_point,fft_window,fft_point,fft_data,h]=syn_self(rcv_data,p);
[data_delay,frame_syn,frame_syn_rtl,frame_syn_1,syn_point,start_point,fft_window,fft_point_cnt,fft_data,h,m_rcv_fft,m_rcv]=syn_cox(rcv_data_ex,p,fft_point,payload_num,ofdm_window_offset);
%h1=fft(fft_data,256)./fft(tx_data(syn_point+2207:syn_point+2462),256);
%valid_data_rcv=data_rcv(fft_data,h,payload_num);

frame_id = 1;
syn_point_vec(frame_id)=syn_point;% 同步点滑动范围
start_point_vec(frame_id)=start_point;%起始点滑动范围
[valid_data_rcv,rt_r_vec,rt_j_vec]=data_rcv(fft_data,h,payload_num,m_rcv_fft,fft_point,first_carrier_id,last_carrier_id,cp_num);


%%%%%%%%%%%%误码率统计%%%%%%%%%%%%%%%%%%%%%
fid = fopen('f:\lhf\hw_proj_17_syn\sim_data\din_m.txt');
payload_data = (fread(fid)-'0')';
fclose(fid);

valid_data_tx = repmat(payload_data, 1, payload_num);
save2file([dir,'payload_bits_m.txt'],valid_data_tx);
save2file([dir,'demod_bits_m.txt'],valid_data_rcv);
save2file_binvec2hex([dir,'demod_bits_hex_m.txt'],reshape(valid_data_rcv,[],payload_num).');

err_cnt = 0;
for k=1:carrier_num*payload_num
    if valid_data_rcv(k)~=valid_data_tx(k)
        err_cnt=err_cnt+1;
    end
end
err_rate = err_cnt/(carrier_num*payload_num);
fprintf('err_rate=%.2f\n',err_rate*100);
%     err_total=err_total+err_cnt;
% end
%  err_rate_total=err_total/(carrier_num*payload_num*frame_num)
%%%%%%%%%%%%%%%%%%比较matlab模型与modelsim模型的发送数据%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   tx_data_o = load('e:\design\QUARTUS\plc_design_final.git\tb_tx_data_o.txt');%读取modelsim的仿真数据
%   tx_data_o =tx_data_o';
%   tx_data_compare=tx_data_matlab-tx_data_o;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%比较matlab模型与modelsim模型的复数乘法后的数据


figure;
subplot(4,1,1)
plot(tx_data);
subplot(4,1,2)
plot(data_delay,'r');
subplot(4,1,3)
%plot(Z1);
plot(frame_syn);
subplot(4,1,4)
plot(fft_window);
figure;
plot(valid_data_rcv-valid_data_tx);
figure;
plot(abs(h(first_carrier_id:last_carrier_id)));
figure;
plot(abs(m_rcv_fft));
figure;
subplot(2,1,1)
plot(syn_point_vec);% 同步点的抖动情况
subplot(2,1,2)
plot(start_point_vec);% 起始点的抖动情况
figure;
plot(err_rate);
figure;
plot(rt_r_vec,'r');
hold on
plot(rt_j_vec);
