% x = [a b c];
clear all;
generate_training_data;
velocity_ID;

t = 0.5;
E = zeros(1);

a = 0.1:0.5:50;
b = 0.1:0.5:50;

c = 1.01;

ii = 1;
jj = 1;

for a = 0.1:0.5:50
    for b = 0.1:0.5:50
        x = [a b c];
        [F,Es] = objFun(x,t,dres,id_selected,v_train,ind_train,ID,T,E);
        F_value(ii,jj) = F;
        Es_value(ii,jj) = Es;
        ii = ii+1;
        jj = jj+1;
    end
end

mesh(F_value);
figure;
mesh(Es_value)