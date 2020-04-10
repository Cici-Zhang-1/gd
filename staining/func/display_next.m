function display_next(img, n)
    global showHistory
    global currentHistory
    
    maxHistory = size(showHistory, 3);
    if currentHistory > maxHistory - 1 
        return
    end
    currentHistory = currentHistory + 1;
    tmp = showHistory(:, :, currentHistory);
    toshow = img.CData;
    toshow(:, :, n) = tmp;
    display_refresh(img, toshow);
    return
end