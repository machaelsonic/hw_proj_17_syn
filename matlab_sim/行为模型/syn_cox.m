function [data_delay,frame_syn,frame_syn_rtl,frame_syn_1,syn_point,start_point,fft_window,fft_point_cnt,fft_data,h,m_rcv_fft,m_rcv]=syn_cox(data,p,fft_point,payload_num,ofdm_window_offset)
[N,M]=size(data);
data=[data zeros(1,1024)];
data_delay=[zeros(1,1024) data];%延时1024个采样点，在FPGA实现时，可采用s_a的移位输出实现1024点延时
%%%%%%%%%%%FPGA实现接收数据的1024点延时%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for k1=1:M+fft_point-1
%    for k=2*fft_point:-1:1
%        s(1,k+1)=s(1,k);
%    end
%        s(1,1)=data(1,k1);
%   for k=1:1:M+fft_point-1 
%     data_delay(1,k)=data_delay(1,k+1);
%   end
%     data_delay(1,M+fft_point)=s_a(1,fft_point);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s=zeros(1,2*fft_point+1);
s_a_buff=zeros(1,fft_point);

state=0;
flag=0;
cnt0=0;

min_frame_syn=0;
start_point=0;
fft_point_cnt=0;
m_rcv_cnt=0;
syn_point=0;
state_cnt=0;
for k1=1:M+fft_point-1
   for k=2*fft_point:-1:1
       s(1,k+1)=s(1,k);
   end
       s(1,1)=data(1,k1);
   
   s_a=s(1,1:fft_point);
   s_b=s(1,fft_point+1:2*fft_point);
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%理论同步算法%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  frame_syn(k1)=2*sum(s_a.*s_b)/(sum(s_a.^2)+sum(s_b.^2));% 理论算法1帧同步信号，与信号能量无关
  frame_syn_1(k1)=sign(sum(s_a.*s_b))*((sum(s_a.*s_b))^2/((sum(s_a.^2)*sum(s_b.^2))));% 理论算法2帧同步信号，与信号能量无关
  

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%FPGA实现算法%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         sum_mult_ab(1)=0;
         s_mult_ab=(s_a(1)-s(1,2*fft_point+1))*s_b(1);
         sum_mult_ab(k1+1)=sum_mult_ab(k1) +s_mult_ab;        
         sum_mult_a2b2(1)=0;
         s_mult_a2b2=s_a(1)*s_a(1)-s(1,2*fft_point+1)*s(1,2*fft_point+1);
         sum_mult_a2b2(k1+1)=sum_mult_a2b2(k1)+s_mult_a2b2;
         frame_syn_rtl(k1)=2*sum_mult_ab(k1)/sum_mult_a2b2(k1);       
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  frame_syn(k1)=frame_syn(k1)*1023; %量化位12位数据,保留2位符号位
  frame_syn_rtl(k1)=frame_syn_rtl(k1)*1023; %量化位12位数据,保留2位符号位
  frame_syn_1(k1)=frame_syn_1(k1)*1023; %量化位12位数据,保留2位符号位
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     switch state 
         case 0 
              if  frame_syn_rtl(k1)>300 
                   cnt0=cnt0+1; 
                   if cnt0>3  %连续三次超过阈值
                      state=1;
                      start_point=k1;
                      s_a_buff=s_a;
                      cnt1=0;
                   else
                      state=0;
                   end
              else
                  cnt0=0;
              end
              cnt3=0;
              frame_cnt=0;%接收计数器清零
         case 1  
               frame_cnt=frame_cnt+1; %检测到同步序列后，接收计数器开始工作，
               state_cnt=state_cnt+1; %状态超时判断计数器
              if state_cnt<10240 
                if  frame_syn_rtl(k1)<-300 
                    cnt1=cnt1+1;
                    if cnt1>3  %连续三次超过阈值
                       state=2;
                       cnt2=0;
                       min_frame_syn=frame_syn_rtl(k1);
                       state_cnt=0;
                    else
                       state=1;
                    end
                else
                  cnt1=0;
                end
              else
                state=0;
                cnt0=0;
                state_cnt=0;
              end
         case 2 
             frame_cnt=frame_cnt+1; 
             state_cnt=state_cnt+1;%状态超时判断计数器
             if state_cnt<5000
               if (frame_syn_rtl(k1)>min_frame_syn)
                  cnt2=cnt2+1;
                  if cnt2>500 %连续判断501个点，若一直处在上升阶段，则结束最小值搜寻
                     state=3;
                     cnt3=0;
                     syn_point_min=frame_cnt;
                     syn_point_ref=k1;%最小值的参考点，syn_point_ref+（1024-501）=10241， 
                     state_cnt=0;
                  else
                     state=2;
                  end
               else  %(frame_syn_rtl(k1)< min_frame_syn) 
                  cnt2=0;
                   min_frame_syn=frame_syn_rtl(k1); 
               end
             else
               state=0;
               cnt0=0;
               state_cnt=0;
             end

         case 3
              frame_cnt=frame_cnt+1; 
              if k1==M+fft_point-1 
                  state=0; %回归初始状态
                  cnt0=0;
                  state_cnt=0;
              else
                  state=3;
              end
             cnt3=cnt3+1;
     end  
  
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%     if  frame_syn_rtl(k1)>300 %帧同步阈值选择, 在噪声环境下需要选择较小的值. 
%        if flag==0
%          start_point=k1;
%          flag=1;
%          s_a_buff=s_a;
%      end
%     symbol_syn(k1)=sum(s_a_buff.*s_b)/sum(s_a_buff.^2);% OFDM符号同步信号,与信号能量无关
%    end

%symbol_syn(k1)=sum(s_a_buff.*s_b)/sum(s_a_buff.^2);% OFDM符号同步信号,与信号能量无关
%%%%%%%%求OFDM同步点%%%%%%%%%%%%%%%% 
  %%%%%%%%%%%%%%%%%FFT window%%%%%%%%%%
 
  if cnt3>=523-ofdm_window_offset && cnt3<=523+1023-ofdm_window_offset  %在状态2判断了501个采样点，因此此处的计数值位1024-501=523
      m_rcv_cnt=m_rcv_cnt+1;
      m_rcv(m_rcv_cnt)=data_delay(1,k1);%使用第二个m符号进行信道估计，
  end
  
   if cnt3>=524+1023-ofdm_window_offset  && cnt3<=524+1023+8891-ofdm_window_offset
            if flag==0
                syn_point=k1;%在fpga实现时这个数值是测不出来的，但可以测出cnt3，cnt3=524+1023时为开窗点
                                      %在matlab模型中用来评估OFDM窗口的抖动情况,理论值为10241+1024=11265
                flag=1;
            end
            fft_point_cnt=fft_point_cnt+1;
            fft_window(k1)=1;
            fft_data(fft_point_cnt)=data_delay(1,k1);
        else
            fft_window(k1)=0; 
     end 
     
     
end
syn_point
start_point;
frame_cnt+start_point;  
 syn_point_min;
  syn_point_ref; 
  cnt3; 
 syn_point_ref-syn_point_min-start_point ;

 %%%%%%%%%%%%%%%%%FFT window%%%%%%%%%%
 
   
%  for k1=1:M+1
%   if (k1>=syn_point+6880) && (k1<=syn_point+15771)  % 接收数据，包含cp,frame_syn(k1)>0.4
%             fft_point_cnt=fft_point_cnt+1;
%             fft_window(k1)=1;
%         else
%             fft_window(k1)=0; 
%        end
%  end  
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%fft_data=data(syn_point+6880:syn_point+15771); % 10241~16564，接收数据，包含cp ,frame_syn(k1)>0.2
     
     
  
  
 
  
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
    

