clear;
close all;
% Sagittal

addpath(genpath('E:\matlab\tools\Bruker'));
% addpath(genpath('toolbox'));
datadir = 'F:\iVASO';
name = '20191114_100717_Gd_CSF_1_4';

studynum = 11;

Result = readbrukerdata([datadir,filesep, name, filesep,num2str(studynum)]);

Image = Result.image;
for n = 1:1:size(Image,3)
        img1(:,:,n) = fliplr(imrotate(Image(:,:,n),-90));
end

montage(img1, ...
    'DisplayRange', [0 max(max(max(max(img1))))*.5]);

title(sprintf('IMG GD CSF Num (%d)',studynum));

saveas(gcf,sprintf('%s_IMG_GD_CSF_Sagittal_Num_%d.jpg', name, studynum))