clear;
close all;

if ispc
    seperator = '\';
    datadir = 'F:\cell';
elseif ismac
    seperator = '/';
    datadir = '/Users/chuangchuangzhang/Documents/Data/HSdata/Test/3monthStriatumHDMerge';
elseif isunix
else
end

cells = {'BRIGHTFIELD_7346_03282020_0149.jpg'; 'BRIGHTFIELD_7358_03282020_0153.jpg';
'BRIGHTFIELD_7348_03282020_0149.jpg'; 'BRIGHTFIELD_7360_03282020_0153.jpg';
'BRIGHTFIELD_7350_03282020_0150.jpg'; 'BRIGHTFIELD_7362_03282020_0200.jpg';
'BRIGHTFIELD_7352_03282020_0151.jpg'; 'BRIGHTFIELD_7364_03282020_0201.jpg';
'BRIGHTFIELD_7354_03282020_0151.jpg'; 'BRIGHTFIELD_7366_03282020_0202.jpg';
'BRIGHTFIELD_7356_03282020_0152.jpg'; 'BRIGHTFIELD_7368_03282020_0203.jpg'};
cellsNum = size(cells, 1);

C = cell(1, 2);
C(1, 1) = {'string'};
C(1, 2) = {'double'};
Results = table('Size', [size(cells, 1) 2], 'VariableTypes', C);
figure;
k = imread([datadir seperator 'g_Colligen4AQP4.tif']);
% k=imresize(k,[1024/4,1280/4]);
% 1 original image
subplot(2, 2, 1);
imshow(k);
avg = mean2(nonzeros(k));
sigma = std2(nonzeros(k));
k(k<avg + 2 * sigma) = 0;
subplot(2, 2, 2);
imshow(k);
% K = rgb2gray(k);

% thred = 20;
% se = strel('disk', thred);
% background = imopen(k,se);
% K2 = k - background;
% K = rgb2gray(k);
% K = imbinarize(K, 'adaptive');
% 
% subplot(2, 2, 3);
% imshow(K);

imwrite(k,[datadir seperator 'r_g_Colligen4AQP4.tif']);


% K = rgb2gray(k);
% imshow(K)
% % 2 increased compare
% n = 1;  
% Kdouble = im2double(K); 
% avg = mean2(Kdouble);
% % sigma = std2(Kdouble);
% % K = imadjust(k,[avg-n*sigma 1],[]);
% % 
% % K = imadjust(K,[avg 0.6],[]);
% % K = imadjust(K);
% K = filter2(fspecial('average',3),K)/255;
% figure, imshow(K)
% 
% % 3 remove noise
% K = wiener2(K,[5 5]);
% figure, imshow(K)
% % 4 median filtering and image binarize
% K = medfilt2(K);
% K = imbinarize(K, 'adaptive', 'ForegroundPolarity','dark','Sensitivity',0.5);
% K = ~K;
% figure, imshow(K);
% % 5 filled holes
% K = imfill(K, 'holes');
% figure, imshow(K);
% % 6 image erode with disk
% se = strel('disk', 2);
% K = imerode(K,se);
% figure, imshow(K);
% % 7 Remove small objects from binary image
% K = bwareaopen(K,500, 8);
% figure, imshow(K);
% % 8 Remove circle
% % Label the image
% [labeledImage, numberOfCells] = bwlabel(K);
% % Ask for Euler number
% measurements = regionprops(labeledImage, 'EulerNumber');
% % allEulerNumbers = [measurements.Eccentricity];
% % % blobsToKeep = find(allEulerNumbers == 1);
% % % K = ismember(labeledImage, blobsToKeep) > 0; % Retain only these
% % k = bwareaopen(allEulerNumbers<0.20,100);
% 
% figure, imshow(K);
% % K = bwareafilt(K, [30, inf]); % Extract only blobs 30 pixels or larger.
% % [labeledImage, numberOfCells] = bwlabel(K); % Count blobs.
% disp(numberOfCells);
