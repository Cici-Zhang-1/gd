clear;
close all;
% staining compare
addpath('MatlabCentral_ICIP2018');

if ispc
    seperator = '\';
elseif ismac
    seperator = '/';
elseif isunix
else
end

datadir = 'F:\GD\staining';
% Aqp4 = '3monthCortexWTAQP4.tif';
% C4 = '3monthCortexWTC4.tif';
MergesFolders = {'hdcortex10Mcolligen4aqp4_45'; 'hdcortex10Mcolligen4aqp4_46';
    'hdcortex10Mcolligen4aqp4_47'; 'hdstriatu10Mcolligen4aqp4_48';
    'hdstriatu10Mcolligen4aqp4_49'; 'hdstriatu10Mcolligen4aqp4_50';
    'hdstriatu10Mcolligen4aqp4_60'; 'wtcor10Mcolligen4aqp4_31';
    'wtcor10Mcolligen4aqp4_32'; 'wtcor10Mcolligen4aqp4_33';
    'wtstr10Mcolligen4aqp4_34'; 'wtstr10Mcolligen4aqp4_35';
    'wtstr10Mcolligen4aqp4_36'};
Merge = 'AQP4Colligen4.tif';
% Merges = {'3monthCortexHDMerge.tif'; '3monthCortexWTMerge.tif';
%     '3monthStriatumHDMerge.tif'; '3monthStriatumWTMerge.tif';
%     '6monthCortexHDMerge.tif'; '6monthCortexWTMerge.tif';
%     '6monthStriatumHDMerge.tif'; '6monthStriatumWTMerge.tif';};

MergesNum = size(MergesFolders, 1);

for i = 1:1:MergesNum
    tmp = imread(strjoin([datadir seperator MergesFolders(i, 1) seperator Merge], ''));
    MergeImg = tmp(:, :, 1:3);
    
    RedImg = MergeImg;
    
    RedImg(:, :, 2) = 0;
    
    GreenImg = MergeImg;
    
    GreenImg(:, :, 1) = 0;
    
    imwrite(GreenImg,strjoin([datadir seperator MergesFolders(i, 1) seperator 'g_' Merge], ''));
    imwrite(RedImg,strjoin([datadir seperator MergesFolders(i, 1) seperator 'r_' Merge], ''));
end

