
%
% read Stanford Drone Dataset Annotation files
% --------------------------------------------------------
% Written by Xiaoyang
% --------------------------------------------------------

function dres = read_drone2dres(filename)

fid = fopen(filename, 'r');


% <track ID>, <xmin>, <ymin>, <xmax>, <ymax>, <frame>, < >, <occluded>, <generated>, <label>

C = textscan(fid, '%d %f %f %f %f %d %d %d %d %s', 'Delimiter', ',');

fclose(fid);

% build the dres structure for detections
dres.id = C{1};
% left top
dres.lt = [C{2}, C{3}];
% right bottom
dres.rb = [C{4}, C{5}];
% frame
dres.fr = C{6};
dres.lost = C{7};
dres.occl = C{8};
dres.gener = C{9};
dres.label = C{10};
dres.pos = [(C{2}+C{4})/2,(C{3}+C{5})/2];