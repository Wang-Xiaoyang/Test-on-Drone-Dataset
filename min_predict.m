
function errorTerm = min_predict(x,T,id_selected,dres,ind_train,ID)
Error = 0;

v0 = [0.5,0.5];
for kk = 2:T-1;  % (2:T-1)
    
    options = optimoptions('fminunc','Algorithm','quasi-newton','FunctionTolerance',1e-6);
    % compute the desired velocity at current time
    E = @(v)Energ_collision(v,kk,x,id_selected,dres,ind_train,ID);
    [v,fval] = fminunc(E,v0,options);
    
    % for current t
    % find the current index of interest target
    cur_ind = id_selected(kk);
    
    % which frame, current position
    pi = dres.pos(cur_ind,:);
    
    p_estimated = pi + v;
    p_real = dres.pos(cur_ind+1,:);
    
    error_temp = norm((p_estimated - p_real))^2;
    
    Error = Error + error_temp;
    
    errorTerm = Error;
    
    if rem(T-1,kk) == 0
        disp(['kk = ',num2str(kk)]);
    end
end
end