function [SV,alpha,b] = trainsvm(D,C,kernel_fnc,kernel_args)
%
%
% function [SV,alpha,b] = trainsvm(D,C,kernel_fnc,kernel_args)
%
% Train an svm.
%  kernel_fnc is a handle to a kernel function (K(x,y,a)) where a
%  is the kernel_args array
%
%  SV is the support vector array (needed for evaluation)
%   each SV occupies one ROW of this array.
%
%  Using the dataset D (still assume 2D planar data and 2 classes)
%  Format x_1, x_2, y  per line
%
%  C is the slack cost -- the cost of misclassifying  training point in 
%   the non-separable case.  C = inf means separable case.


n = size(D,1);

Dy1 = D((D(:,3) == -1),:);
Dy2 = D((D(:,3) == +1),:);



% the quadprog function executes:
%   min_x 1/2  x'Hx + f'x
%   subject to:  Ax <= b,  Aeq.x = beq (equality constriants)
%                lb <= x <= ub
%
%   x = quadprog(H,f,A,b,Aeq,Beq,lb,ub,x0,options)


%  build H first
H = zeros(n,n);
for i=1:n
    
    xi = D(i,1:2);
    yi = D(i,3);
    
    for j=1:n
        
        xj = D(j,1:2);
        yj = D(j,3);
        
        H(i,j) = <<<FILL IN HERE>>>
        
    end
end
H = H+1e-10*eye(size(H));  % increases numerical stability of H

% f is just a vector of ones
f = -ones(n,1);

% there are no A and b constraints
A = [];
b = [];

% set the Aeq and beq constraints
Aeq = D(:,3)';
beq = 0;

% set the lower bound and leave the upperbound free
lb  = zeros(n,1);
%ub  = ones(n,1).*inf;  % inf is for the separable case
ub  = ones(n,1).*C;  % C is for the non-separable case; 
                     % C is the cost for misclassiyfing a training point

% no starting point
x0 = [];

% we need to tell the optimizer to use the medium scale version for this
% problem formulation
options = optimset('LargeScale','off');

[x,fval] = quadprog(<<<FILL IN HERE>>>)

tol = 1e-8;

% store the class information of the support vectors directly with the 
%  estimated coefficients x

% build the SV matrix
nSV = 0;
for i=1:n
    if x(i) > tol
        nSV = nSV + 1;
    end 
end
SV = zeros(nSV,2);
alpha = zeros(nSV,1);
alphaD = zeros(nSV,1);
nSV=1;
for i=1:n
   if x(i) > tol
       SV(nSV,:) = D(i,1:2);
       alpha(nSV) = x(i);
       alphaD(nSV) = x(i)*D(i,3);
       nSV = nSV + 1;
   end
end
nSV = size(SV,1);




% compute b
b = 0;
for i=1:nSV   % for each support vector get a rho value
    
    wtxi = 0;
    for j=1:nSV
       wtxi = wtxi + alphaD(j).*kernel_fnc(SV(i,:)',SV(j,:)',kernel_args);
    end

    thisb = ( alpha(i)-alphaD(i).*wtxi ) / alphaD(i)
    b = b + thisb;
    
end
b = b / nSV


% we don't need separated alpha(i) and D(i,3) anymore...
alpha = alphaD;



% plotting tools
%v = [-w(2);w(1)];   % direction of the decision boundary

% compute two points on the decision boundary at the edges of the graph.
%px1 = -100;
%py1 = (- b - w(1)*px1) / w(2);
%
%px2 = 100;
%py2 = (- b - w(1)*px2) / w(2);
%
h = plot_dataset(D);
%plot([px1;px2],[py1;py2],'k');

% specify the support vectors
for i=1:n
    if x(i) > tol
        plot(D(i,1),D(i,2),'ko','MarkerSize',10);
    end
end

hg = classify_grid(kernel_fnc,kernel_args,SV,alpha,b);





