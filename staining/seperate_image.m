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
end

