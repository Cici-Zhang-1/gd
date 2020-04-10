function display_prev_image(img, oImgObj, folderInfo)
%DISPLAY_PREV_IMAGE 此处显示有关此函数的摘要
%   此处显示详细说明
    global MergesFolders;
    global currentImage;
    global showHistory;
    global currentHistory;
    
    if currentImage < 2
        return
    end
    currentImage = currentImage - 1;
    Origin = imread([folderInfo.datadir folderInfo.seperator ...
        MergesFolders(currentImage).name folderInfo.seperator folderInfo.type folderInfo.Merge]);
    display_refresh(oImgObj, Origin);
    [Modified] = get_modified(Origin);
    display_refresh(img, Modified);
    [Width, Height, w] = size(Origin);
    showHistory = zeros(Width, Height, 1);
    showHistory(:, :, 1) = Modified(:, :, folderInfo.n);
    currentHistory = 1;
    edit_title(folderInfo);
    return;
end

