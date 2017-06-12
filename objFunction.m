% Compute the objective function
% For test

generate_training_data;
velocity_ID;

% sigma_w = 2.088;
% sigma_d = 0.361;
% beta = 1.462;

x = [50,20,2];

for kk = 2:(T-1)
    cur_ind = id_selected(kk);   % index of current learning target in the ground truth
    % current frame number
    cur_fr = dres.fr(cur_ind);
    pi = dres.pos(cur_ind,:);
    cur_vDesire = v_train(cur_ind,:);
    
    vi = v_train(cur_ind-1,:);
    
    % search all the target (regard of the ID and frame)
    E_temp = zeros(1);
    
    for ii = 2:length(ind_train)
        % for ii = length(ind_train)
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
        
        %x(1): radius of interest
        k_ij = pi - pj;
        norm_value = norm(k_ij,'fro');
        w_rd = exp(-norm_value^2 / (2 * x(1)^2));   % current distance weight
        w_angle = ((1 + cos_phi) / 2)^x(3);    % angular displacement weight
        
        w_r = w_rd * w_angle;   % energy weight
        
        % interation energy
        q_ij = cur_vDesire - vj;
        dis = k_ij - sum(k_ij .* q_ij) * q_ij / (norm(q_ij)^2 + eps); % q_ij'  ???
        d_ij = (norm(dis))^2;
        
        E_ij = exp(-(d_ij^2) / (2 * x(2)^2));
        
        
        E_temp = E_temp + E_ij;
        
        %     if E_ij ~= 0
        %         disp(['E_ij = ', num2str(E_ij)]);
        %         disp(['E = ', num2str(E)]);
        %     end
        
    end
    
    E(kk) = E_temp;
    
end


sigma_w = x(1)
sigma_d = x(2)
beta = x(3)
