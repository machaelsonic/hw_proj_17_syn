function [load_data,valid_data,pre_phase_next]=data_gen(pre_phase)
 data=rand(1,36);%产生随机数据
  %data=zeros(1,36);
for k=1:36 
    if data(k)>0.5 
       data(k)=1; 
    else
       data(k)=0;  
    end
end
valid_data=data;%待发送的有效数据,0或者1

%valid_data_map=bpsk_map(valid_data);% bpsk调制方式
[valid_data_map,pre_phase_next]=dpsk_map(valid_data,pre_phase);% dpsk调制方式

 load_data=zeros(1,256); 

for k=34:69
     load_data(k)=valid_data_map(k-33);%在有效子载波上装载调制后的待发送数据
end


end