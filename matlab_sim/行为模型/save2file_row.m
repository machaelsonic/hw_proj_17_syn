function save2file_row(filepath, var)
    fid = fopen(filepath,'w');
    fprintf(fid,'%d',var);
    fclose(fid);
end