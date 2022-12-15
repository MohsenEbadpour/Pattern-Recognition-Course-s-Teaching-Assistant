% This is a simple script that will let the user make a new dataset
%  for binary problems only
%
% The dataset is a set of 2D points with a label, each. 
%   D = [X Y L] vertical vectors


% set up the figure first.  It will be a square with axes -100:100

h = figure;
a = axes;

set(a,'XLim',[-100,100]);
set(a,'YLim',[-100,100]);
set(a,'XTick',[-100:50:100]);
set(a,'YTick',[-100:50:100]);
set(a,'XGrid','on');
set(a,'YGrid','on');

hold on;


disp('There will be two classes of points to acquire.');
Anum = input('How many points in the first class?');

A = ones(Anum,3);

for i=1:Anum
    [x,y] = ginput(1);
    A(i,:) = [x y -1];
    plot(x,y,'ro');
end


disp('Done with points in the first class.');
Bnum = input('How many points in the second class?');

B = ones(Bnum,3);

for i=1:Bnum
    [x,y] = ginput(1);
    B(i,:) = [x y 1];
    plot(x,y,'b+');
end


disp('Done with points in the class class.');

D = [A;B]