function edit_title(folderInfo)
%EDIT_TITLE 改变subplot title信息
%   此处显示详细说明
global MergesFolders;
global currentImage;
set(folderInfo.f, 'Name', ['Staining ' MergesFolders(currentImage).name], 'Numbertitle', 'off');
sgtitle(folderInfo.f, ['Staining ' MergesFolders(currentImage).name]);
end

