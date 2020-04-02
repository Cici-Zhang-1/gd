clear;
close all;
% vessel remove background

if ispc
    seperator = '\';
    datadir = 'F:\GD\vessels';
elseif ismac
    seperator = '/';
    datadir = '/Users/chuangchuangzhang/Documents/Data/HSdataIVASO/3Mivaso';
elseif isunix
else
end

% Aqp4 = '3monthCortexWTAQP4.tif';
% C4 = '3monthCortexWTC4.tif';

MergesFolder = 'HDCORTEX3Mcolligen4_IVASO_09';

Merge = '10X_CH2.tif';

type = '';
thred = 20;

tmp = imread([datadir seperator MergesFolder seperator type Merge]);
MergeImg = tmp(:, :, 1:3);

figure;
subplot(3, 2, 1);
imshow(MergeImg);

se = strel('disk', thred);
background = imopen(MergeImg,se);
I2 = MergeImg - background;
I2_1 = rgb2gray(I2);
subplot(3, 2, 2);
imshow(I2);
% I3 = imadjust(I2_1);
level = graythresh(I2_1);
disp(level);
% bw = imbinarize(I2_1, 0.06);
bw = imbinarize(I2_1);
MergeImgSub = imfill(bw, 'holes');


subplot(3, 2, 3);
imshow(MergeImgSub);

MergeImgSub = bwareaopen(MergeImgSub,50);
% MergeImgSub = bw;
subplot(3, 2, 4);
imshow(MergeImgSub);

% se = strel('disk', 2);
% MergeImgSub = imdilate(MergeImgSub,se);
% subplot(3, 2, 5);
% imshow(MergeImgSub);

%         prompt2 = 'Continue?\n';
%         k = input(prompt2);
%     end

disp('saved');
imwrite(MergeImgSub,[datadir seperator MergesFolder seperator 'r_' type Merge]);

