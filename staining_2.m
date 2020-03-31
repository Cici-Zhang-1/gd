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

MergesFolders = {'hdcortex10Mcolligen4aqp4_45'; 'hdcortex10Mcolligen4aqp4_46';
    'hdcortex10Mcolligen4aqp4_47'; 'hdstriatu10Mcolligen4aqp4_48';
    'hdstriatu10Mcolligen4aqp4_49'; 'hdstriatu10Mcolligen4aqp4_50';
    'hdstriatu10Mcolligen4aqp4_60'; 'wtcor10Mcolligen4aqp4_31';
    'wtcor10Mcolligen4aqp4_32'; 'wtcor10Mcolligen4aqp4_33';
    'wtstr10Mcolligen4aqp4_34'; 'wtstr10Mcolligen4aqp4_35';
    'wtstr10Mcolligen4aqp4_36'};

C = cell(1, 2);
C(1, 1) = {'string'};
C(1, 2) = {'double'};
Results = table('Size', [size(MergesFolders, 1) 2], 'VariableTypes', C);
Merge = 'AQP4Colligen4.tif';

MergesNum = size(MergesFolders, 1);
figure;
for i = 1:1:MergesNum
    GreenImg = imread(strjoin([datadir seperator MergesFolders(i, 1) seperator 'r_g_' Merge], ''));
    RedImg = imread(strjoin([datadir seperator MergesFolders(i, 1) seperator 'r_r_' Merge], ''));
    
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
    Results(i, 1) = MergesFolders(i, 1);
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

