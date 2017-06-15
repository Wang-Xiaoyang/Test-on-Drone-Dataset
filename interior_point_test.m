clc;

fun = @(x)3*x(1)^2 + 2*x(1)*x(2) + x(2)^2 - 4*x(1) + 5*x(2);

x0 = [1,1];
[x,fval] = fminunc(fun,x0);

x

tol = 1e-10;
mu = 10;

t = 200;

options = optimoptions('fminunc','Display','iter','Algorithm','quasi-newton','FunctionTolerance',1e-2);

while 1/t >= tol
    
%     f = @(x)objFun(x,t,dres,id_selected,v_train,ind_train,ID,T);
    
    [x,fval] = fminunc(fun,x0,options);
    
    x0 = x;
    
    t = mu * t;
    
    ii = ii+1;
end

x