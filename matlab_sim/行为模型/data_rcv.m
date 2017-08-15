function valid_data_rcv=data_rcv(data,h,payload_num)
    [N,M]=size(data);
    valid_data_rcv=[];
    for k1=1:payload_num
         data_per_symbol=data(31+(k1-1)*286:k1*286);
         
          data_fft_r=real(fft(data_per_symbol,256)./h);
         %    data_fft_r=real(fft(data_per_symbol,256));
      for k=34:69
          if  data_fft_r(k)>0 
               valid_data_rcv_t(k-33)=0;
          else
               valid_data_rcv_t(k-33)=1;
          end 
      end
        valid_data_rcv=[valid_data_rcv valid_data_rcv_t];
    end   
end
       
    
    
    
    