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
MergesFolder = 'hdcortex10Mcolligen4aqp4_45';

Merge = 'AQP4Colligen4.tif';

MergesNum = size(MergesFolders, 1);

type = 'r_';
thred = 20;

for i = 1:1:MergesNum
%     k = 1;
%     while k
%         prompt3 = 'Input the thred?\n';
%         thred = input(prompt3);
        tmp = imread(strjoin([datadir seperator MergesFolders(i, 1) seperator type Merge], ''));
        MergeImg = tmp(:, :, 1:3);

        figure;
        subplot(1, 2, 1);
        imshow(MergeImg);

        se = strel('disk', thred);
        background = imopen(MergeImg,se);
        I2 = MergeImg - background;
        I2_1 = rgb2gray(I2);
%         I3 = imadjust(I2_1);
        level = graythresh(I2_1);
        disp(level);
%         bw = imbinarize(I2_1, 0.1);
        bw = imbinarize(I2_1);
        MergeImgSub = bwareaopen(bw,20);
    %     imshow(bw)

    %     MergeImgSub = staining_img(MergeImg, thred);

        subplot(1, 2, 2)
        imshow(MergeImgSub);
%         prompt2 = 'Continue?\n';
%         k = input(prompt2);
%     end

    prompt1='Save the image?\n';
    save_or_not = input(prompt1);  %%%%%%%%%%%%%%%%
    if save_or_not
        disp('saved');
        imwrite(MergeImgSub,strjoin([datadir seperator MergesFolders(i, 1) seperator 'r_' type Merge], ''));
    end
end

