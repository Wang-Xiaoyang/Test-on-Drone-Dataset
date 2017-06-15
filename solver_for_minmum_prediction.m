% solve minimun prediction error

clear variables;

generate_training_data;
velocity_ID;

% set parameter
tol = 1e-3;
mu = 10;   % increase factor of t
% t_0 = 2;  % initialize of t

% initialize of x
x0 = [100,20,1];

t = 10;

options = optimoptions('fminunc','Display','iter','Algorithm','quasi-newton','FunctionTolerance',1e-10);

% E = zeros(1,T);

% iteration
tic
% while 1/t >= tol

errorTerm = @(x)min_predict(x,T,id_selected,dres,ind_train,ID);

[x,fval,exitflag,output] = fminunc(errorTerm,x0,options);

exitflag

%     x0 = x;
%
%     t = mu * t
%
%     ii = ii+1;

toc


x
fval