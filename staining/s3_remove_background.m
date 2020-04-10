clear;
close all;
% remove background by remove the avg value
% addpath('MatlabCentral_ICIP2018');
global showHistory;
global currentHistory;
global currentImage;
global MergesFolders;

[seperator, datadir, Merge] = get_dir();

load ValidFolders.mat

MergesFolders = ValidFolders;

type = 'g_'; % g_ stands for green r_ stands for red
if strcmp(type, 'g_') 
    n = 2;
else
    n = 1;
end % type
MergesNum = size(MergesFolders, 1);
folderInfo = struct('datadir', datadir, 'seperator', seperator, 'Merge', Merge, 'type', type, ...
    'n', n, 'MergesNum', MergesNum);

f = figure;
screensize = get(groot, 'Screensize');
left = 100;
bottom = 100;
width = screensize(1, 3) - left * 2;
height = screensize(1, 4) - bottom * 2;
set(gcf, 'position', [left, bottom, width, height]);

currentImage = 1;
Origin = imread([datadir seperator MergesFolders(currentImage).name seperator type Merge]);
[Width, Height, w] = size(Origin);

posHeight = Height ./ Width .* 0.4;
pos1 = [0.05 0.3 0.425 posHeight];
subplot('Position', pos1);
oImgObj = imshow(Origin);
title('Original Image');
[Modified] = get_modified(Origin);
pos2 = [0.5 0.3 0.425 posHeight];
subplot('Position',pos2)
imgobj = imshow(Modified);
title('Modified Image');
showHistory = zeros(Width, Height, 1);
showHistory(:, :, 1) = Modified(:, :, n);
currentHistory = 1;
folderInfo.f = f;
edit_title(folderInfo);

RemoveAllBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[20,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Remove');
RemoveAllBtn.Callback = @(src, event) display_roi(imgobj, n, 1);

MeanAllBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[130,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Mean');
MeanAllBtn.Callback = @(src, event) display_roi(imgobj, n, 5);

RemovePixel = uicontrol('Parent', f, 'Style','edit', 'Position', [240, 140, 100, 30], 'String', 0);
RemovePixelBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[340,140,50,30],...
              'value',0, 'min',0, 'max',1, 'String', 'V');
RemovePixelBtn.Callback = @(src, event) display_roi(imgobj, n, 6, ...
    struct('pixel', str2double(RemovePixel.String)));
          
SaveBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[400,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Save');
SaveBtn.Callback = @(src, event) display_save_img(imgobj, folderInfo);

BackBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[510,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Previous');
BackBtn.Callback = @(src, event) display_previous(imgobj, n);

NextBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[620,140,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Next');
NextBtn.Callback = @(src, event) display_next(imgobj, n);

PreImageBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[20,100,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Prev Image');
PreImageBtn.Callback = @(src, event) display_prev_image(imgobj, oImgObj, folderInfo);

NextImgBtn = uicontrol('Parent',f,'Style','pushbutton','Position',[130,100,100,30],...
              'value',0, 'min',0, 'max',1, 'String', 'Next Image');
NextImgBtn.Callback = @(src, event) display_next_image(imgobj, oImgObj, folderInfo);

