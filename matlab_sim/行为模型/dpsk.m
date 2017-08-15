

data=zeros(1,256);
data_fft=fft(data,256);

data_fft_r=real(data_fft);
data_fft_i=imag(data_fft);

for k=1:256
    

