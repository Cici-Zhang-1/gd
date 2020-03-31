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

datadir = 'F:\GD';
% Aqp4 = '3monthCortexWTAQP4.tif';
% C4 = '3monthCortexWTC4.tif';
Merges = {'3monthCortexHDMerge.tif'; '3monthCortexWTMerge.tif';
    '3monthStriatumHDMerge.tif'; '3monthStriatumWTMerge.tif';
    '6monthCortexHDMerge.tif'; '6monthCortexWTMerge.tif';
    '6monthStriatumHDMerge.tif'; '6monthStriatumWTMerge.tif';};
C = cell(1, 2);
C(1, 1) = {'string'};
C(1, 2) = {'double'};
Results = table('Size', [size(Merges, 1) 2], 'VariableTypes', C);
% Merge = '3monthStriatumWTMerge.tif';
% 
% tmp = imread([datadir seperator Aqp4]);
% Aqp4Img = tmp(:, :, 1:3);
% tmp = imread([datadir seperator C4]);
% C4Img = tmp(:, :, 1:3);
MergesNum = size(Merges, 1);
figure;
for i = 1:1:MergesNum
    tmp = imread(strjoin([datadir seperator Merges(i, 1)], ''));
    MergeImg = tmp(:, :, 1:3);
    MergeImg = staining_img(MergeImg, 60);
%     MergeImg = MergeImg .* uint8(removeImageNoise(MergeImg));
    
    width = size(MergeImg, 1);
    Height = size(MergeImg, 2);
    
    t = 0;
    for j= 1:1:width
        for k = 1:1:Height
            if MergeImg(j, k, 1) > 0 && MergeImg(j, k, 2) > 0 %&& abs(MergeImg(j, k, 1)- MergeImg(j, k, 2)) < 1
                t = t+1;
            end
        end
    end
    [red p] = size(find(MergeImg(:, :, 1) >0));
    radio = t/red;
    Results(i, 1) = Merges(i, 1);
    Results(i, 2) = {radio};
    
    subplot(2,MergesNum/2,i)
    imshow(MergeImg);
end

writetable(Results, [datadir seperator 'results.xlsx'], 'Sheet', 'Results');



% figure;
% subplot(1,3,1)
% imshow(Aqp4Img);
% subplot(1,3,2)
% imshow(C4Img);
% subplot(1,3,3)
% imshow(MergeImg);

