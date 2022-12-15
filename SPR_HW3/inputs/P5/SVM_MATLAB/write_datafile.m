function write_dataset(D,fname)

% function write_dataset(D,fname)
%
% D is the dataset
% fname is the filename string


n = size(D,1);

f = fopen(fname,'w');


for i=1:n
   
    fprintf(f,'%g,%g,%d\n',D(i,:));
    
end


fclose(f);