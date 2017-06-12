% solve the probelm with interior point method (barrier method)
clear all;

generate_training_data;
velocity_ID;

% set parameter
tol = 1e-3;
mu = 1.5;   % increase factor of t
t_0 = 2;  % initialize of t

% initialize of x
x0 = [500,200,2];

t = 500;

options = optimoptions('fminunc','Algorithm','quasi-newton');

E = zeros(1,T);

% iteration
for ii = 1:50
    
    f = @(x)objFun(x,t,dres,id_selected,v_train,ind_train,ID,T,E);
    
    [x,fval] = fminunc(f,x0,options);
    
    
    t = 0.1*t;
    
    x0 = x;
    
    F_value(ii) = fval;
end

ii

x
fval

plot(1:ii,F_value)