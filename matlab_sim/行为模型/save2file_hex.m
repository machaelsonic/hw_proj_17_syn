function save2file_binvec2hex(filepath, var)
    fid = fopen(filepath,'w');

    for i = 1:4:length(var)
        tmp = var[i:i+3];
        fprintf(fid,'%s',dec2hex(tmp(1)*8+tmp(2)*4+tmp(3)*2+tmp(4)));
    end
    fclose(fid);
        