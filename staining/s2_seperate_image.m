clear;
close all;
% seperate image into grean and red

[seperator, datadir, Merge] = get_dir();

load ValidFolders.mat
MergesFolders = ValidFolders;

MergesNum = size(MergesFolders, 1);

for i = 1:1:MergesNum
    tmp = imread([datadir seperator MergesFolders(i).name seperator Merge]);
    MergeImg = tmp(:, :, 1:3);

    RedImg = MergeImg;

    RedImg(:, :, 2:3) = 0;

    GreenImg = MergeImg;

    GreenImg(:, :, 1) = 0;
    GreenImg(:, :, 3) = 0;

    imwrite(GreenImg, [datadir seperator MergesFolders(i).name seperator 'g_' Merge]);
    imwrite(RedImg, [datadir seperator MergesFolders(i).name seperator 'r_' Merge]);
end

