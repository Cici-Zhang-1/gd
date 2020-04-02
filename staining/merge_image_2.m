clear;
close all;
% staining compare
% addpath('MatlabCentral_ICIP2018');

if ispc
    seperator = '\';
    datadir = 'F:\GD\staining';
elseif ismac
    seperator = '/';
    datadir = '/Users/chuangchuangzhang/Documents/Data/HSdata';
elseif isunix
else
end
% Aqp4 = '3monthCortexWTAQP4.tif';
% C4 = '3monthCortexWTC4.tif';
MergesFolders = dir(datadir);

excepts = {'.'; '..'; '.DS_Store'; 'ivaso'; 'results.xlsx'};

Merge = 'Colligen4AQP4.tif';

MergesNum = size(MergesFolders, 1);

for i = 1:1:MergesNum
    if find(ismember(excepts, MergesFolders(i).name) == 1)
        continue;
    end
    
    RedImg = imread([datadir seperator MergesFolders(i).name seperator 'r_r_' Merge]);
    GreenImg = imread([datadir seperator MergesFolders(i).name seperator 'r_g_' Merge]);
    
    [Height, Width] = size(RedImg);
    MergeImg = zeros(Height, Width, 3);
    for j = 1:1:Height
        for k = 1:1:Width
            if RedImg(j, k)
                MergeImg(j, k, 1) = 255;
            end
            if GreenImg(j, k)
                MergeImg(j, k, 2) = 255;
            end
        end
    end
    
    imwrite(MergeImg,[datadir seperator MergesFolders(i).name seperator 'm_' Merge]);
end

