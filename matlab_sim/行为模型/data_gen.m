function [load_data,valid_data]=data_gen
  data=rand(1,36);%�����������

for k=1:36 
    if data(k)>0.5 
       data(k)=1; 
    else
       data(k)=0;  
    end
end
valid_data=data;%�����͵���Ч����,0����1

valid_data_map=bpsk_map(valid_data);

 load_data=zeros(1,256); 

for k=34:69
     load_data(k)=valid_data_map(k-33);%����Ч���ز���װ�ص��ƺ�Ĵ���������
end


end