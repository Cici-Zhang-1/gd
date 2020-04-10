function [modified] = get_modified(origin)
%GET_MODIFIED 此处显示有关此函数的摘要
%   此处显示详细说明
avg = mean2(nonzeros(origin));
sigma = std2(nonzeros(origin));
origin(origin < avg * 2) = 0;
modified = imadjust(origin, [0 0.01 0; 1 0.5 1], []);
end

