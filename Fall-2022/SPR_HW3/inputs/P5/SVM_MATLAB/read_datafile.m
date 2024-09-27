function [ D ] = read_datafile( fname )

%function [ D ] = read_datafile( fname )
%   fname is the string to the filename
%   D is the loaded datafile

f = fopen(fname,'r');


n=0;
while (~feof(f))
    t = fgetl(f);
    n = n + 1;
end

fseek(f,0,'bof');

D = ones(n,3);

for i=1:n
    x = fscanf(f,'%g,%g,%d\n',[1,3]);
    D(i,:) = x;
end

fclose(f);


% function end
end

