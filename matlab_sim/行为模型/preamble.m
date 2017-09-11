function [output,p]=preamble(phase_data,fft_point,first_carrier_id,last_carrier_id) 

for k=1:fft_point
    x(k)=0+i*0;
end
for k=first_carrier_id:last_carrier_id
    x(k)=exp(i*phase_data(k)*pi/8);
end
ifft_x=ifft(x,fft_point);
p=real(ifft_x);

p=round(p*1023);%p符号量化为12位二进制数据,保留2位符号,10位有效数据
m=0-p;

output=[p p p p p p p p m m];
end