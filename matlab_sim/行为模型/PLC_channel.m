function [channel_out,ht,trms,t_max]=PLC_channel(signal_send,chan_type,is_noise,snr)
% 函数功能：  模仿低压电力线通信信道模型，实现信号的传输 
% 输入参数：
    % signal_send   输入PLC信道的信号
    % chan_type     选择PLC信道模型  0 无多径理想信道，1 四径模型，2 11径模型，3 AR模型，4 FIR模型；
    % is_noise      是否添加噪声：0 否，1 是；
    % snr           信噪比  
% 输出参数：
    % channel_out   通过PLC信道后的信号
channel_out=[];
if chan_type==1%四径信道模型
    f=[];f=0:800e3:3.2*1e6;
    g1=0.64;g2=0.38;g3=-0.15;g4=0.05;
    d1=200;d2=222.4;d3=244.8;d4=267.5;
    t_max=d4/(3e8);
    trms=(d1+d2+d3+d4)/4/(3e8);
    a=7.8*1e-10;c0=3*1e8;er=3.8;%%%%****************er=3.8
    y1=g1*exp((-a-2*pi*i*er.^0.5/c0)*d1*f);
    y2=g2*exp((-a-2*pi*i*er.^0.5/c0)*d2*f);
    y3=g3*exp((-a-2*pi*i*er.^0.5/c0)*d3*f);
    y4=g4*exp((-a-2*pi*i*er.^0.5/c0)*d4*f);
    fre=[];
    fre=abs(y1+y2+y3+y4).';%%为何取模？取模得到系统的幅频特性，fre（1：length（f））
    ht=[];
    ht=real(ifft(fre));%%%ht（1：length（f））
    tmp_a=[];tmp_a=conv(ht,signal_send);%得到信道输出的时域信号tmp_a(1:length(f))
    channel_out=real(tmp_a(1:length(signal_send)));%取时域信号tmp_a(1:length(f))的与输入信号个数相同的采样点tmp_a(1:length(signal_send))，取实数？？，通过其自相关函数R(0)来求信道的输出信号的平均功率，
elseif chan_type==2%多径信道模型-11径
    f=[];f=0:800e3:3.2*1e6;
    g=[0.064,0.038,-0.015,0.005,-0.002,-0.003,-0.005,-0.006,-0.005,0.002,-0.004];
    d=[200,222.4,244.8,267.5,290,350,428,440,452,630,680];  
    t_max=680/(3e8);
    trms=0;
    for kk=1:11 
      trms=trms+d(kk);
    end
     trms=trms/11/(3e8);
    
    a=8.8*1e-10;c0=3*1e8;er=3.8;
    y1=g(1).*exp((-a-2*pi*i*er.^0.5/c0)*d(1).*f);
    y2=g(2).*exp((-a-2*pi*i*er.^0.5/c0)*d(2).*f);
    y3=g(3).*exp((-a-2*pi*i*er.^0.5/c0)*d(3).*f);
    y4=g(4).*exp((-a-2*pi*i*er.^0.5/c0)*d(4).*f);
    y5=g(5).*exp((-a-2*pi*i*er.^0.5/c0)*d(5).*f);
    y6=g(6).*exp((-a-2*pi*i*er.^0.5/c0)*d(6).*f);
    y7=g(7).*exp((-a-2*pi*i*er.^0.5/c0)*d(7).*f);
    y8=g(8).*exp((-a-2*pi*i*er.^0.5/c0)*d(8).*f);
    y9=g(9).*exp((-a-2*pi*i*er.^0.5/c0)*d(9).*f);
    y10=g(10).*exp((-a-2*pi*i*er.^0.5/c0)*d(10)*f);
    y11=g(11).*exp((-a-2*pi*i*er.^0.5/c0)*d(11).*f);
    fre=[];
    fre=abs(y1+y2+y3+y4+y4+y5+y6+y7+y8+y9+y10+y11).';
    ht=[];
    ht=ifft(fre);
    tmp_a=[];
    tmp_a=conv(ht,signal_send); 
    channel_out=real(tmp_a(1:length(signal_send)));
elseif chan_type==3%AR信道模型
    f=[];f=800e3;
    N=5;
    tmp_y=[];tmp_y=zeros(1,N+3);
    a1=-0.727+j*0.081;
    a2=-0.121+j*0.046;
    a3=-0.111-j*0.032;
    sigma=1.048e-5^0.5;
    tmp_y(1:3)=normrnd(0,sigma,1,3);
    for k=4:N+3
        v=normrnd(0,sigma);
        tmp_y(k)=-a1*tmp_y(k-1)-a2*tmp_y(k-2)-a3*tmp_y(k-3)+v;
    end
    fre=[];ht=[];
    fre=abs(tmp_y(4:N+3)).';%why abs
    ht=ifft(fre);
    tmp_a=[];
    tmp_a=conv(signal_send,ht);
    channel_out=200*real(tmp_a(1:length(signal_send)));
    trms=0;
    t_max=0;
elseif chan_type==4%FIR信道模型
    b=[0.65 0.2-0.2*j 0.15+0.05*j 0.25-0.1*j 0.19+0.1*j];
    a=[1 0 0 0 0];
    [H w]=freqz(b,a,5);
    ht=ifft((H));
    tmp_a=[];
    tmp_a=conv(signal_send,ht);
    channel_out=[];
    channel_out=real(tmp_a(1:length(signal_send)));
    trms=0;
    t_max=0;
else%no multi-path
    ht=[1];
    channel_out=signal_send;
end% end of if chan_type==1
%添加噪声
% channel_out = signal_send;
if is_noise==1
    %加噪方式一
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %计算信号功率
    SignalPower=var(channel_out);%平稳随机过程中信号的方差为信号交流平均功率
    %根据信噪比得到相应高斯噪声的功率
    noise=normrnd(0,sqrt(.5*SignalPower/(10^(snr/10))),1,length(channel_out));%%%%%*产生维数与信道输出序列长度相同服从均值为零，产生正态分布随机数的函数normrnd-用来产生高斯随机矩阵  
    %均方差为sqrt(.5*SignalPower/(10^(snr/10)))正态分布的随机数，做为加入的高斯白噪声信号
    %添加噪声
    channel_out=channel_out+noise;
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  加噪方式二
    %  [channel_out,NOISE] = noisegen(channel_out,snr);
end % end of if is_noise==1