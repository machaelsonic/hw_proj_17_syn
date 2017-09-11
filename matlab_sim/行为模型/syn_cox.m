function [frame_syn,symbol_syn,syn_point,start_point,fft_window,fft_point_cnt,fft_data,h,m_rcv_fft]=syn_cox(data,p,fft_point)
[N,M]=size(data);
s=zeros(1,2*fft_point);
s_a_buff=zeros(1,fft_point);
k2=0;
flag=0;
max_symbol_syn=0;
min_frame_syn=0;
start_point=0;
fft_point_cnt=0;
syn_point=0;
for k1=1:M
   for k=2*fft_point-1:-1:1
       s(1,k+1)=s(1,k);
   end
       s(1,1)=data(1,k1);
   
   s_a=s(1,1:fft_point);
   s_b=s(1,fft_point+1:2*fft_point);

 frame_syn(k1)=sum(s_a.*s_b)/(sum(s_a.^2)+sum(s_b.^2));% 帧同步信号，与信号能量无关
 frame_syn(k1)=frame_syn(k1)*1023; %量化位12位数据,保留2位符号位
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if  frame_syn(k1)>250 %帧同步阈值选择, 在噪声环境下需要选择较小的值.
     if flag==0 
         start_point=k1;
         flag=1;
         syn_point=start_point+fft_point+20;
         s_a_buff=s_a;
     end
%      k2=k2+1;
%      if k2==1024
%         s_a_buff=s_a;
%         k2=0;
%       end
     symbol_syn(k1)=sum(s_a_buff.*s_b)/sum(s_a_buff.^2);% OFDM符号同步信号,与信号能量无关
%%%%%%%%求OFDM同步点%%%%%%%%%%%%%%%%

      if (k1>=start_point+fft_point+20) &&(k1<=start_point+2*fft_point+20)

 %%%%%%%%%%%%%%%%%%%%%%%%%%精同步查找同步点%%%%%%%%%%%%%%%%%%%%%%%
       if  symbol_syn(k1)>max_symbol_syn 
            max_symbol_syn=symbol_syn(k1);
            syn_point=k1;  
       end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

      end  
  end
 end
syn_point=syn_point-40;
%syn_point=syn_point-100;
 %%%%%%%%%%%%%%%%%FFT window%%%%%%%%%%
 for k1=1:M+1
        if (k1>=syn_point+6880) && (k1<=syn_point+13203)  % 接收数据，包含cp,frame_syn(k1)>0.4
            fft_point_cnt=fft_point_cnt+1;
            fft_window(k1)=1;
        else
            fft_window(k1)=0; 
       end
 end  
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start_point;
syn_point;

 fft_data=data(syn_point+6880:syn_point+13203); % 10241~16564，接收数据，包含cp ,frame_syn(k1)>0.2
 m_rcv=data(syn_point+5856:syn_point+6879);%使用第二个m符号进行信道估计，9217~10240,frame_syn(k1)>0.2
 m_tx=0-p;
 
  %m_rcv_fft=fft(m_rcv,256);
  [m_rcv_fft,exp1]=fft_ip_model(m_rcv,fft_point,0) ;
  m_tx_fft=fft(m_tx,fft_point);
  
  h=m_rcv_fft./m_tx_fft;
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
 
 
 
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

  
% if  frame_syn(k1)>250 %帧同步阈值选择, 在噪声环境下需要选择较小的值.
%      if flag==0 
%          start_point=k1;
%          flag=1;
%      end
% end
% symbol_syn(k1)=0;
% %%%%%%%%求OFDM同步点%%%%%%%%%%%%%%%%
%  %%%%%%%%%%%%%%%%%%%%%%%%%粗同步查找同步点%%%%%%%%%%%%%%%%%%%%%%%%%%
%   if k1>start_point 
%      if  frame_syn(k1)< min_frame_syn
%            min_frame_syn=frame_syn(k1); 
%            syn_point=k1;
%      end
%  end  
%  
%  
%  
% end
% syn_point=syn_point+20;
% 
%  %%%%%%%%%%%%%%%%%FFT window%%%%%%%%%%
%  for k1=1:M+1
%         if (k1>=syn_point+257) && (k1<=syn_point+1716+256)  % 接收数据，包含cp,frame_syn(k1)>0.4
%             fft_point=fft_point+1;
%             fft_window(k1)=1;
%         else
%             fft_window(k1)=0; 
%        end
%  end  
%   
%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% start_point;
% syn_point;
%  %fft_data=data(syn_point+1619:syn_point+3334); % 2561~4276，接收数据，包含cp ,frame_syn(k1)>0.4
%  %m_rcv=data(syn_point+1363:syn_point+1618);%使用第二个m符号进行信道估计，2305~2560,frame_syn(k1)>0.4
%  fft_data=data(syn_point+257:syn_point+1716+256); % 2561~4276，接收数据，包含cp ,frame_syn(k1)>0.2
%  m_rcv=data(syn_point+1:syn_point+256);%使用第二个m符号进行信道估计，2305~2560,frame_syn(k1)>0.2
%  m_tx=0-p;
%  
%   %m_rcv_fft=fft(m_rcv,256);
%   [m_rcv_fft,exp1]=fft_ip_model(m_rcv,256,0) ;
%   m_tx_fft=fft(m_tx,256);
%   
%   h=m_rcv_fft./m_tx_fft;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end
    

