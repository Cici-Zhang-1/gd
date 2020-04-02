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
% MergesFolders = {'hdcortex10Mcolligen4aqp4_45'; 'hdcortex10Mcolligen4aqp4_46';
%     'hdcortex10Mcolligen4aqp4_47'; 'hdstriatu10Mcolligen4aqp4_48';
%     'hdstriatu10Mcolligen4aqp4_49'; 'hdstriatu10Mcolligen4aqp4_50';
%     'hdstriatu10Mcolligen4aqp4_60'; 'wtcor10Mcolligen4aqp4_31';
%     'wtcor10Mcolligen4aqp4_32'; 'wtcor10Mcolligen4aqp4_33';
%     'wtstr10Mcolligen4aqp4_34'; 'wtstr10Mcolligen4aqp4_35';
%     'wtstr10Mcolligen4aqp4_36'};
MergesFolders = dir(datadir);
excepts = {'.'; '..'; '.DS_Store'; 'ivaso'; 'results.xlsx'};
Merge = 'Colligen4AQP4.tif';
% Merges = {'3monthCortexHDMerge.tif'; '3monthCortexWTMerge.tif';
%     '3monthStriatumHDMerge.tif'; '3monthStriatumWTMerge.tif';
%     '6monthCortexHDMerge.tif'; '6monthCortexWTMerge.tif';
%     '6monthStriatumHDMerge.tif'; '6monthStriatumWTMerge.tif';};

MergesNum = size(MergesFolders, 1);
ValidFoldersNum = 1;

for i = 1:1:MergesNum
    if find(ismember(excepts, MergesFolders(i).name) == 1)
        continue;
    end
    ValidFolders(ValidFoldersNum).name = MergesFolders(i).name;
    ValidFoldersNum = ValidFoldersNum + 1;
    if exist([datadir seperator MergesFolders(i).name seperator Merge], 'file')
        tmp = imread([datadir seperator MergesFolders(i).name seperator Merge]);
        MergeImg = tmp(:, :, 1:3);

        RedImg = MergeImg;

        RedImg(:, :, 2) = 0;
        RedImg(:, :, 3) = 0;

        GreenImg = MergeImg;

        GreenImg(:, :, 1) = 0;
        GreenImg(:, :, 3) = 0;

        imwrite(GreenImg, [datadir seperator MergesFolders(i).name seperator 'g_' Merge]);
        imwrite(RedImg, [datadir seperator MergesFolders(i).name seperator 'r_' Merge]);
    else
        disp(MergesFolders(i).name);
    end
end
save('ValidFolders.mat', 'ValidFolders');

