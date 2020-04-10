clear;
close all;
% remove single image background

[seperator, datadir, Merge] = get_dir();

global showHistory;
global currentHistory;
MergesFolder = '3monthStriatumHDMerge';

type = 'g_'; % g_ stands for green r_ stands for red
if strcmp(type, 'g_') 
    n = 2;
else
    n = 1;
end

f = figure;
Origin = imread([datadir seperator MergesFolder seperator type Merge]);
[Width, Height, w] = size(Origin);

posHeight = Height ./ Width .* 0.4;
pos1 = [0.05 0.3 0.425 posHeight];
subplot('Position', pos1);
imshow(Origin);
title('Original Image');
% Modified = Origin;
% avg = mean2(nonzeros(Modified));
% sigma = std2(nonzeros(Modified));
% Modified(Modified < avg * 2) = 0;
% Modified = imadjust(Modified, [0 0.01 0; 1 0.5 1], []);
[Modified] = get_modified(Origin);
pos2 = [0.5 0.3 0.425 posHeight];
subplot('Position',pos2)
imgobj = imshow(Modified);
title('Modified Image');
showHistory = zeros(Width, Height, 1);
showHistory(:, :, 1) = Modified(:, :, n);
currentHistory = 1;

screensize = get(groot, 'Screensize');
left = 100;
bottom = 100;
width = screensize(1, 3) - left * 2;
height = screensize(1, 4) - bottom * 2;
set(gcf, 'position', [left, bottom, width, height], ...
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



