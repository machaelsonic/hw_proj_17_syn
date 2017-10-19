function save2file_binvec2hex(filepath, var)
    % var每一行一个要写入的变量
    fid = fopen(filepath,'w');

%     var = reshape(var,4,floor(length(var)/4)).';
%     var = var(:,1)*8 + var(:,2)*4 + var(:,3)*2 + var(:,4)*1;
%     fprintf(fid,'%X',var);
    
    var = var(:,1:4:end)*8 + var(:,2:4:end)*4 + var(:,3:4:end)*2 + var(:,4:4:end)*1;

    for i = 1:1:size(var,1)
        fprintf(fid,'%X',var(i,:));
        fprintf(fid,'\n');
    end
    
    
%     for i = 1:4:length(var)
%         tmp = var(i:i+3);
%         fprintf(fid,'%s',dec2hex(tmp(1)*8+tmp(2)*4+tmp(3)*2+tmp(4)));
%     end
    fclose(fid);
        