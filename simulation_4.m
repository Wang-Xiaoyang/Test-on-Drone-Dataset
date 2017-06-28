clc;

x = [5 3 1];
% simulate four targets
p = [2 2;
    -1 -1;
    5 4;
    3 1;
    7 2;
    -3 -4;
    2*randn(4,2)];

% p = randn(7,2);

% v = rand(7,2)*3;
% 
v = [0 2;
    1 1;
    2 2;
    0 1;
    1 0.5;
    -1 0;
    0 2;
    randn(3,2)];

kk = 1;

pi = p(kk,:);
cur_vDesire = v(kk,:);

vi = v(kk,:);

% to compute curren Ess (interaction energy), search all the target (regard of the ID and frame)
E_temp = 0;

for ii = 2:length(p)
    
   
    % compute pj
    pj = p(ii,:);
    vj = v(ii,:);
    
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
    
    W(ii) = Weight;
    
%     if Weight ~= 0
        q_ij = cur_vDesire - vj;
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
    
    E(ii) = Ess;
    E_temp(ii) = E_ij;
    dis_ii(ii) = dis;
    cur_dist(ii) = norm(p_ij).^2; 
    ratio_t(ii) = ratio;
%     E_temp = E_temp + Ess;
end

% E(kk) = E_temp;
E
W

quiver(p(:,1),p(:,2),v(:,1),v(:,2)); hold on
scatter(p(:,1),p(:,2)); grid on

for jj = 1:length(p)
text(p(jj,1),p(jj,2),[' ',' ',' ',num2str(jj)]);
end

find(W ~= 0)
find(E ~= 0)

-ratio_t