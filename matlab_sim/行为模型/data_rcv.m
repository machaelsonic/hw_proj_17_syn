function valid_data_rcv=data_rcv(data,h,payload_num,m_rcv_fft)
    [N,M]=size(data);
    valid_data_rcv=[];
    pre_symbol=conj(m_rcv_fft);
    
    for k1=1:payload_num
          data_per_symbol=data(31+(k1-1)*286:k1*286);
          
          %data_fft_r=real(fft(data_per_symbol,256)./h);% 使用信道估计估计算法
          %data_fft_r=real(fft(data_per_symbol,256));%无信道估计算法
        
      %%%%%bpsk解调%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       for k=34:69
%           if  data_fft_r(k)>0 
%                valid_data_rcv_t(k-33)=0;
%           else
%                valid_data_rcv_t(k-33)=1;
%           end 
%       end
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
       data_fft=fft(data_per_symbol,256);
       rt_r=real(pre_symbol.*data_fft);
      %%%%%dpsk解调%%%%%%%%%%%%%%%%%%%%%%%%%%%
      for k=34:69
          if  rt_r(k)>0 
               valid_data_rcv_t(k-33)=0;
          else
               valid_data_rcv_t(k-33)=1;
          end 
      end
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       pre_symbol=conj(data_fft);
        valid_data_rcv=[valid_data_rcv valid_data_rcv_t];
    end   
end
       
    
    
    
    