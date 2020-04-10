clear;
close all;
% merge green and red image together

[seperator, datadir, Merge] = get_dir();

load ValidFolders.mat
MergesFolders = ValidFolders;

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

