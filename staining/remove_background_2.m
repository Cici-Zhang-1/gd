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
MergesFolder = 'hdcortex10Mcolligen4aqp4_45';
Merge = 'Colligen4AQP4.tif';
type = 'g_';
thred = 20;

MergesNum = size(MergesFolders, 1);

for i = 1:1:MergesNum
    
    tmp = imread([datadir seperator MergesFolders(i).name seperator type Merge]);
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

    prompt1= ['Save the image?' MergesFolders(i).name '\n'];
    save_or_not = input(prompt1);  %%%%%%%%%%%%%%%%
    if save_or_not
        disp('saved');
        imwrite(MergeImgSub,[datadir seperator MergesFolders(i).name seperator 'r_' type Merge]);
    end
end

