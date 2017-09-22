clear
clc
SNR=9;% 信噪比 
noise_ctr=0;  % noise_ctr=0代表无噪声,noise_ctr=1,代表有噪声;
payload_num=6; %payload的symbol个数

first_carrier_id=81;%起始子载波编号
last_carrier_id=496;%终止子载波编号

carrier_num=416;%使用的子载波个数
fft_point=1024;% FFT点数
cp_num=458;%循环前缀的点数

frame_length=fft_point*10+payload_num*(fft_point+cp_num); %帧长度=19132;
ofdm_window_offset=50;%定义ofdm窗口的提前量
phase_data=load('E:\design\QUARTUS\plc_design_final.git\matlab_sim\行为模型\phase_rev.txt'); %从文件中读取前导序列相位
%phase_data=phase_data-1;
 %根据使用的子载波情况生成m符号相位
for k1=first_carrier_id:last_carrier_id
    if phase_data(1,k1)>=8 
       m_phase(1,k1-first_carrier_id+1)=phase_data(1,k1)-8;
    else
       m_phase(1,k1-first_carrier_id+1)=phase_data(1,k1)+8;
    end
end

frame_num=5;%发送帧个数
err_cnt=zeros(1,frame_num);%帧误码计数
err_total=0; %总误码计数
tx_data_matlab=[];
for frame_id=1:frame_num
    
    pre_phase=m_phase;%生成第一个payload symbol的参考相位
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%发送机代码%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    send_data_ifft_r=[];
    valid_data_tx=[];
    send_data_ifft_r_rtl=[];
    for k1=1:payload_num
        %[load_data,valid_data]=data_gen;
        %data=rand(1,36);%产生随机数据
         data= double(dec2bin(frame_id,carrier_num))-double('0');%产生递增数据：1，2，3，4，5......
 
        [load_data,valid_data,valid_data_map,pre_phase_next]=data_gen(pre_phase,data,carrier_num,fft_point,first_carrier_id,last_carrier_id);
        
        %%%%%%%%%%%理论FFT模型%%%%%%%%%%%%%%%%%%%%%%%%%%%
        data_gen_ifft_r=round(real(ifft(load_data,fft_point)));
        cp=data_gen_ifft_r(fft_point-cp_num+1:fft_point);
        send_data_ifft_r=[send_data_ifft_r cp data_gen_ifft_r];%6个payload数据，每个payload数据包含一个cp，
        %一个cp为458个采样点，共6*1482=8892个采样点
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%RTL模型(使用FFT IP 核模型)
        [data_gen_ifft_rtl, exp_out] = fft_ip_model(load_data,fft_point,1) ;
        data_gen_ifft_r_rtl=real(data_gen_ifft_rtl);
        cp_rtl=data_gen_ifft_r_rtl(fft_point-cp_num+1:fft_point);
        send_data_ifft_r_rtl=[send_data_ifft_r_rtl cp_rtl data_gen_ifft_r_rtl];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
         
        
        valid_data_tx=[valid_data_tx valid_data];
        pre_phase=pre_phase_next;%生成下个payload symbol的参考相位
    end
    %%%%%%%%%%%%%%理论模型与RTL模型的量化误差%%%%%%%%%%%%%%%%%%%%%%%%%%
    quan_err=send_data_ifft_r_rtl-send_data_ifft_r*2^(10+exp_out(1));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [pre_data,p]=preamble(phase_data,fft_point,first_carrier_id,last_carrier_id);%生成前导序列，包含8个p符号和2个m符号，10240个采样点
    tx_data=[pre_data*16 send_data_ifft_r_rtl*4]; %发送到电力线上的数据， 共19132个采样点,对前导序列放大16倍,实际设计过程中可根据具体数值进行调整
    
    for k=1:frame_length
        if tx_data(k)>1023
            tx_data(k)=1023;
        end
        if tx_data(k)<-1023
            tx_data(k)=-1023;
        end
    end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tx_data_matlab=[tx_data_matlab tx_data];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%电力线信道%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %   rcv_data=tx_data;%理想信道
    %   [rcv_data,NOISE] = noisegen(tx_data,SNR);
      [rcv_data,ht,trms,t_max]=PLC_channel(tx_data,1,noise_ctr,SNR);
    rcv_data_ex=[rcv_data zeros(1,600)]; %扩展接收数据,防止定位点后移导致数据数组索引超范围
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%接收机代码%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %[X1,Z1,c,syn_point,start_point,fft_window,fft_point,fft_data,h]=syn_self(rcv_data,p);
    [data_delay,frame_syn,frame_syn_rtl,frame_syn_1,syn_point,start_point,fft_window,fft_point_cnt,fft_data,h,m_rcv_fft,m_rcv]=syn_cox(rcv_data_ex,p,fft_point,payload_num,ofdm_window_offset);
    %h1=fft(fft_data,256)./fft(tx_data(syn_point+2207:syn_point+2462),256);
    %valid_data_rcv=data_rcv(fft_data,h,payload_num);
    
    
    syn_point_vec(frame_id)=syn_point;% 同步点滑动范围
    start_point_vec(frame_id)=start_point;%起始点滑动范围
    [valid_data_rcv,rt_r,rt_j]=data_rcv(fft_data,h,payload_num,m_rcv_fft,fft_point,first_carrier_id,last_carrier_id,cp_num);
    %%%%%%%%%%%%误码率统计%%%%%%%%%%%%%%%%%%%%%
    for k=1:carrier_num*payload_num
        if valid_data_rcv(k)~=valid_data_tx(k)
            err_cnt(1,frame_id)=err_cnt(1,frame_id)+1;
        end
    end
    err_rate(1,frame_id)=err_cnt(1,frame_id)/(carrier_num*payload_num);
    err_total=err_total+err_cnt(1,frame_id);
end 
 err_rate_total=err_total/(carrier_num*payload_num*frame_num)
 %%%%%%%%%%%%%%%%%%比较matlab模型与modelsim模型的发送数据%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   tx_data_o = load('e:\design\QUARTUS\plc_design_final.git\tb_tx_data_o.txt');%读取modelsim的仿真数据
%   tx_data_o =tx_data_o';
%   tx_data_compare=tx_data_matlab-tx_data_o;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(1);
    subplot(4,1,1)
    plot(tx_data);
    subplot(4,1,2)
    plot(data_delay,'r');
    subplot(4,1,3)
    %plot(Z1);
    plot(frame_syn);
    subplot(4,1,4)
    plot(fft_window);
    figure(2)
    plot(valid_data_rcv-valid_data_tx);
    figure(3)
    plot(abs(h(first_carrier_id:last_carrier_id)));
    figure(4)
    plot(abs(m_rcv_fft));
    figure(5)
    subplot(2,1,1)
     plot(syn_point_vec);% 同步点的抖动情况
     subplot(2,1,2)
     plot(start_point_vec);% 起始点的抖动情况
    figure(6)
    plot(err_rate);
    figure(7)
    plot(rt_r,'r');
    hold on
    plot(rt_j);
  



 