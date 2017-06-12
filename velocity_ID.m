% compute velocity for all the target with different ID
id_total = unique(dres.id);

id_num = length(id_total);
tbl = tabulate(dres.id);
tbl = tbl(:,1:2);

for ii = 1:id_num
    tbl_new(ii) = sum(tbl(1:ii,2));
end

tbl_new = [0 tbl_new];
% v_train = cell{id_num,}
% for ii = 2:id_num
v_past = [];
for ii = 1:id_num
    T = tbl_new(ii+1);
    fr_gap = dres.fr(tbl_new(ii)+2:T) - dres.fr(tbl_new(ii)+1:(T-1));
    fr_gap = double(fr_gap);
    v_cur = (dres.pos(tbl_new(ii)+2:T,:) - dres.pos(tbl_new(ii)+1:(T-1),:)) ./ [fr_gap fr_gap]; % [num 2]; num = T-1
    
    v_cur = [v_cur;[0 0]];
    
    v_train = [v_past;v_cur];
    v_past = v_train;

end