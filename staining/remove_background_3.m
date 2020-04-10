clear;
close all;
% remove background by remove the avg value
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

MergesFolders = dir(datadir);
MergesFolder = 'hdcortex10Mcolligen4aqp4_45';
Merge = 'Colligen4AQP4.tif';
type = 'g_';
thred = 20;

MergesNum = size(MergesFolders, 1);

for i = 1:1:MergesNum
    tmp = imread([datadir seperator MergesFolders(i).name seperator type Merge]);
    MergeImg = tmp(:, :, 1:3);

    figure;
    subplot(2, 2, 1);
    imshow(MergeImg);
    avg = mean2(nonzeros(MergeImg));
    sigma = std2(nonzeros(MergeImg));
    MergeImg(MergeImg < avg * 2) = 0;
    disp(avg);
    disp(sigma);
    subplot(2, 2, 2);
    imshow(MergeImg);

    prompt1= ['Save the image?' MergesFolders(i).name '\n'];
    save_or_not = input(prompt1);  %%%%%%%%%%%%%%%%
    if save_or_not
        disp('saved');
        imwrite(MergeImg,[datadir seperator MergesFolders(i).name seperator 'r_' type Merge]);
    end
end

