function [data_delay,frame_syn,frame_syn_rtl,frame_syn_1,syn_point,start_point,fft_window,fft_point_cnt,fft_data,h,m_rcv_fft,m_rcv]=syn_cox(data,p,fft_point,payload_num,ofdm_window_offset)
[N,M]=size(data);
data=[data zeros(1,1024)];
data_delay=[zeros(1,1024) data];%��ʱ1024�������㣬��FPGAʵ��ʱ���ɲ���s_a����λ���ʵ��1024����ʱ
%%%%%%%%%%%FPGAʵ�ֽ������ݵ�1024����ʱ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%����ͬ���㷨%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  frame_syn(k1)=2*sum(s_a.*s_b)/(sum(s_a.^2)+sum(s_b.^2));% �����㷨1֡ͬ���źţ����ź������޹�
  frame_syn_1(k1)=sign(sum(s_a.*s_b))*((sum(s_a.*s_b))^2/((sum(s_a.^2)*sum(s_b.^2))));% �����㷨2֡ͬ���źţ����ź������޹�
  

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%FPGAʵ���㷨%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         sum_mult_ab(1)=0;
         s_mult_ab=(s_a(1)-s(1,2*fft_point+1))*s_b(1);
         sum_mult_ab(k1+1)=sum_mult_ab(k1) +s_mult_ab;        
         sum_mult_a2b2(1)=0;
         s_mult_a2b2=s_a(1)*s_a(1)-s(1,2*fft_point+1)*s(1,2*fft_point+1);
         sum_mult_a2b2(k1+1)=sum_mult_a2b2(k1)+s_mult_a2b2;
         frame_syn_rtl(k1)=2*sum_mult_ab(k1)/sum_mult_a2b2(k1);       
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  frame_syn(k1)=frame_syn(k1)*1023; %����λ12λ����,����2λ����λ
  frame_syn_rtl(k1)=frame_syn_rtl(k1)*1023; %����λ12λ����,����2λ����λ
  frame_syn_1(k1)=frame_syn_1(k1)*1023; %����λ12λ����,����2λ����λ
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     switch state 
         case 0 
              if  frame_syn_rtl(k1)>300 
                   cnt0=cnt0+1; 
                   if cnt0>3  %�������γ�����ֵ
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
              frame_cnt=0;%���ռ���������
         case 1  
               frame_cnt=frame_cnt+1; %��⵽ͬ�����к󣬽��ռ�������ʼ������
               state_cnt=state_cnt+1; %״̬��ʱ�жϼ�����
              if state_cnt<10240 
                if  frame_syn_rtl(k1)<-300 
                    cnt1=cnt1+1;
                    if cnt1>3  %�������γ�����ֵ
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
             state_cnt=state_cnt+1;%״̬��ʱ�жϼ�����
             if state_cnt<5000
               if (frame_syn_rtl(k1)>min_frame_syn)
                  cnt2=cnt2+1;
                  if cnt2>500 %�����ж�501���㣬��һֱ���������׶Σ��������Сֵ��Ѱ
                     state=3;
                     cnt3=0;
                     syn_point_min=frame_cnt;
                     syn_point_ref=k1;%��Сֵ�Ĳο��㣬syn_point_ref+��1024-501��=10241�� 
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
                  state=0; %�ع��ʼ״̬
                  cnt0=0;
                  state_cnt=0;
              else
                  state=3;
              end
             cnt3=cnt3+1;
     end  
  
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%     if  frame_syn_rtl(k1)>300 %֡ͬ����ֵѡ��, ��������������Ҫѡ���С��ֵ. 
%        if flag==0
%          start_point=k1;
%          flag=1;
%          s_a_buff=s_a;
%      end
%     symbol_syn(k1)=sum(s_a_buff.*s_b)/sum(s_a_buff.^2);% OFDM����ͬ���ź�,���ź������޹�
%    end

%symbol_syn(k1)=sum(s_a_buff.*s_b)/sum(s_a_buff.^2);% OFDM����ͬ���ź�,���ź������޹�
%%%%%%%%��OFDMͬ����%%%%%%%%%%%%%%%% 
  %%%%%%%%%%%%%%%%%FFT window%%%%%%%%%%
 
  if cnt3>=523-ofdm_window_offset && cnt3<=523+1023-ofdm_window_offset  %��״̬2�ж���501�������㣬��˴˴��ļ���ֵλ1024-501=523
      m_rcv_cnt=m_rcv_cnt+1;
      m_rcv(m_rcv_cnt)=data_delay(1,k1);%ʹ�õڶ���m���Ž����ŵ����ƣ�
  end
  
   if cnt3>=524+1023-ofdm_window_offset  && cnt3<=524+1023+8891-ofdm_window_offset
            if flag==0
                syn_point=k1;%��fpgaʵ��ʱ�����ֵ�ǲⲻ�����ģ������Բ��cnt3��cnt3=524+1023ʱΪ������
                                      %��matlabģ������������OFDM���ڵĶ������,����ֵΪ10241+1024=11265
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
%   if (k1>=syn_point+6880) && (k1<=syn_point+15771)  % �������ݣ�����cp,frame_syn(k1)>0.4
%             fft_point_cnt=fft_point_cnt+1;
%             fft_window(k1)=1;
%         else
%             fft_window(k1)=0; 
%        end
%  end  
  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%fft_data=data(syn_point+6880:syn_point+15771); % 10241~16564���������ݣ�����cp ,frame_syn(k1)>0.2
     
     
  
  
 
  
 m_tx=0-p;
 
  %m_rcv_fft=fft(m_rcv,256);
  [m_rcv_fft,exp1]=fft_ip_model(m_rcv,fft_point,0) ;
  m_tx_fft=fft(m_tx,fft_point);
  
  h=m_rcv_fft./m_tx_fft;

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
 
 
 
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

  
% if  frame_syn(k1)>250 %֡ͬ����ֵѡ��, ��������������Ҫѡ���С��ֵ.
%      if flag==0 
%          start_point=k1;
%          flag=1;
%      end
% end
% symbol_syn(k1)=0;
% %%%%%%%%��OFDMͬ����%%%%%%%%%%%%%%%%
%  %%%%%%%%%%%%%%%%%%%%%%%%%��ͬ������ͬ����%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%         if (k1>=syn_point+257) && (k1<=syn_point+1716+256)  % �������ݣ�����cp,frame_syn(k1)>0.4
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
%  %fft_data=data(syn_point+1619:syn_point+3334); % 2561~4276���������ݣ�����cp ,frame_syn(k1)>0.4
%  %m_rcv=data(syn_point+1363:syn_point+1618);%ʹ�õڶ���m���Ž����ŵ����ƣ�2305~2560,frame_syn(k1)>0.4
%  fft_data=data(syn_point+257:syn_point+1716+256); % 2561~4276���������ݣ�����cp ,frame_syn(k1)>0.2
%  m_rcv=data(syn_point+1:syn_point+256);%ʹ�õڶ���m���Ž����ŵ����ƣ�2305~2560,frame_syn(k1)>0.2
%  m_tx=0-p;
%  
%   %m_rcv_fft=fft(m_rcv,256);
%   [m_rcv_fft,exp1]=fft_ip_model(m_rcv,256,0) ;
%   m_tx_fft=fft(m_tx,256);
%   
%   h=m_rcv_fft./m_tx_fft;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end
    

