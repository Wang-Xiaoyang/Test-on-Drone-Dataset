% compute velocity for all the target with different ID


% % desired velocity at time t = position t - position t-1
% id_total = unique(dres.id);
% 
% % number of IDs (kind of targets) in the scene
% id_num = length(id_total);
% tbl = tabulate(dres.id);
% % first column: IDs; second column: existing number of each ID
% tbl = tbl(:,1:2);
% 
% for ii = 1:id_num
%     tbl_new(ii) = sum(tbl(1:ii,2));
% end
% 
% tbl_new = [0 tbl_new];
% % v_train = cell{id_num,}
% % for ii = 2:id_num
% v_past = [];
% for ii = 1:id_num
%     length_i = tbl_new(ii+1);
%     fr_gap = dres.fr(tbl_new(ii)+2:length_i) - dres.fr(tbl_new(ii)+1:(length_i-1));
%     fr_gap = double(fr_gap);
%     v_cur = (dres.pos(tbl_new(ii)+2:length_i,:) - dres.pos(tbl_new(ii)+1:(length_i-1),:)) ./ [fr_gap fr_gap]; % [num 2]; num = T-1
%     
%     % assume that in t = 0 and t = 1, the velocity remains unchanged
%     v_cur = [v_cur(1,:);v_cur];
% %     v_cur = [[0 0];v_cur];
%     
%     v_train = [v_past;v_cur];
%     v_past = v_train;
% 
% end

% desired velocity at time t (esitimate result) = position t+1 - position t
id_total = unique(dres.id);

% number of IDs (kind of targets) in the scene
id_num = length(id_total);
tbl = tabulate(dres.id);
% first column: IDs; second column: existing number of each ID
tbl = tbl(:,1:2);

for ii = 1:id_num
    tbl_new(ii) = sum(tbl(1:ii,2));
end

tbl_new = [0 tbl_new];
% v_train = cell{id_num,}
% for ii = 2:id_num
v_past = [];
for ii = 1:id_num
    length_i = tbl_new(ii+1);
    fr_gap = dres.fr(tbl_new(ii)+2:length_i) - dres.fr(tbl_new(ii)+1:(length_i-1));
    fr_gap = double(fr_gap);
    v_cur = (dres.pos(tbl_new(ii)+2:length_i,:) - dres.pos(tbl_new(ii)+1:(length_i-1),:)) ./ [fr_gap fr_gap]; % [num 2]; num = T-1
    
    % assume that in the last time step t, the speed remains the same with t-1
    v_last = v_cur(end,:);
    v_cur = [v_cur;v_last];
    
    v_train = [v_past;v_cur];
    v_past = v_train;

end
