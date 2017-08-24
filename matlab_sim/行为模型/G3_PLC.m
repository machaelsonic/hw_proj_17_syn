clear
clc
SNR=10;% 信噪比 
noise_ctr=1;  % noise_ctr=0代表无噪声,noise_ctr=1,代表有噪声;
payload_num=6; %payload的symbol个数
m_phase=[10,9,8,7,6,4,2,15,11,7,3,14,9,3,13,6,15,7,15,7,14,5,10,0,5,10,14,2,5,8,10,11,13,14,15,15]; %m序列相位
frame_num=10;%发送帧个数
err_cnt=zeros(1,frame_num);%帧误码计数
err_total=0; %总误码计数

for frame_id=1:frame_num
    
    pre_phase=m_phase;%生成第一个payload symbol的参考相位
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%发送机代码%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    send_data_ifft_r=[];
    valid_data_tx=[];
    send_data_ifft_r_rtl=[];
    for k1=1:payload_num
        %[load_data,valid_data]=data_gen;
        [load_data,valid_data,pre_phase_next]=data_gen(pre_phase);
        
        %%%%%%%%%%%理论FFT模型%%%%%%%%%%%%%%%%%%%%%%%%%%%
        data_gen_ifft_r=round(real(ifft(load_data,256)));
        cp=data_gen_ifft_r(227:256);
        send_data_ifft_r=[send_data_ifft_r cp data_gen_ifft_r];%6个payload数据，每个payload数据包含一个cp，
        %一个cp为30个采样点，共6*286=1716个采样点
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%RTL模型(使用FFT IP 核模型)
        [data_gen_ifft_rtl, exp_out] = fft_ip_model(load_data,256,1) ;
        data_gen_ifft_r_rtl=real(data_gen_ifft_rtl);
        cp_rtl=data_gen_ifft_r_rtl(227:256);
        send_data_ifft_r_rtl=[send_data_ifft_r_rtl cp_rtl data_gen_ifft_r_rtl];
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
         
        
        valid_data_tx=[valid_data_tx valid_data];
        pre_phase=pre_phase_next;%生成下个payload symbol的参考相位
    end
    %%%%%%%%%%%%%%理论模型与RTL模型的量化误差%%%%%%%%%%%%%%%%%%%%%%%%%%
      quan_err=send_data_ifft_r_rtl-send_data_ifft_r*2^(8+exp_out(1));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [pre_data,p]=preamble;%生成前导序列，包含8个p符号和2个m符号，2560个采样点
    tx_data=[pre_data*4 send_data_ifft_r_rtl]; %发送到电力线上的数据， 共4276个采样点,对前导序列放大4倍,实际设计过程中可根据具体数值进行调整
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%电力线信道%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %    rcv_data=tx_data;%理想信道
    %   [rcv_data,NOISE] = noisegen(tx_data,SNR);
    [rcv_data,ht,trms,t_max]=PLC_channel(tx_data,1,noise_ctr,SNR);
    rcv_data_ex=[rcv_data zeros(1,400)]; %扩展接收数据,防止定位点后移导致数据数组索引超范围
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%接收机代码%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %[X1,Z1,c,syn_point,start_point,fft_window,fft_point,fft_data,h]=syn_self(rcv_data,p);
    [frame_syn,symbol_syn,syn_point,start_point,fft_window,fft_point,fft_data,h,m_rcv_fft]=syn_cox(rcv_data_ex,p);
    %h1=fft(fft_data,256)./fft(tx_data(syn_point+2207:syn_point+2462),256);
    %valid_data_rcv=data_rcv(fft_data,h,payload_num);
    syn_point_vec(frame_id)=syn_point;% 同步点滑动范围
    valid_data_rcv=data_rcv(fft_data,h,payload_num,m_rcv_fft);
    %%%%%%%%%%%%误码率统计%%%%%%%%%%%%%%%%%%%%%
    for k=1:36*payload_num
        if valid_data_rcv(k)~=valid_data_tx(k)
            err_cnt(1,frame_id)=err_cnt(1,frame_id)+1;
        end
    end
    err_rate(1,frame_id)=err_cnt(1,frame_id)/(36*payload_num);
    err_total=err_total+err_cnt(1,frame_id);
end 
err_rate_total=err_total/(36*payload_num*frame_num)
    figure(1);
    subplot(5,1,1)
    plot(tx_data);
    subplot(5,1,2)
    plot(rcv_data,'r');
    subplot(5,1,3)
    %plot(Z1);
    plot(frame_syn);
    subplot(5,1,4)
    %plot(c);
    plot(symbol_syn);
    subplot(5,1,5)
    plot(fft_window);
    figure(2)
    plot(valid_data_rcv-valid_data_tx);
    figure(3)
    plot(abs(h(34:69)));
    figure(4)
    plot(abs(m_rcv_fft));
    figure(5)
    plot(syn_point_vec);
    figure(6)
    plot(err_rate);
    % figure(4)
    % plot(h1,'r');

  



 