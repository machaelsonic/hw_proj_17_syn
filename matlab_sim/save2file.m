function save2file(filepath, data_array)
% save a one-dimension data vector to disk
if size(data_array,1) ~= 1 && size(data_array,2) ~= 1
    error('data_array must be one-dimenstion!');
end

f = fopen(filepath, 'w');
for i = 1:1:length(data_array)
    fprintf(f,'%d\n',data_array(i));
end
fclose(f);

end
