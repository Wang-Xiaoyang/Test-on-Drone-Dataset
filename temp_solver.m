% solve the probelm with interior point method (barrier method)
% clear all;

generate_training_data;
velocity_ID;

% set parameter
tol = 1e8;
mu = 10;   % increase factor of t
% t_0 = 2;  % initialize of t

% initialize of x
x0 = [50,150,1];

t = 50;

options = optimoptions('fminunc','Display','iter','Algorithm','quasi-newton','FunctionTolerance',1e-4);

% E = zeros(1,T);
ii = 0;

% iteration
tic
% while 1/t >= tol
    
for ii = 1:5
    f = @(x)objFun(x,t,dres,id_selected,v_train,ind_train,ID,T);
    
    [x,fval,exitflag,output] = fminunc(f,x0,options);
    
    exitflag
    
    x0 = x;
    
    t = mu * t
    

end
toc

1/t
ii
x
fval