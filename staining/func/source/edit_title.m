function edit_title(folderInfo)
%EDIT_TITLE �ı�subplot title��Ϣ
%   �˴���ʾ��ϸ˵��
global MergesFolders;
global currentImage;
set(folderInfo.f, 'Name', ['Staining ' MergesFolders(currentImage).name], 'Numbertitle', 'off');
sgtitle(folderInfo.f, ['Staining ' MergesFolders(currentImage).name]);
end

