function save2file(filepath, var)
    fid = fopen(filepath,'w');
    fprintf(fid,'%d\n',var);
    fclose(fid);
end