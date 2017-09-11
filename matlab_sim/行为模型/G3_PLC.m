clear
clc
SNR=10;% ����� 
noise_ctr=1;  % noise_ctr=0����������,noise_ctr=1,����������;
payload_num=6; %payload��symbol����

first_carrier_id=111;%��ʼ���ز����
last_carrier_id=238;%��ֹ���ز����

carrier_num=128;%ʹ�õ����ز�����
fft_point=1024;% FFT����


phase_data=load('E:\design\QUARTUS\plc_design_final.git\matlab_sim\��Ϊģ��\phase.txt'); %���ļ��ж�ȡǰ��������λ
phase_data=phase_data';
 %����ʹ�õ����ز��������m������λ
for k1=first_carrier_id:last_carrier_id
    if phase_data(1,k1)>8 
       m_phase(1,k1-first_carrier_id+1)=phase_data(1,k1)-8;
    else
       m_phase(1,k1-first_carrier_id+1)=phase_data(1,k1)+8;
    end
end

frame_num=5;%����֡����
err_cnt=zeros(1,frame_num);%֡�������
err_total=0; %���������
tx_data_matlab=[];
for frame_id=1:frame_num
    
    pre_phase=m_phase;%���ɵ�һ��payload symbol�Ĳο���λ
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ͻ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    send_data_ifft_r=[];
    valid_data_tx=[];
    send_data_ifft_r_rtl=[];
    for k1=1:payload_num
        %[load_data,valid_data]=data_gen;
        %data=rand(1,36);%�����������
         data= double(dec2bin(frame_id,128))-double('0');
 
        [load_data,valid_data,valid_data_map,pre_phase_next]=data_gen(pre_phase,data,carrier_num,fft_point,first_carrier_id,last_carrier_id);
        
        %%%%%%%%%%%����FFTģ��%%%%%%%%%%%%%%%%%%%%%%%%%%%
        data_gen_ifft_r=round(real(ifft(load_data,fft_point)));
        cp=data_gen_ifft_r(fft_point-29:fft_point);
        send_data_ifft_r=[send_data_ifft_r cp data_gen_ifft_r];%6��payload���ݣ�ÿ��payload���ݰ���һ��cp��
        %һ��cpΪ30�������㣬��6*1054=6324��������
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%RTLģ��(ʹ��FFT IP ��ģ��)
        [data_gen_ifft_rtl, exp_out] = fft_ip_model(load_data,fft_point,1) ;
        data_gen_ifft_r_rtl=real(data_gen_ifft_rtl);
        cp_rtl=data_gen_ifft_r_rtl(fft_point-29:fft_point);
        send_data_ifft_r_rtl=[send_data_ifft_r_rtl cp_rtl data_gen_ifft_r_rtl];
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
         
        
        valid_data_tx=[valid_data_tx valid_data];
        pre_phase=pre_phase_next;%�����¸�payload symbol�Ĳο���λ
    end
    %%%%%%%%%%%%%%����ģ����RTLģ�͵��������%%%%%%%%%%%%%%%%%%%%%%%%%%
    quan_err=send_data_ifft_r_rtl-send_data_ifft_r*2^(10+exp_out(1));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    [pre_data,p]=preamble(phase_data,fft_point,first_carrier_id,last_carrier_id);%����ǰ�����У�����8��p���ź�2��m���ţ�10240��������
    tx_data=[pre_data*16 send_data_ifft_r_rtl*2]; %���͵��������ϵ����ݣ� ��16564��������,��ǰ�����зŴ�4��,ʵ����ƹ����пɸ��ݾ�����ֵ���е���

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tx_data_matlab=[tx_data_matlab tx_data];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%�������ŵ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %    rcv_data=tx_data;%�����ŵ�
    %   [rcv_data,NOISE] = noisegen(tx_data,SNR);
     [rcv_data,ht,trms,t_max]=PLC_channel(tx_data,1,noise_ctr,SNR);
    rcv_data_ex=[rcv_data zeros(1,400)]; %��չ��������,��ֹ��λ����Ƶ�������������������Χ
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ջ�����%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %[X1,Z1,c,syn_point,start_point,fft_window,fft_point,fft_data,h]=syn_self(rcv_data,p);
    [frame_syn,symbol_syn,syn_point,start_point,fft_window,fft_point_cnt,fft_data,h,m_rcv_fft]=syn_cox(rcv_data_ex,p,fft_point);
    %h1=fft(fft_data,256)./fft(tx_data(syn_point+2207:syn_point+2462),256);
    %valid_data_rcv=data_rcv(fft_data,h,payload_num);
    syn_point_vec(frame_id)=syn_point;% ͬ���㻬����Χ
    valid_data_rcv=data_rcv(fft_data,h,payload_num,m_rcv_fft,fft_point,first_carrier_id,last_carrier_id);
    %%%%%%%%%%%%������ͳ��%%%%%%%%%%%%%%%%%%%%%
    for k=1:carrier_num*payload_num
        if valid_data_rcv(k)~=valid_data_tx(k)
            err_cnt(1,frame_id)=err_cnt(1,frame_id)+1;
        end
    end
    err_rate(1,frame_id)=err_cnt(1,frame_id)/(carrier_num*payload_num);
    err_total=err_total+err_cnt(1,frame_id);
end 
 err_rate_total=err_total/(carrier_num*payload_num*frame_num)
 %%%%%%%%%%%%%%%%%%�Ƚ�matlabģ����modelsimģ�͵ķ�������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  tx_data_o = load('e:\design\QUARTUS\plc_design_final.git\tb_tx_data_o.txt');%��ȡmodelsim�ķ�������
%  tx_data_o =tx_data_o';
%  tx_data_compare=tx_data_matlab-tx_data_o;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    plot(abs(h(first_carrier_id:last_carrier_id)));
    figure(4)
    plot(abs(m_rcv_fft));
    figure(5)
    plot(syn_point_vec);
    figure(6)
    plot(err_rate);
    % figure(4)
    % plot(h1,'r');

  



 