function [X1,Z1,c,syn_point,start_point,fft_window,fft_point,fft_data,h]=syn_self(data,p)
  [N,M]=size(data);
  T=256;
  Th_Z=1;
  Th_c=50;
  first_time=0;% 第一次达到接收门限值
  fft_point=0;
  for k=1:1:T
         if p(k)>0 
             p1(k)=1;
         else
             p1(k)=-1;
         end
  end
  g=zeros(1,T);
for k=1:T
    p2(k)=p1(T+1-k);
end

for k1=1:1:M
    for k=255:-1:1
        g(k+1)=g(k);
    end
        g(1)=data(k1);
    X1(k1)=0;
    Z1(k1)=0;
    for k=1:1:T
        X1(k1)=X1(k1)+g(k)*p2(k);
        f(k)=abs(g(k));
        Z1(k1)=Z1(k1)+f(k);
    end
    c(k1)=X1(k1)/(Z1(k1)/(T/2));
end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

 for k1=1:1:M   
   if (Z1(k1)>Th_Z) 
          if first_time==0
              first_time=1;
              k2=1;
              start_point=k1;   
              for k1=start_point:1:start_point+256
                 if  (c(k1)>Th_c)
                     output1(k2)=k1;%保存超过门限的序列号
                     output2(k2)=c(k1);%保存超过门限的序列值
                     k2=k2+1;
                 end 
              end
          end
   
          for k=1:1:k2-1
              if output2(k)~=0
                 if output2(k)==max(output2)  %判断序列值是否等于最大值
                      output3=k;%保存最大值对应的计数值
                 end
              else
                 output3=0;
              end
          end
  
         if output3~=0
             syn_point=output1(output3);%获得最大值对应的序列号,用来与理论同步点进行比较
         else
             syn_point=0;
         end 
         if k2>=2 
             piancha=syn_point-256;
         end
   end
 end
 
 for k1=1:1:M+1
         %if (k1>=syn_point+2207) && (k1<=syn_point+2462)
         if (k1>=syn_point+2305) && (k1<=syn_point+4020)  % 接收数据，包含cp
            fft_point=fft_point+1;
            fft_window(k1)=1;
        else
            fft_window(k1)=0; 
         end
 end
 
  
  %fft_data=data(syn_point+2207:syn_point+2462);
  
   fft_data=data(syn_point+2305:syn_point+4020); % 2561~4276，接收数据，包含cp
   
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%channel estimation%%%%%%%%%%%%%%%%
 % m_rcv=data(syn_point+1793:syn_point+2048);
  %m_rcv=data(syn_point+2305:syn_point+2560);
  
  m_rcv=data(syn_point+1363:syn_point+2304);%使用第二个m符号进行信道估计，2305~2560
  m_tx=0-p;
  m_rcv_fft=fft(m_rcv,T);
  m_tx_fft=fft(m_tx,T);
  
  h=m_rcv_fft./m_tx_fft;
  figure(4)
  plot(abs(m_rcv_fft));
  %plot(abs(fft(fft_data)));
  

end  
