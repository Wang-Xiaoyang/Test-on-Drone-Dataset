% solve the probelm with interior point method (barrier method)

clear all;

% set parameter
tol = 1e-6;
mu = 1.2;   % increase factor of t
t_0 = 0.5;  % initialize of t

% initialize of x
x0 = [2,0.3,1];

% iteration
while 1/t >= tol
    
    X = fminunc(@objFun,x0);
    
    x0 = X;
    
    t = mu * t;
    
end