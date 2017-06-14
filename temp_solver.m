% solve the probelm with interior point method (barrier method)
% clear all;

generate_training_data;
velocity_ID;

% set parameter
tol = 1e-3;
mu = 10;   % increase factor of t
% t_0 = 2;  % initialize of t

% initialize of x
x0 = [5,5,1];

t = 2;

options = optimoptions('fminunc','Algorithm','quasi-newton');

% E = zeros(1,T);

% iteration
for ii = 1
    
    f = @(x)objFun(x,t,dres,id_selected,v_train,ind_train,ID,T);
    
    [x,fval] = fminunc(f,x0,options);
    
    x0 = x;
    
    if 1/t < tol
        break;
    end
    
    t = mu * t;
        
end

ii

x
fval