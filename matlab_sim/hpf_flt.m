function sig_out = hpf_flt(sig_in)
sig_out = zeros(size(sig_in));
tmp3 = 0;
for i = 1:1:length(sig_in)
    tmp1 = sig_in(i);
    tmp4 = floor(tmp3/16);
    tmp6 = tmp1 - tmp4;
    tmp5 = tmp3 - tmp4;
    tmp2 = tmp1 + tmp5;
    tmp3 = tmp2;
    
    sig_out(i) = tmp6;
    
%     sig_out(i) = sig_in(i) - floor(reg/16);
%     reg = sig_in(i) + reg - floor(reg/16);
end