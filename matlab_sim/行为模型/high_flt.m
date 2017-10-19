function sig_out = high_flt(sig)

alpha = 16;

sig_out = zeros(1,length(sig));
reg = 0;

alpha = 4;      % 阶数
point = 4;      % 小数位

for i = 1:1:length(sig)
    sig_out(i) = sig(i) - floor(reg/2^point);
    reg = floor(sig(i)*2^(point-alpha)) + reg - floor(reg/2^alpha);
end
