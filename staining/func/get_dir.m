function [seperator,datadir, Merge] = get_dir()
%GET_DIR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

