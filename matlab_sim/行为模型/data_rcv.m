function [valid_data_rcv,rt_r_vec,rt_j_vec]=data_rcv(data,h,payload_num,m_rcv_fft,fft_point,first_carrier_id,last_carrier_id,cp_num)
    [N,M]=size(data);
    valid_data_rcv=[];
    pre_symbol=conj(m_rcv_fft);
    rt_r_vec=[];
    rt_j_vec=[];
    for k1=1:payload_num
          data_per_symbol=data(cp_num+1+(k1-1)*(fft_point+cp_num):k1*(fft_point+cp_num));
          
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

       data_fft=fft(data_per_symbol,fft_point);
       % data_fft=fft_ip_model(data_per_symbol,fft_point,0) ;
       rt_r=real(pre_symbol.*data_fft);
       rt_j=imag(pre_symbol.*data_fft);
       
      %%%%%dpsk解调%%%%%%%%%%%%%%%%%%%%%%%%%%%
      for k=first_carrier_id:last_carrier_id
          if  rt_r(k)>0 
               valid_data_rcv_t(k-first_carrier_id+1)=0;
          else
               valid_data_rcv_t(k-first_carrier_id+1)=1;
          end 
      end
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pre_symbol=conj(data_fft);
        valid_data_rcv=[valid_data_rcv valid_data_rcv_t];
        rt_r_vec=[rt_r_vec rt_r];
        rt_j_vec=[rt_j_vec rt_j];
    end  
     
end
       
    
    
    
    