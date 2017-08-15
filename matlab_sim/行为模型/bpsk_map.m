function x=bpsk_map(y)
 [N,M]=size(y);
  for k=1:M
  if y(k)==0 
      x(k)=1+j*0;
  else
      x(k)=-1+j*0;
  end
  end
end