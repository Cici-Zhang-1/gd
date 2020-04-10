clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;

[seperator, datadir] = get_dir();
VesselFolders = dir(datadir);
excepts = {'.'; '..'; '.DS_Store';};

Vessel = 'Colligen4AQP4.tif';
VesselNum = size(VesselFolders, 1);
ValidFoldersNum = 1;

for i = 1:1:VesselNum
    if ~isempty(find(ismember(excepts, VesselFolders(i).name) == 1, 1)) || ~VesselFolders(i).isdir
        continue;
    end
    
    if exist([datadir seperator VesselFolders(i).name seperator Vessel], 'file')
        ValidFolders(ValidFoldersNum, 1).name = VesselFolders(i).name;
        ValidFolders(ValidFoldersNum, 1).folder = VesselFolders(i).folder;
        ValidFoldersNum = ValidFoldersNum + 1;
    else
        disp(VesselFolders(i).name);
    end
    
end
% 
% VesselFolders = ValidFolders;
save('ValidFolders.mat', 'ValidFolders');
    

