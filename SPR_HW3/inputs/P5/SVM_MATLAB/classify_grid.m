function  h = classify_grid(kernel_fnc,kernel_args,SV,alpha,b)

% function  h = classify_grid(kernel_fnc,kernel_args,SV,alpha,b)
%
% 
%  kernel_fnc and kernel_args specify the kernel (see svm_train.m)
%
%  SV is the matrix of support vectors (each row);
%  alpha is the vector of coefficients, one per sv.
%  b is the "offset"
%
%  (Assume grid is still -100:100 in both axes)


% the classification rule is essentially 
%  sgn(w'x+b)

h = figure;
a = axes;

set(a,'XLim',[-100,100]);
set(a,'YLim',[-100,100]);
set(a,'XTick',[-100:50:100]);
set(a,'YTick',[-100:50:100]);
set(a,'XGrid','on');
set(a,'YGrid','on');

hold on;

nSV = size(SV,1);

for y=-100:5:100
    for x = -100:5:100
        xy = [x;y];
        
        % e.g., direct linear case
        %v = -b - w'*xy;
        
        v=b;
        for j=1:nSV
            v = v + <<<FILL IN HERE>>>
        end
        
        if (v < 0)
            plot(x,y,'ro');
        else
            plot(x,y,'b+');
        end
    end
end

end

