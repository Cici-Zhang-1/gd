clear;
close all;
% staining compare

if ispc
    seperator = '\';
    datadir = 'F:\GD\staining';
elseif ismac
    seperator = '/';
    datadir = '/Users/chuangchuangzhang/Documents/Data/HSdata/Test';
    addpath('./func');
elseif isunix
else
end

global showHistory;
global currentHistory;
MergesFolder = '3monthStriatumHDMerge';
Merge = 'Colligen4AQP4.tif';

type = 'g_';
n = 2;
thred = 60;

f = figure;
Origin = imread([datadir seperator MergesFolder seperator type Merge]);
[Width, Height, w] = size(Origin);

Height = Height ./ Width .* 0.4;
pos1 = [0.05 0.3 0.425 Height];
subplot('Position', pos1);
imshow(Origin);
title('Original Image');
Modified = Origin;
avg = mean2(nonzeros(Modified));
sigma = std2(nonzeros(Modified));
Modified(Modified < avg * 2) = 0;
Modified = imadjust(Modified, [0 0.01 0; 1 0.5 1], []);
pos2 = [0.5 0.3 0.425 Height];
subplot('Position',pos2)
imgobj = imshow(Modified);
title('Modified Image');
showHistory(:, :, 1) = Modified(:, :, n);
currentHistory = 1;

set(gcf, 'position', [500, 100, 900, 900], ...
    'Name', ['Staining ' Merge], 'Numbertitle', 'off');
sgtitle(f, ['Staining ' Merge]);

RemoveAllBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[20,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Remove');
RemoveAllBtn.Callback = @(src, event) display_roi(imgobj, n, 1);

MeanAllBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[130,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Mean');
MeanAllBtn.Callback = @(src, event) display_roi(imgobj, n, 5);

RemovePixel = uicontrol('Parent', f, 'Style','edit', 'Position', [240, 140, 100, 30], 'String', 0);
RemovePixelBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[340,140,50,30],...
              'value',0, 'min',0, 'max',1, 'String', 'V');
RemovePixelBtn.Callback = @(src, event) display_roi(imgobj, n, 6, struct('pixel', str2double(RemovePixel.String)));
          
SaveBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[400,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Save');
SaveBtn.Callback = @(src, event) display_save_img(imgobj, ...
    [datadir seperator MergesFolder seperator 'r_' type Merge]);

BackBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[510,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Previous');
BackBtn.Callback = @(src, event) display_previous(imgobj, n);

NextBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[620,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Next');
NextBtn.Callback = @(src, event) display_next(imgobj, n);

PreImageBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[20,100,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Prev Image');
PreImageBtn.Callback = @(src, event) display_prev_image(imgobj, n);

NextImgBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[130,100,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Next Image');
NextImgBtn.Callback = @(src, event) display_next_image(imgobj, n);



