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
% 3monthCortexHDMerge   3monthStriatumHDMerge 6monthCortexHDMerge   6monthStriatumHDMerge
% 3monthCortexWTMerge   3monthStriatumWTMerge 6monthCortexWTMerge   6monthStriatumWTMerge

MergesFolder = '3monthCortexHDMerge';

Merge = 'Colligen4AQP4.tif';

type = 'r_';
thred = 20;

tmp = imread([datadir seperator MergesFolder seperator type Merge]);
MergeImg = tmp(:, :, 1:3);

figure;
subplot(1, 3, 1);
imshow(MergeImg);

se = strel('disk', thred);
background = imopen(MergeImg,se);
I2 = MergeImg - background;
subplot(1, 3, 3);
imshow(background);
I2_1 = rgb2gray(I2);
%         I3 = imadjust(I2_1);
level = graythresh(I2_1);
disp(level);
Kdouble = im2double(I2_1); 
avg = mean2(Kdouble);
bw = imbinarize(I2_1, avg);
% bw = imbinarize(I2_1);
MergeImgSub = bwareaopen(bw,20);
%     imshow(bw)

%     MergeImgSub = staining_img(MergeImg, thred);

subplot(1, 3, 2);
imshow(MergeImgSub);
%         prompt2 = 'Continue?\n';
%         k = input(prompt2);
%     end

prompt1= ['Save the image?' MergesFolder '\n'];
save_or_not = input(prompt1);  %%%%%%%%%%%%%%%%
if save_or_not
    disp('saved');
    imwrite(MergeImgSub,[datadir seperator MergesFolder seperator 'r_' type Merge]);
end

