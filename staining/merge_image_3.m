clear;
close all;
% staining compare
% addpath('MatlabCentral_ICIP2018');

if ispc
    seperator = '\';
    datadir = 'F:\GD\staining';
elseif ismac
    seperator = '/';
    datadir = '/Users/chuangchuangzhang/Documents/Data/HSdata/Test';
elseif isunix
else
end
% Aqp4 = '3monthCortexWTAQP4.tif';
% C4 = '3monthCortexWTC4.tif';
MergesFolders = dir(datadir);

excepts = {'.'; '..'; '.DS_Store'; 'ivaso'; 'results.xlsx'; 'results3.xlsx'};

Merge = 'Colligen4AQP4.tif';

MergesNum = size(MergesFolders, 1);

for i = 1:1:MergesNum
    if ~isempty(find(ismember(excepts, MergesFolders(i).name) == 1, 1)) || ~MergesFolders(i).isdir
        continue;
    end
    
    RedImg = imread([datadir seperator MergesFolders(i).name seperator 'r_r_' Merge]);
    GreenImg = imread([datadir seperator MergesFolders(i).name seperator 'r_g_' Merge]);
    
    [Height, Width, s] = size(RedImg);
    MergeImg = zeros(Height, Width, 3);
    MergeImg(:, :, 1) = RedImg(:, :, 1);
    MergeImg(:, :, 2) = GreenImg(:, :, 2);
    
    imwrite(MergeImg,[datadir seperator MergesFolders(i).name seperator 'm_' Merge]);
end

