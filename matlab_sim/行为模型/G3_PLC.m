clear
clc
SNR=10;% ����� 
noise_ctr=1;  % noise_ctr=0����������,noise_ctr=1,����������;
payload_num=6; %payload��symbol����
m_phase=[10,9,8,7,6,4,2,15,11,7,3,14,9,3,13,6,15,7,15,7,14,5,10,0,5,10,14,2,5,8,10,11,13,14,15,15]; %m������λ
frame_num=10;%����֡����
err_cnt=zeros(1,frame_num);%֡�������
err_total=0; %���������

for frame_id=1:frame_num
    
    pre_phase=m_phase;%���ɵ�һ��payload symbol�Ĳο���λ
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ͻ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    send_data_ifft_r=[];
    valid_data_tx=[];
    send_data_ifft_r_rtl=[];
    for k1=1:payload_num
        %[load_data,valid_data]=data_gen;
        [load_data,valid_data,pre_phase_next]=data_gen(pre_phase);
        
        %%%%%%%%%%%����FFTģ��%%%%%%%%%%%%%%%%%%%%%%%%%%%
        data_gen_ifft_r=round(real(ifft(load_data,256)));
        cp=data_gen_ifft_r(227:256);
        send_data_ifft_r=[send_data_ifft_r cp data_gen_ifft_r];%6��payload���ݣ�ÿ��payload���ݰ���һ��cp��
        %һ��cpΪ30�������㣬��6*286=1716��������
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%RTLģ��(ʹ��FFT IP ��ģ��)
        [data_gen_ifft_rtl, exp_out] = fft_ip_model(load_data,256,1) ;
        data_gen_ifft_r_rtl=real(data_gen_ifft_rtl);
        cp_rtl=data_gen_ifft_r_rtl(227:256);
        send_data_ifft_r_rtl=[send_data_ifft_r_rtl cp_rtl data_gen_ifft_r_rtl];
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
         
        
        valid_data_tx=[valid_data_tx valid_data];
        pre_phase=pre_phase_next;%�����¸�payload symbol�Ĳο���λ
    end
    %%%%%%%%%%%%%%����ģ����RTLģ�͵��������%%%%%%%%%%%%%%%%%%%%%%%%%%
      quan_err=send_data_ifft_r_rtl-send_data_ifft_r*2^(8+exp_out(1));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [pre_data,p]=preamble;%����ǰ�����У�����8��p���ź�2��m���ţ�2560��������
    tx_data=[pre_data*4 send_data_ifft_r_rtl]; %���͵��������ϵ����ݣ� ��4276��������,��ǰ�����зŴ�4��,ʵ����ƹ����пɸ��ݾ�����ֵ���е���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%�������ŵ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %    rcv_data=tx_data;%�����ŵ�
    %   [rcv_data,NOISE] = noisegen(tx_data,SNR);
    [rcv_data,ht,trms,t_max]=PLC_channel(tx_data,1,noise_ctr,SNR);
    rcv_data_ex=[rcv_data zeros(1,400)]; %��չ��������,��ֹ��λ����Ƶ�������������������Χ
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ջ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %[X1,Z1,c,syn_point,start_point,fft_window,fft_point,fft_data,h]=syn_self(rcv_data,p);
    [frame_syn,symbol_syn,syn_point,start_point,fft_window,fft_point,fft_data,h,m_rcv_fft]=syn_cox(rcv_data_ex,p);
    %h1=fft(fft_data,256)./fft(tx_data(syn_point+2207:syn_point+2462),256);
    %valid_data_rcv=data_rcv(fft_data,h,payload_num);
    syn_point_vec(frame_id)=syn_point;% ͬ���㻬����Χ
    valid_data_rcv=data_rcv(fft_data,h,payload_num,m_rcv_fft);
    %%%%%%%%%%%%������ͳ��%%%%%%%%%%%%%%%%%%%%%
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

  



 