function [x,pre_phase_next]=dpsk_map(y,pre_phase)
 [N,M]=size(y);
%  M=33;%��ʼ���ز����
%  C=36;%ʹ�����ز�����
  for k=1:M
            if y(k)==0 
                x_phase(k)=pre_phase(k);
            else
                if pre_phase(k)>=8
                     x_phase(k)=pre_phase(k)-8;
                else
                     x_phase(k)=pre_phase(k)+8;
                end 
            end
          x(k)=exp(i*x_phase(k)*pi/8);  
   end
        pre_phase_next=x_phase;
        
%         x=zeros(1,256);
%         for k=M+1:1:M+C
%             x(k)=exp(i*x_phase(k-M)*pi/8);
%         end
end
        
    

