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

MergesNum = size(MergesFolders, 1);

for i = 1:1:MergesNum
    RedImg = imread(strjoin([datadir seperator MergesFolders(i, 1) seperator 'r_r_' Merge], ''));
    GreenImg = imread(strjoin([datadir seperator MergesFolders(i, 1) seperator 'r_g_' Merge], ''));
    
    [Height, Width] = size(RedImg);
    MergeImg = zeros(Height, Width, 3);
    for j = 1:1:Height
        for k = 1:1:Width
            if RedImg(j, k)
                MergeImg(j, k, 1) = 255;
            end
            if GreenImg(j, k)
                MergeImg(j, k, 2) = 255;
            end
        end
    end
    
    imwrite(MergeImg,strjoin([datadir seperator MergesFolders(i, 1) seperator 'm_' Merge], ''));
end

