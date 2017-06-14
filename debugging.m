% debugging energy function
sigma_w = 5;
sigma_d = 2;
beta = 1;

x = [sigma_w, sigma_d, beta];


seq.id = [0;0;0;1;1;1;2;2;2];
seq.pos = [227 1055;
    225 1055;
    225 1055;
    1403 629.5;
    1401 628.5;
    1400 628.5;
    1256.5 54;
    1256.5 54;
    1256.5 54];

%% for id.i = 0, id.j = 1

p_ij = seq.pos(1,:) - seq.pos(4,:)
norm_k = norm(p_ij)^2

temp_a = norm_k/(2*sigma_w^2);

w_r = exp(-temp_a)

%% t = 1 (start form 0)
p_ij = seq.pos(2,:) - seq.pos(8,:)
norm_k = norm(p_ij)^2

temp_a = norm_k/(2*sigma_w^2);

w_r = exp(-temp_a)

% vi = current position - last position; should start from the second i
vi = seq.pos(2,:) - seq.pos(1,:);   

vj = seq.pos(8,:) - seq.pos(7,:);

cos_phi = -sum(vi .* p_ij)/ norm(vi) / norm(p_ij);

if cos_phi < 0
    w_angle = 0
else
       w_angle = ((1 + cos_phi) / 2)^x(3)
end

Weight = w_r * w_angle

% v_desire = next position - current position
vi_desire = v_train(2,:)

if Weight ~= 0
    q_ij = vi_desire - vj;
    term1 = sum(p_ij.*q_ij);
    term2 = norm(q_ij)^2;
    ratio = term1 / term2;
    dis_temp = p_ij - ratio * q_ij;
    dis = norm(dis_temp)^2;
    E_ij = exp(-dis/2/x(2)/x(2));
    E_temp = Weight * E_ij;
else
    E_temp = 0;
end