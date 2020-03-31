clear;
close all;
% coronal

addpath(genpath('E:\matlab\tools\Bruker'));
datadir = 'H:\GdCSFinfusion';
name = '20191123_100403_Gd_CSF_1_9wt258';

studynum = 20;

[img1 NX NY slices NI dyns] = read_2dseq_v3jh([datadir,filesep, name, filesep], studynum, 1);

slice = size(img1,3);
for n = 1:1:slice
        img2(:,:, slice - n + 1) = img1(:,:,n);
end

montage(img2, 'DisplayRange', [0 max(max(max(max(img1))))*.5], 'Size', [3 6]);

title(sprintf('IMG GD CSF Num (%d)',studynum));

saveas(gcf,sprintf('%s_IMG_GD_CSF_Coronal_Num_%d.jpg', name, studynum));

% I = img2(:,:, 5);
% BW1 = edge(I,'sobel');
% BW2 = edge(I,'Canny');
% figure;
% imshowpair(BW1,BW2,'montage');
% title('Sobel Filter                                   Canny Filter');
% figure;
% imshow(I, 'DisplayRange', []);

% colorbar;
% colormap('jet');

% figure;
% edgeIm = sobel_mex(I, 0.7);
% im3 = repmat(edgeIm, [1 1 3]);
% image(im3);
