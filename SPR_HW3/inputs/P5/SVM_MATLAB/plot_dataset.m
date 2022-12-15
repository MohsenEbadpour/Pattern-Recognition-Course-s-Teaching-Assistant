function h = plot_dataset(D)

% function plot_dataset(D)
%
%  Creates a figure and plots the dataset in D


h = figure;
a = axes;

set(a,'XLim',[-100,100]);
set(a,'YLim',[-100,100]);
set(a,'XTick',[-100:50:100]);
set(a,'YTick',[-100:50:100]);
set(a,'XGrid','on');
set(a,'YGrid','on');

hold on;

n = size(D,1);

for i=1:n
    
    if (D(i,3) == -1)
        plot(D(i,1),D(i,2),'ro');
    else
        plot(D(i,1),D(i,2),'b+');
    end
    
end
