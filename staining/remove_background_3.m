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
excepts = {'.'; '..'; '.DS_Store'; 'ivaso'; 'results.xlsx'; 'hdstri6Mcolligen44_24';};

MergesFolder = 'hdcortex10Mcolligen4aqp4_45';

Merge = 'Colligen4AQP4.tif';

MergesNum = size(MergesFolders, 1);

type = 'g_';
thred = 20;

for i = 1:1:MergesNum
%     k = 1;
%     while k
%         prompt3 = 'Input the thred?\n';
%         thred = input(prompt3);
    if ~isempty(find(ismember(excepts, MergesFolders(i).name) == 1, 1)) || ~MergesFolders(i).isdir
        continue;
    end
    
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

