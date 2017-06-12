% generate training data


% % Compute the position and velocity of all targets in each frame
% num = length(dres.id);
% 
% uni_id = unique(dres.id);
% 
% % for ii = 1:num
% %     pos(dres.id(ii)+1, dres.fr(ii)) = (dres.lt(ii) + dres.rb(ii))./2;
% % end

filename = 'C:\Datasets\stanford_campus_dataset\annotations\bookstore\video0\annotations.txt';
dres = read_drone2dres(filename);

% Take ID 0 for example:

ID = 0;

id_selected = find(dres.id == ID);

T = length(id_selected)/3;
T = round(T);

fr = dres.fr(1:T);  % frame index of the chosen target with ID = 0

fr_train = [];
for ii = 1:length(fr)
    foi = find(dres.fr == fr(ii));  % find the frame of interest
    fr_train = [fr_train;foi];
end

ind_train = sort(fr_train); % get the index (row index in the ground truth file) of training data

