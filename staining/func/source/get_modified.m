function [modified] = get_modified(origin)
%GET_MODIFIED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
avg = mean2(nonzeros(origin));
sigma = std2(nonzeros(origin));
origin(origin < avg * 2) = 0;
modified = imadjust(origin, [0 0.01 0; 1 0.5 1], []);
end

