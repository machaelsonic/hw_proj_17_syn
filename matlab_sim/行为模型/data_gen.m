function [load_data,valid_data,valid_data_map,pre_phase_next]=data_gen(pre_phase,data,carrier_num,fft_point,first_carrier_id,last_carrier_id)
 %data=rand(1,36);%�����������
 %data=ones(1,36);


for k=1:carrier_num 
    if data(k)>0.5 
       data(k)=1; 
    else
       data(k)=0;  
    end
end
for k=1:carrier_num
   %valid_data(k)=data(37-k);%�����͵���Ч����,0����1,Ϊ����modelsim�������Ƚ�,�ߵ�λ����,ʹ��С��ŵ����ز��������λ
   valid_data(k)=data(k);
end
%valid_data_map=bpsk_map(valid_data);% bpsk���Ʒ�ʽ
[valid_data_map,pre_phase_next]=dpsk_map(valid_data,pre_phase);% dpsk���Ʒ�ʽ
 

 load_data=zeros(1,fft_point); 

for k=first_carrier_id:last_carrier_id
     load_data(k)=valid_data_map(k-first_carrier_id+1);%����Ч���ز���װ�ص��ƺ�Ĵ���������,34���͸�λ,
end


end