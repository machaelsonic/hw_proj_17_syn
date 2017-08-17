function [channel_out,ht,trms,t_max]=PLC_channel(signal_send,chan_type,is_noise,snr)
% �������ܣ�  ģ�µ�ѹ������ͨ���ŵ�ģ�ͣ�ʵ���źŵĴ��� 
% ���������
    % signal_send   ����PLC�ŵ����ź�
    % chan_type     ѡ��PLC�ŵ�ģ��  0 �޶ྶ�����ŵ���1 �ľ�ģ�ͣ�2 11��ģ�ͣ�3 ARģ�ͣ�4 FIRģ�ͣ�
    % is_noise      �Ƿ����������0 ��1 �ǣ�
    % snr           �����  
% ���������
    % channel_out   ͨ��PLC�ŵ�����ź�
channel_out=[];
if chan_type==1%�ľ��ŵ�ģ��
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
    fre=abs(y1+y2+y3+y4).';%%Ϊ��ȡģ��ȡģ�õ�ϵͳ�ķ�Ƶ���ԣ�fre��1��length��f����
    ht=[];
    ht=real(ifft(fre));%%%ht��1��length��f����
    tmp_a=[];tmp_a=conv(ht,signal_send);%�õ��ŵ������ʱ���ź�tmp_a(1:length(f))
    channel_out=real(tmp_a(1:length(signal_send)));%ȡʱ���ź�tmp_a(1:length(f))���������źŸ�����ͬ�Ĳ�����tmp_a(1:length(signal_send))��ȡʵ��������ͨ��������غ���R(0)�����ŵ�������źŵ�ƽ�����ʣ�
elseif chan_type==2%�ྶ�ŵ�ģ��-11��
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
elseif chan_type==3%AR�ŵ�ģ��
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
elseif chan_type==4%FIR�ŵ�ģ��
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
%�������
% channel_out = signal_send;
if is_noise==1
    %���뷽ʽһ
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %�����źŹ���
    SignalPower=var(channel_out);%ƽ������������źŵķ���Ϊ�źŽ���ƽ������
    %��������ȵõ���Ӧ��˹�����Ĺ���
    noise=normrnd(0,sqrt(.5*SignalPower/(10^(snr/10))),1,length(channel_out));%%%%%*����ά�����ŵ�������г�����ͬ���Ӿ�ֵΪ�㣬������̬�ֲ�������ĺ���normrnd-����������˹�������  
    %������Ϊsqrt(.5*SignalPower/(10^(snr/10)))��̬�ֲ������������Ϊ����ĸ�˹�������ź�
    %�������
    channel_out=channel_out+noise;
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  ���뷽ʽ��
    %  [channel_out,NOISE] = noisegen(channel_out,snr);
end % end of if is_noise==1