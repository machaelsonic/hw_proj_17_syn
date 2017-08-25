function [load_data,valid_data,valid_data_map,pre_phase_next]=data_gen(pre_phase,data)
 %data=rand(1,36);%产生随机数据
 %data=ones(1,36);

for k=1:36 
    if data(k)>0.5 
       data(k)=1; 
    else
       data(k)=0;  
    end
end
for k=1:36
   %valid_data(k)=data(37-k);%待发送的有效数据,0或者1,为了与modelsim仿真结果比较,高低位互换,使最小编号的子载波传送最高位
   valid_data(k)=data(k);
end
%valid_data_map=bpsk_map(valid_data);% bpsk调制方式
[valid_data_map,pre_phase_next]=dpsk_map(valid_data,pre_phase);% dpsk调制方式
 
 load_data=zeros(1,256); 

for k=34:69
     load_data(k)=valid_data_map(k-33);%在有效子载波上装载调制后的待发送数据,34传送高位,
end


end