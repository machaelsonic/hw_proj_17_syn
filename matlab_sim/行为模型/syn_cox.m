function [frame_syn,symbol_syn,syn_point,start_point,fft_window,fft_point,fft_data,h,m_rcv_fft]=syn_cox(data,p)
[N,M]=size(data);
s=zeros(1,512);
s_a_buff=zeros(1,256);
k2=0;
flag=0;
max_symbol_syn=0;
start_point=0;
fft_point=0;
syn_point=0;
for k1=1:M
   for k=511:-1:1
       s(1,k+1)=s(1,k);
   end
     s(1,1)=data(1,k1);
   s_a=s(1,1:256);
   s_b=s(1,257:512);

 frame_syn(k1)=sum(s_a.*s_b)/(sum(s_a.^2)+sum(s_b.^2));% 帧同步信号，与信号能量无关
 
 if  frame_syn(k1)>0.2 %帧同步阈值选择, 在噪声环境下需要选择较小的值.
     if flag==0 
         start_point=k1;
         flag=1;
         syn_point=start_point+255+20;
     end
     k2=k2+1;
     if k2==256
        s_a_buff=s_a;
        k2=0;
     end
     symbol_syn(k1)=sum(s_a_buff.*s_b)/sum(s_a_buff.^2);% OFDM符号同步信号,与信号能量无关
%%%%%%%%求OFDM同步点%%%%%%%%%%%%%%%%

   if (k1>=start_point+255+20) &&(k1<=start_point+511+20)
 %   if (k1>=start_point+245) &&(k1<=start_point+501)
       if  symbol_syn(k1)>max_symbol_syn;
            max_symbol_syn=symbol_syn(k1);
            syn_point=k1;  
       end
   
       
% if symbol_syn(k1)>0.85
%     syn_point=k1;
% end
   end  
 
 end

end
syn_point=syn_point-40;
%syn_point=syn_point-100;
 %%%%%%%%%%%%%%%%%FFT window%%%%%%%%%%
 for k1=1:M+1
       %if (k1>=syn_point+1619) && (k1<=syn_point+3334)  % 接收数据，包含cp,frame_syn(k1)>0.4
        if (k1>=syn_point+1728) && (k1<=syn_point+3443)  % 接收数据，包含cp,frame_syn(k1)>0.4
            fft_point=fft_point+1;
            fft_window(k1)=1;
        else
            fft_window(k1)=0; 
       end
 end  
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start_point;
syn_point;
 %fft_data=data(syn_point+1619:syn_point+3334); % 2561~4276，接收数据，包含cp ,frame_syn(k1)>0.4
 %m_rcv=data(syn_point+1363:syn_point+1618);%使用第二个m符号进行信道估计，2305~2560,frame_syn(k1)>0.4
 fft_data=data(syn_point+1728:syn_point+3443); % 2561~4276，接收数据，包含cp ,frame_syn(k1)>0.2
 m_rcv=data(syn_point+1472:syn_point+1727);%使用第二个m符号进行信道估计，2305~2560,frame_syn(k1)>0.2
 m_tx=0-p;
  m_rcv_fft=fft(m_rcv,256);
  m_tx_fft=fft(m_tx,256);
  
  h=m_rcv_fft./m_tx_fft;



end
    

