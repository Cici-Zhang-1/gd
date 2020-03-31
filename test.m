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
Merges = 'B_.jpg';

tmp = imread([datadir seperator Merges]);
MergeImg = tmp(:, :, 1:3);

imshow(MergeImg);

% 
% I = MergeImg .* uint8(removeImageNoise(MergeImg));
% figure
% imshow(I)



% figure;
% subplot(1,3,1)
% imshow(Aqp4Img);
% subplot(1,3,2)
% imshow(C4Img);
% subplot(1,3,3)
% imshow(MergeImg);

