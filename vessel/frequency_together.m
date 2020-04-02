clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.

fontSize = 20;

if ispc
    seperator = '\';
    datadir = 'F:\GD\vessels';
elseif ismac
    seperator = '/';
    datadir = '/Users/chuangchuangzhang/Documents/Data/HSdataIVASO/3Mivaso';
elseif isunix
else
end

load ValidFolders.mat

Vessel = 'fre_10X_CH2.tif';
VesselNum = size(VesselFolders, 1);

% for k = 1:VesselNum
%     ax(k) = subplot(4, 3, k);
% end

rows = 3;
lines = ceil(VesselNum / rows);

for i = 1:1:VesselNum
    SourceImg = imread([datadir seperator VesselFolders(i).name seperator Vessel]);
    subplot(lines, rows, i);
    imshow(SourceImg);
end
saveas(gcf, [datadir seperator 'fre_' Vessel]);
    

