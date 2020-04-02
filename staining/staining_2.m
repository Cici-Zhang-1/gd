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

load ValidFolders.mat
MergesFolders = ValidFolders;

C = cell(1, 2);
C(1, 1) = {'string'};
C(1, 2) = {'double'};
Results = table('Size', [size(MergesFolders, 2) 2], 'VariableTypes', C);
Merge = 'Colligen4AQP4.tif';

MergesNum = size(MergesFolders, 2);
figure;
for i = 1:1:MergesNum
    GreenImg = imread([datadir seperator MergesFolders(i).name seperator 'r_g_' Merge]);
    RedImg = imread([datadir seperator MergesFolders(i).name seperator 'r_r_' Merge]);
    
    [width, Height] = size(GreenImg);
    
    t = 0;
    for j= 1:1:width
        for k = 1:1:Height
            if GreenImg(j, k) > 0 && RedImg(j, k) > 0 %&& abs(MergeImg(j, k, 1)- MergeImg(j, k, 2)) < 1
                t = t+1;
            end
        end
    end
    [red p] = size(find(RedImg(:, :, 1) >0));
    radio = t/red;
    Results(i, 1) = { MergesFolders(i).name };
    Results(i, 2) = {radio};
    
%     subplot(2,MergesNum/2,i)
%     imshow(MergeImg);
end

writetable(Results, [datadir seperator 'results.xlsx'], 'Sheet', 'Results');



% figure;
% subplot(1,3,1)
% imshow(Aqp4Img);
% subplot(1,3,2)
% imshow(C4Img);
% subplot(1,3,3)
% imshow(MergeImg);

