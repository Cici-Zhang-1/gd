clear;
close all;
% Axial

addpath(genpath('toolbox'));
datadir = 'F:\iVASO';
name = '20191114_100717_Gd_CSF_1_4';

studynum = 12;

[img1 NX NY slices NI dyns] = read_2dseq_v3jh_m([datadir, filesep, name, filesep], studynum, 1);

img = reshape(img1, size(img1, 2), size(img1, 1), size(img1, 3));
for n = 1:1:size(img,3)
        img2(:,:,n) = fliplr(imrotate(img(:,:,n),-90));
end

montage(img2, ...
    'DisplayRange', [0 max(max(max(max(img1))))*.5]);

title(sprintf('IMG GD CSF Num (%d)',studynum));

saveas(gcf,sprintf('%s_IMG_GD_CSF_Axial_Num_%d.jpg', name, studynum))