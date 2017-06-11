% Compute the objective function

T;  % number of targets ( the taget of interest, e.g. ID = 0)

% for ii = 1 (ii = 1:(T-1)) % interation of the first training target

cur_train;

% for jj = 1 (jj = 1:)    % current frame, current training target, find other targets in the same frame

% at time = 0
fr_gap = dres.fr(2:T) - dres.fr(1:(T-1));
fr_gap = double(fr_gap);

v_train = (dres.pos(2:T,:) - dres.pos(1:(T-1),:))./[fr_gap fr_gap]; % [num 2]; num = T-1

% for the first interact target

a = unique(sort(dres.id(ind_train)));

for jj = 1:length(a)
    if a(jj) ~= ID
        pi = dres.pos(cur_train,:);
        