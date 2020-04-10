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

load ValidFolders.mat
MergesFolders = ValidFolders;
Merge = 'Colligen4AQP4.tif';

MergesNum = size(MergesFolders, 1);

for i = 1:1:MergesNum
    RedImg = imread([datadir seperator MergesFolders(i).name seperator 'r_r_' Merge]);
    GreenImg = imread([datadir seperator MergesFolders(i).name seperator 'r_g_' Merge]);
    
    [Height, Width, s] = size(RedImg);
    MergeImg = zeros(Height, Width, 3);
    MergeImg(:, :, 1) = RedImg(:, :, 1);
    MergeImg(:, :, 2) = GreenImg(:, :, 2);
    
    imwrite(MergeImg,[datadir seperator MergesFolders(i).name seperator 'm_' Merge]);
end

