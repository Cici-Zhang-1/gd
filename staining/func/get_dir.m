function [seperator,datadir, Merge] = get_dir()
%GET_DIR 此处显示有关此函数的摘要
%   此处显示详细说明
if ispc
    seperator = '\';
    datadir = 'F:\GD\staining';
elseif ismac
    seperator = '/';
    datadir = '/Users/chuangchuangzhang/Documents/Data/HSdata/Test';
elseif isunix
    seperator = '/';
    datadir = '/Users/chuangchuangzhang/Documents/Data/HSdata/Test';
else
    seperator = '\';
    datadir = 'F:\GD\staining';
end
Merge = 'Colligen4AQP4.tif';
end

