function F = simu2Fun(v_desire,p1,p2,v1,v2,x)



vi = v1;
pi = p1;

% compute pj
pj = p2;
vj = v2;

% vj = v_train(ind_temp-1,:);  % ind_temp-1 ?

p_ij = pi - pj;

% weight of distance
norm_k = norm(p_ij)^2;
temp_a = norm_k/(2*x(1)^2);     % note this formula; different in two papers
w_r = exp(-temp_a);

% weight of angle
cos_phi = -sum(vi .* p_ij)/ (norm(vi) * norm(p_ij) + eps);  % + eps?
if cos_phi < 0
    w_angle = 0;
else
    w_angle = ((1 + cos_phi) / 2)^x(3);
end

% total weight
Weight = w_r * w_angle;

%     if Weight ~= 0
q_ij = v_desire - vj;
term1 = sum(p_ij.*q_ij);
term2 = norm(q_ij)^2;
ratio = term1 / (term2 + eps);
dis_temp = p_ij - ratio * q_ij;
dis = norm(dis_temp)^2;
E_ij = exp(-dis/2/x(2)/x(2));

Ess = Weight * E_ij;
%     else
%         Ess = 0;
%     end
F = Ess;
%     E_temp = E_temp + Ess;
end