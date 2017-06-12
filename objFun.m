% Objective function in Interior point method
function F = objFun(x)

generate_training_data;
velocity_ID;

t = 0.5;

% for traning target #1 (total number: T )
cur_ind = id_selected(2);   % index of current learning target in the ground truth
% current frame number
cur_fr = dres.fr(cur_ind);
pi = dres.pos(cur_ind,:);
cur_vDesire = v_train(cur_ind,:);

vi = v_train(cur_ind-1,:);

% search all the target (regard of the ID and frame)
E = zeros(1);

for ii = length(ind_train)
    ind_temp = ind_train(ii);   % current index in the ground truth
    % extract the information of current target
    fr_temp = dres.fr(ind_temp);
    id_temp = dres.id(ind_temp);
    % if the current target is not in the same frame with the learning method, quit current loop
    if fr_temp ~= cur_fr
        continue
    end
    
    % check if the id is different
    if id_temp == ID
        continue
    end
    
    % compute pj
    pj = dres.pos(ind_temp,:);
    % comupte vj: current_vj = current position of j minus last position of j

    vj = v_train(ind_temp-1,:);  % ind_temp-1 ?
    
    % angle
    cos_phi = sum(vi .* vj) / (norm(vi,'fro') * norm(vj,'fro'));
    if cos_phi < 0
        cos_phi = 0;
    end
    
    %sigma_w: radius of interest
    k_ij = pi - pj;
    norm_value = norm(k_ij,'fro');
    w_rd = exp(-norm_value^2 / (2 * sigma_w^2));   % current distance weight
    w_angle = ((1 + cos_phi) / 2)^beta;    % angular displacement weight
    
    w_r = w_rd * w_angle;   % energy weight
    
    % interation energy
    q_ij = cur_vDesire - vj;
    dis = k_ij - sum(k_ij .* q_ij) * q_ij / (norm(q_ij)^2 + eps); % q_ij'  ???
    d_ij = (norm(dis))^2;
    
    E_ij = exp(-(d_ij^2) / (2 * sigma_d^2));
    
    if E_ij ~= 0
        break
    end
    
    E = E + E_ij;
end


F = t*E - log(x(2)-0.1) - log(x(1));

end