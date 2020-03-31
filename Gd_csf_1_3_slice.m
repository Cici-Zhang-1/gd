clear;
close all;
% coronal

addpath(genpath('E:\matlab\tools\Bruker'));
datadir = 'H:\GdCSFinfusion';
name = '20191202_170832_Gd_1_6HD';

ten_study = 20;
twenty_study = 30;
thirty_study = 34;
all_slices = [6, 7, 8; 6, 7, 8];

[ten_image NX NY slices NI dyns] = read_2dseq_v3jh([datadir,filesep, name, filesep], ten_study, 1);
slice = size(ten_image,3);
i = 1;
for n = slice:-1:1
    tmp = slice - n + 1;
    if ~isempty(find(all_slices(1, :) == tmp))
        image(:,:, i) = ten_image(:,:,n);
        i = i + 1;
    end
end
[twenty_image NX NY slices NI dyns] = read_2dseq_v3jh([datadir,filesep, name, filesep], twenty_study, 1);
slice = size(twenty_image,3);
for n = slice:-1:1
    tmp = slice - n + 1;
    if ~isempty(find(all_slices(2, :) == tmp))
        image(:,:, i) = twenty_image(:,:,n);
        i = i + 1;
    end
end
[thirty_image NX NY slices NI dyns] = read_2dseq_v3jh([datadir,filesep, name, filesep], thirty_study, 1);
slice = size(thirty_image,3);
for n = slice:-1:1
    tmp = slice - n + 1;
    if ~isempty(find(all_slices(3, :) == tmp))
        image(:,:, i) = thirty_image(:,:,n);
        i = i + 1;
    end
end



montage(image, 'DisplayRange', [0 max(max(max(max(image))))*.5], 'Size', [3 3]);
yticks([0 50 100]);
yticklabels({'30min','20min','10min'});

title(sprintf('IMG GD CSF Num (%s)', strrep(name,'_','\_')));

saveas(gcf,sprintf('%s_IMG_GD_CSF_Coronal_Num_%d_%d_%d.jpg', name, ten_study, twenty_study, thirty_study));






