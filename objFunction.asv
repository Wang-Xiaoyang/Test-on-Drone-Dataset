% Compute the objective function
% For test
clear variables;

t = 2;

% get training targets and corresponding index in GT
generate_training_data;
% get the v_train (desired velocity in each time step; not current velocity)
velocity_ID_R;

sigma_w = 5;
sigma_d = 5;
beta = 1;

x = [sigma_w,sigma_d,beta];

E = zeros(1,T);

for kk = 1:(T-1)  % start from the second training target; for the first target, we don't know the current velocity
% for kk = 1
    cur_ind = id_selected(kk);   % index of current learning target in the ground truth
    
    if cur_ind == 1 % if cur_ind == 1, cur_ind -1 is an invalid index
        continue;
    else
        % current frame number
        cur_fr = dres.fr(cur_ind);
        pi = dres.pos(cur_ind,:);
        cur_vDesire = v_train(cur_ind,:);
        
        %     vi = v_train(cur_ind-1,:);
        % comupte vi from target position (to avoid confusion)
        if dres.id(cur_ind) == dres.id(cur_ind-1)   % if not, this target is the first target in this ID group; can not be used
            gap_temp = (dres.fr(cur_ind) - dres.fr(cur_ind-1));
            gap_temp = double(gap_temp);
            vi = (dres.pos(cur_ind,:) - dres.pos(cur_ind-1,:)) ./ [gap_temp,gap_temp];
        else
            continue
        end
        
        % to compute curren Ess (interaction energy), search all the target (regard of the ID and frame)
        E_temp = 0;
        
        for ii = 1:length(ind_train)
            
            ind_temp = ind_train(ii);   % current index of target in the ground truth
            if ind_temp == 1
                continue
            else
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
                if dres.id(ind_temp) == dres.id(ind_temp-1)
                    gap_temp = (dres.fr(ind_temp,:) - dres.fr(ind_temp-1,:));
                    gap_temp = double(gap_temp);
                    vj = (dres.pos(ind_temp,:) - dres.pos(ind_temp-1,:)) ./ [gap_temp,gap_temp];
                else    % if else, then we don't know vj, so quit this loop
                    continue
                end
                
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
                
                if Weight ~= 0
                    q_ij = cur_vDesire - vj;
                    term1 = sum(p_ij.*q_ij);
                    term2 = norm(q_ij)^2;
                    ratio = term1 / (term2 + eps);
                    dis_temp = p_ij - ratio * q_ij;
                    dis = norm(dis_temp)^2;
                    E_ij = exp(-dis/2/x(2)/x(2));
                    
                    Ess = Weight * E_ij;
                else
                    Ess = 0;
                end
                
%                 if isnan(Ess)
%                     ii
%                     break;
%                 end
                
                E_temp = E_temp + Ess;
            end
        end
    end
    
    E(kk) = E_temp;
end

F = t*sum(E) - log(x(2)-4.149) - log(x(1))

sum(E)
% sigma_w = x(1)
% sigma_d = x(2)
% beta = x(3)
